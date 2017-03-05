function [ns, r] = trans_fun(s, a, drive_time)
    %s - state, a - action, ns - next state, r - reward
    %drive_time - time since passenger pick up   
    global DROP_LOCS WALLS X Y
    
    % number of actions
    
    ns = copy_state(s);
    %default - no reward
    r = 0;
    % a == 1, go north, up
    if a == 1 
        ns.y = ns.y + 1; 
    end;
    % a == 2, go south, down
    if a == 2
        ns.y = ns.y - 1;
    end;
    % a == 3, go west, left
    if a == 3
        ns.x = ns.x - 1;
    end;
    % a == 4, go east, right
    if a == 4
        ns.x = ns.x + 1;
    end;
    %check for collisions
    hit_walls = any(ismember(WALLS,[s.x, s.y, ns.x, ns.y],'rows'));
    within_maze = 1 <= ns.x && ns.x <= X && 1 <= ns.y && ns.y <= Y;
    out_of_maze = ~within_maze;
    if hit_walls || out_of_maze
        %restore previous position
        ns.x = s.x;
        ns.y = s.y;
        r = -1;
    end;

    % a == 5, pick up passenger
    if a == 5
        %default failed
        r = -1; 
        %check for already pick up
        if s.pp == 5
            return;
        end;
        %check for the same location of taxi and passenger
        psng_loc = DROP_LOCS(s.pp, :);
        if all([s.x, s.y] == psng_loc)
            ns.pp = 5;
            r = 1;
        end;
    end;
    % a == 6, drop off passenger
    if a == 6
        %default failed
        r = -1; 
        %check for passenger presence 
        if s.pp ~= 5
            return;
        end;
        %check for the same location of taxi and passenger
        drop_loc = DROP_LOCS(s.dp, :);
        if all([s.x, s.y] == drop_loc)
            ns.pp = s.dp;
            r = 10/drive_time;
        end;
    end;
end


