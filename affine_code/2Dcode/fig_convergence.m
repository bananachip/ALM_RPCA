clc
close all
clear all
apple = load('obj_apple')
apple = apple.VC;
bone = load('obj_bone')
bone = bone.VC;
heart = load('obj_heart')
heart = heart.VC;
device = load('obj_device')
device = device.VC;
figure;

% subplot(2,2,1)
plot(apple(1:25), 'r*-');
% xlabel('Iteration number');
% ylabel('Objective function');
% title('Apple')
% grid on;
% xlim([0 25 ])

hold on
% subplot(2,2,2)
plot(heart(1:25), 'bo-');
% plot(heart(1:25), 'r*-');
% grid on;
% xlabel('Iteration number');
% ylabel('Objective function');
% title('Heart')
% xlim([0 25 ])

% 
% subplot(2,2,3)
plot(bone(1:25), 'gx-');
% plot(bone(1:25), 'r*-');
% grid on;
% xlabel('Iteration number');
% ylabel('Objective function');
% title('Bone')
% xlim([0 25 ])

% subplot(2,2,4)
plot(device(1:25),'m+-');
% plot(device(1:25),'r*-');
grid on;
% xlabel('Iteration number');
% ylabel('Objective function');
% title('Device')
% xlim([0 25 ])
% title('Compare ICP, ICPS and ICPBS (0.9¡Üs¡Ü1.1)');
legend('Apple',  'Heart', 'Bone','Device', 4);
axis([0 25 0.4 1])
