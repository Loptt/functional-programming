-module(degrees).
-export([degrees/1]).

degrees([]) -> [];
degrees([X | Xs]) -> [length(X) | degrees(Xs)]