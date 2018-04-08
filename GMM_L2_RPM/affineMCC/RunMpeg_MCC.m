clc;
clear;
close all;
%%%%%%A*MData->DData找对应点
%seta = 2;
%手动给定初值。即先在蓝色点集中取不共线的3个点，紧接着在红色点集中按顺序取其对应的3个点。

path = '..\2Ddata\original\';

% 第1组没有缩放的数据
% MDataSource = imread([path, 'bat-4.gif']);
% DDataSource = imread([path, 'bat-5.gif']);
% MDataSource = imread([path, 'beetle-6.gif']);
% DDataSource = imread([path, 'beetle-5.gif']);
% MDataSource = imread([path, 'horse-4.gif']);
% DDataSource = imread([path, 'horse-3.gif']);


% 第2组没有缩放的数据
%  MDataSource = imread([path, 'butterfly-18.gif']);
%  DDataSource = imread([path, 'butterfly-19.gif']);
% MDataSource = imread([path, 'horse-2.gif']);
% DDataSource = imread([path, 'horse-1.gif']);
%MDataSource = imread('C:\Users\hongchen chen\Pictures\original\horse-2.gif');
% DDataSource = imread( 'C:\Users\hongchen chen\Pictures\original\horse-1.gif');

% 
% MDataSource = imread([path, 'deer-9.gif']);
% DDataSource = imread([path, 'deer-8.gif']);
% % 
% MDataSource = imread([path, 'apple-19.gif']);
% DDataSource = imread([path, 'apple-18.gif']);
% 
%比例加旋转数据
% MDataSource = imread([path, 'bird-11.gif']);
% DDataSource = imread([path, 'bird-14.gif']);
% MDataSource = imread([path, 'butterfly-1.gif']);
% DDataSource = imread([path, 'butterfly-2.gif']);
% MDataSource = imread([path, 'chicken-2.gif']);
% DDataSource = imread([path, 'chicken-3.gif']);



%%%%%%%%%%%%%%%%%%%%%%%%%仿射数据%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MDataSource = imread([path, 'dog-1.gif']);
% DDataSource = imread([path, 'dog-19.gif']);
% MDataSource = imread([path, 'fish-15.gif']);
% DDataSource = imread([path, 'fish-14.gif']);
% MDataSource = imread([path, 'chicken-16.gif']);
% DDataSource = imread([path, 'chicken-2.gif']);
% MDataSource = imread([path, 'bird-5.gif']);
% DDataSource = imread([path, 'bird-4.gif']);
% MDataSource = imread([path, 'apple-1.gif']);
% DDataSource = imread([path, 'apple-2.gif']);


% 第1组有缩放的数据
% MDataSource = imread([path, 'flatfish-14.gif']);
% DDataSource = imread([path, 'flatfish-13.gif']);
% 第2组有缩放的数据
% MDataSource = imread([path, 'elephant-17.gif']);
% DDataSource = imread([path, 'elephant-19.gif']);
% MDataSource = imread([path, 'apple-4.gif']);
% DDataSource = imread([path, 'apple-3.gif']);
% MDataSource = imread([path, 'bell-19.gif']);
% DDataSource = imread([path, 'bell-20.gif']);
% MDataSource = imread([path, 'horseshoe-8.gif']);
% DDataSource = imread([path, 'horseshoe-16.gif']);
% MDataSource = imread([path, 'turtle-1.gif']);
% DDataSource = imread([path, 'turtle-6.gif']);

% 第1组没有缩放的数据
% MDataSource = imread([path, 'bat-4.gif']);
% DDataSource = imread([path, 'bat-5.gif']);
% MDataSource = imread([path, 'beetle-6.gif']);
% DDataSource = imread([path, 'beetle-5.gif']);
% MDataSource = imread([path, 'horse-3.gif']);
% DDataSource = imread([path, 'horse-4.gif']);

% 第2组没有缩放的数据
% MDataSource = imread([path, 'butterfly-18.gif']);
% DDataSource = imread([path, 'butterfly-19.gif']);
% MDataSource = imread([path, 'horse-2.gif']);
% DDataSource = imread([path, 'horse-1.gif']);
% MDataSource = imread([path, 'horse-8.gif']);
% DDataSource = imread([path, 'horse-7.gif']);

% MDataSource = imread([path, 'ray-5.gif']);
% DDataSource = imread([path, 'ray-8.gif']);

% MDataSource = imread([path, 'heart-3.gif']);
% DDataSource = imread([path, 'heart-14.gif']);

%  MDataSource = imread([path, 'ray-17.gif']);
%  DDataSource = imread([path, 'ray-18.gif']);

%%%%%%%%%%%%%%%%%%%%%%%%%%我的仿射数据%%%%%%%%%%%%%
%  MDataSource = imread([path, 'bat-2.gif']);
%  DDataSource = imread([path, 'bat-3.gif']);
%  MDataSource = imread([path, 'bird-7.gif']);
%  DDataSource = imread([path, 'bird-8.gif']);
%   MDataSource = imread([path, 'chicken-2.gif']);%sigma=1.5
%   DDataSource = imread([path, 'chicken-3.gif']);
%  MDataSource = imread([path, 'apple-17.gif']);
%  DDataSource = imread([path, 'apple-18.gif']);
%  MDataSource = imread([path, 'butterfly-5.gif']);
%  DDataSource = imread([path, 'butterfly-6.gif']);
%   MDataSource = imread([path, 'crown-4.gif']);
%   DDataSource = imread([path, 'crown-5.gif']);
%  MDataSource = imread([path, 'cup-18.gif']);
%  DDataSource = imread([path, 'cup-20.gif']);


%%%%%%%%%%%%%%真实数据%%%%%%%%%%%%%%%%%%
 MDataSource = imread([path, 'bone-3.gif']);
 DDataSource = imread([path, 'bone-18.gif']);
%  MDataSource = imread([path, 'pocket-15.gif']);
%  DDataSource = imread([path, 'pocket-16.gif']);
%  MDataSource = imread([path, 'heart-6.gif']);
%  DDataSource = imread([path, 'heart-18.gif']);
%  MDataSource = imread([path, 'apple-17.gif']);
%  DDataSource = imread([path, 'apple-18.gif']);
%  MDataSource = imread([path, 'device6-9.gif']);
%  DDataSource = imread([path, 'device6-11.gif']);
%%%%%%%%%%%%%%%%%%%%%%% 数据预处理 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MDataSource = rgb2gray(MDataSource);
% DDataSource = rgb2gray(DDataSource);

% MDataSource1 = MDataSource;
% DDataSource1 = DDataSource;

MDataSource = edge(MDataSource,'sobel');%一个二维矩阵，其中边缘点为1，其他点为零
[X, Y] = find(MDataSource==1);%X Y 分别为边缘点的横纵坐标
MData = [X Y];
% A0=[0.865 0.23;-0.8 0.25]
% MData=MData*A0';%%%加入仿射变换
%MData = vertcat(MData(1:2,:),MData(2:500,:));
Num= length(MData);
% Num = length(Y);
One = ones(Num,1);
MData1=[MData One];
% MData1 = [X Y One];

%仿真的A0
% A0=rand(2,2);
% t0=rand(2,1);
% A=[A0,t0]
% A0=[0.865 0.5;-0.5 0.865]
% t0=[0;0];
% DData=MData*A0';
% DData = [DData(:,1)+t0(1), DData(:, 2)+t0(2)];
% DData1 =  [DData One];

DDataSource = edge(DDataSource,'sobel');
[X, Y] = find(DDataSource==1);
DData = [X Y];

%DData = vertcat(DData(1:50,:),DData(100:400,:),DData(550:800,:),DData(1000:end,:));
%DData = vertcat(DData(1:2,:),DData(2:500,:));

Num = length(Y);
One = ones(Num,1);
DData1 = [X Y One];
%DData1 = vertcat(DData1(1:50,:),DData1(100:400,:),DData1(550:800,:),DData1(1000:end,:));
%DData1 = vertcat(DData1(1:2,:),DData1(2:500,:));




%%%%画出边缘形状
figure
plot(X,Y,'r.');
plot(DData(:,1),DData(:,2),'r.')
hold on
plot(MData(:,1),MData(:,2),'b.')
axis equal;
grid on


%%%%%%用ginput获得初值%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
% A0=A(1:2,1:2)
% t0=A(1:2,3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
plot(X,Y,'r.');
plot(DData(:,1),DData(:,2),'r.')
axis off
figure
plot(MData(:,1),MData(:,2),'b.')
axis off

tri = delaunayn(DData);

%另加的？？
% [M, D] = size(MData); 
% R = eye(D);
% t = zeros(D,1)
%%%%%%%%%%%%%%%%%%%%%%%% ICP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[A, TCorr1, error, TData] = ICP(MData, DData, tri,AC0);
% save data1.txt  error  -ascii -double
% xlswrite(error_device, error)
% figure;
% plot(error(1:50), 'r*-');
% hold on
% plot(error1(1:50), 'bo-');
% plot(error2(1:50), 'gx-');
% grid on;
% xlabel('Iteration number');
% ylabel('RMS');
% title('Compare ICP, ICPS and ICPBS (0.9≤s≤1.1)');
% legend('ICP',  'ICPBS', 'ICPUS', 1);
% axis([0 50 0.0015 0.006])



figure
 %plot(DData(:,1),DData(:,2),'ko')
hold on
plot(DData(:,1),DData(:,2),'r.') %DData是不动的一方，所以与原图一样
plot(TData(:,1),TData(:,2),'b.') %旋转后的图
%plot(TData1(TCorr1(:,2),1),TData1(TCorr1(:,2),2),'g.')%旋转后的图
axis equal;
axis off;
grid on
