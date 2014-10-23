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
%   insert element at n-th position

%   take first n element
%   drop first n element
%   take last n element
%   drop last n element

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

