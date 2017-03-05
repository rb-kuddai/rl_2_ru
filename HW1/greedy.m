function [v, a] = greedy(s, Q)
    %s - state, v - value of state s, a - next action
    [v, a] = max(Q(s.x, s.y, s.pp, s.dp, :));
end