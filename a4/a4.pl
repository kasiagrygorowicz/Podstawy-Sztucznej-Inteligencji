:- dynamic xpositive/4.
:- dynamic xnegative/4.

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
    negative(has,high_price).

it_is(samsung):-
    positive(is,from_korea), 
    positive(has,high_price).
    
it_is(apple):-
    positive(is,from_us), 
    positive(has,high_price).

it_is(android):-
    negative(does,run_fast),
    positive(is,open_source).

it_is(iso):-
    positive(does,run_fast),
    negative(is,open_source).

% Szukanie potwierdzenia cechy obiektu w dynamicznej bazie
positive(X,Y):- xpositive(X,Y),!.
positive(X,Y):- not(xnegative(X,Y)), ask(X,Y,yes).
negative(X,Y):- xnegative(X,Y),!.
negative(X,Y):- not(xpositive(X,Y)), ask(X,Y,no).

% Zadawanie pytań użytkownikowi
ask(X,Y,yes):-
    write(X), write(' it '), write(Y), write('\n'),
    read(Replay),
    sub_string(Replay,0,1,_,'y'),!,
    remember(X,Y,yes).

ask(X,Y,no):-
    write(X), write(' it '), write(Y), write('\n'),
    read(Replay),
    sub_string(Replay,0,1,_,'no'),!,
    remember(X,Y,no).


ask(X,Y,no) :-
    remember(X,Y,no), fail.

ask(X,Y,yes) :-
    remember(X,Y,yes), fail.

% Zapamiętanie odpowiedzi w dynamicznej bazie
remember(X,Y,yes):-
    assert(xpositive(X,Y)).
remember(X,Y,no):-
    assert(xnegative(X,Y)).

% Uruchomienie programu
run:-
    phone_is(X),!,
    write('\nYour phone could be a(n) '), write(X),
    nl,nl,clear_facts.
run:-
    write('\nUnable to determine what your phone is\n\n'),
     clear_facts.

% Wyczyszczenie zawartości dynamicznej bazy
clear_facts:-
    retract(xpositive(_,_)),fail.
clear_facts:-
    retract(xnegative(_,_)),fail.
clear_facts:-
    write('\n\nPlease press the space bar to exit\n').
