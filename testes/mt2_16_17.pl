% -----------------------------------------------------------------------
% --------------------- BIBLIOTECAS USADAS NO TESTE --------------------- 
% -----------------------------------------------------------------------

% 1.
:- use_module(library(lists)).

:- use_module(library(clpfd)).

% 1. Explique o que faz o seguinte programa em Prolog e comente quanto à sua
% eficiência:

% p1(+L1, -L2)
% predicado que ordena uma lista de forma crescente ou decrescente, no
% entanto esta não pode ter valores repetidos e tem de ter no mínimo
% tamanho igual a 2
% Não é eficiente porque não utiliza restrições e também porque os ";"
% não são a maneira mais eficiente de ordenar de forma crescente/decrescente
p1(L1,L2) :-
    gen(L1,L2),
    test(L2).

% gen(+L1, +L2)
% percorre L2 e verifica se todos elementos existem em L1
gen([],[]).
gen(L1,[X|L2]) :-
    % X ocorre em L1 e L3 é L1 sem as ocorrências de X
    select(X,L1,L3),
    gen(L3,L2).

% text(-L)
% retorna uma lista ordenada de forma crescente/decrescente
test([_,_]).
test([X1,X2,X3|Xs]) :-
    % ou está ordenado de forma crescente ou de forma decrescente
    (X1 < X2, X2 < X3; X1 > X2, X2 > X3),
    test([X2,X3|Xs]).

% -----------------------------------------------------------------------
% -----------------------------------------------------------------------

% 2. O Asdrúbal resolveu implementar uma versão equivalente usando programação
% em lógica com restrições (PLR):

/* p2(L1,L2) :-
    length(L1,N),
    length(L2,N),
    %
    pos(L1,L2,Is),
    all_distinct(Is),
    %
    labeling([],Is),
    test(L2).
    
pos([],_,[]).
pos([X|Xs],L2,[I|Is]) :-
    nth1(I,L2,X),
    pos(Xs,L2,Is). */

% Contudo, após estudar melhor descobriu que o seu programa não era uma 
% implementação correta em PLR. Escolha a opção que melhor traduz essa
% constatação:

% As variáveis de domínio estão a ser instanciadas antes da fase de pesquisa
% e nem todas as restrições foram colocadas antes da fase da pesquisa.

% -----------------------------------------------------------------------
% -----------------------------------------------------------------------

% 3. Corrija o programa, de modo a obter uma implementação correta em PLR.

p2(L1,L2) :-
    length(L1,N),
    length(L2,N),
    pos(L1,L2,Is),
    all_distinct(Is),
    test(L2),
    labeling([],Is).
    
pos([],_,[]).
pos([X|Xs],L2,[I|Is]) :-
    element(I,L2,X),
    pos(Xs,L2,Is).

% text2(-L)
% retorna uma lista ordenada dinamicamente de forma crescente/decrescente
test2([_,_]).
test2([X1,X2,X3|Xs]) :-
    % ou está ordenado de forma crescente ou de forma decrescente
    ((X1 #< X2 #/\ X2 #< X3) ; (X1 #> X2 #/\ X2 #> X3)),
    test2([X2,X3|Xs]).

% ???

% -----------------------------------------------------------------------
% -----------------------------------------------------------------------

% 4. Para os seus cozinhados natalícios, o Bonifácio dispunha de um 
% determinado número de ovos, com prazo de validade próximo. Este era o único
% recurso limitado, dispondo ele de quantidades intermináveis de todos os
% outros ingredientes. Na sua lista de Cookings de doces, cada receita
% inclui, entre outras coisas, o tempo de preparação e o número de ovos que
% leva. O Bonifácio tem um tempo limitado para cozinhar, pretende fazer 3
% pratos diferentes de doce e gastar o maior número possível de ovos de que
% dispõe. Usando programação em lógica com restrições, construa um programa
% que determine que Cookings é que o Bonifácio deve fazer. O predicado
% sweet_recipes(+MaxTime,+NEggs,+RecipeTimes,+RecipeEggs,-Cookings,-Eggs)
% recebe o máximo de tempo disponível (MaxTime), o número de ovos disponíveis
% (NEggs), os tempos (RecipeTimes) e ovos (RecipeEggs) gastos por cada
% receita; devolve em Cookings os cozinhados a realizar (índices
% das listas RecipeTimes/RecipeEggs) e em Eggs os ovos utilizados.

% Exemplos:

% | ?- sweet_recipes(60,30,[20,50,10,20,15],[6,4,12,20,6],Cookings,Eggs).
% Cookings = [1,3,5],
% Eggs = 24
% | ?- sweet_recipes(120,30,[20,50,10,20,15],[6,4,12,20,6],Cookings,Eggs).
% Cookings = [1,2,4],
% Eggs = 30

sweet_recipes(MaxTime, NEggs, RecipeTimes, RecipeEggs,Cookings,Eggs):- 
    % NumCookings é o número de receitas que existem
    length(RecipeEggs, NumCookings),
    % obrigatoriamente retorna 3 pratos 
    length(Cookings, 3), 
    % receitas feitas pertencem ao intervalo [1, NumCookings]
    domain(Cookings, 1, NumCookings), 
    % número de ovos gastos pertence ao intervalo [0, NEggs]
    domain([Eggs], 0, NEggs), 
    % não se pode fazer uma receita mais que uma vez
    all_distinct(Cookings), 
    
    % obter tempos e ovos gastos no total
    findRecipes(Cookings, RecipeTimes, RecipeEggs, Time, Eggs),
    Eggs #=< NEggs,
    Time #=< MaxTime, 

    labeling([maximize(Eggs)], [Eggs, Time | Cookings]).    

findRecipes([],_,_,0,0).
findRecipes([IndexRecipe | Cookings], RecipeTimes, RecipeEggs, Time, Eggs) :-
    element(IndexRecipe, RecipeTimes, NewTime),
    element(IndexRecipe, RecipeEggs, NewEggs),
    Time #= NewTime + Time1,
    Eggs #= NewEggs + Eggs1,
    findRecipes(Cookings, RecipeTimes, RecipeEggs, Time1, Eggs1).

% -----------------------------------------------------------------------
% -----------------------------------------------------------------------

% 5. O Eleutério trabalha numa loja que corta prateleiras de madeira à medida. 
% Para efeitos deste exercício, consideramos apenas cortes numa dimensão 
% (isto é, assumimos que todas as prateleiras têm sempre a mesma largura). 
% A páginas tantas, o Eleutério dispõe de várias pranchas, cada qual com um 
% determinado comprimento, e precisa de cortar um conjunto de prateleiras,
% cada qual com a sua dimensão. Construa um programa, usando programação em 
% lógica com restrições, que determine em que prancha é que cada prateleira 
% deve ser cortada. O predicado cut(+Shelves,+Boards,-SelectedBoards) recebe 
% a lista de prateleiras a cortar Shelves com a dimensão (unidimensional) de 
% cada uma, e a lista Boards com o comprimento de cada prancha; devolve em 
% SelectedBoards as pranchas a utilizar para cada prateleira.

% Exemplos:
% | ?- cut([12,50,14,8,10,90,24], [100,45,70], S).
% S = [2,3,3,2,1,1,2] ? ;
% S = [3,3,2,3,1,1,2] ? ;
% no    

cut(Shelves, Boards, SelectedBoards) :-
    length(Shelves, N),
    length(TaskList, N),
    maplist(make_task, Shelves, TaskList, SelectedBoards),
    create_machines(1, Boards, MachinesList),
    cumulatives(TaskList, MachinesList, [bound(upper)]),
    labeling([], SelectedBoards).

make_task(CurrShelf, task(0, 1, 1, CurrShelf, Board), Board).

create_machines(_, [], []).
create_machines(ID, [CurrBoard|RestBoards], [machine(ID, CurrBoard)|RestMachines]) :-
    NextID is ID+1,
    create_machines(NextID, RestBoards, RestMachines).

% ???? https://github.com/GambuzX/MIEIC_plog/blob/master/Exams/mt2_2017.pl