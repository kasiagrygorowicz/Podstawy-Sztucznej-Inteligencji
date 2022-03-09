%opis grafu
gallery(entry,monsters).
gallery(entry,fountain).
gallery(fountain,hell).
gallery(fountain,food).
gallery(exit,gold_treasure).
gallery(fountain,mermaid).
gallery(robbers,gold_treasure).
gallery(fountain,robbers).
gallery(food,gold_treasure).
gallery(mermaid,exit).
gallery(monsters,gold_treasure).

% graf nieskierowany
neighborroom(X, Y) :- gallery(X, Y).
neighborroom(X, Y) :- gallery(Y, X).
%lista węzłów zakazanych
avoid([monsters,robbers]).
go(Here,There) :- route(Here, There,[Here]). 
%rekurencyjne poszukiwanie drogi
route(exit,exit,VisitedRooms) :-
member(gold_treasure,VisitedRooms), write(VisitedRooms), nl.
route(Room,Way_out,VisitedRooms) :-
neighborroom(Room,NextRoom),
avoid(DangerousRooms),
\+ member(NextRoom,DangerousRooms),
\+ member(NextRoom,VisitedRooms),
route(NextRoom,Way_out,[NextRoom|VisitedRooms]).
%sprawdzenie, czy element występuje w liście
member(X,[X|_]).
member(X,[_|H]) :- member(X,H).