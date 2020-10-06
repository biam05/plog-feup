% 2

% pilotos
pilot('Lamb').
pilot('Besenyei').
pilot('Chambliss').
pilot('MacLean').
pilot('Mangold').
pilot('Jones').
pilot('Bonhomme').

% equipas: team(X, Y) -> a equipa de X é Y
team('Lamb', 'Breitling').
team('Besenyei', 'Red Bull').
team('Chambliss', 'Red Bull').
team('MacLean', 'Mediterranean Racing Team').
team('Mangold', 'Cobra').
team('Jones', 'Matador').
team('Bonhomme', 'Matador').

% aviões: airplane(X, Y) -> Y é o avião de X
airplane('Lamb', 'MX2').
airplane('Besenyei', 'Edge540').
airplane('Chambliss', 'Edge540').
airplane('MacLean', 'Edge540').
airplane('Mangold', 'Edge540').
airplane('Jones', 'Edge540').
airplane('Bonhomme', 'Edge540').

% circuitos
circuit('Istanbul').
circuit('Budapest').
circuit('Porto').

% vitórias: win(X, Y) -> o piloto Y venceu no circuito X
win('Porto', 'Jones').
win('Budapest', 'Mangold').
win('Istanbul', 'Mangold').

% gates: gates(X, Y) -> o circuito X tem Y gates
gates('Istanbul', 9).
gates('Budapest', 6).
gates('Porto', 5).

% vitória de equipa: teamwin(X, Y), a equipa X ganhou em Y se o piloto Z pertencer à equipa
% X e o piloto Z ganhar no circuito Y.
teamwin(X, Y) :- win(Y, Z), team(Z, X).

/*
Quem venceu a corrida no Porto?
win('Porto', X).

Qual a equipa que ganhou no Porto?
teamwin(X, 'Porto').

Quais os pilotos que venceram mais de um circuito?
win(_Y, X) , win(_Z, X), _Y @< _Z.

Que circuitos têm mais de 8 gates?
gates(X, Y), Y > 8.

Que pilotos não pilotam um Edge540?
airplane(X, Y), Y \= 'Edge540'.
*/