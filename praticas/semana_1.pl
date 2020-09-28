male('Aldo Burrows').
male('Lincoln Burrows').
male('Michael Scofield').
male('LJ Burrows').

female('Christina Rose Scofield').
female('Lisa Rix').
female('Sara Tancredi').
female('Ella Scofield').

parent('LJ Burrows', 'Lisa Rix').
parent('LJ Burrows', 'Lincoln Burrows').
parent('Lincoln Burrows', 'Aldo Burrows').
parent('Lincoln Burrows', 'Christina Rose Scofield').
parent('Ella Scofield', 'Michael Scofield').
parent('Ella Scofield', 'Michael Scofield').
parent('Michael Scofield', 'Aldo Burrows').
parent('Michael Scofield', 'Christina Rose Scofield').

/*
Quem são os pais de Michael?
parent('Michael Scofield', X).
Quem são os filhos de Aldo?
parent(X, 'Aldo Burrows').
*/

