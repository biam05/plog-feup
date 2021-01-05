:- use_module(library(clpfd)).
:- use_module(library(lists)).

% O Problema do quadrado mágico consiste em preencher um quadrado com NxN casa, com os
% números entre 1 e NxN (cada número utilizado uma única vez) de forma a que a soma das linhas,
% colunas e diagonais (principais) sejam idênticas.

% a) Resolva as versões 3x3 e 4x4 do problema

% 3x3
magic3x3 :-
    Vars = [A1, A2, A3, B1, B2, B3, C1, C2, C3],
    domain(Vars, 1, 9), % 3x3 = 9
    all_distinct(Vars), % todos os valores de Vars sao distintos entre si
    A1 + A2 + A3 #= Soma,
    B1 + B2 + B3 #= Soma,
    C1 + C2 + C3 #= Soma,
    A1 + B1 + C1 #= Soma,
    A2 + B2 + C2 #= Soma,
    A3 + B3 + C3 #= Soma,    
    A1 + B2 + C3 #= Soma,
    A3 + B2 + C1 #= Soma,
    A1 #< A2, A1 #< A3, A1 #< B1, A2 #< B1,  % elimina simetrias
    labeling([], Vars),
    write(A1), write('|'), write(A2), write('|'), write(A3), nl,
    write('-----'), nl,
    write(B1), write('|'), write(B2), write('|'), write(B3), nl,
    write('-----'), nl,
    write(C1), write('|'), write(C2), write('|'), write(C3).

% 4x4
magic4x4 :-
    Vars = [A1, A2, A3, A4, B1, B2, B3, B4, C1, C2, C3, C4, D1, D2, D3, D4],
    domain(Vars, 1, 16), % 4x4 = 16
    all_distinct(Vars), % todos os valores de Vars sao distintos entre si
    A1 + A2 + A3 + A4 #= Soma,
    B1 + B2 + B3 + B4 #= Soma,
    C1 + C2 + C3 + C4 #= Soma,
    A1 + B1 + C1 + D1 #= Soma,
    A2 + B2 + C2 + D2 #= Soma,
    A3 + B3 + C3 + D3 #= Soma, 
    A4 + B4 + C4 + D4 #= Soma,    
    A1 + B2 + C3 + D4 #= Soma,
    A4 + B3 + C2 + D1 #= Soma,
    A1 #< A2, A1 #< A3, A1 #< B1, A2 #< B1,  % elimina simetrias
    labeling([], Vars),
    write(A1), write(' |'), write(A2), write(' |'), write(A3), write('|'), write(A4), nl,
    write('-----------'), nl,
    write(B1), write('|'), write(B2), write('|'), write(B3), write(' |'), write(B4), nl,
    write('-----------'), nl,
    write(C1), write('|'), write(C2), write(' |'), write(C3), write('|'), write(C4), nl,
    write('-----------'), nl,
    write(D1), write(' |'), write(D2), write('|'), write(D3), write(' |'), write(D4).

% NxN
magic(N, Vars) :-
    MaxValue is N * N,
    length(Vars, MaxValue),
    domain(Vars, 1, MaxValue),
    all_distinct(Vars), 
    equality_restriction(Vars, EqualSum, N),
    labeling([], Vars).

% NAO FUNCIONA AINDA
% teria de fazer um sum_lines, um sum_columns e um sum_diagonals