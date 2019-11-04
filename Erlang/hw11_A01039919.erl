-module(hw11_A01039919).
-export([pow/2, fibonacci/1, reverse/1, count/2]).

% Complete the following functions and submit your file to Canvas.

% ========= IMPORTANT ==========
% Change the name of the file so that it contains your student ID or name.
% Do not change the names of the functions. The system will specifically look for the names used in this file. Changing the name of a function will automatically make you lose the points for that function.
% Do not change the number of arguments in the functions. Changing the number of arguments of a function will automatically make you lose the points for that function.
% Make sure that nothing additional is printed as the result of running this file. Avoid printing names, student IDs, or any other messages. If you print anything else, the system will wrongly grade your solutions.
% If your file cannot be loaded by the Erlang compiler, your grade will be zero. Then, submit only code that works.

% pow (tail recursive version)
powAux(_, 0) -> 1;

powAux(X, N) -> X * powAux(X, N-1).
pow(X, N) -> powAux(X, N).

% Fibonacci (tail recursive version)
fibAux(0) -> 0;
fibAux(1) -> 1;
fibAux(N) -> fibAux(N-1) + fibAux(N-2).

fibonacci(N) -> fibAux(N).

% reverse (tail recursive version)
reverseAux([]) -> [];
reverseAux([X|Xs]) -> reverseAux(Xs) ++ [X].

reverse(X) -> reverseAux(X).

% count (tail recursive version
countAux([], _) -> 0;
countAux([X|Xs], N) -> if 
    X == N ->
        countAux(Xs, N) + 1; 
    true ->
        countAux(Xs, N)
    end. 

count(X, N) -> countAux(X, N).
