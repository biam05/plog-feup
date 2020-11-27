:- use_module(library(lists)).

%participant(Id,Age,Performance)
participant(1234, 17, 'Pé coxinho').
participant(3423, 21, 'Programar com os pés').
participant(3788, 20, 'Sing a Bit').
participant(4865, 22, 'Pontes de esparguete').
participant(8937, 19, 'Pontes de pen-drives').
participant(2564, 20, 'Moodle hack').

%performance(Id,Times)
performance(1234,[120,120,120,120]).
performance(3423,[32,120,45,120]).
performance(3788,[110,2,6,43]).
performance(4865,[120,120,110,120]).
performance(8937,[97,101,105,110]).

% sucede se Participant é um participante que já atuou e em cuja atuação pelo menos 
% um elemento do júri não carregou no botão.
madeItThrough(Participant) :-
    performance(Participant, Times),
    conta_elem(120, Times, N),
    N >= 1.

conta_elem(X, [], 0).
conta_elem(X, [H|T], N) :-
    X \= H,
    conta_elem(X, T, N).
conta_elem(X, [X|T], N) :-
    conta_elem(X, T, N1),
    N is N1 + 1.

% devolve em Times o tempo de atuação de cada participante na lista Participants
% (pela mesma ordem) até que o júri número JuriMember (de 1 a E) carregou no botão,
% e em Total a soma desses tempos.
juriTimes(Participants, JuriMember, Times, Total) :-
    getJuriNList(JuriMember, Participants, Times),
    sumList(Times, Total).

sumList([],0).
sumList([H|T], Sum) :-
    sumList(T, S1),
    Sum is H + S1.

nth_membro(1,[M|_],M).
nth_membro(N,[_|T],M):- N>1,  N1 is N-1,  nth_membro(N1,T,M).

getJuriNList(_JuriMember, [], []).
getJuriNList(JuriMember, [P|T], [Time|Times]) :-
    performance(P, L),
    nth_membro(JuriMember, L, Time),
    getJuriNList(JuriMember, T, Times).

% sucede se o júri JuriMember já se absteve de carregar no botão pelo menos por duas vezes
patientJuri(JuriMember) :-
    performance(P1, Juris1),
    performance(P2, Juris2),
    P1 \= P2,
    nth_membro(JuriMember, Juris1, 120),
    nth_membro(JuriMember, Juris2, 120).

% unifica P com o melhor dos dois participantes P1 e P2. O melhor participante é
% aquele que tem uma maior soma de tempos na sua atuação (independentemente de
% estar ou não em condições de passar à próxima fase). Se ambos tiverem o mesmo tempo
% total, o predicado deve falhar.
bestParticipant(P1, P2, P) :-
    performance(P1, Juris1),
    performance(P2, Juris2),
    sumList(Juris1, Total1),
    sumList(Juris2, Total2),
    Total1 > Total2,
    P is P1.
bestParticipant(P1, P2, P) :-
    performance(P1, Juris1),
    performance(P2, Juris2),
    sumList(Juris1, Total1),
    sumList(Juris2, Total2),
    Total1 < Total2,
    P is P2.

% imprime na consola os números dos participantes que já atuaram, juntamente com o nome da 
% sua atuação e lista de tempos.
allPerfs :- 
    performance(ID, Times),
    once(participant(ID, _Age, Name)),   
    write(ID),write(':'),write(Name),write(':'),write(Times), nl,
    fail.
allPerfs.

% determina quantos participantes não tiveram qualquer clique no botão durante a sua atuação.
nSuccessfulParticipants(T) :-
    setof(ID, (performance(ID, Times), no_click_of_button(Times)), Participants),
    length(Participants, T).

no_click_of_button([]).
no_click_of_button([Head|Tail]):-
    Head == 120,
    no_click_of_button(Tail).

% uma lista contendo, para cada participante, a lista dos elementos do júri que
% não carregaram no botão ao longo da sua atuação.
juriFans(JuriFansList):-
    setof(Participant-Preferences, goal(Participant, Preferences), JuriFansList).

goal(Participant, Preferences):-
    performance(Participant,Times),
    % once para nao voltar a usar esta clausula quando estiver a "subir" no backtrack
    once(get_favorite_juris(Times, Preferences, 1)).

get_favorite_juris([], [], _).
get_favorite_juris([Head|Tail], [Head_P|Tail_P], Index):-
    Head == 120,
    Head_P is Index,
    Index2 is Index +1,
    get_favorite_juris(Tail, Tail_P, Index2).

get_favorite_juris([_Head|Tail], Preferences, Index):-
    Index2 is Index +1,
    get_favorite_juris(Tail, Preferences, Index2).

% obter participantes, suas atuações e tempos totais, que estejam em condições
% de passar à próxima fase: para um participante poder passar, tem de haver pelo
% menos um elemento do júri que não tenha carregado no botão durante a sua atuação.
eligibleOutcome(Id,Perf,TT) :-
    performance(Id,Times),
    madeItThrough(Id),
    participant(Id,_,Perf),
    sumlist(Times,TT).

% obtém a lista com os tempos totais, números e atuações dos N melhores participantes,
% que passarão portanto à próxima fase. Se não houver pelo menos N participantes a passar,
% o predicado deve falhar.
nextPhase(N, Participants):-
    setof(TT-Id-Perf, eligibleOutcome(Id, Perf, TT), List_Temp),
    length(List_Temp, Size_List),
    Size_List >= N,
    Diff is Size_List - N,
    cut_out_best(Diff, List_Temp, Participants_Reversed), % podia ter usado reverse...
    reverse_my_list(Participants_Reversed, Participants, []).
    
reverse_my_list([],_X,_X).
reverse_my_list([Head_Ori|Tail_Ori], Result, Acc):-
    reverse_my_list(Tail_Ori, Result, [Head_Ori|Acc]).

cut_out_best(0, _Lista, _Lista).
cut_out_best(N, [_Head|Tail], Result):-
    NewN is N-1,
    cut_out_best(NewN, Tail, Result).




% langford
impoe(X,L) :-
    length(Mid,X),
    append(L1,[X|_],L), append(_,[X|Mid],L1).

impoeRestricoes(0, L, L).
impoeRestricoes(N, L, LF) :-
    impoe(N, L),
    NewN is N - 1,
    impoeRestricoes(NewN, L, LF).

langford(N, L) :-
    Size is 2 * N,      % sequencia de 2 * N numeros
    length(LAux, Size), % criar a lista de 2 * N numeros
    impoeRestricoes(N, LAux, L).


