enigmaB([] , _ , []).
enigmaB(_ , [] , []) .
enigmaB([ X | Xs ] , [ Y | Ys ] , [[ X , Y , Z ] | W ]) :- Z is X + Y , enigmaB( Xs , Ys , W ) , !.

oldest(Julio, Gloria, Pablo, Miguel, Silvia) :-
    between(0, 6, L),
    member(Julio, L),
    member(Gloria, L),
    member(Pablo, L),
    member(Miguel, L),
    member(Silvia, L),
    Julio > Gloria,
    Julio > Pablo,
    Miguel < Silvia,
    Miguel < Pablo,
    Miguel > Gloria,
    Julio < Silvia, !.


mutate([], [], []).
mutate([X|XS], [Y|YS], [Z|ZS]) :- Y is 1, X is 0, Z is 1, mutate(XS, YS, ZS).
mutate([X|XS], [Y|YS], [Z|ZS]) :- Y is 1, X is 1, Z is 0, mutate(XS, YS, ZS).
mutate([X|XS], [Y|YS], [Z|ZS]) :- Y is 0, Z is X, mutate(XS, YS, ZS).

next(X, Y, L) :- 
    length(L, L1),
    nth1(PX, L, X),
    nth1(PY, L, Y),
    PX is L1,
    PY is 1, !.

next(X, Y, L) :- 
    length(L, L1),
    nth1(PX, L, X),
    nth1(PY, L, Y),
    PY is L1,
    PX is 1, !.

next(X, Y, L) :- 
    nth1(PX, L, X),
    nth1(PY, L, Y),
    PX is PY-1, !.

next(X, Y, L) :- 
    nth1(PX, L, X),
    nth1(PY, L, Y),
    PX is PY+1, !.

solveFamily(Solution) :-
    length(Solution, 7),
    member(ben, Solution),
    member(rey, Solution),
    member(han, Solution),
    member(luke, Solution),
    member(leia, Solution),
    member(anakin, Solution),
    member(palpatine, Solution),

    next(ben, rey, Solution),
    next(luke, han, Solution),
    next(luke, leia, Solution),
    next(ben, anakin, Solution),
    not(next(ben, luke, Solution)),
    next(palpatine, anakin, Solution),
    not(next(palpatine, luke, Solution)),
    not(next(palpatine, leia, Solution)), !.

solveBest(Erik, Charles, Logan, Scott) :-
    L = [0,1,2,3],
    member(Erik, L),
    member(Charles, L),
    member(Logan, L),
    member(Scott, L),
    Erik > Logan,
    Charles > Logan,
    Scott < Charles,
    Scott > Erik, !.

nextM(X, Y, L) :- 
    nth1(PX, L, X),
    nth1(PY, L, Y),
    PX is PY-1, !.

nextM(X, Y, L) :- 
    nth1(PX, L, X),
    nth1(PY, L, Y),
    PX is PY+1, !.

arrange(Solution) :- 
    length(Solution, 5),
    member(a, Solution),
    member(b, Solution),
    member(c, Solution),
    member(d, Solution),
    member(e, Solution),

    not(nextM(a,b,Solution)),
    not(nextM(a,c,Solution)),
    not(nextM(c,b,Solution)),
    not(nextM(d,e,Solution)).

edge(a, d, 10).
edge(d, f, 4).
edge(d, g, 11).
edge(d, e, 12).
edge(d, b, 5).
edge(b, c, 3).
edge(c, e, 4).
edge(e, h, 1).
edge(f, g, 3).
edge(g, h, 7).

path(X, Y, [X|Y], T) :- edge(X, Y, C), C =< T.
path(X, Y, [X|L], T) :- edge(X, Z, C), C =< T, TR is T - C, path(Z, Y, L, TR).

bags(Solution) :- 
    length(Solution, 3),
    Solution = [[pink,_], [red,_], [white,_]],
    Solution = [[_,wheat], [_,corn], [_,sorghum]],!.