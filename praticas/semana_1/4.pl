% 4

% comida
food('peru').
food('frango').
food('salmao').
food('solha').

% bebida
drink('vinho verde').
drink('vinho maduro').

% feminino
f('Ana').
f('Barbara').

% masculino
m('Antonio').
m('Bruno').

% casados: married(X, Y) -> X é casado com Y
married('Ana', 'Bruno').
married(X, Y) :- married(Y, X).

% gostos: like(X, Y) -> X gosta de Y
like('Ana', 'vinho verde').
like('Bruno', 'vinho verde').

% combinações: combined(X, Y) -> X combina bem com Y
combined('peru', 'vinho maduro').
combined('salmao', 'vinho verde').
combined('solha', 'vinho verde').

/*
Ana e Bruno são casados e gostam de vinho verde?
like('Ana', 'vinho verde'), married('Ana', 'Bruno'), like('Bruno', 'vinho verde').

Que bebida combina com salmão?
combined('salmao', X).

Que comidas combinam com vinho verde?
combined(X, 'vinho verde').
*/
