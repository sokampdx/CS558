% Numbers Properties
%   Find all the factors of a positive integer
divisible(A, B) :-
	X is A mod B,
	X == 0.

notDivisible(A, B) :-
	X is A mod B,
	X \= 0.

factor(N, Result) :-
	N >= 1,
	factorList(N, N, [], Result).
factorList(_, 1, Result, [1|Result]).
factorList(N, F, Current, Result) :- 
	F > 1,
	divisible(N, F),
	F1 is F - 1,
	append([F], Current, Next),
	factorList(N, F1, Next, Result).
factorList(N, F, Current, Result) :-
	F > 1,
	notDivisible(N, F),
	F1 is F - 1,
	factorList(N, F1, Current, Result).


%   Find a prime factorization of a positive integer
primeFact(1, []).
primeFact(N, Result) :-
	factor(N, List),
	primeCheck(List, Result).

primeCheck([], []).
primeCheck([1|Check], Result) :-
	primeCheck(Check, Result).
primeCheck([F|Factor], [F|Result]) :-
	F > 1,
	divisibleList(F, Factor, Remain),
	primeCheck(Remain, Result).

divisibleList(_, [], []).
divisibleList(F, [C|Check], Remain) :-
	divisible(C, F),
	divisibleList(F, Check, Remain).
divisibleList(F, [C|Check], [C|Remain]) :-
	notDivisible(C, F),
	divisibleList(F, Check, Remain).


%   Tell whether a number is prime
isPrime(N) :- primeFact(N, [N]), !.

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
primeList(N, Result) :-
	inclist(N, List),
	primeCheck(List, Result).


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
	removeLast(S, X),
	M is N - 1,
	dropLast(M, X, R).

%   remove all even numbers
removeEven([], []).
removeEven([H|T], R) :- 
	X is H mod 2,
	X == 0,
	removeEven(T, R).
removeEven([H|T], [H|R]) :-
	X is H mod 2,
	X == 1,
	removeEven(T, R).

%   remove all except even numbers
removeOdd([], []).
removeOdd([H|T], R) :- 
	X is H mod 2,
	X == 1,
	removeOdd(T, R).
removeOdd([H|T], [H|R]) :-
	X is H mod 2,
	X == 0,
	removeOdd(T, R).

%   remove every other element
removeEO(List, Keep) :-
	length(List, N), 
	removeEOI(List, 1, N, Keep).
removeEOI([], _, _, []).
removeEOI([_|List], S, N, Keep) :-
	S1 is S + 1,
	S =< N,
	X is S mod 2,
	X == 0,
	removeEOI(List, S1, N, Keep).	
removeEOI([H|List], S, N, [H|Keep]) :-
	S2 is S + 1,
	S =< N,
	X is S mod 2,
	X == 1,
	removeEOI(List, S2, N, Keep).

%   rotate left
rotateLeft([], []).
rotateLeft([H|T], X) :-
	append(T, [H], X).

%   rotate right
rotateRight([], []).
rotateRight(X, [H|T]) :-
	append(T, [H], X).

%   add together all the numbers
mySum([], 0).
mySum([H|T], S) :-
	mySum(T, X),
	S is H + X.

%   average all the numbers
average(List, Result) :-
	length(List, N),
	mySum(List, S),
	Result is S / N.

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

