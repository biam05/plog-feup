:- use_module(library(clpfd)).

% Construa um programa CLP que permita resolver o problema das N-Rainhas. 
% Este problema consiste em colocar, num tabuleiro com NxN casa, N rainhas 
% (de xadrez), sem que nenhuma rainha ataque uma outra rainha posicionada no 
% tabuleiro (isto é, na horizontal, vertical ou diagonal)

% a) Resolva a versão 4x4 do problema

/*
    C1 C2 C4 C4
    C1 C2 C3 C4
    C1 C2 C3 C4
    C1 C2 C3 C4
*/

queens(4) :-
    Cols = [C1, C2, C3, C4],
    domain(Cols, 1, 4),
    C1 #\= C2, C1 #\= C3, C1 #\= C4, C2 #\= C3, C2 #\= C4, C3 #\= C4,
    C1 #\= C2 + 1, C1 #\= C2 - 1, C1 #\= C3 + 2, C1 #\= C3 - 2, C1 #\= C4 + 3, C1 #\= C4 - 3,
    C2 #\= C3 + 1, C2 #\= C3 - 1, C2 #\= C4 + 2, C2 #\= C4 - 2,
    C3 #\= C4 + 1, C3 #\= C4 - 1,
    labeling([], Cols),
    write(Cols).

/*
    | ?- queens(4).                                                    
    [2,4,1,3]
    yes
*/

% b) Generalize para NxN

nqueens(N,Cols):-
    length(Cols,N),
    domain(Cols,1,N),
    constrain(Cols),
    all_distinct(Cols),
    labeling([],Cols).

constrain([]).
constrain([H | RCols]):-
    safe(H,RCols,1),
    constrain(RCols).

safe(_,[],_).
safe(X,[Y | T], K) :-
    noattack(X,Y,K),
    K1 is K + 1,
    safe(X,T,K1).

noattack(X,Y,K) :-
    X #\= Y,
    X + K #\= Y,
    X - K #\= Y.

% Test: nqueens(4,C).
% C = [2, 4, 1, 3] More? (;)
% C = [3, 1, 4, 2] More? (;)
% no (more) solution.
   