:- use_module(library(clpfd)).
/*
    12 automóveis estão parados, em fila indiana, num cruzamento com 
    semáforos. Sabe-se que:
        - Os automóveis têm a seguinte distribuição de cores: 4 amarelos, 2 
    verdes, 3 vermelhos e 3 azuis;    
        - O primeiro e o último automóvel são da mesma cor;
        - O segundo e o penúltimo são da mesma cor;
        - O quinto automóvel é azul;
        - Todos os conjuntos de 3 automóveis consecutivos têm 3 cores 
    distintas;
        - Partindo do primeiro automóvel para o último, é possível visualizar
    a sequência amarelo-verde-vermelho-azul uma única vez.

    Qual a cor de cada um dos doze carros parados no semáforo?
*/

/*
    1 - Amarelo
    2 - Verde
    3 - Vermelho
    4 - Azul
*/
carros :-
    Carros = [A, B, C, D, 4, F, G, H, I, J, B, A],
    % amarelo - 1 vez       verde - 2 vezes
    % vermelho - 3 vezes    azul - 3 vezes
    global_cardinality(Carros, [1-4, 2-2, 3-3, 4-3]), 
    % todos os conjuntos de 3 automóveis consecutivos têm 3 cores distintas
    sub_sequencia(Carros),
    % sequência amarelo-verde-vermelho-azul uma única vez
    sequencia_unica(Carros, 1),
    labeling([], Carros),
    print(Carros).

% todos os conjuntos de 3 automóveis consecutivos têm 3 cores distintas
sub_sequencia([]).
sub_sequencia([_]).
sub_sequencia([_,_]).
sub_sequencia([X, Y, C | Tail]) :-
    all_distinct([X, Y, C]),
    sub_sequencia([Y, C | Tail]).

% sequência amarelo-verde-vermelho-azul uma única vez
sequencia_unica([_,_,_],0).
sequencia_unica([X, Y, Z, W | Tail], Count) :-
    (X #= 1 #/\ Y #= 2 #/\ Z #= 3 #/\ W #= 4) #<=> B,
    Count #= Count1 + B,
    sequencia_unica([Y,Z,W|Tail], Count1).

print([]).
print([H|T]) :-
    write(H),
    print(T).