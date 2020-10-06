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
