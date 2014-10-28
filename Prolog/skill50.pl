% Numbers Properties
%   Find all the factors of a positive integer

%   Find a prime factorization of a positive integer

%   Tell whether a number is prime

% Construct lists:
%   [1,2,3,...]
inclist(N, List) :- construct(1, N, 1, List).
construct(Min, Max, Step, [Min|List]) :-
	Min =< Max,
	X is Min + Step,
	construct(X, Max, Step, List).
construct(Min, Max, _, []) :- Min > Max.

%   [...,3,2,1]
declist(N, List) :- destruct(N, 1, 1, List).
destruct(Max, Min, Step, [Max|List]) :-
	Max >= Min,
	X is Max - Step,
	destruct(X, Min, Step, List).
destruct(Max, Min, _, []) :- Max < Min.

%   [0,2,4,6,...]
evenlist(N, List) :- construct(0, N, 2, List).

%   [1,3,5,7,...]
oddlist(N, List) :- construct(1, N, 2, List).

%   squares
squarelist(N, List) :- square(1, N, List).
square(Min, Max, []) :- Min > Max.
square(Min, Max, List) :-
	Min =< Max,
	NextMin is Min + 1,
	square(NextMin, Max, Tail),
	X2 is Min * Min,
	List = [X2 | Tail].

%   triangulars
trianglelist(N, List) :- triangle(1, N, List).
triangle(Min, Max, List) :-
	Min =< Max,
	X is div((Min * (Min + 1)), 2),
	NextMin is Min + 1,
	List = [X | Tail],
	triangle(NextMin, Max, Tail).
triangle(Min, Max, []) :- Min > Max.

%   primes



%   fibonacci sequence
fib([0,1|X]) :-
    ffib(0,1,X).
ffib(A,B,X) :-
    freeze(X, (C is A+B, X=[C|Y], ffib(B,C,Y)) ).	


myfib2(N, F) :- myfib4(N, 0, 1, F).
myfib4(0, A, _, A) :- !.
myfib4(N, A, B, F) :-
	N1 is N - 1,
	Sum is A + B,
	myfib4(N1, B, Sum, F).	

myfib(0, 0) :- !.
myfib(1, 1) :- !.
myfib(N, F) :-
	N > 1,
	A is N-1,
	B is N-2,
	myfib(A, F1),
	myfib(B, F2),
	F is F1 + F2.

% Manipulate a list:
%   length of a list
myLength([_|Tail], N) :-
	myLength(Tail, X),
	N is X + 1.
myLength([], 0).

%   append two list
myAppend([], List, List).
myAppend(List1, List2, Result) :-
	myAppend(Tail1, List2, Tail), 
	List1 is [Head|Tail1],
	Result is [Head|Tail].

myAppend2([], Y, Y).
myAppend2([A|T], Y, [A|W]) :- myAppend2(T, Y, W).

%   reverse a list
myReverse([], []).
myReverse([H|T], R) :- 
	myReverse(T, L1),
	append(L1, [H], R). 

%   find first element
myHead([], []).
myHead([H|_], H).

%   find last element
myLast([H|[]], H).
myLast([_|T], X) :- mylast(T, X).

%   find n-th element
elementAt([H|_], 1, H).
elementAt([_|T], N, X) :-
	M is N-1,
	elementat(T, M, X).
	
%   remove first element
removeFirst([], []).
removeFirst([_|T], T).

%   remove given element
removeElement([H|T], H, T).
removeElement([H|T], X, [H|L]) :-
	removeElement(T, X, L).

%   remove last element
removeLast([_|[]], []).
removeLast([H|T], [H|L]) :-
	removeLast(T, L).

%   remove n-th element
removeNElement([_|T], 1, T).
removeNElement([_|T], N, X) :-
	M is N-1,
	removeNElement(T, M, X).

%   insert element at end
insertLast(X, [], [X]).
insertLast(X, [H|T], [H|Z]) :-
	insertLast(X, T, Z).

%   insert element at n-th position
insertAt(X, 1, L, [X|L]).
insertAt(X, N, [H|T], [H|R]) :-
	N > 1,
	M is N-1,
	insertAt(X, M, T, R).

%   take first n element
take(0, _, []).
take(N, [H|T], [H|L]) :-
	N > 0,
	M is N-1,
	take(M, T, L).

%   drop first n element
drop(0, X, X).
drop(N, [_|T], L) :-
	N > 0,
	M is N-1,
	drop(M, T, L).

%   take last n element
takeLast(N, S, R) :-
	N >= 0,
	length(S, LS),
	length(R, N),
	X is LS - N,
	drop(X, S, R).
	
%   drop last n element
dropLast(0, S, S).
dropLast(N, S, R) :-
	N > 0,
	length(S, LS),
	length(R, LR),
	LR is LS - N,
	take(LR, S, R).




%   remove all even numbers
%   remove all except even numbers
%   remove every other element

%   rotate left
%   rotate right

%   add together all the numbers
%   average all the numbers

% Manipulate a binary search tree
%   build a tree
%   count the elements
%   count the elements with some property
%   test the membership of an element
%   insert an element
%   remove an element (harder)
%   traverse in pre/in/post-order
%   sum all the number
%   average the numbers

% Manipulate (general) trees
%   build a tree
%   count the elements
%   test the membership of an element
%   traverse in pre/post-order

