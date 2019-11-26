:- use_module(library(clpfd)).

solveCryptarithmetic(T, W, O, F, U, R) :-
    L = [0,1,2,3,4,5,6,7,8,9],
    member(T, L),
    member(W, L),
    member(O, L),
    member(F, L),
    member(U, L),
    member(R, L),
    all_different([T,W,O,F,U,R]),
    Or is O + O, Om is mod(Or, 10), Od is div(Or, 10),
    R = Om,
    Wr is W + W + Od, Wm is mod(Wr, 10), Wd is div(Wr, 10),
    U = Wm,
    Tr is T + T + Wd, Tm is mod(Tr, 10), Td is div(Tr, 10),
    O = Tm,
    F = Td.

oldest(Julio, Gloria, Pablo, Miguel, Silvia) :-
    L = [0,1,2,3,4],
    member(Julio, L),
    member(Gloria, L),
    member(Pablo, L),
    member(Miguel, L),
    member(Silvia, L),
    Julio > Gloria,
    Julio > Pablo,
    Silvia > Miguel,
    Pablo > Miguel,
    Miguel > Gloria,
    Silvia > Julio,