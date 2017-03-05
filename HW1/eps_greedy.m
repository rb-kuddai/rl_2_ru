function [v, a] = eps_greedy(s, Q, eps)
    %s - state, v - value of state s, a - next action, eps - epsilon
    global A
    [v, a] = greedy(s, Q);
    if (rand(1)<eps) 
        a = randi(A);
    end;
end

