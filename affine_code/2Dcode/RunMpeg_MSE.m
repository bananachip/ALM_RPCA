clc;
clear;
close all;
%手动给定初值。即先在蓝色点集中取不共线的3个点，紧接着在红色点集中按顺序取其对应的3个点。
path = '.\2Ddata\original\';
%过程：MData(蓝色）->TData==DData(红色）（MData经变换与DData匹配）

%%%%%%%%%%%%%%%真实数据%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  MDataSource = imread([path, 'bone-3.gif']);
%  DDataSource = imread([path, 'bone-18.gif']);
%   MDataSource = imread([path, 'heart-6.gif']);
%  DDataSource = imread([path, 'heart-18.gif']);
 MDataSource = imread([path, 'apple-17.gif']);
 DDataSource = imread([path, 'apple-18.gif']);
%  MDataSource = imread([path, 'device6-9.gif']);
%  DDataSource = imread([path, 'device6-11.gif']);
% MDataSource = imread([path, 'pocket-15.gif']);
%  DDataSource = imread([path, 'pocket-16.gif']);
%%%%%%%%%%%%%%%%%%%%%%% 数据预处理 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MDataSource = rgb2gray(MDataSource);
% DDataSource = rgb2gray(DDataSource);
MDataSource1 = MDataSource;
DDataSource1 = DDataSource;
MDataSource = edge(MDataSource,'sobel');%一个二维矩阵，其中边缘点为1，其他点为零
[X, Y] = find(MDataSource==1);%X Y 分别为边缘点的横纵坐标
MData = [X Y];
% A0=[0.865 0.23;-0.8 0.25]
% MData=MData*A0';%%%加入仿射变换
% MData = vertcat(MData(1:2,:),MData(2:500,:));
DDataSource = edge(DDataSource,'sobel');
[X, Y] = find(DDataSource==1);
DData = [X Y];

% 
%  DData = vertcat(DData(1:2,:),DData(2:500,:));
%  %%仿真
% A0=[0.865 0.5;-0.5 0.865]
% t0=[0;0];
% DData=MData*A0';
% DData = [DData(:,1)+t0(1), DData(:, 2)+t0(2)];
 
%DData = vertcat(DData(1:100,:),DData(250:400,:),DData(550:1800,:),DData(1908:end,:));
%%%%画出边缘形状
figure
plot(X,Y,'r.');
plot(DData(:,1),DData(:,2),'r.')
hold on
plot(MData(:,1),MData(:,2),'b.')
axis equal;
grid on

%%%%%%用ginput获得初值%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[x y]=ginput(3);  %%MData 蓝色
for i=1:3
    min=(MData(1,1)-x(i))^2+(MData(1,2)-y(i))^2 ;
    xtmp=MData(1,1);
    ytmp=MData(1,2);
    for j=1:length(MData)
        if ((MData(j,1)-x(i))^2+(MData(j,2)-y(i))^2)<min
             min=(MData(j,1)-x(i))^2+(MData(j,2)-y(i))^2;
             xtmp=MData(j,1);
             ytmp=MData(j,2);
        end    
    end
    x(i)=xtmp;
    y(i)=ytmp;
end
[x1 y1]=ginput(3);  %%DData 红色
for i=1:3
    min=(DData(1,1)-x1(i))^2+(DData(1,2)-y1(i))^2 ;
    xtmp=DData(1,1);
    ytmp=DData(1,2);
    for j=1:length(DData)
        if ((DData(j,1)-x1(i))^2+(DData(j,2)-y1(i))^2)<min
             min=(DData(j,1)-x1(i))^2+(DData(j,2)-y1(i))^2;
             xtmp=DData(j,1);
             ytmp=DData(j,2);
        end    
    end
    x1(i)=xtmp;
    y1(i)=ytmp;
end

%%%%计算初值A0和t0%%%%%%%%%%
unit=ones(3,1);
M=[x y unit]
value1=M\x1;
value2=M\y1;
p=[0;0;1];
AC0=[value1 value2 p]'
A0=AC0(1:2,1:2)
t0=AC0(1:2,3)


tri = delaunayn(DData);
 
%另加的？？
% [M, D] = size(MData); 
% R = eye(D);
% t = zeros(D,1)
%%%%%%%%%%%%%%%%%%%%%%%% ICP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[R1, t1, TCorr1, MSE1, TData1] = AffineICP2D(MData, DData,A0,t0, tri);
figure
 %plot(DData(:,1),DData(:,2),'ko')
hold on
plot(DData(:,1),DData(:,2),'r.') %DData是不动的一方，所以与原图一样
plot(TData1(:,1),TData1(:,2),'b.') %旋转后的图

%plot(TData1(TCorr1(:,2),1),TData1(TCorr1(:,2),2),'g.')%旋转后的图
axis equal;
% axis off
grid on
