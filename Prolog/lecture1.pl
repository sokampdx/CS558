% parent example
father(bill,jill).
father(kyle,john).
father(john,mary).
mother(jill,john).
mother(mary,anne).

parent(X,Y) :- mother(X,Y).
parent(X,Y) :- father(X,Y).
ancestor(X,Y) :- parent(X,Y).
ancestor(X,Y) :- parent(X,Z), ancestor(Z,Y).



% book  exmample
gcd(U, 0, U).
gcd(U, V, W) :- not(V = 0), R is U mod V, gcd(V, R, W).

% cons add an element to the head of a list
%cons(X,Y,L) :- L = [X|Y].
cons(X,Y,[X|Y]).

% append2 put list A in front of list B
append2([], Y, Y).
append2([A|B], Y, [A|W]) :- append2(B, Y, W).

reverse([],[]).
reverse([H|T], L) :- reverse(T, L1), append2(L1, [H], L).

reverseAppend([], Y, Y).
reverseAppend(X, Y, Z) :- reverse(X, R), append2(R, Y, Z).


%quicksort

quicksort([],[]).
quicksort([H|T], Result) :-
	split(H,T,A,B),
	quicksort(A,X),
	quicksort(B,Y),
	append(X,[H|T], Result).



