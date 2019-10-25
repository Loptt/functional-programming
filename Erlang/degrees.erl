-module(degrees).
-export([degrees/1]).

degrees([]) -> [];
degrees([X | Xs]) -> [(length(X) -1) | degrees(Xs)].