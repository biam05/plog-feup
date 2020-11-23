% objetivo: ter 2L numa jarra de 4L, utilizando apenas a jarra de 4L e uma jarra de 3L

% procedimento: Encher o de 3, virar no de 4, encher novamente o de 3, virar no de 4 até 
% encher (ficam 2 no de 3). Esvaziar o de 4 e virar os 2 litros do de 3 no de 4

% X-Y (functiona como uma struct)
% X - jarra de 4L; Y - jarra de 2L
initial(0-0). % estado inicial, ambas as jarras têm 0L
final(2-_Y).  % estado final, a jarra de 4L tem 2L e a jarra de 3L tem um valor qualquer

% Operadores
next(_X-Y, 0-Y, e1) % esvaziar o 1º balde
next(X-_Y, X-0, e2) % esvaziar o 2º balde

next(_X-Y, 4-Y, e1) % encher o 1º balde
next(X-_Y, X-3, e2) % encher o 2º balde

% ------------------ Caminho mais Curto ------------------ 

% Len: Tamanho do Caminho
% Path: Caminho
% dfs(Initial, Final, [Initial], Path, Ops): pesquisa de todos os caminhos possiveis 
%                                       em profundidade)
% length(Path, Len): caminho e o seu tamanho guardado em len
% Solução: Tamanho do Caminho mais Curto-Caminho mais cuto
% o dfs chama o next() durante a sua execução
initial(Initial), final(Final),
setof(Len-Path-Ops, 
    (dfs(Initial, Final, [Initial], Path, Ops), length(Path, Len)), 
    [_MinLen-MinPath-MinOps | _]),
printa(MinPath-MinOps).
