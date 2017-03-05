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