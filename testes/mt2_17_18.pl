% -----------------------------------------------------------------------
% --------------------- BIBLIOTECAS USADAS NO TESTE --------------------- 
% -----------------------------------------------------------------------

% 1.
:- use_module(library(lists)).
:- use_module(library(between)).

:- use_module(library(clpfd)).

% 1. Explique o que faz o seguinte programa em Prolog. O predicado 
% between(+Inf,+Sup,-X) unifica X com valores no intervalo fechado [Inf,Sup].

% prog1(+N, +M, -L1, -L2)
% retorna L1 com dimensão N e L2 com dimensão N - 1, sendo que nenhum dos
% valores é inferior a 1 ou superior a M e, para além disso, cada par de
% elementos de L1 é igual ao elemento de L2 (NOTA: nenhum elemento de L1
% igual a qualquer elemento de L2 e vice-versa)
prog1(N,M,L1,L2) :-
    % força lista L1 a ter dimensão N
    length(L1,N),       
    % força lista L2 a ter dimensão N - 1
    N1 is N-1, length(L2,N1),
    % LE é a lista com todas as soluções de E que se encontram no intervalo
    % fechado [1, M]
    findall(E,between(1,M,E),LE), 
    % preenchimento de L1  
    fill(L1,LE,LE_),  
    % preenchiemnto de L2              
    fill(L2,LE_,_),  
    % verifica se a soma de cada par de elementos de L1 é igual ao elemento
    % de L2               
    check(L1,L2).                   

% fill(-L, +Laux, +Laux_)
% preenche L
fill([],LEf,LEf).
fill([X|Xs],LE,LEf) :-
% LE é uma lista onde ocorre X e LE_ é tudo exceto esse X
    select(X,LE,LE_),               
    fill(Xs,LE_,LEf).

% check(+L1, +L2)
% verifica se a soma de cada par de L1 é igual ao valor correspondente de L2
check([_],[]).
check([A,B|R],[X|Xs]) :-
    % verifica se A + B igual a X
    A+B =:= X,                     
    check([B|R],Xs).

% | ?- prog1(4, 10, L1, L2).
% L1 = [1,2,4,5],
% L2 = [3,6,9] ? 
% yes
%   1 - todos os valores entre 1 e 10
%   2 - dimensão de L1 é 4 e dimensão de L2 é 3 (4 - 1)
%   3 - 1 + 2 = 3, 2 + 4 = 6, 4 + 5 = 9
%   4 - todos os valores de L1 são diferentes de L2 e vice-versa

% -----------------------------------------------------------------------
% -----------------------------------------------------------------------

% 2. Identifique a dimensão do espaço de procura do problema anterior
%
%   M**(2N - 1)
%   os valores estão obrigatoriamente entre 1 e M
%   N + N - 1 é a dimensão total das duas listas => 2N - 1

% -----------------------------------------------------------------------
% -----------------------------------------------------------------------

% 3. O Severino verificou que o programa anterior obtinha soluções simétricas,
% pelo que pensou em reduzir o espaço de procura através da eliminação de 
% simetrias. Resolveu implementar uma versão equivalente usando programação 
% em lógica com restrições (PLR):

% prog2(N,M,L1,L2) :-
%    length(L1,N),
%    N1 is N-1, length(L2,N1),
%    domain(L1,1,M),
%    domain(L2,1,M),
%    check(L1,L2),
%    labeling([],L1). 

% Esta resolução, incompleta, vai obter soluções que não fazem parte do 
% problema original. Complete-a, corrija-a e concretize a intenção do 
% Severino de eliminar simetrias.

prog2(N,M,L1,L2) :-
    length(L1,N),
    N1 is N-1, length(L2,N1),
    domain(L1,1,M),
    domain(L2,1,M),
    % criar uma lista com todos os valores das duas listas
    append(L1, L2, Laux),
    % força a que todos os valores de ambas as lista são diferentes entre si
    all_distinct(Laux),    
    % iguala check mas dinâmico  
    checkDynamic(L1,L2),
    labeling([],L1). 

% checkDynamic(+L1, +L2)
% verifica dinamicamente se a soma de cada par de L1 é igual ao valor 
% correspondente de L2
checkDynamic([_],[]).
checkDynamic([A,B|R],[X|Xs]) :-
    % verifica dinamicamente se A + B igual a X
    A+B #= X,                    
    checkDynamic([B|R],Xs).

% -----------------------------------------------------------------------
% -----------------------------------------------------------------------

% 4. Uma escola de ginástica acrobática pretende ter um programa que obtenha, 
% forma automática, emparelhamentos de alunos para as suas aulas. 

% Dadas as alturas dos homens e das mulheres presentes na aula em igual número,
% pretendem-se emparelhamentos em que a diferença de alturas entre o homem e 1
% mulher seja inferior a um delta. O homem nunca poderá ser mais baixo do que 
% a mulher. 

% Construa um programa em PLR que permita obter estes emparelhamentos. 
% Soluções simétricas devem ser evitadas. O predicado
% gym_pairs(+MenHeights,+WomenHeights,+Delta,-Pairs) recebe as alturas dos 
% homens e das mulheres (listas com o mesmo tamanho) e a diferença máxima de 
% alturas; devolve em Pairs os emparelhamentos de pessoas, identificadas pelo 
% seu índice, que cumpram as restrições.

% Exemplos:
% | ?- gym_pairs([95,78,67,84],[65,83,75,80],10,Pairs).
% no
% | ?- gym_pairs([95,78,67,84],[65,83,75,86],10,Pairs).
% Pairs = [1-4,2-3,3-1,4-2] ? ;
% no
% | ?- gym_pairs([95,78,67,84],[65,77,75,86],10,Pairs).
% Pairs = [1-4,2-2,3-1,4-3] ? ;
% Pairs = [1-4,2-3,3-1,4-2] ? ;
% no

gym_pairs(MenHeights, WomenHeights, Delta, Pairs) :-
    % forçar que existem tantas alturas de homens como de mulheres
    length(MenHeights, Length),
    length(WomenHeights, Length),
    % criar listas dom indices de homens e de mulheres
    length(WomenIndex, Length),
    % dominio de indices é de 1 até numero de alturas
    domain(WomenIndex, 1, Length),
    % indices 1 ... Length
    all_distinct(WomenIndex),  
    % predicado que aplica as restrições e obtem as mulheres ordenadas
    findPairs(MenHeights, WomenHeights, Delta, WomenIndex),
    labeling([], WomenIndex),
    % predicado que crias pares de mulheres e homens e guarda em Pairs
    createPairs(1, WomenIndex, Pairs).

% findPairs(+MenHeights, +WomenHeights, +Delta, -WomenIndexes)
% ordena as mulheres tendo em conta as restrições do enunciado
findPairs([],_,_,_).
findPairs([MenHeight|RestMen], WomenHeights, Delta, [WomenIndex|RestWomen]) :-
    element(WomenIndex, WomenHeights, CurrHeight),
    % O homem nunca poderá ser mais baixo do que a mulher. 
    MenHeight #> CurrHeight,
    % a diferença de alturas entre o homem e 1 mulher é inferior a delta
    MenHeight - CurrHeight #=< Delta,
    findPairs(RestMen, WomenHeights, Delta, RestWomen).

% createPairs(+I, +WomenIndexes, -Pairs)
% crias pares de mulheres e homens e guarda em Pairs
createPairs(_,[],[]).
createPairs(I, [W|TW], [I-W|T]) :-
    % homens estão obrigatoriamente ordenados, por isso pode-se só 
    % incrementar 1
    Next is I + 1,
    createPairs(Next, TW, T).

% -----------------------------------------------------------------------
% -----------------------------------------------------------------------

% 5. Uma escola de patinagem artística pretende ter um programa que obtenha,
% de forma automática, emparelhamentos de alunos para as suas aulas.

% Dadas as alturas dos homens e das mulheres presentes na aula, pretendem-se
% emparelhamentos em que a diferença de alturas entre o homem e a mulher seja
% inferior a um delta. O homem nunca poderá ser mais baixo do que a mulher.

% Por vezes não é possível emparelhar todas as pessoas presentes numa aula. 
% Contudo, é útil saber que pares é possível formar, ficando as pessoas não 
% emparelhadas a assistir à aula. Pode até acontecer que o número de homens e
% de mulheres na aula sejam diferentes, o que inviabiliza a constituição de
% pares para todas as pessoas.

% Construa um programa em PLR que permita obter o maior número possível de
% emparelhamentos. O predicado
% optimal_skating_pairs(+MenHeights,+WomenHeights,+Delta,-Pairs) recebe as
% alturas dos homens e das mulheres (listas não necessariamente com o mesmo
% tamanho) e a diferença máxima de alturas; devolve em Pairs o maior número
% possível de emparelhamentos de pessoas, identificadas pelo seu índice, que
% cumpram as restrições.

% Exemplos:
% | ?- optimal_skating_pairs([95,78,67,84],[65,83,75,80],10,Pairs).
% Pairs = [2-3,3-1,4-2]
% | ?- optimal_skating_pairs([95,78,67,84,65,90,77],[65,83,75,80],10,Pairs).
% Pairs = [4-4,5-1,6-2,7-3]
% | ?- optimal_skating_pairs([65,83,75,80],[95,78,67,84,65,90,77],10,Pairs).
% Pairs = [1-5,2-2,3-3,4-7]
% | ?- optimal_skating_pairs([95,78,67,84,65,90,77],[55,83,75,80],10,Pairs).
% Pairs = [4-4,6-2,7-3]
% | ?- optimal_skating_pairs([55,83,75,80],[95,78,67,84,65,90,77],10,Pairs).
% Pairs = [2-2,3-3,4-7]

optimal_skating_pairs(MenHeights, WomenHeights, Delta, Pairs) :-
    % forçar que existem tantas alturas de homens como de mulheres
    length(MenHeights, Length),
    length(WomenHeights, Length),
    % criar listas dom indices de homens e de mulheres
    length(WomenIndex, Length),
    length(MenIndex, Length),
    % dominio de indices é de 1 até numero de alturas
    domain(WomenIndex, 1, Length),
    domain(MenIndex, 1, Length),
    % indices 1 ... Length
    all_distinct(WomenIndex),  
    all_distinct(MenIndex),   
    % predicado que aplica as restrições e obtem as mulheres ordenadas
    findPairs(MenHeights, WomenHeights, Delta, WomenIndex),
    labeling([], WomenIndex),
    % predicado que crias pares de mulheres e homens e guarda em Pairs
    createPairs(1, WomenIndex, Pairs).

% NAO TERMINADO, nao tive paciencia, rip 6 valores