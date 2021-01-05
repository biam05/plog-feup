:- use_module(library(clpfd)).

% Uma factura antiga revela que 72 perus foram comprados por "-67-" escudos. 
% O primeiro e o último algarismo estão ilegíveis. Construa um programa PLR 
% capaz de determinar quanto é que, na época, custava cada peru.

peru(Preco, PrecoTotal) :-
    Vars = [X, W],
    domain(Vars, 1, 9),
    (X * 1000) + (6 * 100) + (7 * 10) + (W * 1) #= PrecoTotal,
    Preco * 72 #= PrecoTotal,
    labeling([], Vars).
/*
    | ?- peru(Preco, PrecoTotal).                                      
    Preco = 51,
    PrecoTotal = 3672 ? ;
    no
*/