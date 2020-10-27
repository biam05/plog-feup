% Construa um predicado de mapeamento utilizando o operador =.. na sua definição. 

function(F, Args) :-
    G=..[F|Args],
    G.

% Caso Base
map2([],_,[]).

map2([C|R], F, [TC|CR]) :-
    function(F, [C, TC]),
    map2(R, F, CR).

/*
my_map(List, TermName, Result)
my_map([], _, []).
my_map([H | Tail], TermName, [Result|AuxResult]):-
    Term =.. [TermName, H, Result],
    Term,
    my_map(Tail, TermName, AuxResult).
*/