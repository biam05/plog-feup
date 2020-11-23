delete_one(X, L1, L2) :-
    append(La, [X|Lb], L1),
    append(La, Lb, L2).
    
permutacao([],[]).
permutacao(L1, [X|L2]) :-
    delete_one(X, L1, R),
    permutacao(R, L2).