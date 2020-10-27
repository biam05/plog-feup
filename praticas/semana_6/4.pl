/*
 Defina o predicado functor2(Term,F,Arity) que é verdadeiro se Term  
 é um termo cujo functor principal tem o nome F e a aridade Arity. 
*/

functor2(Term, F, Arity) :- 
    Term=..[F|Args], 
    length(Args, N).

/*
 Defina o predicado arg(N,Term,Arg) que é verdadeiro se Arg  
 é o N-ésimo argumento do termo Term.
*/

arg2(N, Term, Arg) :-
    Term =..[_|Args],
    nth1(N, Args, Arg).