function [axis_limits] = determine_border(Model, Scene)
%%=====================================================================
%% Module:    $RCSfile: determine_border.m,v $
%% Language:  MATLAB
%% Author:    $Author: bing.jian $
%% Date:      $Date: 2008-11-13 21:34:29 +0000 (Thu, 13 Nov 2008) $
%% Version:   $Revision: 109 $
%% return [x1min,x1max; ymin,ymax; zmin zmax]
%%=====================================================================

dim = size(Scene,2);
axis_limits = zeros(dim,2);
for i=1:dim
    min_i = min([Scene(:,i);Model(:,i)]); %得到一个长的列向量
    max_i = max([Scene(:,i);Model(:,i)]);
    margin_i = (max_i-min_i)*0.05; %外延一点点
    axis_limits(i,:) = [min_i - margin_i max_i+margin_i];
end

