/*Carlos Estrada A01039919 */

insert(N, [], [N]) :- !.
insert(N, [L|LS], [N, L|LS]) :- N =< L, !.
insert(N, [X|L1], [X|L]) :- insert(N, L1, L).

insertionSort([], []) :- !.
insertionSort([L|LS], X) :- insertionSort(LS, S), insert(L, S, X).

travel(A, B, C) :-
    A is 4,
    C is A - 1,
    B is 2 * (C+C).

fight(Vegeta, Gohan, Goku) :-
    L = [0,1,2],
    member(Vegeta, L),
    member(Gohan, L),
    member(Goku, L),
    Vegeta > Gohan,
    Goku < Gohan, !.