function [A, corr, error, TData, TotalStep, tri] = ICP(MData, DData, tri, A)

% This is an implementation of the Probabilistic Iterative Closest Point (PICP) algorithm.
% The function takes two data sets and registers DData with MData.  
% The code iterates till no more correspondences can be found.
% MData->DData
% Arguments: MData - M x D matrix of the x, y and z coordinates of data set 1, D is the dimension of point set
%            DData - N x D matrix of the x, y and z coordinates of data set 2 
%            tri   - optional argument. obtained by tri = delaunayn(DData');基于 Delaunay 三角化的近点搜索算法
%
% Returns: R - D x D accumulative rotation matrix used to register DData
%          t - D x 1 accumulative translation vector used to register DData
%          corr - M x D matrix of the index no.s of the corresponding points of
%                 MData and DData and their corresponding Euclidean distance
%          error - the probabilistic error between the corresponding points
%                  of MData and DData (normalized with res)
%          TData - M x D matrix of the registered DData 
%
% Copyright: This code is written by Shaoyi Du {dushaoyi@gmail.com}
%            Institute of Artificial Intelligence and Robotics, Xi'an Jiaotong University, P.R.China
%            The code may be used, modified and distributed for research purposes with acknowledgement of the author and inclusion of this copyright information.

% The precision Epsilon
% Epsilon = 10^-6;
Epsilon = 10^-6;

[M, D] = size(MData);   % the number of the model point
[N, D] = size(DData);   % the number of the test point

% Initialization
passtime = 0;
 tic
if nargin <= 2  %输入参数个数 number of input argument
    tri = delaunayn(DData);
end

% The initial value A(0)=Identity
if nargin <= 3
%  A=[0.7 0.4 0.8;-0.4 0.7 0.9;0 0 1]
   A=[1 0 0 ;0 1 0; 0 0 1];
end

TotalStep = 1;  % last step, if the program is pause, it is the total iterative step
CurrStep = 1;  % current step
LastMinuserror = 10^6; %Save the last and last step's error minus last step's error
MaxStep = 50; % the max step of iteration

% error = zeros(MaxStep, 1);   % The Error
error(1) = 10^6;   % The Error

% figure;
% To obtain the transformation data

One = ones(M,1);
MData1 = [MData One];
One = ones(N,1);
DData1 = [DData One];

TData1 = (A * MData1')';  %其实就是TData = MData*A'
TData = TData1(:,1:2);
figure
%TData = TData + repmat(t',[M,1]);  %t'为一个行向量，最后得到M行的t'
%  figure   
% fid =['apple','txt'];
value=cell(1,50); 
flag =1;
while (LastMinuserror > Epsilon && TotalStep < MaxStep)
% while (error(TotalStep) > Epsilon && TotalStep < MaxStep) 
      
    % Find the indices of closest points in the test data
    [corr, TD] = dsearchn(DData, tri, TData);    %在DData中找到所有TData中的每个点对应的最近的点 ，得到长为TData的一个列向量corr和TDatat与DData之间的距离列向量TD
    %corr为该点对应在在DDtata中的位置 TD为两点间相差的距离
    corr(:,2) = [1 : length(corr)]';   %corr=[ck1 1;ck2 2;...ckn n]
    
    % Register DData with TData
    [G,A] = reg(MData, DData, corr,TD); %自定义函数式 计算MData和DData之间新的刚体变换R1和t1

    %%%%收敛图%%%%%%%%%%%%%
    aver_G = mean(G);
    value{flag} = aver_G;
    flag= flag+1;   
    
    


    % To obtain the transformation data
  

    error(CurrStep) = sqrt(sum((sum((TData-DData(corr(:,1), :)).^2, 2)))/M) ; % compute error求在这一次循环中整个数集的平均误差 ；sum（A，2）对A每行求和
    err(CurrStep)=sum(error(CurrStep))/length(error(CurrStep));
    
% 
%      plot(CurrStep,err(CurrStep),'*')
%      hold on
%     
    
    TData1 = (A * MData1')'; 
    TData = TData1(:,1:2);
%     ICPPlot(DData, TData);

    TotalStep = CurrStep;     % TotalStep record current step as last step
    CurrStep = CurrStep + 1;  % CurrStep is next step
    
    if TotalStep == 1
        LastMinuserror = error(TotalStep);
    else
        LastMinuserror = abs(error(TotalStep) - error(TotalStep-1));
    end
    
%     totaltime = toc;
%     disp(['Complete ', num2str(TotalStep),  ' time, ', 'take ', num2str(totaltime - passtime), 's' ]);
   disp(['Complete ', num2str(TotalStep),  ' time, ']);
%     passtime = totaltime;
end
toc

%%%%%%%画收敛图%%%%%%%%%%%%
% VC=zeros(1,25);
% for i=1:25
%     VC(i) = value{i}(1);
% end
% save('obj_bone.mat','VC')
% plot(1:25,VC,'*-')
% disp(['Totaltime:', num2str(totaltime), 's' ]);
% figure;
% plot(error, 'r-');
%   plot(1:CurrStep-1,err,'*-')



%-----------------------------------------------------------------
%%%%%%%%%%%%%% T(TData)->DData %%%%%%%%%%%%%%%%
function [G,A] = reg(MData, DData, corr,TD)
sigma =3;
n = length(corr); 
DData = DData(corr(:,1),:);
One = ones(n,1);
MData1 = [MData One];
DData1 = [DData One];
G = exp(-(TD.^2)/(2*sigma^2));
Dg = diag(G);
% A=((inv(MData1'*Dg*MData1))*MData1'*Dg*DData1)'
 A=DData1'*Dg*MData1*inv(MData1'*Dg*MData1);



