% Kam Pui So (Anthony)
% CS558 Fall 2014
% Homework 1

% ------------------------------------
% Problem 1
% ------------------------------------
% Part 3:
% ------------------------------------

% Definition of Shapes
circle(3). 				% radius
square(5).				% side
triangle(3,8).			% base, height
rectangle(3,8).			% base, height

% area(Shope(), ShapeArea)
area(circle(Radius), Area) :- 		
	Area is pi * Radius * Radius.
area(square(Side), Area) :-		
	Area is Side * Side.
area(triangle(Base, Height), Area) :-
	Area is 0.5 * Base * Height.
area(rectangle(Base, Height), Area) :-
	Area is Base * Height.


% ------------------------------------
% Problem 2
% ------------------------------------
% Matrix is a list of list where 
% transpose([[1,2,3],[4,5,6]],  [[1,4],[2,5],[3,6]])
% will evaluate to true.

% empty(Matrix)
empty([[]]).
empty([[]|Matrix]) :-
	empty(Matrix).

% splitCol(Matrix, FirstColumn, RemainColumns)
splitCol([], [], []).
splitCol([[RH|RT]|RN], [RH|H], [RT|T]) :-
	splitCol(RN, H, T).

% transpose(Matrix, TransposedMatrix)
transpose(M, []) :- empty(M).
transpose([H|T], X) :-
	splitCol(X, H, Y),
	transpose(Y, T).


