% factorial
% 2! = 1 * 2 = 2; 3! 1 * 2 * 3 = 6

factorial(0, 1).
factorial(N, Valor) :-
    N > 0,              % se n for maior, é o caso base, logo falha.
    N1 is N - 1,        % número anterior ao atual
    factorial(N1, V),   % factorial do numero anterior
    Valor is N * V.     % valor = numero atual * valor do factorial anterior

% fibonacci
% F2 = 1 + 1 = 2; F3 = 1 + 2 = 3; F4 = 2 + 3 = 5 

fibonacci(0, 1).
fibonacci(1, 1).
fibonacci(N, Valor) :-
    N > 1,              % se n for maior, é o caso base, logo falha.
    N1 is N - 1,        % número anterior ao atual
    N2 is N - 2,        % número anterior ao anterior
    fibonacci(N1, V1),  % fibonacci anterior
    fibonacci(N2, V2),  % fibonacci anterior ao anterior
    Valor is V1 + V2.   % valor = fibonacci anterior + fibonacci anterior ao anterior