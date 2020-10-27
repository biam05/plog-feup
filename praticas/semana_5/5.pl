/*
Defina o predicado unificavel(L1, Termo, L2) em que L2 é uma lista 
com todos os elementos de L1que são unificáveis com Termo. Os elementos de L2 não são no  
entanto unificados com Termo. 
*/

% Caso base
unificavel([], X, []).

unificavel([X1|L1], X, L2):-
% se T1=T2 resulta => not(T1=T2) falha ^ instanciação T1=T2 é anulado.
        X \= X1,
        !,
        unificavel(L1, X, L2).

unificavel([X1|L1], X, [X1|L2]):-
        unificavel(L1, X, L2).