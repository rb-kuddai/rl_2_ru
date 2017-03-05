function [] = draw_maze_test()
    define_maze_global()
    global X Y
    'test arbitrary grid cells'
    V = zeros(X, Y);
    V(:, 1) = 1:5;
    V(:, 2) = 6:10;
    V(:, 3) = 11:15;
    V(:, 4) = 16:20;
    V(:, 5) = 21:25;
    V
    
    lbls_V = grid_to_lbls(V, '%4.2f');
    figure;
    draw_maze(lbls_V, 'maze grid');
    
    'test actions mapping'
    M = zeros(X, Y);
    M(1,1) = 0;%up
    M(1,2) = 0;%up
    M(1,3) = 0;%right
    M(2,3) = 0;%pick
    lbls_M = grid_to_lbls(M);
    lbls_M = actions2str(lbls_M);
    figure;
    draw_maze(lbls_M, 'actions map');
end

