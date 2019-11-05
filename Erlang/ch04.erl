-module(ch04).
-import(timer, [send_after/3]).
-import(lists, [sum/1]).
-export[respond/0, doMath/3, startCalculator/1, add/1, subtract/1, multiply/1, divide/1, getResult/0, calculate/1, tic/0, tac/0, startClock/0, stopClock/0, sumConcurrent/1, sumAux/0].

respond() ->
    receive
        X when is_number(X) ->
            io:format("~p~n", [X+1]),
            respond();
        _ ->
            io:format("Bye~n")
    end.

sumNumbers() ->
    receive 
        {Pid, Y, Z} ->
            Pid ! (Y + Z)
    end.

multiplyNumbers() ->
    receive 
        {Pid, X, M} ->
            Pid ! (X * M)
    end.

doMath(X, Y, Z) ->
    PidS = spawn(fun sumNumbers/0),
    PidM = spawn(fun multiplyNumbers/0),
    PidS ! {self(), Y, Z},

    receive 
        N ->
            PidM ! {self(), N, X}
    end,

    receive 
        A ->
            A
    end.

calculate(X) ->
    receive
        {"+", N} ->
            calculate(X+N);
        {"-", N} ->
            calculate(X-N);
        {"*", N} ->
            calculate(X*N);
        {"/", N} ->
            calculate(X/N);
        {"f", _} ->
            io:format("The result is ~p~n", [X])
    end.

startCalculator(X) ->
    register(calculator, spawn(?MODULE, calculate, [X])).

add(X) -> calculator ! {"+", X}.

multiply(X) -> calculator ! {"*", X}.

subtract(X) -> calculator ! {"-", X}.

divide(X) -> calculator ! {"/", X}.

getResult() -> calculator ! {"f", 0}, io:format("finish~n").

startClock() ->
    register(ticid, spawn(?MODULE, tic, [])),
    register(tacid, spawn(?MODULE, tac, [])),
    ticid ! 0.

tic() ->
    receive
        1 ->
            io:format("Stopped Tic...~n", []);
        _ ->
            io:format("Tic...~n", []),
            send_after(1000, tacid, 0),
            tic()
    end.

tac() ->
    receive
        1 ->
            io:format("Stopped Tac...~n", []);
        _ ->
            io:format("Tac...~n", []),
            send_after(1000, ticid, 0),
            tac()
    end.

stopClock() ->
    ticid ! 1,
    tacid ! 1.

sumAux() ->
    receive
        {Pid, X} ->
            Pid ! sum(X)
    end.

sumConcurrent(X) ->
    register(sumid, spawn(?MODULE, sumAux, [])),
    sumid ! {self(), X},

    receive
        N ->
            N
    end.