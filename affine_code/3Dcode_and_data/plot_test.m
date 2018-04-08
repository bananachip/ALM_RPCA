% load .\Data\StanFordData\bunny.mat
% DData = bunny{1,1};
% MData = bunny{2,1};

load Data\StanFordData\bunnyReconstruction.mat
DData = bunny{1,1};
MData = bunny{2,1};

figure
subplot(1,2,1)
plot3(MData(:,1),MData(:,2),MData(:,3),'b.')
% view(2);
hold on 
grid on
% figure
subplot(1,2,2)
plot3(DData(:,1),DData(:,2),DData(:,3),'r.')
% view(2)
hold on 
grid on