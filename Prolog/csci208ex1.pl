edge(a,b).
edge(a,f).
edge(b,c).
edge(c,d).
edge(c,e).
edge(e,d).
edge(f,c).
edge(f,e).
edge(f,g).
edge(g,c).
edge(X,Y) :- tedge(X,Y).

tedge(Node1,Node2) :-
	edge(Node1,SomeNode),
	edge(SomeNode,Node2).
