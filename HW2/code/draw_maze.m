function [] = draw_maze(lbls, name, Sx, Sy, Goals)
    %lbls - labels - cell array of strings to display in the maze grid
    %size X*Y
    %name - plot title
    %draw location names with light green color
    
    hold on;
    grid on;
    h = findobj(gca,'Type','Text');
    delete(h);
    
    title(name);
    xlim([0 Sx]);
    ylim([0 Sy]);
    set(gca,'XTick',0:Sx);
    set(gca,'YTick',0:Sy);
    %to have nice grid cells as squares
    axis square;
    
    % grid domains
    xg = 1:Sx;
    yg = 1:Sy;
    %label coordinates, substract 0.5 for centering
    [xlbl, ylbl] = meshgrid(xg - 0.5, yg - 0.5);    
    drawArrow = @(x,y,varargin) quiver( x(1),y(1),x(2)-x(1),y(2)-y(1),0, varargin{:} );
    for ix = 1:Sx
      for iy = 1:Sy
        xx = xlbl(ix, iy);
        yy = ylbl(ix, iy);
        a = lbls(ix, iy);
        if ismember([ix, iy], Goals, 'rows')
          text(xx, yy, 'Goal',...
            'Color', 'r',...
            'FontWeight', 'bold', 'FontUnits', 'normalized', 'FontSize', 1/( 5* Sy),...
            'HorizontalAlignment', 'center',...
            'VerticalAlignment', 'middle');          
        elseif a == 1
          %right
          drawArrow([xx, xx], [yy - 0.3, yy + 0.3], 'MaxHeadSize',10,'Color','r','LineWidth',3);  
        elseif a == 2
          %down
          drawArrow([xx + 0.3, xx - 0.3], [yy,yy], 'MaxHeadSize',12,'Color','r','LineWidth',2);
          
        elseif a == 3
          %left
          drawArrow([xx, xx], [yy + 0.3, yy - 0.3],'MaxHeadSize',12,'Color','r','LineWidth',2);
        elseif a == 4
          %up
          drawArrow([xx - 0.3, xx + 0.3], [yy,yy], 'MaxHeadSize',12,'Color','r','LineWidth',2);
        elseif a == 5
          text(xx, yy, 'Stay',...
            'Color', 'r',...
            'FontWeight', 'bold', 'FontUnits', 'normalized', 'FontSize', 1/( 5* Sy),...
            'HorizontalAlignment', 'center',...
            'VerticalAlignment', 'middle');
        end
        
      end
    end
%     text(xlbl(:), ylbl(:), lbls(:),'color','r',...
%         'HorizontalAlignment','center','VerticalAlignment','middle',...
%         'FontWeight', 'bold', 'FontUnits', 'normalized', 'FontSize', 1/(5*Y));

    hold off;
    drawnow;
end