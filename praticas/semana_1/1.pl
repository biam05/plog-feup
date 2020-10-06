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