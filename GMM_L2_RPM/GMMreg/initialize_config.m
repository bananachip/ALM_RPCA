function [config] = initialize_config(model, scene, motion)

config.model = model;
config.scene = scene;
config.motion = motion;
% estimate the scale from the covariance matrix
[n,d] = size(model);

%%%%%%%%%%%%%%设置scale大小，相当于设置方差sigma大小，从大到小调节%%%%%%%%%
config.scale = power(det(model'*model/n), 1/(2^d)); %默认
config.scale = config.scale /20
%config.scale = 3.5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

config.display = 0; %%显示过程图
config.init_param = [ ];
config.max_iter = 1000;
config.normalize = 0;
switch lower(motion)
    case 'tps'
        interval = 5;
        config.ctrl_pts =  set_ctrl_pts(model, scene, interval); %%取定义域内的interval*interval个像素点
        config.alpha = 1;
        config.beta = 0;
        config.opt_affine = 1;
        [n,d] = size(config.ctrl_pts); % number of points in model set : n=25, d=2
        config.init_tps = zeros(n-d-1,d); %25-2-1=22行 2列
        init_affine = repmat([zeros(1,d) 1],1,d); %[0 0 1 0 0 1]
        config.init_param = [init_affine zeros(1, d*n-d*(d+1))];% 2*25 - 2*（2+1） = 44个0
        config.init_affine = [ ];
    otherwise
        [x0,Lb,Ub] = set_bounds(motion);
        %%%%%%%给x0设置初值,默认为set_bounds返回的单位阵%%%%%%
        %初值格式为[t1 t2 a11 a21 a12 a22];注意仿射矩阵a12 a21的位置
        %x0 =  [0    0   1   0  0  1] %%%给初值
        config.init_param = x0;
        config.Lb = Lb;
        config.Ub = Ub;
end

