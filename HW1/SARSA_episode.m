function [Q_final, total_episode_reward] = SARSA_episode(Q, eta, gamma, eps, trans_f)
   %v - value, a - action, s - state, r - reward, q - Q-value
   %n in front of them means next
   global DROP_LOCS MAX_EPISODE_TIME
   s = create_rnd_state();
   %trial
   drive_time = 0;
   total_episode_reward = 0;
   %initial action
   [v, a] = eps_greedy(s, Q, eps);
   for step=1:MAX_EPISODE_TIME
       %passenger is within taxi increase time
       if s.pp == 5
           drive_time = drive_time + 1;
       end

       %perform action
       [ns, r] = trans_f(s, a, drive_time);
       total_episode_reward = total_episode_reward + r;

       %estimate next state
       [nv, na] = eps_greedy(ns, Q, eps);
       %learning
       q = Q(s.x, s.y, s.pp, s.dp, a);
       Q(s.x, s.y, s.pp, s.dp, a) = (1-eta)*q + eta*(r+gamma*nv);

       %check for terminal conditions
       drop_loc = DROP_LOCS(s.dp, :);
       %when we drop off passanger in the drop of location, 
       %previously we had passanger within taxi
       if s.pp == 5 && a == 6 && all([ns.x, ns.y] == drop_loc)
           break;
       end
       %update old state
       s = ns;
       %new action
       a = na;
   end
   Q_final = Q;
end



