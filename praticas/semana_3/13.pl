% a
lista_ate(0, []).   
lista_ate(N, [N|L]) :-  
	N >=1,
	N1 is N-1, 
	lista_ate(N1, L). 

% b
lista_entre(N2, N2, [N2]).  
lista_entre(N1, N2, [N1|L]):- 
	N_next is N1+1,  
	lista_entre(N_next, N2, L). 

% c
soma_lista([], 0).
soma_lista([X|L], Soma) :-
	soma_lista(L, S),
	Soma is S+X.

% d
par(N) :-
	0 is mod(N, 2).

% e
lista_pares(0, [0]).
lista_pares(N, L) :-
	N >= 0,
	1 is mod(N, 2),
	N1 is N - 1,
	lista_pares(N1, L).
lista_pares(N, [N|L]) :-
	N >= 0,
	0 is mod(N, 2),
	N1 is N - 1,
	lista_pares(N1, L).

% f
lista_impares(0, []).
lista_impares(N, L) :-
	N >= 0,
	\+(1 is mod(N, 2)),
	N1 is N - 1,
	lista_impares(N1, L).
lista_impares(N, [N|L]) :-
	N >= 0,
	\+(0 is mod(N, 2)),
	N1 is N - 1,
	lista_impares(N1, L).