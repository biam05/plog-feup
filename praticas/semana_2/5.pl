temFator(N, L) :- N mod L =:= 0. % tem um fator se N a dividir por L for resto 0 (CASO BASE)
temFator(N, L) :- 
    L * L < N,          % para continuar verificação, o quadrado de L tem de ser menor que N
    L2 is L + 2,        % ???
    temFator(N, L2).
 
e_primo(2).
e_primo(3).
e_primo(N) :-
    integer(N),         % é um número inteiro
    N > 3,              % maior que 3, se não é caso base
    N mod 2 =\= 0,      % não é par
    \+ temFator(N, 3).  % não tem fatores
