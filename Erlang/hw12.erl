-module(hw12).
-export([startAppend/0, listenList/1, factorial/1, a/0, b/0]).

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
        {Pid, M} ->
            io:format("Received a message from a friend process, ~p: ~p", [Pid, M])
    end.


startFoF(X, Color) ->
    register(X, spawn(?MODULE, fof, [Color])).