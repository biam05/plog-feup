imaturo(X):- adulto(X), !, fail.
imaturo(X).
adulto(X):- pessoa(X), !, idade(X, N), N>=18.
adulto(X):- tartaruga(X), !, idade(X, N), N>=50.

% Explique a função dos ‘cuts’ incluídos no programa abaixo. 

/*
1. imaturo definido como negação de adulto. cut vermelho: muda o 
funcionamento do programa, são retornados resultados diferentes

2. cut verde: não irá tentar entrar em clausulas de baixo que sabemos
que iriam falhar, logo os resultados não se alteram. 

if pessoa , idade >= 18 para ser adulto
else if tartatuga, idade >= 50 para ser adulto
*/