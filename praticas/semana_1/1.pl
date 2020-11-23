% male characters
male('Aldo Burrows').
male('Lincoln Burrows').
male('Michael Scofield').
male('LJ Burrows').

% female characters
female('Christina Rose Scofield').
female('Lisa Rix').
female('Sara Tancredi').
female('Ella Scofield').

% parent relationship -> parent(X, Y): X is the parent of Y
parent('Aldo Burrows', 'Lincoln Burrows').
parent('Aldo Burrows', 'Michael Scofield').

parent('Christina Rose Scofield', 'Lincold Burrows').
parent('Christina Rose Scofield', 'Michael Scofield').

parent('Lisa Rix', 'LJ Burrows').
parent('Lincoln Burrows', 'LJ Burrows').

parent('Michael Scofield', 'Ella Scofield').
parent('Sara Tancredi', 'Ella Scofield').

/* Pais de Michael : parent(X, 'Michael Scofield').
X = 'Aldo Burrows'; X = 'Christina Rose Scofield'. */

/* Filhos de Aldo : parent('Aldo Burrows', X).
X = 'Lincoln Burrows'; X = 'Michael Scofield'. */