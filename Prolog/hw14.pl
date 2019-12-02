:- use_module(library(clpfd)).

/*Carlos Estrada A01039919 */

duplicate([], []).
duplicate([L|LS], [Y1|[Y2|YS]]) :- duplicate(LS, YS), Y1 is L, Y2 is L.

sum([], 0).
sum([L|LS], X) :- sum(LS, Y), X is Y + L.

toBinaryString(1, "1").
toBinaryString(0, "0").
toBinaryString(N, X) :- A is N mod 2, B is N div 2, toBinaryString(A, Z), toBinaryString(B, W), atom_concat(Z, W, X), !.

edge(a,b,3).
edge(b,c,2).
edge(a,d,1).
edge(b,d,4).
edge(d,e,5).
edge(e,f,3).

path(X, Y, [X|Y], C) :- edge(X, Y, C).
path(X, Y, [X|LS], C) :- edge(X, Z, C1),  path(Z, Y, LS, C2), C is C1 + C2.

magicSquare([[S1,S2,S3],[S4,S5,S6],[S7,S8,S9]]) :-
    L = [1,2,3,4,5,6,7,8,9],
    member(S1, L),
    member(S2, L),
    member(S3, L),
    member(S4, L),
    member(S5, L),
    member(S6, L),
    member(S7, L),
    member(S8, L),
    member(S9, L),
    all_different([S1,S2,S3,S4,S5,S6,S7,S8,S9]),
    15 is S1+S2+S3,
    15 is S4+S5+S6,
    15 is S7+S8+S9,
    15 is S1+S4+S7,
    15 is S2+S5+S8,
    15 is S3+S6+S9,
    15 is S1+S5+S9,
    15 is S3+S5+S7.    
    


right(X, Y, L) :-
    nth1(X1, L, X),
    nth1(Y1, L, Y),
    X1 is Y1 + 1.

next(X, Y, L) :-
    right(X, Y, L);
    right(Y, X, L).

solveEinstein(Solution) :-
    length(Solution, 5),
    member([red, _, _, _, englishman], Solution),
    member([_, dogs, _, _, sweede], Solution),
    member([_, _, tea, _, dane], Solution),
    right([green, _, _, _, _], [white, _, _, _, _], Solution),
    member([green, _, coffee, _, _], Solution),
    member([_, birds, _, pallmall, _], Solution),
    member([yellow, _, _, dunhills, _], Solution),
    Solution = [_, _, [_, _, milk, _, _], _, _],
    Solution = [[_, _, _, _, norwegian], _, _, _, _],
    next([_, cats, _, _, _], [_, _, _, blend, _], Solution),
    member([_, _, beer, bluemaesters, _], Solution),
    next([_, _, _, dunhills, _], [_, horses, _, _, _], Solution),
    member([_, _, _, prince, german], Solution),
    next([_, _, _, _, norwegian], [blue, _, _, _, _], Solution),
    next([_, _, water, _, _], [_, _, _, blend, _], Solution),
    member([_, fish, _, _, _], Solution), !.