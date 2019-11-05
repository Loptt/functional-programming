-module(ch04).
-export[respond/0, doMath/3, startCalculator/1, add/1, subtract/1, multiply/1, divide/1, finish/0].

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
            io:format("The result is ~p~n", X)
    end.

startCalculator(X) ->
    register(calculator, spawn(?MODULE, calculate, [X])).

add(X) -> calculator ! {"+", X}.

multiply(X) -> calculator ! {"*", X}.

subtract(X) -> calculator ! {"-", X}.

divide(X) -> calculator ! {"/", X}.

finish() -> calculator ! {"f", 0}.