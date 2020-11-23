% pilotos
piloto('Lamb').
piloto('Besenyei').
piloto('Chambliss').
piloco('MacLean').
piloto('Mangold').
piloto('Jones').
piloto('Bonhomme').

% equipas; equipa(X, Y): X é da equipa Y
equipa('Lamb', 'Breitling').
equipa('Besenyei', 'Red Bull').
equipa('Chambliss', 'Red Bull').
equipa('MacLean', 'Mediterranean Racing Team').
equipa('Mangold', 'Cobra').
equipa('Jones', 'Matador').
equipa('Bonhomme', 'Matador').

% avioes; aviao(X, Y): Y é o avião de X
aviao('Lamb', 'MX2').
aviao('Besenyei', 'Edge540').
aviao('Chambliss', 'Edge540').
aviao('MacLean', 'Edge540').
aviao('Mangold', 'Edge540').
aviao('Jones', 'Edge540').
aviao('Bonhomme', 'Edge540').

% circuitos
circuito('Istanbul').
circuito('Budapest').
circuito('Porto').

% vitorias; vitoria(X, Y): X ganhou em Y
vitoria('Jones', 'Porto').
vitoria('Mangold', 'Budapest').
vitoria('Mangold', 'Istanbul').

% gates; gates(X, Y): X tem Y gates
gates('Istanbul', 9).
gates('Budapest', 6).
gates('Porto', 5).

% vitoria de uma equipa: vitoriaEquipa(X, Y): a equipa X ganhou a corrida Y
vitoriaEquipa(X, Y) :-
    equipa(Z, X),   % o piloto Z é da equipa X
    vitoria(Z, Y).  % o piloto Z ganhou a corrida Y

/* Venceu corrida no Porto : vitoria(X, 'Porto').
X = 'Jones'. */

/* Equipa que ganhou no Porto : vitoriaEquipa(X, 'Porto')
X = 'Matador'. */

/* Venceram mais de um Circuito : vitoria(X, _Y), vitoria(X, _Z), _Y @< _Z
X = 'Mangold'. */

/* Circuitos com mais que 8 gates : gates(X, _Y), _Y > 8.
X = 'Istanbul'. */

/* Pilotos que não pilotam um Edge540 : aviao(X, _Y), _Y \= 'Edge540'
X = 'Lamb'. */