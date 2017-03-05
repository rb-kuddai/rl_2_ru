function [] = draw_maze(lbls, name)
    %lbls - labels - cell array of strings to display in the maze grid
    %size X*Y
    %name - plot title
    global WALLS X Y DROP_LOCS LOC_NAMES
    %draw location names with light green color
    
    hold on;
    grid on;
    h = findobj(gca,'Type','Text');
    delete(h);
    for i = 1:size(DROP_LOCS,1)
        %substract shifts for centering, must be in sync with font size
        dlx = DROP_LOCS(i,1) - 0.5;
        dly = DROP_LOCS(i,2) - 0.5;
        loc_name = LOC_NAMES(i);
        % 
        text(dlx, dly, loc_name,...
            'Color', [0.8 0.8 0.8],...
            'FontWeight', 'bold', 'FontUnits', 'normalized', 'FontSize', 1/Y,...
            'HorizontalAlignment', 'center',...
            'VerticalAlignment', 'middle');
    end
    title(name);
    xlim([0 X]);
    ylim([0 Y]);
    set(gca,'XTick',0:X);
    set(gca,'YTick',0:Y);
    %to have nice grid cells as squares
    axis square;
    
    % grid domains
    xg = 1:X;
    yg = 1:Y;
    %label coordinates, substract 0.5 for centering
    [xlbl, ylbl] = meshgrid(xg - 0.5, yg - 0.5);    
    text(xlbl(:), ylbl(:), lbls(:),'color','r',...
        'HorizontalAlignment','center','VerticalAlignment','middle',...
        'FontWeight', 'bold', 'FontUnits', 'normalized', 'FontSize', 1/(5*Y));
    %plot maze walls
    
    for i = 1:size(WALLS, 1)
        wall = WALLS(i, :);
        %centering
        wall = wall - 0.5; 
        x1 = wall(1);
        y1 = wall(2);
        x2 = wall(3);
        y2 = wall(4);
        %vertical
        if y1 == y2
            wx = (x2 - x1)*0.5 + x1;
            plot([wx, wx], [y1 - 0.5, y1 + 0.5],'-k', 'LineWidth',4);
        end
        %horizontal
        if x1 == x2
            wy = (y2 - y1)*0.5 + y1;
            plot([x1 - 0.5, x1 + 0.5], [wy, wy],'-k', 'LineWidth',4);
        end
    end
    hold off;
    drawnow;
end