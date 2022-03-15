:-dynamic computer/5.

main:-
    write('1 - biezacy stan bazy danych'), nl,
    write('2 - dodanie nowego komputera'), nl,
    write('3 - usuniecie komputera'), nl,
    write('4 - obliczenie średniej ceny komputerów w bazie'), nl,
    write('5 - uzupelnienie bazy o dane zapisane w pliku'), nl,
    write('6 - zapisanie bazy w pliku'), nl,
    write('7 - pokazanie komputerów o wybranej nazwie CPU'), nl,
    write('8 - pokazanie komputerów o cenie niszej niz podana'), nl,
    write('0 - koniec programu'), nl, nl,
    read(I),
    I > 0,
    option(I),
    main.

main.


option(1) :- display.

option(2) :- 
    write('Podaj nazwe procesora: '), read(Cpu), nl,
	write('Podaj typ procesora: '), read(Type), nl,
	write('Podaj czestotliwosc zegara: '), read(Freq), nl,
	write('Podaj pojemnosc HDD: '), read(Hdd), nl,
	write('Podaj cene komputera: '), read(Price), nl,
	assert(computer(Cpu, Type, Freq, Hdd, Price)).

option(3):-
	write('Podaj nazwe procesora: '), read(Cpu), nl,
	write('Podaj typ procesora: '), read(Type), nl,
	retract(computer(Cpu,Type,_,_,_)),!; 
    write('Brak wskazanego komputera w bazie\n').


option(4):-
	calculateAverage.

option(5) :- write('Podaj nazwe pliku:'), read(Nazwa),
            exists_file(Nazwa), !, consult(Nazwa);
            write('Brak pliku o podanej nazwie'), nl.

option(6) :- write('Podaj nazwe pliku:'), read(Name),
 open(Name, write, X), save(X), close(X).

option(7):-
	write('Podaj nazwe CPU: '), 
	read(Name),
	findall([Name,Type,Freq,Hdd,Price],
		computer(Name,Type,Freq,Hdd,Price),List),
	sumList(List,N),
	displayList(List),
	nl,
	write('Liczba komputerow: '), write(N), nl.

option(8):-
	write('Podaj cene: '), read(P),
	findall([Cpu,Type,Freq,Hdd,Price],
		(computer(Cpu,Type,Freq,Hdd,Price),Price<P),List),
	sumList(List,N),
	displayList(List),
	nl,
	write('Liczba komputerow o cenie niszej niz '),
	write(P),
	write(': '),
	write(N),
	nl.

option(_) :- write('Zly numer opcji'), nl.


% OPTION 1
display:-
	write('elementy bazy:'), nl,
	computer(Cpu, Type, Freq, Hdd, Price),
	write('CPU: '),write(Cpu), write(' '),
	write('Typ: '),write(Type), write(' '),
	write('Częstotliwość: '),write(Freq), write(' '),
	write('HDD: '),write(Hdd), write(' '),
	write('Cena: '),write(Price), nl, fail.
display:-
	nl.

displayList([]).
displayList([H|T]):-
	format('CPU: ~w, Typ procesora: ~w,Częstotliwość: ~w, Rozmiar HDD: ~w, Cena: ~w~n',H),
	displayList(T).

calculateAverage:-
	findall(Price, computer(_,_,_,_,Price), List),
	sum(List, Sum, N),
	Avg is Sum / N,
	write('Srednia cena komputera: '),
    write(Avg),
    nl.


sum([],0,0).
sum([Head|Tail], Sum,N) :-
    sum(Tail, X, Y),
    Sum is Head + X,
	N is Y + 1.

sumList([],0).
sumList([Head|Tail], N) :- sumList(Tail, N1),
                         N is N1+1.


save(X):-
	computer(Cpu, Type, Freq, Hdd, Price),
	write(X, 'computer('),
	write(X, Cpu), write(X, ','),
	write(X, Type), write(X, ','),
	write(X, Freq), write(X, ','),
	write(X, Hdd), write(X, ','),
	write(X, Price),
	write(X, ').'), nl(X), fail.
save(_):-
	nl.

computer(cpu1,type1,12,3,3000).
computer(cpu1,type2,6,4,4000).