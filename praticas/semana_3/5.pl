% a.
membro(X, L) :- L = [X|_].      % Caso base : yes se o elemento atual for igual a X
membro(X, L) :-
    L = [_|Tail],               % Dividir L em _ e Tail
    membro(X, Tail).            % Chamar novamente para Tail

% b.
membro(X, L) :- append(_, [X|_], L).    
% verifica se L é a concatenação de _ e [X|_]; falha quando
% X não pertence a L

% c
last(L, X) :- append(_, [X], L).
% verifica se L é a concatenação de _ e X; falha quando
% X não é o último elemento de L, porque o append dá append
% no final

% d
nth_membro(1, [M|_], M).        % Caso base : o primeiro elemento de uma lista é a Head
nth_membro(N, [_|T], M) :-      % Recursao
    N > 1,                      % N tem de ser > 1 se não é o caso base 
    N1 is N - 1,                % posicao anterior na lista
    nth_membro(N1, T, M).       % repetir, até chegar ao primeiro
