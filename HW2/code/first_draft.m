% a simple illustration of Q-learning: a walker in a 2-d maze

% number of states
Sx = 5;  % width of grid world
Sy = 5;  % length of grid world
S = Sx*Sy;  % number of states in grid world

Goals=[1, S, Sx, S + 1 - Sx]; % this is the left corner, try other places

% number of actions
A = ;    % number of actions: E, S, W, N and 0
% total number of learning trials
T = 80000;

%initialisation
Q = 0.1*rand(S,A);
V = max(Q,[],2);
eta = 0.2;
gamma = 0.9;
epsilon = 0.1;
samples = zeros(T, 1);
prev_V = max(Q,[],2);
avg_rs = zeros(T, 1);
% run the algorithm for T trials

for t=1:T

% set the starting state
s0=randi(S);    
    
% each trial consists of re-inialisation and a S*S moves
% a random walker will reach the goal in a number of steps proportional to
% S*S
avg_r = 0;
for u=1:S*S

[V(s0),a0]=max(Q(s0,:));  % we only need the a0 here

% exploration (epsilon-greedy)
if (rand(1)<epsilon) a0=randi(A);end;

% reward is for reaching the goal and staying there
if (ismember(s0, Goals(:)))&&(a0==5) r=1;
else r=0;
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
if (a0==1) s1=s0-1;
    if (rem(s1,Sy)==0) s1=s1+1;end;
end;
if (a0==2) s1=s0-Sx;
    if (s1<1) s1=s1+Sx;end;
end;
if (a0==3) s1=s0+1;
    if (rem(s1,Sy)==1) s1=s1-1;end;
end;
if (a0==4) s1=s0+Sx;
    if (s1>S) s1=s1-Sx;end;
end;
if (a0==5) s1=s0;end;

% now the learning step
V(s1)=max(Q(s1,:));
Q(s0,a0)=(1-eta)*Q(s0,a0)+eta*(r+gamma*V(s1));

% goto next trial once the goal is reached
if (ismember(s0, Goals(:))) 
  avg_r = r/u;
  %display(avg_r, 'reached the goal!');
  break; 
end

s0=s1;
end
avg_rs(t) = avg_r;
VV = max(Q,[],2);
samples(t) = sum(reshape(VV, 1,numel(VV)));
% exploration rate gets lower and lower
% (note that this was wrong in the 1D version: a "T" instead of the "t")
% epsilon=1/sqrt(t);
% we could also reduce the learning rate
% eta=1/sqrt(t);

% plotting the Q-function
% if (rem(t,10)==0)
% plot(Q);
% hold on
% title(t);
% ylim([0 1/(1-gamma)]);
% plot(Q,'ok');
% hold off
% drawnow
% end;

% % you may prefer using a mesh plot as it is a 2D example.
if (rem(t,100)==0)
  figure(6);
  
	zlim([0 1/(1-gamma)]);
	V2 = reshape(max(Q,[],2),Sx,Sy); % this is the V-value function
  %samples(
	mesh(V2);
	%%you may also like to have a look at (a=2, choose also other actions):
	%Q2 = reshape(Q(:,2),Sx,Sy);
	%mesh(Q2);
  title(t);
	drawnow
  
%t % don't know how to put current time in the figure
end

end

average_over = 200;
figure(7);
title('value average values');
avg_samples = mean(reshape(samples, average_over, []));
plot(avg_samples);

figure(8);
std_samples = std(reshape(samples, average_over, []));
plot(std_samples);

figure(9);
title('reward');
plot(mean(reshape(avg_rs, average_over, [])));


rel_diff = zeros(1, numel(avg_samples) - 1);
for t=2:size(avg_samples, 2)
  rel_diff(t) = abs(avg_samples(t) - avg_samples(t-1))/avg_samples(t);
end
convg = find(rel_diff > 0.000001, 1, 'last')
convg_t = convg * average_over
figure(10);
title('value relative difference');
plot(rel_diff);

%pallet
% as = zeros(size(avg_rewards));
% for t=21:size(avg_rewards, 2)
%   as(t)=std(avg_rewards((t-20):t))
% end
%  avg_rewards_t = ones(size(rewards, 1), 1) * -200;
%  for t=201: size(rewards, 1)
%    avg_rewards_t(t) = mean(rewards((t-200):t));
%  end
%  plot(avg_rewards_t);
% std_rewards_t = ones(size(rewards, 1), 1) * -300;
% for t=101: size(rewards, 1)
%   std_rewards_t(t) = std(rewards((t-100):t));
% end
% 
% figure(12);
% 
% plot(std_rewards_t);
% %fig=gcf;
% %set(findall(fig,'-property','FontSize'),'FontSize',24)
% fig=gcf;
% set(findall(fig,'-property','FontSize'),'FontSize',24)
% title('cat');
% figure(15);
% 
% plot(avg_rewards_t);
% % ismember([2, 4], [[2, 3]; [2, 4]; [1, 1]; ], 'rows')
% avg_samples2 = mean(reshape(samples, 200, []));
% figure(21);
% plot(avg_samples2);
% rel_diff = zeros(1, numel(avg_samples2) - 1);
% for t=2:size(avg_samples2, 2)
%   rel_diff(t) = abs(avg_samples2(t) - avg_samples2(t-1))/avg_samples2(t);
% end
% figure(22);
% plot(rel_diff);  
% find(rel_diff > 0.000001, 1, 'last')



% Try to answer the following questions:
%
% What is actually plotted?
%
% Note that we could have changed the representation for the algorithm 
% to use 2D states, but we did not. Would the algorithm become better or 
% faster when using 2D states?
% 
% We have instead kept the algorithm exactly as in the 1D example (jsut 
% with more states and actions and a different environment.
% 
% Obviously also plotting should be different as we wish to see the results
% in a representation that is implied by the enviroment. Uncomment the 
% commands near the mesh plot at the end of the above program. 
%
% Now you can answer the following questions which are quite similar as 
% last time (i.e. for 1D case). Or you can skip to the last three questions.
%
% What does the value function (V) look like after convergence?
%
% How is the length of the vertical axis determined?
%
% How long does it take until the agent finds the optimal strategy? 
% How could you test this in the program above?
%
% How long does it take until the Q-function converges? How could you 
% How could you test this in the program above?
% 
% How does the answer for the two previous questions change when S changes?
% (if you want precise results you could add an outer loop over S)
%
% Can you give more than one reason why convergence gets so slow for 
% the sub-optimal actions far from the goal?
% 
% How can you speed-up the program (without using information on the goal)?
%
%
% MORE SPECIFICALLY FOR THE 2D CASE:
%
% Why does the algorithm have problems to learn the correct value for 
% a few single states. even after 50000 or more trials?
% 
% Add some obstacle (you can find some code pieces in the middle of the 
% programme above which you can simply uncomment). 
%
% The above program implements Q-learning. How can you change it into a
% SARSA program? Can you identify a difference in the behaviour of 
% Q-learning and SARSA (in particular for the case with obstacles? 
% Note that I haven't tried this out.