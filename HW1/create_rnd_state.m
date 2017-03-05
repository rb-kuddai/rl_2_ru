function state = create_rnd_state()
    %x  - x position in the maze
    %y  - y position in the maze
    %pp - passenger position
    %dp - drop position
    global X Y PSNG_POS DROP_POS
    state = struct('x', randi(X),...
                   'y', randi(Y),...
                   'pp',randi(PSNG_POS),...
                   'dp',randi(DROP_POS));
end