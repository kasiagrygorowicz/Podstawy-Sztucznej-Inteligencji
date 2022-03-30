:- dynamic xpositive/2.
:- dynamic xnegative/2.

phone_is(iphone_13):-
    it_is(apple),
    it_is(ios),
    positive(has,blue_color),
    positive(has,chip_A15).


phone_is(iphone_11):-
    it_is(apple),
    it_is(ios),
    positive(has,red_color),
    positive(has,chip_A13).

phone_is(iphone_6):-
    it_is(apple),
    it_is(ios),
    positive(has,silver_color),
    positive(has,chip_A6).

phone_is(iphone_12):-
    it_is(apple),
    it_is(ios),
    positive(has,red_color),
    positive(has,chip_A14).

phone_is(galaxy_S22):-
    it_is(samsung),
    it_is(android),
    positive(has,purple_color),
    positive(has,'8_gb_ram').

phone_is(galaxy_S22_ultra):-
    it_is(samsung),
    it_is(android),
    positive(has,blue_color),
    positive(has,'6_gb_ram').

phone_is(galaxy_A52):-
    it_is(samsung),
    it_is(android),
    positive(has,black_color),
    positive(has,'4_gb_ram').

phone_is(galaxy_A22):-
    it_is(samsung),
    it_is(android),
    positive(has,blue_color),
    positive(has,'12_gb_ram').

phone_is(xperia_1_III):-
    it_is(sony),
    positive(has,oled_display),
    positive(has,black_color).

phone_is(xperia_10_III):-
    it_is(sony),
    negative(has,oled_display),
    positive(has,purple_color).

it_is(sony):-
    positive(is,from_japan),
    negative(has,high_price),!.

it_is(samsung):-
    positive(is,from_korea), 
    positive(has,high_price),!.
    
it_is(apple):-
    positive(is,from_us), 
    positive(has,high_price),!.

it_is(android):-
    negative(does,run_fast),
    positive(is,open_source),!.

it_is(ios):-
    positive(does,run_fast),
    negative(is,open_source),!.

% Szukanie potwierdzenia cechy obiektu w dynamicznej bazie

positive(X,Y) :- 
    xpositive(X,Y), !. 
positive(X,Y) :-
    not(xnegative(X,Y)) ,
    ask(X,Y).

negative(X,Y) :- 
    xnegative(X,Y), !.
negative(X,Y) :-
    not(xpositive(X,Y)) ,
    ask(X,Y).

%4. Zadawanie pytań użytkownikowi
ask(X,Y) :-
    write(X), write(' it '),write(Y), write('\n'),
    read(Reply),
    (sub_string(Reply,0,1,_,'y') 
    -> remember_y(X,Y), write('yes'), nl  
    ; (sub_string(Reply,0,1,_,'n') 
        -> remember_n(X,Y), write('no'), nl, fail  
        ; ask(X,Y)) ),
     !.



%5. Zapamiętanie odpowiedzi w dynamicznej bazie
remember_y(X,Y) :- assert(xpositive(X,Y)).

remember_n(X,Y) :- assert(xnegative(X,Y)).


%6. Uruchomienie programu
run :-
    phone_is(X),!,
    write('\nYour phone may be a(n) '),write(X),
    nl,nl,clear_facts.

run :-
    write('\nUnable to determine what'),
    write('your phone is.\n\n'),clear_facts.


%7. Wyczyszczenie zawartości dynamicznej bazy
clear_facts :-
    retract(xpositive(_,_)),fail.
clear_facts :-
    retract(xnegative(_,_)),fail.
clear_facts :-
    write('\n\nPlease press the space bar to exit\n').