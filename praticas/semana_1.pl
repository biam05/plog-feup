% 1

% pessoas do sexo masculino
male('Aldo Burrows').
male('Lincoln Burrows').
male('Michael Scofield').
male('LJ Burrows').

% pessoas do sexo feminino
female('Christina Rose Scofield').
female('Lisa Rix').
female('Sara Tancredi').
female('Ella Scofield').

% parentesco: parent(X, Y) -> X é filho de Y
parent('LJ Burrows', 'Lisa Rix').
parent('LJ Burrows', 'Lincoln Burrows').
parent('Lincoln Burrows', 'Aldo Burrows').
parent('Lincoln Burrows', 'Christina Rose Scofield').
parent('Ella Scofield', 'Michael Scofield').
parent('Ella Scofield', 'Sara Tancredi').
parent('Michael Scofield', 'Aldo Burrows').
parent('Michael Scofield', 'Christina Rose Scofield').

/*
Quem são os pais de Michael?
parent('Michael Scofield', X).

Quem são os filhos de Aldo?
parent(X, 'Aldo Burrows').
*/

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

% 3

% livros
book('Os Maias').

% autores
author('Eca de Queiroz').

% livros escritos: wrotebook(X, Y) -> o livro X foi escrito por Y
wrotebook('Os Maias', 'Eca de Queiroz').

% nacionalidades
nationality('portugues').
nationality('ingles').

% nacionalidade do autor: authorn(X, Y) -> o autor X é da nacionalidade Y
authorn('Eca de Queiroz', 'portugues').

% géneros
genre('romance').
genre('ficcao').

% géneros escritos pelo autor: wrotegenre(X, Y) -> o autor X escreve o género Y
wrotegenre('Eca de Queiroz', 'romance').

/*
Quem escreveu “Os Maias”?
wrotebook('Os Maias', X).

Que autores portugueses escrevem romances?
wrotegenre(X, 'romance'), authorn(X, 'portugues').

Quais os autores de livros de ficção que escreveram livros de outro tipo também?
wrotegenre(X, 'ficcao'), wrotegenre(X, _Y), 'ficcao' @< _Y.
*/




