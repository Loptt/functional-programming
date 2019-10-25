-module(hw10).
-import(math,[pow/2]).
-export([sumFirst/1, nestedSum/1, removeNestedLists/1, cleanString/1, evaluate/2, toBinaryString/1, zip/2, tuplesToList/1]).

% Complete the following functions and submit your file to Canvas.

% ========= IMPORTANT ==========
% Change the name of the file so that it contains your student ID or name.
% Do not change the names of the functions. The system will specifically look for the names used in this file. Changing the name of a function will automatically make you lose the points for that function.
% Do not change the number of arguments in the functions. Changing the number of arguments of a function will automatically make you lose the points for that function.
% Make sure that nothing additional is printed as the result of running this file. Avoid printing names, student IDs, or any other messages. If you print anything else, the system will wrongly grade your solutions.
% If your file cannot be loaded by the Erlang compiler, your grade will be zero. Then, submit only code that works.


% Sum of first n positive integers
sumFirst(0) -> 0;
sumFirst(X) -> X + sumFirst(X-1).

% Calculates the sum of the elements in a list (ignores nested lists).
nestedSum([]) -> 0;
nestedSum([X|Xs]) -> if 
    is_list(X) ->
        nestedSum(X) + nestedSum(Xs);
    true ->
        X + nestedSum(Xs)
    end. 

% Removes nested lists in the argument and returns all the elements as one single plain list.
removeNestedLists([]) -> [];
removeNestedLists([X|Xs]) -> if 
    is_list(X) ->
        removeNestedLists(X) ++ removeNestedLists(Xs);
    true ->
        [X | removeNestedLists(Xs)]
    end. 

% Cleans a string. Given a string, return recursively a 'cleaned' string where adjacent chars that are the same have been reduced to a single char. So "yyzzza" yields "yza".
cleanString([]) -> [];
cleanString([X]) -> [X];
cleanString([X|Xs]) -> if
    X == hd(Xs) ->
        cleanString(Xs);
    true ->
        [X | cleanString(Xs)]
    end. 

% Evaluation of polynomials
evaluate([], _) -> 0;
evaluate([X|Xs], N) -> (X * (pow(N, length(Xs)))) + evaluate(Xs, N).

% Converts a number to a binary string.
toBinaryString(0) -> "0";
toBinaryString(1) -> "1";
toBinaryString(N) -> toBinaryString(N div 2) ++ toBinaryString(N rem 2).

% Zipping two lists
zip([], _) -> [];
zip(_, []) -> [];
zip([X|Xs], [Y|Ys]) -> [{X,Y} | zip(Xs,Ys)].

% Lists of tuples
tuplesToList([]) -> [];
tuplesToList([{X,Y}|Xs]) -> if
    is_list(X) and is_list(Y) ->
        X ++ Y ++ tuplesToList(Xs);
    is_list(X) ->
        X ++ [Y] ++ tuplesToList(Xs);
    is_list(Y) ->
        [X] ++ Y ++ tuplesToList(Xs);
    true ->
        [X] ++ [Y] ++ tuplesToList(Xs)
    end.