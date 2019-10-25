-module(averages).
-import(lists,[sum/1]).
-import(lists,[filter/2]).  
-import(lists,[map/2]).  
-export([averages/1]).

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

