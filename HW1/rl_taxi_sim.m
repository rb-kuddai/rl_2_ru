function [rewards_per_episode] = rl_taxi_sim(trans_f, learning)
    %reinforcement learning taxi problem simulation. Can be found here:
    % Dutech, A., Edmunds, T., Kok, J., Lagoudakis, M., Littman, M., Riedmiller, M., Whiteson, S.
    % (2005) Reinforcement learning benchmarks and bake-offs II. Workshop at Advances in Neural
    % Information Processing Systems conference
    
    
    % define maze global variables
    define_maze_global();
    global X Y PSNG_POS DROP_POS A MAX_EPISODE_TIME DROP_LOCS
    
    %local paramaters
    % total number of learning trials
    MAX_EPISODE_TIME = 1500;
    T = 15000;
    eps=0.5;
    eps_decay =  0.9998;
    gamma = 0.9;
    eta = 0.5;
    eta_decay = 0.9999;
    over_episode = 100;
    %initialisation
    Q = 0.1*rand(X, Y, PSNG_POS, DROP_POS, A);
    
    rewards_per_episode = zeros(T, 1);
    max_Q_diffs = [];
    samples = zeros(T, 1);
    abs_diff = ones(T, 1);
    prev_std = 0;
    for t=1:T
       [Q_new, total_episode_reward] = learning(Q, eta, gamma, eps, trans_f);
       
       rewards_per_episode(t) = total_episode_reward;
       samples(t) = total_episode_reward;
       if t > 201
%          display(t, 'time');
%          new_std = mean(samples((t - 200):t));
%          
%          %display(new_std, 'current std');
%          abs_diff(t) = abs(new_std - prev_std);
%          %display(abs(new_std - prev_std), 'abs diff');
%          prev_std = new_std;
       end
%        Q_diff = abs(Q_new - Q);
%        max_diff = max(Q_diff(:));
%        max_Q_diffs = [max_Q_diffs, max_diff];
       
       %paramaters decay
       eta = eta * eta_decay;
       eps = eps * eps_decay;
       
       %print and values to control converges
       if (rem(t, over_episode)==0)
          display(eps, 'current eps');
          display(eta, 'current eta');
          
          figure(1);
          avg_rewards = mean(reshape(rewards_per_episode(1:t), over_episode, []));
          plot(avg_rewards, 'b');
          ylabel('average cumulative reward');
          xlabel(['Training Episodes (x', num2str(over_episode),')']);
          drawnow;
          
          %maze values for a case when
          %the passenger within taxi and drop off point is in G or in my
          %representation state with pp=5 and dp=3
%           MV = max(Q,[],5);
%           MV = MV(:, :, 5, 3);
%           MV = reshape(MV, X, Y);
%           %round to 4 digits on the left
%           MV = round(MV, 4);
%           lbls_MV = grid_to_lbls(MV, '%2.5f');
%           figure(2);
%           draw_maze(lbls_MV, strcat('maze values for pp=5 and dp=3 t=', num2str(t)));
          
%           figure(3);
%           max_diffs = mean(reshape(max_Q_diffs, over_episode, []));
%           stem(max_diffs);
%           xlabel(['Training Episodes (x', num2str(over_episode),')']);
%           ylabel('Average maximum absolute difference in Q');
       end
       Q = Q_new;
    end
    figure(3);
    plot(abs_diff);
end

