% a
delete_one(X, L1, L2) :-
    append(La, [X|Lb], L1),     % L1 = [La, X, Lb] (atribui valores a La e Lb para retornar yes)
    append(La, Lb, L2).         % L2 = [La, Lb], Logo L2 é L1 sem X

% b
delete_all(X, [], []).              % Caso base
delete_all(X, [X| L1], Ans) :- 
	delete_all(X, L1, Ans).         % Elimina o primeiro elemento  

delete_all(X, [Y|L1], [Y|Ans]):-    % ???????????
	X \= Y,                     
	delete_all(X, L1, Ans).

% c
delete_all_list(LX, [X|L1], [X|Ans]):-
	\+ member(X, LX),                   % continua se o primeiro elemento da resposta não for membro
	delete_all_list(LX, L1, Ans).       % chama para o próximo elemento

delete_all_list(LX, [X|L1], Ans):-
	member(X, LX),                      % continua se for membro
	delete_all_list(LX, L1, Ans).       % chama para o próximo elemento

delete_all_list(LX, [], []).            % caso base
