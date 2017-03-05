% a simple illustration of Q-learning|: a walker in a 1-d maze

% number of states
S = 10;
% number of actions
A = 3;
% total number of learning trials
T = 100000;

%initialisation
Q = 0.1*rand(S,A);
V = max(Q,[],2);
eta = 0.25;
gamma = 0.9;
epsilon = 1.0;

% run the algorithm for T trials
for t=1:T

	% set the starting state
	s0=randi(S);    
	    
	% each trial consists of re-inialisation and a S*S moves
	% a random walker will reach the goal in a number of steps proportional to
	% S*S
	for u=1:S*S
		[V(s0),a0]=max(Q(s0,:));  % we only need the a0 here

		% exploration (epsilon-greedy)
		if (rand(1)<epsilon) a0=randi(A);end

		% reward is for reaching the goal and staying there
		if (s0==1)&&(a0==2) 
			r=1;
		else 
			r=0;
		end

		% now moving left, right or not
		if (a0==1) s1=s0-1;end
		if (a0==2) s1=s0;end
		if (a0==3) s1=s0+1;end

		% don't step outside the track
		if (s1<1) s1=1;end
		if (s1>S) s1=S;end

		% now the learning step
		V(s1)=max(Q(s1,:));
		Q(s0,a0)=(1-eta)*Q(s0,a0)+eta*(r+gamma*V(s1));

		% goto next trial once the goal is reached
		if (s0==1) break; end
		s0=s1;
	end

	% exploration rate gets lower and lower
	epsilon=1/sqrt(T);
	% we could also reduce the learning rate
	%eta=1/sqrt(T);

	% plotting the Q-function
	if (rem(t,10)==0)
		plot(Q);
		hold on
		title(t);
		ylim([0 1/(1-gamma)]);
		plot(Q,'ok');
		hold off
		drawnow
	end
end

% have look at the final Q-function
Q(:,:)


% Try to answer the following questions:
%
% What is actually plotted?
%
% Why do the two upper lines intersect between state 1 and state 2?
%
% What does the value function (V) look like after convergence?
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