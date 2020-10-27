A :- B, C, !, D, E. 
A :- F, G. 

% Efeito do "cut" (!) no conjunto de cláusulas acima

/*
Se B e C funcionarem, resultado de A depende de D e E
Se B e C falharem, resultado de A depende de F e G

"if ... else ..."

if B, C : D, E
else : F, G
*/