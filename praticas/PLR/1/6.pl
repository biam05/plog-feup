:- use_module(library(clpfd)).

% Que conjuntos de três números têm a sua soma igual ao seu produto?

sol(A, B, C) :-
    domain([A, B, C], 1, 1000),
    A*B*C #= A+B+C,
    C #> B, B #> A,         % elimina simetrias
    labeling([], [A,B,C]).

/*
    com simetrias                   sem simetrias

    | ?- sol(A,B,C).                | ?- sol(A,B,C). 
    A = 1,                          A = 1,
    B = 2,                          B = 2,    
    C = 3 ? ;                       C = 3 ? ;
    A = 1,                          no    
    B = 3,
    C = 2 ? ;
    A = 2,
    B = 1,
    C = 3 ? ;
    A = 2,
    B = 3,
    C = 1 ? ;
    A = 3,
    B = 1,
    C = 2 ? ;
    A = 3,
    B = 2,
    C = 1 ? ;
    no
*/