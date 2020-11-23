% a
conta([], 0).                   % Caso Base : o número de elementos numa lista vazia é 0
conta([Head|Tail], N) :-
    conta(Tail, N1),            % Recursao
    N is N1 + 1.                % o valor total é igual ao valor obtido anteriormente + 1

% b
conta_elem(X, [], 0).           % Caso Base : o número de elementos X numa lista vazia é 0
% tem-se de fazer o caso de X ser igual à Head e X diferente da Head
conta_elem(X, [H|T], N) :-
    X \= H,                     % X é diferente da Head
    conta_elem(X, T, N).

conta_elem(X, [X|T], N) :-
    conta_elem(X, T, N1),       % X é igual à head
    N is N1 + 1.                % soma-se 1