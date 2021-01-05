:- use_module(library(clpfd)).

% O Problema dos CRIPTOGRAMAS consiste em atribuir dígitos decimais às 
% letras, de modo a que a respectiva soma seja válida. Construa um programa 
% CLP para resolver os seguintes criptogramas:

%  a) puzzle(3,[0,S,E,N,D],[0,M,O,R,E],[M,O,N,E,Y]).

puzzle(3) :-
    Vars = [S,E,N,D,M,O,R,Y],
    domain(Vars, 0, 9),
    all_distinct(Vars),
    S #\= 0, M #\= 0,
    S * 1000 + E * 100 + N * 10 + D +
    M * 1000 + O * 100 + R * 10 + E #=
    M * 10000 + O * 1000 + N * 100 + E * 10 + Y,
    labeling([], Vars),
    % para facilitar a leitura
    write('  S E N D'), nl,
    write('+ M O R E'), nl,
    write('---------'), nl,
    write('M O N E Y'), nl, nl,
    write(' '), write(' '), write(S), write(' '), write(E), write(' '), write(N), write(' '), write(D), nl,
    write('+'), write(' '), write(M), write(' '), write(O), write(' '), write(R), write(' '), write(E), nl,
    write('---------'), nl,
    write(M), write(' '), write(O), write(' '), write(N), write(' '), write(E), write(' '), write(Y).

/*
    | ?- puzzle(3).
      S E N D
    + M O R E
    ---------
    M O N E Y

      9 5 6 7
    + 1 0 8 5
    ---------
    1 0 6 5 2
    yes
*/
puzzle(1) :-
    Vars = [D, O, N, A, L, G, E, R, B, T],
    domain(Vars, 0, 9),
    all_distinct(Vars),
    D * 100000 + O * 10000 + N * 1000 + A * 100 + L * 10 + D +
    G * 100000 * E * 10000 + R * 1000 + A * 100 + L * 10 + D #=
    R * 100000 + O * 10000 + B * 1000 + E * 100 + R * 10 + T,
    labeling([], Vars),
    % para facilitar a leitura
    write('  D O N A L D'), nl,
    write('+ G E R A L D'), nl,
    write('-------------'), nl,
    write('  R O B E R T'), nl, nl,
    write(' '), write(D), write(' '), write(O), write(' '), write(N), write(' '), write(A), write(' '), write(L), write(' '), write(D), nl,
    write('+'), write(G), write(' '), write(E), write(' '), write(R), write(' '), write(A), write(' '), write(L), write(' '), write(D), nl,
    write('-------------'), nl,
    write('  '), write(R), write(' '), write(O), write(' '), write(B), write(' '), write(E), write(' '), write(R), write(' '), write(T).

/*
    | ?- puzzle(1).
    no
*/

puzzle(2) :-
    Vars = [C, R, O, S, A, D, N, G, E],
    domain(Vars, 0, 9),
    all_distinct(Vars),
    C #\= 0, R #\= 0,
    C * 10000 + R * 1000 + O * 100 + S * 10 + S +
    R * 10000 + O * 1000 + A * 100 + D * 10 + S #=
    D * 100000 + A * 10000 + N * 1000 + G * 100 + E * 10 + R,
    labeling([], Vars),
    % para facilitar a leitura
    write('  C R O S S'), nl,
    write('+ R O A D S'), nl,
    write('-----------'), nl,
    write('D A N G E R'), nl, nl,
    write('  '), write(C), write(' '), write(R), write(' '), write(O), write(' '), write(S), write(' '), write(S), nl,
    write('+ '), write(R), write(' '), write(O), write(' '), write(A), write(' '), write(D), write(' '), write(S), nl,
    write('-----------'), nl,
    write(D), write(' '), write(A), write(' '), write(N), write(' '), write(G), write(' '), write(E), write(' '), write(R).
    
/*
    | ?- puzzle(2).                                                    
      C R O S S
    + R O A D S
    -----------
    D A N G E R

      9 6 2 3 3
    + 6 2 5 1 3
    -----------
    1 5 8 7 4 6
    yes
*/