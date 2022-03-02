%   F0 
fib(0,0).
%   F1
fib(1,1).
fib(N,Nx):-
    N > 1,
    F is N - 1,
    K is N - 2,
    fib(F,Fx),
    fib(K,Kx),
    Nx is Kx + Fx.


write_result(N):-
    write('F'),
    write(N),
    write('= '),
    fib(N,Result),
    write(Result),
    write('\n').

print_fibonacci(N):-
    N == 0 -> (
    write_result(N)
        ) ; (      
    F is N-1,
    write_result(N),
    print_fibonacci(F)  
            )
    .  

    

        % print_fibonacci(N):-
        %     N >= 0,
        %     F is N-1,
        %     write('F'),
        %     write(N),
        %     write('= '),
        %     fib(N,Result),
        %     write(Result),
        %     write('\n'),
        %     print_fibonacci(F).  