aluno(joao, paradigmas).
aluno(maria, paradigmas).
aluno(joel, lab2).
aluno(joel, estruturas).

frequenta(joao, feup).
frequenta(maria, feup).
frequenta(joel, ist).

professor(ana_paula, estruturas).
professor(carlos, paradigmas).
professor(pedro, lab2).

funcionario(pedro, ist).
funcionario(ana_paula, feup).
funcionario(carlos, feup).

/* alunos do professor X 
aluno(Y, _Z), professor(X, _Z) 
Y = joao X = carlos ? Y = maria X = carlos ? Y = joel X = pedro; Y = joel X = ana_paula */

/* pessoas da universidade X
funcionario(X, U); frequenta(X, U). */

/* quem é colega de quem */
professoresColegas(X, Y) :-
    funcionario(X, U),
    funcionario(Y, U),
    X \= Y.

alunosColegas(X, Y) :-
    (
        (aluno(X, C), aluno(Y, C));
        (frequenta(X, U), frequenta(Y, U))
    ),
    X \= Y.

colegas(X, Y) :-
    professoresColegas(X, Y);
    alunosColegas(X, Y).
