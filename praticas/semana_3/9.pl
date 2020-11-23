% a
substitui(X, Y, [], []).
substitui(X, Y, [X|T], [Y|T2]) :-
    substitui(X, Y, T, T2).

substitui(X, Y, [H|T], [H|T2]) :-
    X \= H,
    substitui(X, Y, T, T2).

% b
elimina_duplicados([],[]).
elimina_duplicados([X|L1],L2) :-            % não existe ainda em L2
    member(X, L1),                          % X tem de ser membro de L1, se não para
    elimina_duplicados(L1, L2).             % recursao

elimina_duplicados([X|L1], [X|L2]) :-       % já existe em L2
    \+ member(X, L1),                       % X não pode ser membro de L1, se não para
    elimina_duplicados(L1, L2).             % recursao