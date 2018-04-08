% Example 1. Affine CPD point-set registration. No options are set, so the
% default ones are used. 2D fish point-set.
clear all; close all; clc;
path = '.\2Ddata\original\';
%Y为MData 经过变换与X/Data匹配
%%%%%%%%%%%%%%本实验所用真实数据%%%%%%%%%%%%%%%%%%
 MDataSource = imread([path, 'device6-9.gif']);
 DDataSource = imread([path, 'device6-11.gif']);
%   MDataSource = imread([path, 'bone-3.gif']);
%  DDataSource = imread([path, 'bone-18.gif']);
%  MDataSource = imread([path, 'heart-6.gif']);
%  DDataSource = imread([path, 'heart-18.gif']);
%  MDataSource = imread([path, 'apple-17.gif']);
%  DDataSource = imread([path, 'apple-18.gif']);

MDataSource = edge(MDataSource,'sobel');%一个二维矩阵，其中边缘点为1，其他点为零
[X, Y] = find(MDataSource==1);%X Y 分别为边缘点的横纵坐标
MData = [X Y];
% A0=[0.865 0.23;-0.8 0.25]
% MData=MData*A0';%%%加入仿射变换
%MData = vertcat(MData(1:2,:),MData(2:500,:));
DDataSource = edge(DDataSource,'sobel');
[X, Y] = find(DDataSource==1);
DData = [X Y];



% % % %仿真的A0%%%%%%%%%%%%%%%%%%%%%%%%%
%  As=rand(2,2);
%  ts=10*rand(2,1);
%  %A=[A0,t0]
%  As=[0.865 0.23;-0.8 0.25]
%  ts=[12;5];
%  DData=MData*As';
%  DData = [DData(:,1)+ts(1), DData(:, 2)+ts(2)];
%  DData = vertcat(DData(1:1,:),DData(200:end,:));%apple device bone
% %  DData = vertcat(DData(1:10,:),DData(300:end,:)); %heart
%  
Y=MData;
X=DData;
%%%%画出边缘形状
figure

plot(X(:,1),X(:,2),'r.')
hold on
plot(Y(:,1),Y(:,2),'b.')
axis equal;
grid on

 
% load cpd_data2D_fish; Y=X;

% Add a random affine transformation
% B=eye(2)+0.5*abs(randn(2,2));
% X=X*B';


opt.method='affine';
tic
Transform=cpd_register(X,Y,opt)
toc
% norm(Transform.R-As)
% norm(Transform.t-ts)

% Initial point-sets
figure,cpd_plot_iter(X, Y); title('Before');

% Registered point-sets
figure 
 plot(X(:,1), X(:,2),'r.', Transform.Y(:,1), Transform.Y(:,2),'b.'); axis off;
% figure,cpd_plot_iter(X, Transform.Y);  title('After');
