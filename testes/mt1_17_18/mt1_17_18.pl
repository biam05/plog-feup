:- dynamic played/4.
:- use_module(library(lists)).
:- use_module(library(sets)).

%player(Name, UserName, Age).
player('Danny', 'Best Player Ever', 27).
player('Annie', 'Worst Player Ever', 24).
player('Harry', 'A-Star Player', 26).
player('Manny', 'The Player', 14).
player('Jonny', 'A Player', 16).

%game(Name, Categories, MinAge).
game('5 ATG', [action, adventure, open-world, multiplayer], 18).
game('Carrier Shift: Game Over', [action, fps, multiplayer, shooter], 16).
game('Duas Botas', [action, free, strategy, moba], 12).

%played(Player, Game, HoursPlayed, PercentUnlocked)
played('Worst Player Ever', '5 ATG', 52, 9).
played('Best Player Ever', '5 ATG', 3, 83).
played('The Player', 'Carrier Shift: Game Over', 44, 22).
played('A Player', 'Carrier Shift: Game Over', 48, 24).
played('A-Star Player', 'Duas Botas', 37, 16).
played('Best Player Ever', 'Duas Botas', 33, 22).

% ----------------------------- 1 ----------------------------- 
% sucede se o jogador Player jogou pelo menos 50h em algum jogo.
playedALot(Player) :-
    played(Player, Game, Hours, PercentUnlocked),
    Hours >= 50.

% ----------------------------- 2 ----------------------------- 
% sucede se Game é um jogo adequado à idade da pessoa Name.
isAgeAppropriate(Name, Game) :-
    player(Name, Username, Age),
    game(Game, Categories, MinAge),
    Age >= MinAge.

% ----------------------------- 3 ----------------------------- 
% atualiza a base de conhecimento relativamente ao número de horas que o jogador Player jogou
% o jogo Game.
updatePlayer(Player, Game, Hours, Percentage) :-
    retract(played(Player, Game, PastH, PastP)),
    NewH is PastH + Hours,
    NewP is PastP + Percentage,
    assert(played(Player, Game, NewH, NewP)).


% ----------------------------- 4 ----------------------------- 
% imprime na consola os títulos de todos os jogos que se enquadram na categoria Cat, 
% indicando ainda a idade mínima recomendada para cada jogo. Note que o predicado sucede 
% sempre.
listGamesOfCategory(Cat) :-
    game(Name, Categories, MinAge),
    isMember(Cat, Categories),
    format('~w (~w)~n', [Name, MinAge]), fail.
listGamesOfCategory(_). % para retornar sempre 'yes'

isMember(X, L) :- append(_, [X|_], L).


% ----------------------------- 5 ----------------------------- 
% determina o número total de horas que o jogador Player investiu a jogar cada um dos
% jogos indicados na lista Games, retornando em ListOfTimes os tempos de cada um dos
% jogos na ordem respetiva, e em SumTimes o número total de horas.
timePlayingGames(Player, Games, ListOfTime, SumTimes) :-
    getTimesList(Games, ListOfTime),
    sumList(ListOfTime, SumTimes).

sumList([], 0).
sumList([H|T], Sum) :-
   sumList(T, Rest),
   Sum is H + Rest.

getTimesList([], ListOfTime).
getTimesList([H|T], [HoursPlayed|ListOfTime]) :-
    played(Player, H, HoursPlayed, PercentUnlocked),
    getTimesList(T, L).

% ----------------------------- 6 ----------------------------- 
% devolve em Games a lista de jogos nos quais o jogador Player investiu menos de 
% 10h a jogar.
fewHours(Player, Games) :-
    fewHours(Player, [], Games).

fewHours(Player, L, Games) :-
    played(Player, Game, Hours, _),
    Hours < 10, \+member(Game, L),
    fewHours(Player, [Game | L], Games).
fewHours(_, Games, Games).
    

% -------------- NOT FINISHED -------------- 

% ----------------------------- 7 ----------------------------- 
% devolve em Players a lista dos nomes dos jogadores com idade compreendida entre
% MinAge e MaxAge
ageRange(MinAge, MaxAge, Players) :-
   findall(Name, (player(Name, _UserName, Age), (Age >= MinAge, Age =< MaxAge)), Players).

% ----------------------------- 8 ----------------------------- 
% determina a idade média dos jogadores que jogam o jogo Game.
averageAge(Game, AverageAge) :-
    findall(Age, (player(_Name, Player, Age), played(Player, Game, _, _)), Ages),
    sumList(Ages, A),
    length(Ages, L),
    AverageAge is A/L.

% ----------------------------- 9 ----------------------------- 
% determina o jogador ou jogadores que jogam o jogo Game com maior eficiência. O jogador 
% mais eficiente é aquele que conseguiu alcançar uma maior percentagem de conclusão do jogo 
% num menor número de horas.
mostEffectivePlayers(Game, Players) :-
    findall(Username-HoursPlayed-PercentUnlocked, played(Username, Game, HoursPlayed, PercentUnlocked), AuxPlayers),
    getValues(AuxPlayers, A),
    keysort(A, B),
    getUsernameList(B, Players).

getValues([],[]).
getValues([Username-HoursPlayed-PercentUnlocked|T], [Username-Value|V]) :-
    Value is PercentUnlocked/HoursPlayed,
    getValues(T, V).

getUsernameList([], []).
getUsernameList([P1-V1, P2-V2|T], [P1]) :-
    V1 > V2.
getUsernameList([P1-V1, P2-V2|T], [P1, P2]) :-
    V1 = V2.

% -------------- NOT FINISHED --------------

% ----------------------------- 10 ----------------------------- 
gamesAllowedToPlayer(Username):-
    player(Name, Username, Age), !,
    \+ ( played(Username, Game, Hours, Percentage),
        game(Game, Categories, MinAge),
        MinAge > Age ).

% determina se o jogador joga apenas jogos para o qual tem a idade mínima
    

