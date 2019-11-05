-module(hw12).
-export([startAppend/0]).

listenList(X) ->
    receive 
        N when N > 0 ->
            io:format("Number: ˜p has been added to the list ˜n", N),
            listenList([N|X]);
        _ ->
            io:format("The numbers registered by the process are: ˜p ˜n", X)
    end.
            

startAppend() -> spawn(listenList([])). 