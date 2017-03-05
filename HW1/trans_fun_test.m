function [] = trans_fun_test()
    define_maze_global();
    
    'test - check go up'
    s = create_rnd_state();
    s.x = 1;
    s.y = 1;
    s
    [ns r] = trans_fun(s, 1, 0);
    ns
    assert(r==0,'reward must be 0');
    assert(ns.x==s.x, 'x must be the same');
    assert(ns.y==(s.y + 1), 'y must bigger by 1');
    
    'test - check go left. out of maze'
    s = create_rnd_state();
    s.x = 1;
    s.y = 1;
    s
    [ns r] = trans_fun(s, 3, 0)
    assert(r==-1,'reward must be -1 due to out of maze check');
    assert(ns.x==s.x, 'x must be the same');
    assert(ns.y==s.y, 'y must be the same');
    
    'test - check go right, walls collision'
    s = create_rnd_state();
    s.x = 1;
    s.y = 1;
    s
    [ns r] = trans_fun(s, 4, 0)
    assert(r==-1,'reward must be -1 due to collisions with walls');
    assert(ns.x==s.x, 'x must be the same');
    assert(ns.y==s.y, 'y must be the same');
    
    'test - check go left, walls collision'
    s = create_rnd_state();
    s.x = 2;
    s.y = 1;
    s
    [ns r] = trans_fun(s, 3, 0)
    assert(r==-1,'reward must be -1 due to collisions with walls');
    assert(ns.x==s.x, 'x must be the same');
    assert(ns.y==s.y, 'y must be the same');
    
    'test - check go down, out of maze'
    s = create_rnd_state();
    s.x = 1;
    s.y = 1;
    s
    [ns r] = trans_fun(s, 2, 0)
    assert(r==-1,'reward must be -1 due to out of maze');
    assert(ns.x==s.x, 'x must be the same');
    assert(ns.y==s.y, 'y must be the same');
    
    'test - check go down'
    s = create_rnd_state();
    s.x = 1;
    s.y = 2;
    s
    [ns r] = trans_fun(s, 2, 0)
    assert(r==0,'reward must be 0');
    assert(ns.x==s.x, 'x must be the same');
    assert(ns.y==(s.y - 1), 'y must be smaller by 1');
    
    'test - walls collision 1'
    s = create_rnd_state();
    s.x = 2;
    s.y = 2;
    s
    [ns r] = trans_fun(s, 3, 0)
    assert(r==-1,'reward must be -1 due to walls collision');
    assert(ns.x==s.x, 'x must be the same');
    assert(ns.y==s.y, 'y must be the same');
    
    'test - walls collision 2'
    s = create_rnd_state();
    s.x = 4;
    s.y = 1;
    s
    [ns r] = trans_fun(s, 3, 0)
    assert(r==-1,'reward must be -1 due to walls collision');
    assert(ns.x==s.x, 'x must be the same');
    assert(ns.y==s.y, 'y must be the same');
    
    'test - walls collision 3'
    s = create_rnd_state();
    s.x = 3;
    s.y = 5;
    s
    [ns r] = trans_fun(s, 3, 0)
    assert(r==-1,'reward must be -1 due to walls collision');
    assert(ns.x==s.x, 'x must be the same');
    assert(ns.y==s.y, 'y must be the same');
    
    'test - walls collision 4'
    s = create_rnd_state();
    s.x = 3;
    s.y = 4;
    s
    [ns r] = trans_fun(s, 3, 0)
    assert(r==-1,'reward must be -1 due to walls collision');
    assert(ns.x==s.x, 'x must be the same');
    assert(ns.y==s.y, 'y must be the same');
    
    'test - negative pick up'
    s = create_rnd_state();
    s.x = 2;
    s.y = 2;
    s.pp = 1;
    s
    [ns r] = trans_fun(s, 5, 0)
    assert(r==-1,'reward must be -1 due to negative pick up');
    assert(ns.x==s.x, 'x must be the same');
    assert(ns.y==s.y, 'y must be the same'); 
    assert(ns.pp==s.pp, 'pp must be the same');
    
    'test - positive pick up'
    s = create_rnd_state();
    s.x = 1;
    s.y = 1;
    s.pp = 1;
    s
    [ns r] = trans_fun(s, 5, 0)
    assert(r==1,'reward must be 1 for successful pick up');
    assert(ns.x==s.x, 'x must be the same');
    assert(ns.y==s.y, 'y must be the same'); 
    assert(ns.pp==5, 'pp must be 5, because passenger is within taxi');
    
    'test - positive pick up in [4,1]'
    s = create_rnd_state();
    s.x = 4;
    s.y = 1;
    s.pp = 4;
    s
    [ns r] = trans_fun(s, 5, 0)
    assert(r==1,'reward must be 1 for successful pick up');
    assert(ns.x==s.x, 'x must be the same');
    assert(ns.y==s.y, 'y must be the same'); 
    assert(ns.pp==5, 'pp must be 5, because passenger is within taxi');
    
    'test - negative drop off with passenger'
    s = create_rnd_state();
    s.x = 2;
    s.y = 2;
    s.pp = 5;
    s
    [ns r] = trans_fun(s, 6, 0)
    assert(r==-1,'reward must be -1 for negative drop off');
    assert(ns.x==s.x, 'x must be the same');
    assert(ns.y==s.y, 'y must be the same'); 
    assert(ns.pp==s.pp, 'pp must be the same');
    
    'test - negative drop off without passenger'
    s = create_rnd_state();
    s.x = 2;
    s.y = 2;
    s.pp = 4;
    s
    [ns r] = trans_fun(s, 6, 0)
    assert(r==-1,'reward must be -1 for negative drop off');
    assert(ns.x==s.x, 'x must be the same');
    assert(ns.y==s.y, 'y must be the same'); 
    assert(ns.pp==s.pp, 'pp must be the same');

    'test - successful drop off, 1 step since succesful pick up'
    s = create_rnd_state();
    s.x = 1;
    s.y = 1;
    s.pp = 5;
    s.dp = 1;
    s
    [ns r] = trans_fun(s, 6, 1)
    assert(r==10,'reward must be 10 for successful drop off ');
    assert(ns.x==s.x, 'x must be the same');
    assert(ns.y==s.y, 'y must be the same'); 
    assert(ns.pp==1, 'pp must be 1 after successful drop off in [1,1]');
    
    'test - successful drop off, 5 step since succesful pick up'
    s = create_rnd_state();
    s.x = 1;
    s.y = 1;
    s.pp = 5;
    s.dp = 1;
    s
    [ns r] = trans_fun(s, 6, 5)
    assert(r==10/5,'reward must be 10/5 for successful drop off ');
    assert(ns.x==s.x, 'x must be the same');
    assert(ns.y==s.y, 'y must be the same'); 
    assert(ns.pp==1, 'pp must be 1 after successful drop off [1,1]');
    
    'test - successful drop off, 5 step since succesful pick up, loc [4,1]'
    s = create_rnd_state();
    s.x = 4;
    s.y = 1;
    s.pp = 5;
    s.dp = 4;
    s
    [ns r] = trans_fun(s, 6, 5)
    assert(r==10/5,'reward must be 10/5 for successful drop off ');
    assert(ns.x==s.x, 'x must be the same');
    assert(ns.y==s.y, 'y must be the same'); 
    assert(ns.pp==4, 'pp must be 4 after successful drop off in [4,1]');
end

