function [ data ] = createData( model )
%根据model创建仿真数据data
A = [.8 .2 ;.3 .8];
data = model*A';
% figure
% DisplayPoints2D(model,data)
t = [-0.3 0.02];
len = size(model,1);
data = data+repmat(t,len,1);
% figure
% DisplayPoints2D(model,data)

logical_index = data(:,2)<200;
data = data(logical_index,:);

rand('seed',3)
noiseX = 50 + 200.*rand([30,1]);
noiseY = 150 + 100.*rand([30,1]);
noise = [noiseX noiseY];

data = [data; noise];
% figure
% DisplayPoints2D(model,data)



end

