clear all;
close all;

%affine2d
%initialize_config函数里的config.scale调节方差大小
%

path = '.\2Ddata\original\';
%%%%%%%%%%%%%%真实数据%%%%%%%%%%%%%%%%%%
%  MDataSource = imread([path, 'bone-3.gif']);
%  DDataSource = imread([path, 'bone-18.gif']);
%  MDataSource = imread([path, 'heart-6.gif']);
%  DDataSource = imread([path, 'heart-18.gif']);  %config.scale / 20
 MDataSource = imread([path, 'apple-17.gif']);
 DDataSource = imread([path, 'apple-18.gif']);
%  MDataSource = imread([path, 'device6-9.gif']);
%  DDataSource = imread([path, 'device6-11.gif']);
%  MDataSource = imread([path, 'pocket-15.gif']);
%  DDataSource = imread([path, 'pocket-16.gif']);
MDataSource = edge(MDataSource,'sobel');%一个二维矩阵，其中边缘点为1，其他点为零
[X, Y] = find(MDataSource==1);%X Y 分别为边缘点的横纵坐标
MData = [X Y];
DDataSource = edge(DDataSource,'sobel');
[X, Y] = find(DDataSource==1);
DData = [X Y];
model = MData; scene = DData;

% model = textread('fish_X.txt');  % config.scale /5 = 0.073
% scene = textread('fish_Y.txt');
% model = textread('face_X.txt');
% scene = textread('face_Y.txt');
% model = textread('fish_X_nohead.txt');
% scene = textread('fish_Y_notail.txt');


config = initialize_config(model, scene, 'affine2d');

[param, transformed_model, history, config] = gmmreg_L2(config);

figure(1)
DisplayPoints2D(config.model,config.scene);
figure(2)
DisplayPoints2D(transformed_model,config.scene);

figure
plot(config.scene(:,1),config.scene(:,2),'r.') %DData是不动的一方，所以与原图一样
hold on;
plot(transformed_model(:,1),transformed_model(:,2),'b.') %旋转后的图
