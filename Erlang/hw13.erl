-module(hw13).
-export([push/2, pop/1, peek/1, matrixSum/2, getBalance/1, search/2]).

% Complete the following functions and submit your file to Canvas.

% ========= IMPORTANT ==========
% Change the name of the file so that it contains your student ID or name.
% Do not change the names of the functions. The system will specifically look for the names used in this file. Changing the name of a function will automatically make you lose the points for that function.
% Do not change the number of arguments in the functions. Changing the number of arguments of a function will automatically make you lose the points for that function.
% Make sure that nothing additional is printed as the result of running this file. Avoid printing names, student IDs, or any other messages. If you print anything else, the system will wrongly grade your solutions.
% If your file cannot be loaded by the Erlang compiler, your grade will be zero. Then, submit only code that works.

% Lists to represent stacks
push(N, X) -> [N|X].

pop([]) -> io:format("Error: empty stack.~n");
pop([_|Xs]) -> Xs.

peek([]) -> io:format("Error: empty stack.~n");
peek([X|_]) -> X.

% Matrix addition
matrixSum(X, Y) -> lists:zipwith(fun(Z, W) -> (lists:zipwith(fun(A, B) -> A+B end, Z, W)) end, X,Y).

% Get balance
% [{charge, 1000}, {charge, 2000}, {payment, 500}, {payment, 3000}, {charge, 3500}]
getBalance(_) -> io:format("Not yet implemented.~n").

% Search in binary trees
%[8, [5, [2, [], []], [7, [], []]], [9, [], [15, [11, [], []]]]]			
search(_, _) -> io:format("Not yet implemented.~n").