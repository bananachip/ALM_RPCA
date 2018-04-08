function [A,t,s] = ginput_iniparameter( MData,DData,method,dim )
%UNTITLED 此处显示有关此函数的摘要
%method: rigid,scale,affine
%dim:2or3

%   此处显示详细说明

switch lower(method)
    case {'rigid'}
        if dim==2
            [R,t]=rigid_reg_2D(MData,DData);
            A=R; 
            disp 'rigid and 2-D'
        elseif dim==3
            [R,t]=rigid_reg_3D(MData,DData);
            A=R;
            disp 'rigid and 3D'
        end
    case {'scale'}
        if dim==2
            disp 'scale and 2-D'
        elseif dim==3
            disp 'scale and 3D'
        end
    case{'affine'}
         if dim==2
            [A,t]=affine_reg_2D(MData,DData);
            disp 'affine and 2-D';
        elseif dim==3
            [A,t]=affine_reg_3D(MData,DData);
            disp 'affine and 3D'
         end
    otherwise errpr('the input method paremeter is wrong')
end

