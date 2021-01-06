% ------------------------------------------------
% ---------- BIBLIOTECAS USADAS NO TESTE ---------
% ------------------------------------------------

:- use_module(library(lists)).
:- use_module(library(between)).

% 1. Explique o que faz o seguinte programa em Prolog. O predicado 
% between(+Inf,+Sup,-X) unifica X com valores no intervalo fechado [Inf,Sup].

% prog1(+N, +M, -L1, -L2)
% retorna L1 com dimensão N e L2 com dimensão N - 1, sendo que nenhum dos
% valores é inferior a 1 ou superior a M e, para além disso, cada par de
% elementos de L1 é igual ao elemento de L2
prog1(N,M,L1,L2) :-
    length(L1,N),                   % força lista L1 a ter dimensão N
    N1 is N-1, length(L2,N1),       % força lista L2 a ter dimensão N - 1
    findall(E,between(1,M,E),LE),   % LE é a lista com todas as soluções 
                                    %   de E que se encontram no intervalo
                                    %   fechado [1, M]
    fill(L1,LE,LE_),                % preenchimento de L1
    fill(L2,LE_,_),                 % preenchiemnto de L2
    check(L1,L2).                   % verifica se a soma de cada par de 
                                    %   elementos de L1 é igual ao elemento
                                    %   de L2

% fill(-L, +Laux, +Laux_)
% preenche L
fill([],LEf,LEf).
fill([X|Xs],LE,LEf) :-
    select(X,LE,LE_),               % LE é uma lista onde ocorre X e
                                    %   LE_ é tudo exceto esse X
    fill(Xs,LE_,LEf).

% check(+L1, +L2)
% verifica se a soma de cada par de L1 é igual ao valor correspondente de L2
check([_],[]).
check([A,B|R],[X|Xs]) :-
    A+B =:= X,                      % verifica dinamicamente se A + B igual a X
    check([B|R],Xs).

% | ?- prog1(4, 10, L1, L2).
% L1 = [1,2,4,5],
% L2 = [3,6,9] ? 
% yes
%   1 - todos os valores entre 1 e 10
%   2 - dimensão de L1 é 4 e dimensão de L2 é 3 (4 - 1)
%   3 - 1 + 2 = 3, 2 + 4 = 6, 4 + 5 = 9
