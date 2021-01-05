:- use_module(library(clpfd)).

% 12 guardas são colocados a guardar um forte com 4 salas em cada lado. Se  
% um guarda estiver numa sala do lado só pode ver esse lado, enquanto se 
% estiver num canto pode ver dois lados. O objectivo é construir um programa 
% em PLR capaz de colocar 12 guardas no forte de forma a que cinco guardas 
% vigiem cada lado.

/*
    R1 R12 R11 R10
    R2         R9
    R3         R8
    R4 R5  R6  R7
*/

guardas :-
    Rooms = [R1, R2, R3, R4, R5, R6,R7, R8, R9, R10, R11, R12],
    domain(Rooms, 0, 12), % número de guardas

    R1 + R12 + R11 + R10 #= 5,
    R1 + R2 + R3 + R4 #= 5,
    R4 + R5 + R6 + R7 #= 5,
    R10 + R9 + R8 + R7 #= 5,    
    sum(Rooms, #=, 12),

    labeling([], Rooms),
    write(R1), write(' '), write(R12), write(' '), write(R11), write(' '), write(R10), nl,
    write(R2), write('     '), write(R9), nl,
    write(R3), write('     '), write(R8), nl,
    write(R4), write(' '), write(R5), write(' '), write(R6), write(' '), write(R7).

/*
    | ?- guardas.                                                      
    0 2 0 3
    0     2
    0     0
    5 0 0 0
    yes
*/