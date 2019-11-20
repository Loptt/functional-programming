duplicate([], []).
duplicate([L|LS], [Y1|[Y2|YS]]) :- duplicate(LS, YS), Y1 is L, Y2 is L.

sum([], 0).
sum([L|LS], X) :- sum(LS, Y), X is Y + L.

toBinaryString(0, "0").
toBinaryString(1, "1").
toBinaryString(N, X) :- write(N), A is N mod 2, B is div(N, 2), toBinaryString(A, Z), toBinaryString(B, W), append(Z, W, X). 