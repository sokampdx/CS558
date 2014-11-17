% KAM PUI SO (ANTHONY)
% CS558 Fall 2014
% HW6 Problem 2

% [[1,2,3,4], [2,1,3,5], [3,1,2,4,5], [4,1,3,5], [5,2,3,4]]
% graph([1,2,3,4,5], [e(1,2), e(1,3), e(1,4), e(2,3), e(2,5), e(3,4), e(3,5), e(4,5)])

isMember(E, [E|_]).
isMember(X, [_|Es]) :-
	isMember(X, Es).

notMember(_, []).
notMember(X, [Y|Es]) :-
	X \= Y,
	notMember(X, Es).

notEmpty([[_]]).

connect(X,Y,graph(_,Es)) :-
	isMember(e(X,Y), Es).
connect(X,Y,graph(_,Es)) :-
	isMember(e(Y,X), Es).
connect(X,Y,[H|_]) :-
	H is [X|Es],
	isMember(Y, Es).
connect(X,Y,[H|T]) :-
	H is [N|_],
	X \= N,
	connect(X,Y,T).


path(Graph, Start, End, Path) :-
	fpath(Graph, Start, [End], Path).

fpath(_, S, [S|Path], [S|Path]).
fpath(Graph, S, [X|Xs], Path) :-
	connect(Y, X, Graph),
	notMember(Y, [X|Xs]),
	fpath(Graph, S, [Y, X|Xs], Path).



	
