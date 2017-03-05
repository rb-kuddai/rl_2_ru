function [samples, avg_rs, convg_times, actions_map] = main_v1()
  % a simple illustration of Q-learning: a walker in a 2-d maze

  % number of states
  Sx = 25;  % width of grid world
  Sy = 25;  % length of grid world
  M = 5; % cover neighbour area
  
  S = Sx*Sy;  % number of states in grid world
  %4 corners
  GoalsOrig =[[1,   1];
              [Sx,  1];
              [1,  Sy];
              [Sx, Sy]]; 
            
  %spread goals across patches MxM          
  Goals = zeros(4 * M * M, 2);
  shift = M - 1;
  k = 1;
  for i = 1:4
    goal = GoalsOrig(i, :);
    for p = -shift:shift
      for q = -shift:shift
        cand = goal + [p, q];
        if 1 <= cand(1) && cand(1) <= Sx &&...
           1 <= cand(2) && cand(2) <= Sy
           Goals(k, :) = cand;
           k = k + 1;
        end
      end
    end
  end

  % number of actions
  A = 5;    % number of actions: E, S, W, N and 0
  % total number of learning trials
  T = 60000;
  
  eta = 0.2;
  gamma = 0.9;
  epsilon = 0.1;
  
  NUM_EXPS = 1; %number of experiments
  convg_times = [];
  actions_map = zeros(Sx, Sy);
  
  for exp_id = 1:NUM_EXPS
    samples = zeros(T, 1);
    avg_rs = zeros(T, 1);
    %initialisation
    Q = 0.1*rand(Sx, Sy, A);
    % run the algorithm for T trials
    r = 0;
    for t=1:T
      % set the starting state
      x0=randi(Sx);    
      y0=randi(Sy);
      % start trial
      avg_r = 0;
      for u=1:S*S
        % exploration (epsilon-greedy)
        if (rand(1)<epsilon) 
          a0=randi(A);
        else
          [V_s0,a0]=max(Q(x0, y0,:));  % we only need the a0 here
        end;

        % reward is for reaching the goal and staying there
        if ismember([x0, y0], Goals, 'rows') %&& (a0==5) 
          r = r + 1;
        else
          r = r + 0;
        end
        
        if x0 == int32(Sx/2) % && y0 == int32(Sy/2)
          r = r - 10;
        end

        %%you can add obstacles simply by adding punishment
        %%e.g. somewhere in the middle
        % if (abs(rem(s0,Sx)-Sy/2)<2)&&(abs(idivide(cast(s0,'int8'),cast(Sy,'int8'))-Sx/2)<2) 
        % r=-10;
        % end;
        %%The agent can still move through the obstacle, so it's more like a
        %%pothole.

        % now moving left, right, up, down, or not
        % and don't step outside the track
        % E, S, W, N and 0
        x1 = x0;
        y1 = y0;
        if     (a0==1) 
          x1 = min(max(x0+1, 1), Sx); %east
        elseif (a0==2) 
          y1 = min(max(y0-1, 1), Sy); %south
        elseif (a0==3)
          x1 = min(max(x0-1, 1), Sx); %west
        elseif (a0==4)
          y1 = min(max(y0+1, 1), Sy); %north
        end

        % now the learning step
        V_s1 = max(Q(x1, y1,:));
        Q(x0, y0, a0)=(1-eta)*Q(x0, y0, a0)+eta*(r+gamma*V_s1);

        % goto next trial once the goal is reached
        if ismember([x0, y0], Goals, 'rows') 
          avg_r = r/u;
          %display(avg_r, 'reached the goal!');
          break; 
        end

        x0=x1;
        y0=y1;
      end

      avg_rs(t) = avg_r;
      VV = max(Q,[],3);
      samples(t) = sum(reshape(VV, 1,numel(VV)));

      % % you may prefer using a mesh plot as it is a 2D example.
      if (rem(t, 1000) == 0) 
        display(t, 'current trial');
      end
      
      if (rem(t,1000)==0 && NUM_EXPS == 1)
        figure(6);
        clf;
        zlim([0 1/(1-gamma)]);
        %samples(
        mesh(VV);
        %%you may also like to have a look at (a=2, choose also other actions):
        %Q2 = reshape(Q(:,2),Sx,Sy);
        %mesh(Q2);
        title(['value function on episode ', num2str(t)]);
        fig=gcf;
        set(findall(fig,'-property','FontSize'),'FontSize',24)
        drawnow

      %t % don't know how to put current time in the figure
      end

    end
    %end of epoch
    display(exp_id, 'end of experiment');
    
    average_over = 200;
    avg_samples = mean(reshape(samples, average_over, []));
    
    if NUM_EXPS == 1
      figure(7);
      clf;
      title('value average values');
      plot(avg_samples);
      ylabel('value average values');
      xlabel(['training episodes (x', num2str(average_over), ')']);     
      fig=gcf;
      set(findall(fig,'-property','FontSize'),'FontSize',24)
      

      figure(9);
      clf;
      title('epsiode average reward');
      plot(mean(reshape(avg_rs, average_over, [])));
      ylabel('episodes average reward');
      xlabel(['training episodes (x', num2str(average_over), ')']); 
      fig=gcf;
      set(findall(fig,'-property','FontSize'),'FontSize',24)
    end

%     rel_diff = zeros(1, numel(avg_samples) - 1);
%     for t=2:size(avg_samples, 2)
%       rel_diff(t) = abs(avg_samples(t) - avg_samples(t-1))/avg_samples(t);
%     end
%     
%     convg = find(rel_diff > 0.00001, 1, 'last')
%     convg_t = convg * average_over
%     if ~isempty(convg_t)
%       convg_times = [convg_times, convg_t];
%     end

    smp_stds = zeros(1,(size(avg_samples, 2) - 50));
    for t=1:(size(avg_samples, 2) - 50)
      smp_std = std(avg_samples(t:(t+50)));
      smp_stds(t) = smp_std;%abs(avg_samples(t) - avg_samples(t-1))/avg_samples(t);
    end

    convg = find(smp_stds > 0.2, 1, 'last')
    convg_t = convg * average_over
    if ~isempty(convg_t)
      convg_times = [convg_times, convg_t];
    end
    
    if NUM_EXPS == 1
      figure(10);
      clf;
      title('averaged value function standard deviation over 50');
      plot(smp_stds);
      ylabel('standard deviation');
      xlabel(['training episodes (x', num2str(average_over), ')']); 
      fig=gcf;
      set(findall(fig,'-property','FontSize'),'FontSize',24)
    end
    
    if NUM_EXPS == 1
      %plot policy
      actions_map = zeros(Sx, Sy);
      %initial state in the left bottom corner with
      %pasenger and must go to G

      for xx=1:Sx
        for yy=1:Sy
          %perform greedy action
          [V_s,aa]=max(Q(xx, yy,:));
          actions_map(xx, yy) = aa;
        end
      end

      %lbls_actions = grid_to_lbls(actions_map);
      %lbls_actions = actions2str(lbls_actions);
      figure(31);
      clf;
      draw_maze(actions_map, 'maze policy', Sx, Sy, Goals);
    end
  end
  %end of experiments loop
  SE = std(convg_times)/sqrt(length(convg_times)); 
  display(mean(convg_times), 'mean convergence time');
  display(SE, 'standard error');
  display(SE * 1.96, 'confidence interval');
end

