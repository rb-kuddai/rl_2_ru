function [] = define_maze_global()
    global X Y PSNG_POS DROP_POS DROP_LOCS A WALLS LOC_NAMES MAX_EPISODE_TIME
    X = 5;
    Y = 5;
    PSNG_POS = 5;
    DROP_POS = 4;
    % number of actions
    A = 6;
    walls = [[[1,1], [2, 1]];...
             [[1,2], [2, 2]];...
             [[2,4], [3, 4]];...
             [[2,5], [3, 5]];...
             [[3,1], [4, 1]];...
             [[3,2], [4, 2]]];
    mirrored_walls = zeros(size(walls));
    mirrored_walls(:, [3, 1, 4, 2]) = walls(:, [1, 3, 2, 4]);
    WALLS = [walls; mirrored_walls];
    LOC_NAMES = {'Y', 'R', 'G', 'B'};
    DROP_LOCS = [[1,1]; [1,5]; [5,5]; [4,1]];
    MAX_EPISODE_TIME = 1500;
end

