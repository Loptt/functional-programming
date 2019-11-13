-module(hw12).
-export([startAppend/0, listenList/1, factorial/1, a/0, b/0, fof/1,
        startFoF/2, run/0, marco/2, polo/2, startBank/0, stopBank/0,
        createAccount/2, bank/1, seeAcounts/0, requestBalance/1, deposit/2,
        withdraw/2]).

%==========================
% Carlos Estrada A01039919
%==========================

listenList(X) ->
    receive 
        N when (is_number(N) and (N > 0)) ->
            io:format("Number: ~p has been added to the list ~n", [N]),
            listenList([N|X]);
        _ ->
            io:format("The numbers registered by the process are: ~p ~n", [X])
    end.
            

startAppend() -> 
    register(appendNumber, spawn(?MODULE, listenList, [[]])). 

factLess(0) -> 1;
factLess(X) -> X * factLess(X-1).

factMore(_, Y) when Y == 0 -> 1;
factMore(X, Y) when X =< Y -> X;
factMore(X, Y) -> X * factMore(X-1, Y).

a() ->
    receive
        {Pid, X} ->
            Pid ! factLess(X div 2)
    end.

b() ->
    receive
        {Pid, X} ->
            Pid ! factMore(X, (X div 2)+1)
    end.

factorial(X) ->
    register(aid, spawn(hw12, a, [])),
    register(bid, spawn(hw12, b, [])),
    aid ! {self(), X},
    bid ! {self(), X},

    receive 
        N ->
            receive
                S ->
                    N * S
            end
    end.

fof(Color) ->
    receive
        {Pid, M} when is_list(M) ->
            ThisPid = self(),
            OtherPid = whereis(Pid),
            if
                ThisPid == OtherPid ->
                    io:format("Received a message from a friend process, ~p: ~p~n", [Pid, M]);
                true ->
                    Pid ! {self(), Color},
                    receive
                        {Pid, X} when is_atom(X) ->
                            Pid ! {self(), X == Color},
                            fof(Color);
                        X ->
                            Equal =  hd(tl(tuple_to_list(X))),
                            if
                                Equal ->
                                    io:format("Received a message from a friend process, ~p: ~p~n", [Pid, M]);
                                true ->
                                    io:format("Process ~p is not my friend. I will ignore its message~n", [Pid])
                            end
                    end
            end,
            fof(Color);
        {Pid, X} when is_atom(X) ->
            Pid ! {self(), X == Color},
            fof(Color)
    end.


startFoF(X, Color) ->
    register(X, spawn(?MODULE, fof, [Color])).

marco(X, Y) ->
    receive
        {M, N} ->
            DeltaX = if M > 0 -> 1; M < 0 -> -1; true -> 0 end,
            DeltaY = if N > 0 -> 1; N < 0 -> -1; true -> 0 end,
            io:format("Marco moves to (~p, ~p)~n", [X+DeltaX, Y+DeltaY]),
            poloid ! {X+DeltaX, Y+DeltaY},
            marco(X+DeltaX, Y+DeltaY)
    end.

polo(X, Y) ->
    receive
        {M, N} ->
            if
                (M == X) and (N == Y) ->
                    io:format("Marco found me! I was hiding at position (~p, ~p)~n", [X, Y]);
                true ->
                    marcoid ! {X-M, Y-N},
                    polo(X, Y)
            end
    end.


run() ->
    MarcoX = rand:uniform(20),
    MarcoY = rand:uniform(20),
    PoloX = rand:uniform(20),
    PoloY = rand:uniform(20),
    register(marcoid, spawn(hw12, marco, [MarcoX, MarcoY])),
    register(poloid, spawn(hw12, polo, [PoloX, PoloY])),
    io:format("Marco starts at position (~p, ~p)~n", [MarcoX, MarcoY]),
    io:format("Polo is hidden (we dont know where he is)...~n"),
    poloid ! {MarcoX, MarcoY}.

getAmount([], _) -> 0;
getAmount([{N1, X}|Xs], N2) ->
    if 
        N1 == N2 ->
            X;
        true ->
            getAmount(Xs, N2)
    end.

depositBank([], _, _) -> [];
depositBank([{N1, A}|Xs], N2, D) ->
    if
        N1 == N2 ->
            [{N1, A+D}|Xs];
        true ->
            [{N1, A}|depositBank(Xs, N2, D)]
    end.

withdrawBank([], _, _) -> [];
withdrawBank([{N1, A}|Xs], N2, D) ->
    if
        N1 == N2 ->
            [{N1, A-D}|Xs];
        true ->
            [{N1, A}|withdrawBank(Xs, N2, D)]
    end.

bank(X) -> 
    receive
        {O, N, A} when O == create ->
            bank([{N, A}|X]);
        {O, Pid} when O == see ->
            Pid ! X,
            bank(X);
        {O, Pid, A} when O == request ->
            Pid ! getAmount(X, A),
            bank(X);
        {O, N, A} when O == deposit ->
            bank(depositBank(X, N, A));
        {O, N, A} when O == withdraw ->
            bank(withdrawBank(X, N, A))          
    end.

createAccount(Number, Amount) ->
    if
        Amount < 500 ->
            io:format("Initial amount must be at least 500~n");
        true ->
            bankid ! {create, Number, Amount},
            io:format("Account created with number: ~p and initial amount: ~p~n", [Number, Amount])
    end. 

seeAcounts() ->
    bankid ! {see, self()},
    receive
        X ->
            io:format("Current Accounts: ~p~n", [X])
    end.

requestBalance(Number) ->
    bankid ! {request, self(), Number},
    receive
        X ->
            io:format("Amount on account ~p: ~p~n", [Number, X])
    end.

deposit(Number, Amount) ->
    if
        Amount < 20 ->
            io:format("Deposit amount must be at least 20~n");
        true ->
            bankid ! {deposit, Number, Amount},
            io:format("Deposited ~p into account ~p~n", [Amount, Number])
    end. 

withdraw(Number, Amount) ->
    if
        Amount < 1 ->
            io:format("Withdraw amount must be at least 1~n");
        true ->
            bankid ! {withdraw, Number, Amount},
            io:format("Taken ~p from account ~p~n", [Amount, Number])
    end. 

startBank() ->
    register(bankid, spawn(hw12, bank, [[]])).

stopBank() ->
    unregister(bankid).
