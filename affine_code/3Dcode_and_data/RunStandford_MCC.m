clc
clear
close all
% load ..\data\bunny
% load .\Data\StanFordData\bunnyReconstruction.mat
% DData = bunny{4,1};
% MData = bunny{4,1};
% nTotalSize = size(bunny,1);
load  Data\StanFordData\bunny.mat
DData = bunny{1,1};
MData = bunny{2,1};
% 
% load .\Data\StanFordData\dragonReconstruction.mat
% DData = dragon{4,1};
% MData = dragon{4,1};
% load .\Data\StanFordData\dragon.mat
% DData = dragon{1,1}

% load .\Data\StanFordData\happyReconstruction.mat
% DData = happy{3,1};
% MData = happy{4,1};

% load .\Data\StanFordData\dragon.mat
% DData = dragon{2,1};
% MData = dragon{3,1};
% load .\Data\StanFordData\face.mat
% DData = X;
% MData = Y;

%%%%%%%%%%仿真%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ar = [0.4717   -0.3739    0.3599;
% 0.2358    0.5285   -0.2430;
% -0.2767    0.1675    0.4617
% ]
% Ar=rand(3)
% Ar =[
% 
%     0.3188    0.0855    0.0292;
%     0.4242    0.2625    0.9289;
%     0.5079    0.8010    0.7303;
%     ]

% % tr=[4;6;8]
% Ar=[0.8688 -0.0154 0.3816;0.0162 0.9397 0.0262;-0.5694 0.0892 0.4660]
% tr=[0.0026 ;0.0082;0.0064]
% DData = MData*(Ar)';
% DData = [DData(:, 1)+tr(1), DData(:, 2)+tr(2), DData(:,3)+tr(3)];
% DData = vertcat(DData(1:4000,:),DData(end-1:end,:));
% for i=1:20
%     r=-0.025+0.05*rand(1,3)
%     DData=[DData;r]
% end



figure
% subplot(1,2,1)
plot3(MData(:,1),MData(:,2),MData(:,3),'b.')
% view(2)
% hold on 
grid on
% figure
% subplot(1,2,2)
figure
plot3(DData(:,1),DData(:,2),DData(:,3),'r.')
% view(2)
% hold on 
grid on

%%%%%%初值%%%%%%%%%%%%%%%%%%%%%%%%%
% s=[1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1];
% [As,ts]=ginput_iniparameter(MData,DData,'affine',3)
As=[0.816 -0.033 0.55;-0.007 0.98 0.02;-0.5 -0.01 0.76]
ts=[-0.05;0.001;-0.005]
% As=[0.8688 -0.0154 0.3816;0.0162 0.9397 0.0262;-0.5694 0.0892 0.4660]
% ts=[0.0026 ;0.0082;0.0064]
% As=[1.084 -0.153 0.083;0.002 0.9 0.009;-0.203 0.33 1.052]
% ts=[0.143;0.003;-0.118]
% As=[0.545 0.123 0.45;0.263 0.55 0.09; -0.41 -0.056 0.38]
% ts=[0.097;-0.063;-0.057]
% As=[0.869 -0.016 0.38;0.016 0.94 0.026;-0.57 0.09 0.46]
% ts=[0.0026;0.0082;0.0065]
s=[As ts];
s(4,:)=[0 0 0 1];
% disp s

%%%%%%%%%%%%%%%%%%%%%%%%%% 1. 直接利用仿射变换进行3D配准 %%%%%%%%%%%%%%%%%%%%%%%%%
tic
passtime = 0;
tri = delaunayn(DData);
totaltime = toc;
disp(['Complete tri, take ', num2str(totaltime - passtime), 's' ]);

[A2, corr2, error2, data2, TotalStep2] = ICP(MData, DData, tri,s); % use MData to compare DData with initial value
% [A2, corr2, error2, data2, TotalStep2] = ICP(MData, DData, tri); % use MData to compare DData with initial value
% norm(Ar-A2(1:3,1:3))
% norm(tr-A2(1:3,4))
error2 = error2.^0.5;

figure
plot3(DData(:,1),DData(:,2),DData(:,3),'r.')
% view(2)
hold on
plot3(data2(:,1),data2(:,2),data2(:,3),'b.')
% view(2)
grid on


