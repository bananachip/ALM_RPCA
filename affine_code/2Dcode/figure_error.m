load Apple
Apple=err;
load Heart
Heart=err;
load Bone
Bone=err;
load Device
Device=err;
figure
plot(1:length(Apple),Apple,'*-r');title('Apple')
% hold on
figure
plot(1:length(Heart),Heart,'*-b');title('Heart')
% hold on 
figure
plot(1:length(Bone),Bone,'*-g');title('Bone')
% hold on 
figure
plot(1:length(Device),Device,'*-y');title('Device')