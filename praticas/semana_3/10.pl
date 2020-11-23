% a
ordenada([X]).          % Caso Base : só 1 elemento na lista está automaticamente ordenado
ordenada([X1, X2]) :-   % Ordenação de 2 elementos
    X1 =< X2.
ordenada([X1, X2|L]) :-      
    integer(X1), integer(X2),
    X1 =< X2,
    ordenada([X2|L]).

% b -- insert sort
ordena(L1,L2):-i_sort(L1,[],L2).
i_sort([],Acc,Acc).
i_sort([H|T],Acc,Sorted):-insert(H,Acc,NAcc),i_sort(T,NAcc,Sorted).
   
insert(X,[Y|T],[Y|NT]):- X>Y,insert(X,T,NT).
insert(X,[Y|T],[X,Y|T]):-X=<Y.
insert(X,[],[X]).