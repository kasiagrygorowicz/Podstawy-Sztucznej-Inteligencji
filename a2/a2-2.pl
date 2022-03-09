% opis grafu
gallery(entry,fountain).
gallery(entry,amusement_park).
gallery(entry,farmers_market).
gallery(amusement_park,fountain).
gallery(amusement_park,robbers).
gallery(unicorns,exit).
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


distance(gallery(entry,fountain),3).
distance(gallery(entry,amusement_park),4).
distance(gallery(entry,farmers_market),5).
distance(gallery(amusement_park,fountain),8).
distance(gallery(amusement_park,robbers),3).
distance(gallery(unicorns,exit),4).
distance(gallery(hospital,shelter),4).
distance(gallery(robbers,shelter),1).
distance(gallery(exit,hospital),5).
distance(gallery(hospital,taco_bell),7).
distance(gallery(hospital,shooting_range),9).
distance(gallery(cemetery,shooting_range),1).
distance(gallery(cemetery,monsters),2).
distance(gallery(cemetery,farmers_market),4).
distance(gallery(church,monsters),3).
distance(gallery(church,taco_bell),6).
distance(gallery(church,farmers_market),8).
distance(gallery(dungeon,farmers_market),3).
distance(gallery(dungeon,unicorns),1).
distance(gallery(dungeon,hell),2).
distance(gallery(unicorns,city_hall),2).
distance(gallery(city_hall,hell),10).


% graf nieskierowany
neighborroom(X, Y) :- gallery(X, Y).
neighborroom(X, Y) :- gallery(Y, X). 


%lista węzłów zakazanych
avoid([monsters,robbers]).

% oblicz dystans
sum_distance([], 0).
sum_distance([Head|Tail], Sum) :-
    sum_distance(Tail, X),
    Sum is Head + X.

go(Here,There) :- 
    route(Here, There,[Here],[]). 

route(X,X,VisitedRooms,Distance):-
    member(X,VisitedRooms),
    reverse(VisitedRooms,Rooms),
    sum_distance(Distance, Sum), 
    write(Rooms),
    nl,
    write("Distance: "),
    write(Sum), nl.

route(Room,Way_out,VisitedRooms,Distance):-
    neighborroom(Room,NextRoom),
    avoid(DangerousRooms),
    \+ member(NextRoom,DangerousRooms),
    \+ member(NextRoom,VisitedRooms),
    distance(gallery(Room,NextRoom),X),
    route(NextRoom,Way_out,[NextRoom|VisitedRooms],[X|Distance]).

member(X,[X|_]).
member(X,[_|H]):- member(X,H).
