and_gate(N1, N2, N3):-
    N1 == 1 -> (N2 == 1 -> N3 is 1 ; N3 is 0) ; N3 is 0.

or_gate(N1,N2,N3):-
    N1 ==1 -> N3 is 1 ; (N2 ==1 -> N3 is 1; N3 is 0).

xor_gate(N1,N2,N3):-
    N1 == N2 -> N3 is 0 ; N3 is 1.

% ((A and B)or(C and D))xor(E or F)
sys(A,B,C,D,E,F,G):-
    and_gate(A,B,AND1),
    and_gate(C,D,AND2),
    or_gate(E,F,OR1),
    or_gate(AND1,AND2,OR2),
    xor_gate(OR1,OR2,G).










