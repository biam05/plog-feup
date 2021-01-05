:- use_module(library(clpfd)).

% 4 carros, de cores amarelas, verde, azul, e preta, estão em fila. 
% Sabe-se que o carro que está imediatamente antes do carro azul é menor do 
% que o que está imediatamente depois do carro azul; que o carro verde é o 
% menor de todos, que o carro verde está depois do carro azul, e que o carro
% amarelo está depois do preto. A questão a resolver é a seguinte:
% O primeiro carro: a) é amarelo; b) é azul; c) é preto; d) é verde; e) não 
% pode ser determinado com estes dados?

% 1 - Yellow, 2 - Green, 3 - Blue, 4 - Black
% 1 - menor, 4 - maior
filaCarros :-
    length(Cor, 4), length(Tam, 4),
    domain(Cor, 1, 4), domain(Tam, 1, 4),
    all_distinct(Cor), all_distinct(Tam),
    element(X, Cor, 2), element(X, Tam, 1), % o carro verde é o mais pequeno
    element(Blue, Cor, 3), X #> Blue,       % verde depois do azul
    element(Y, Cor, 1), element(Black, Cor, 4), Y #> Black, % amarelo depois do preto
    % antes do azul é menor do que o que está imediatamente depois do azul
    AntesBlue #= Blue - 1, DepoisBlue #= Blue + 1,
    element(AntesBlue, Tam, TAA), element(DepoisBlue, Tam, TDA), TAA #< TDA,
    append(Cor, Tam, Vars), labeling([], Vars), write(Vars).

/*
    | ?- filaCarros.                                                      
    [4,3,1,2,2,3,4,1]
    yes

    preto - azul - amarelo - verde
    verde < preto < amarelo < azul
*/