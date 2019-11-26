/* Carlos Estrada A01039919 */

square([], []).
square([X],[Y]) :- Y is X^2, !.
square([L|LS], [Z|X]) :- Z is L^2, square(LS, X), !.

sumN(0, 0).
sumN(N, X) :- M is N - 1, sumN(M, Y), X is Y + N, !.

xLength([], 0).
xLength([_|LS], X) :- xLength(LS, Y), X is Y + 1, !.

nLength([], 0).
nLength([L|LS], X) :- is_list(L), nLength(L, Y), nLength(LS, Z), X is Y + Z, !.
nLength([_|LS], X) :- nLength(LS, Z), X is Z + 1, !.

dotProduct([X], [Y], Z) :- Z is X * Y.
dotProduct([X|XS], [Y|YS], R) :- S is X * Y, dotProduct(XS, YS, W), R is W + S, !.