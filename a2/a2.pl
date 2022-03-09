% opis grafu
gallery(entry,fountain).
gallery(entry,amusement_park).
gallery(entry,farmers_market).
gallery(amusement_park,fountain).
gallery(amusement_park,robbers).
gallery(unicorns,exit).
gallery(hospital,shelter).
gallery(robbers,shelter).
gallery(exit,hospital).
gallery(hospital,taco_bell).
gallery(hospital,shooting_range).
gallery(cemetery,shooting_range).
gallery(cemetery,monsters).
gallery(cemetery,farmers_market).
gallery(church,monsters).
gallery(church,taco_bell).
gallery(church,farmers_market).
gallery(dungeon,farmers_market).
gallery(dungeon,unicorns).
gallery(dungeon,hell).
gallery(unicorns,city_hall).
gallery(city_hall,hell).

% graf nieskierowany
neighborroom(X, Y) :- gallery(X, Y).
neighborroom(X, Y) :- gallery(Y, X). 


%lista węzłów zakazanych
avoid([monsters,robbers]).

go(Here,There) :- route(Here, There,[Here]). 

route(X,X,VisitedRooms):-
    member(X,VisitedRooms),reverse(VisitedRooms,Q), write(Q), nl.

route(Room,Way_out,VisitedRooms):-
    neighborroom(Room,NextRoom),
    avoid(DangerousRooms),
    \+ member(NextRoom,DangerousRooms),
    \+ member(NextRoom,VisitedRooms),
    route(NextRoom,Way_out,[NextRoom|VisitedRooms]).

member(X,[X|_]).
member(X,[_|H]):- member(X,H).
