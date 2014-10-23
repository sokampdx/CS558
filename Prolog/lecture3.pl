% [[1,2,3],[4,5,6],[7,8,9]]

heads([],[]).
heads([[H|_]|T], [H|U]) 
	:- heads(T, U).

tails([],[]).
tails([[_|Y]|T],[Y|U]) 
	:- tails(T, U).

transp([[]|_],[]).
transp(M,[H|T]) :-
	heads(M, H),
	tails(M, U),
	transp(U, T).



%figure(triangle(B,H), B*H/2, B+2*sqrt(B*B/4+H*H)).

%area(F, A) :- figure(F, X, _), A is X.
%perim(F, P) :- figure(F, _, Y), P is Y.


