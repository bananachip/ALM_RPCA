function [A,t ] = affine_reg_3D( MData,DData)
%UNTITLED6 此处显示有关此函数的摘要
%   此处显示详细说明
disp 'please input four points respect to MMata and DData';
[x,y,z]=ginput(4); %MData上取点
for i=1:4
    min=(MData(1,1)-x(i))^2+(MData(1,2)-y(i))^2+(MData(1,3)-z(i))^2 ;
    xtmp=MData(1,1);
    ytmp=MData(1,2);
    ztmp=MData(1,3);
    for j=1:length(MData)
        if ((MData(j,1)-x(i))^2+(MData(j,2)-y(i))^2+(MData(j,3)-z(i))^2)<min
             min=(MData(j,1)-x(i))^2+(MData(j,2)-y(i))^2+(MData(j,3)-z(i))^2;
             xtmp=MData(j,1);
             ytmp=MData(j,2);
             ztmp=MData(j,3);
        end    
    end
    x(i)=xtmp;
    y(i)=ytmp;
    z(i)=ztmp;
end
[x1 y1 z1]=ginput(4);  %%DData 红色
for i=1:4
    min=(DData(1,1)-x1(i))^2+(DData(1,2)-y1(i))^2+(DData(1,3)-z1(i))^2 ;
    xtmp=DData(1,1);
    ytmp=DData(1,2);
    ztmp=DData(1,3);
    for j=1:length(DData)
        if ((DData(j,1)-x1(i))^2+(DData(j,2)-y1(i))^2+(DData(j,3)-z1(i))^2)<min
             min=(DData(j,1)-x1(i))^2+(DData(j,2)-y1(i))^2+(DData(j,3)-z1(i))^2;
             xtmp=DData(j,1);
             ytmp=DData(j,2);
             ztmp=DData(j,3);
        end    
    end
    x1(i)=xtmp;
    y1(i)=ytmp;
    z1(i)=ztmp;
end
corr=[1 1;2 2;3 3;4 4];
data1=[x y z]';
data2=[x1 y1 z1]';


n = length(corr); 
M = data1(:,corr(:,1)); 
mm = mean(M,2);
S = data2(:,corr(:,2));
ms = mean(S,2); 
Sshifted = [S(1,:)-ms(1); S(2,:)-ms(2); S(3,:)-ms(3)];
Mshifted = [M(1,:)-mm(1); M(2,:)-mm(2); M(3,:)-mm(3)];
% Sshifted = [S(1,:)-ms(1); S(2,:)-ms(2)];
% Mshifted = [M(1,:)-mm(1); M(2,:)-mm(2)];
F = Mshifted*Sshifted';
K = Sshifted*Sshifted';
A = F*(K^-1);

% ddd = A1*Sshifted;
% dddd= ddd - Mshifted;
% sum(sum(dddd.^2))/size(ddd,2)

t = mm - A*ms;

end

