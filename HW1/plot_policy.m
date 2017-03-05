function [] = plot_policy(Q)
  define_maze_global()
  global X Y
  actions_map = zeros(X, Y);
  %initial state in the left bottom corner with
  %pasenger and must go to G
  s = create_rnd_state();
  s.pp = 5;
  s.dp = 3;
 
  for x=1:X
    for y=1:Y
      %perform action
       s.x = x;
       s.y = y;
      [v, a] = greedy(s, Q);
      actions_map(s.x, s.y) = a;
    end
  end
  
  lbls_actions = grid_to_lbls(actions_map);
  lbls_actions = actions2str(lbls_actions);
  figure(4);
  draw_maze(lbls_actions, 'actions map for taxi');
end

