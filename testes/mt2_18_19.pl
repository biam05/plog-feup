% -----------------------------------------------------------------------
% --------------------- BIBLIOTECAS USADAS NO TESTE --------------------- 
% -----------------------------------------------------------------------

:- use_module(library(clpfd)).
:- use_module(library(lists)).

% 1. 
% 2**(NK)

% -----------------------------------------------------------------------
% -----------------------------------------------------------------------

% 2.
% K**N

% -----------------------------------------------------------------------
% -----------------------------------------------------------------------

% 3.

% pres(+N, +K, -Vars)
% retorna uma lista com o indice do dono de cada presente. a escolha dos donos
% de cada presente tem a ver com o indice da pessoa e o indice do presente
%   - se o presente tiver indice impar, so pode ser recebido por pessoas com
%     indice par
%   - se o presente tiver indice par, so pode ser recebido por pessoas com 
%     indice impar
% essa decisao é feita no predicado indices
pres(N, K, Vars) :-
    % existem N presentes
    length(Vars, N),
    % existem K pessoas
    domain(Vars, 1, K),
    %
    indices(1, Vars),
    %
    labeling([], Vars).

indices(I, [V|Vs]) :-
    V mod 2 #\= I mod 2,
    I1 is I + 1,
    indices(I1, Vs).
indices(_,[]).

% -----------------------------------------------------------------------
% -----------------------------------------------------------------------

% 4.
% O limite inferior ou superior do domínio das variáveis é alterado porque
% para o fluxo normal do programa para fazer backtracking e descobrir o valor,
% tornando o domínio infinito

% -----------------------------------------------------------------------
% -----------------------------------------------------------------------

% 5.

constroi_binarias(I, K, Vars, [LBin|LBins]) :-
    I =< K, !,
    constroi_bins(I, Vars, LBin),
    I1 is I + 1,
    constroi_binarias(I1, K, Vars, LBins).
constroi_binarias(_,_,_,[]).

% recorre a materializações para construir a lista de variáveis binárias
% LBin e partir da comparação das variáveis em Vars com o inteiro I
constroi_bins(_,[],[]).
constroi_bins(I, [Var|Vars], [LBin|LBins]) :-
    % se I = Var, LBin = true
    I #= Var #<=> LBin,
    constroi_bins(I, Vars, LBins).

% -----------------------------------------------------------------------
% -----------------------------------------------------------------------

% 6. ???

% -----------------------------------------------------------------------
% -----------------------------------------------------------------------

% 7.

objeto(piano, 3, 30).
objeto(cadeira, 1, 10).
objeto(cama, 3, 15).
objeto(mesa, 2, 15).
homens(4).
tempo_max(60).

furniture :-

    findall(Duracao, objeto(X,Homem,Duracao), Duracoes),
    findall(Homem, objeto(X,Homem,Duracao), Homens),

    length(Duracoes, N),
    length(Homens, N),
    length(StartTimes, N),
    length(EndTimes, N),
    length(Tasks, N),

    tempo_max(MaxTime),
    
    domain(StartTimes, 0, MaxTime),
    domain(EndTimes, 0, MaxTime),

    homens(NHomens),

    createTasks(StartTimes, Duracoes, EndTimes, Homens, 1, Tasks),
    maximum(FinalTime, EndTimes),
    
    cumulative(Tasks,[limit(NHomens)]),
    labeling([minimize(FinalTime)], EndTimes),
    
    write('Total Time: '), write(MaxTime), nl,
    write('Start Times: '), write(StartTimes), nl,
    write('End Times: '), write(EndTimes).

createTasks([],[],[],[],_,[]).
createTasks([StartTime|Oi], [Duration|Di], [EndTime|Ei], [Recursos|Hi], Mi, [task(StartTime,Duration,EndTime,Recursos,Mi)|Tasks]) :-
    Mi2 is Mi + 1,
    createTasks(Oi, Di, Ei, Hi, Mi2, Tasks).
