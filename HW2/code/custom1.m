average_over = 200;
avg_samples = mean(reshape(samples, average_over, []));

rel_diff = zeros(1,(size(avg_samples, 2) - 50));
for t=1:(size(avg_samples, 2) - 50)
  smp_std = std(avg_samples(t:(t+50)));
  rel_diff(t) = smp_std;%abs(avg_samples(t) - avg_samples(t-1))/avg_samples(t);
end

rel_diff = rel_diff(1:N-51);
find(rel_diff > 6, 1, 'last')
figure(40);
clf;
title('value function relative difference');
plot(rel_diff);
ylabel('relative difference');
xlabel(['training epsidoes (x', num2str(average_over), ')']); 
fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',24);