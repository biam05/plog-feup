before(A, B, L) :-
    append(_, [A|Aux], L),      % sucede se A pertencer a L e posteriormente for Aux
    append(_, [B|_], Aux).     % sucede se B pertencer a Aux
% Como B pertence a Aux, Aux sucede A e Aux e A pertencem a L, A e B pertencem a L, sendo que
% B surge depois de A na lista L
