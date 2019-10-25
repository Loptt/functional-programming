-module(cw07).
-import(lists,[sum/1]).
-import(lists,[filter/2]).  
-import(lists,[map/2]). 
-export([removeList/2, mysum/1, transpose/1, quicksort/1, degrees/1, averages/1]).

% 1
removeList(_, []) -> [];
removeList(0, L) -> L;
removeList(N, L) -> removeList(N - 1, tl(L)).

% 2
mysum([]) -> [];
mysum([X]) -> X;
mysum([X | XS]) -> X + mysum(XS).

% 3
transpose([[]|_]) -> [];
transpose(M) -> [ (map (fun([X|_]) -> X end, M)) | transpose(map (fun([_|X]) -> X end, M)) ].

% 4
quicksort([]) -> [];
quicksort([Partition | Rest]) ->
    quicksort([X || X <- Rest, X < Partition]) ++
      [Partition] ++
	quicksort([X || X <- Rest, X >= Partition]).

% 5
degrees([]) -> [];
degrees([X | Xs]) -> [(length(X) -1) | degrees(Xs)].

% 6
averages([]) -> [{"Males", 0}, {"Females", 0}];
averages(X) -> [{"Males", 
    sum
        (map 
            (fun({_, He}) -> He end, (filter(fun({Gen, _}) -> Gen == "Male" end, X)))
        ) / (length (filter(fun({Gen, _}) -> Gen == "Male" end, X)))},
    
    {"Females",
    sum 
        (map 
            (fun({_, He}) -> He end, filter(fun({Gen, _}) -> Gen == "Female" end, X))) 
            / (length (filter(fun({Gen, _}) -> Gen == "Female" end, X)))}].

