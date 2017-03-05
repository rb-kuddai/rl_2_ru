function lbls = grid_to_lbls( grid_values, varargin)
    %transpose because the first axe is X, and the second is Y
    %it is important for draw_maze
    
    flat_V = reshape(grid_values',[],1);
    if length(varargin) == 0
        fmt = '%d';
    else
        fmt = char(varargin(1));
    end
    lbls = strtrim(cellstr(num2str(flat_V, fmt)));
end

