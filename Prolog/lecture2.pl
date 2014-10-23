% Y is factorial of X
fact(0,1).
%fact(N,X) :- N>0, M is N-1, fact(M, Y), X is N*Y.
fact(N,X) :- fact(M, Y), X is N*Y, N is M+1, N>0.


% ! stop evaluation
good(23).
good(19) :- !.
good(4).
good(7).


% T = [1,2,6,9,8,3,5,3]
% H = 6
% split(H, T, A, B) where all element in A <= H and B > H.
% A = [1,2,6,3,5,3], B= [9,8]

split(_,[],[],[]).
split(H,[X|Y],[X|A],B) :- X=<H, split(H,Y,A,B).
split(H,[X|Y],A,[X|B]) :- X>H, split(H,Y,A,B).


% homework hint
% problem 1

circle(3). 				% radius
square(5).				% side
triangle(3,8).			% base, height
rectangle(3,8).			% base, height

area(circle(Radius), Area) :- 		
	Area is pi * Radius * Radius.
area(square(Side), Area) :-		
	Area is Side * Side.
area(triangle(Base, Height), Area) :-
	Area is 0.5 * Base * Height.
area(rectangle(Base, Height), Area) :-
	Area is Base * Height.



% problem 2

% matrix
% [[1,2,3],[4,5,6]]
% 1 2 3
% 4 5 6
% transpose to 
% [[1,4],[2,5],[3,6]]
% 1 4
% 2 5
% 3 6

%[[1,2,3]] = [[1],[2],[3]]

head([],[]).
head([H|_], H).	 
	
%splitRow([], [], []).
%splitRow([H|T], H, T).

%	splitRow(B, [X|Xt], Xn),

splitCol([], [], []).
splitCol([[RowHead|RowTail]|RowRemain], 
		[RowHead|ColHead], [RowTail|ColTail]) :-
	splitCol(RowRemain, ColHead, ColTail).

empty([[]]).
empty([[]|Matrix]) :-
	empty(Matrix).


%transpose([], []).
%transpose([[]], []).
transpose(Matrix, []) :- empty(Matrix).
transpose([Head|Tail], Transform) :-
	splitCol(Transform, Head, Remain),
	transpose(Remain, Tail).


