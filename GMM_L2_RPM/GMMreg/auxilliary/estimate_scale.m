function scale = estimate_scale(M)

%%=====================================================================
%% Project:   Point Set Registration using Gaussian Mixture Model
%% Module:    $RCSfile: estimate_scale.m,v $
%% Language:  MATLAB
%% Author:    $Author: bing.jian $
%% Date:      $Date: 2008-11-13 21:34:29 +0000 (Thu, 13 Nov 2008) $
%% Version:   $Revision: 109 $
%%=====================================================================

[m,d] = size(M);
scale = det(M'*M/m);
for i=1:d
    scale = sqrt(scale);
end