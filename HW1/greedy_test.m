function [] = greedy_test()
%GREEDY_TEST Summary of this function goes here
%   Detailed explanation goes here
    define_maze_global();
    global X Y PSNG_POS DROP_POS A
    Q = zeros(X, Y, PSNG_POS, DROP_POS, A);
    s = create_rnd_state();
    s.x = 1;
    s.y = 1;
    s.pp = 1;
    s.dp = 2;
    Q(s.x, s.y, s.pp, s.dp, :) = [1, 2, 5, 2, 1, 3];
    [v a] = greedy(s, Q)
    
    assert(a==3,'action must be 3');
    assert(v==5,'value must be 5');
    
    Q(s.x, s.y, s.pp, s.dp, :) = [1, 2, 1, 1, 9, 3];
    [v a] = greedy(s, Q)
    assert(a==5,'action must be 5');
    assert(v==9,'value must be 9');
    
    %test imperical_eps should be close to 0.0910
    greedy_action = 0;
    T = 1000;
    for t=1:T
        [ev ea] = eps_greedy(s, Q, 0.1);
        if ea == 5 
            greedy_action = greedy_action + 1;
        end
    end
    imperical_eps = 1 - greedy_action / T
end

