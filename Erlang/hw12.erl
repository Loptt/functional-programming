-module(hw12).
-export([startAppend/0, listenList/1, factorial/1, a/0, b/0, fof/1, startFoF/2, run/0, marco/2, polo/2]).

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

bank(X) -> 
    receive
        
    end.


startBank() ->
    register(bankid, spawn(hw12, bank, [[]])).

stopBank() ->
    unregister(bankid).
