sorted([]).
sorted([_]).
sorted([X, Y|Z]) :- 
	X =< Y,
	sorted([Y|Z]).

permutation([], []).
permutation(X, [Y|Z]) :-
	append(U, [Y|V], X),
	append(U, V, W),
	permutation(W, Z).

sort2(S, T) :-
	permutation(S, T),
	sorted(T).

