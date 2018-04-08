function [A, t, corr, fals, TData, TotalStep, tri] = AffineICP2D(MData, DData, A, t, tri)

% [R, t, corr, error, data2] = icp2(data1, data2)
% 
% This is an implementation of the Iterative Closest Point (ICP) algorithm.
% The function takes two data sets and registers data2 with data1. It is
% assumed that data1 and data2 are in approximation registration. The code
% iterates till no more correspondences can be found.
%
% This is a modified version (12 April, 2005). It is more accurate and has 
% less chances of getting stuck in a local minimum as opposed to my earlier
% version icp.m 
%
% Arguments: data1 - 3 x n matrix of the x, y and z coordinates of data set 1
%            data2 - 3 x m matrix of the x, y and z coordinates of data set 2
%            res   - the tolerance distance for establishing closest point
%                     correspondences. Normally set equal to the resolution
%                     of data1
%            tri   - optional argument. obtained by tri = delaunayn(data1');
%
% Returns: R - 3 x 3 accumulative rotation matrix used to register data2
%          t - 3 x 1 accumulative translation vector used to register data2
%          corr - p x 3 matrix of the index no.s of the corresponding points of
%                 data1 and data2 and their corresponding Euclidean distance
%          error - the mean error between the corresponding points of data1
%                  and data2 (normalized with res)
%          data2 - 3 x m matrix of the registered data2 
%
%
% Copyright : This code is written by Ajmal Saeed Mian {ajmal@csse.uwa.edu.au}
%              Computer Science, The University of Western Australia. The code
%              may be used, modified and distributed for research purposes with
%              acknowledgement of the author and inclusion of this copyright information.

% The precision Epsilon
Epsilon = 10^-6;

% Data for two 3D data sets 
M = size(MData, 1);   % the number of the model point
N = size(DData, 1);   % the number of the test point

% The initial value A(0)=Identity
if nargin <= 3
    A = eye(2);
 %    A=[0.7 0.4;-0.4 0.7 ]
     t = zeros(2,1);
%     t=[0.8;0.9];
end

TotalStep = 1;  % last step, if the program is pause, it is the total iterative step
CurrStep = 1;  % current step
LastMinusFals = 10^6; %Save the last and last step's error minus last step's fals
MaxStep = 50; % the max step of iteration

fals = zeros(MaxStep, 1);   % The Error
fals(1) = 10^6;   % The Error

passtime = 0;
tic
if nargin <= 4
    tri = delaunayn(DData);
end
totaltime = toc;
disp(['Complete tri, take ', num2str(totaltime - passtime), 's' ]);
passtime = totaltime;
% while (LastMinusFals > Epsilon && ;TotalStep < MaxStep)
while (fals(TotalStep) > Epsilon && TotalStep < MaxStep) 
    
    TData = (A * MData')'; % it is the transformation data
    TData = [TData(:,1)+t(1), TData(:, 2)+t(2)];
%     TData = [TData(:, 1)+t(1), TData(:, 2)+t(2), TData(:,3)+t(3)];
    [corr, D] = dsearchn(DData, tri, TData); % find the indices of closest points in the test data    
    corr(:,2) = [1 : length(corr)]';
    
%     mean(D.^2)
    [A1, t1] = reg(DData', TData', corr);  % use TData to register DData by A1 and t1
    A = A1*A
    t = A1*t + t1
    
    TData = (A * MData')'; % it is the transformation data
    TData = [TData(:,1)+t(1), TData(:, 2)+t(2)];
%     TData = [TData(:, 1)+t(1), TData(:, 2)+t(2), TData(:,3)+t(3)];
    fals(CurrStep) = sqrt(sum((sum((TData-DData(corr(:,1), :)).^2, 2)))/M);        % compute error
%     fals(CurrStep) = sum(sqrt(sum((TData-DData(corr(:,1), :)).^2, 2)))/M ;  % compute error
    err=sum(fals(CurrStep))/length(fals(CurrStep)) %¼ÆËã¾ù·½Îó²î
    TotalStep = CurrStep;      % TotalStep record current step as last step
    CurrStep = CurrStep + 1;  % CurrStep is next step
    if TotalStep == 1
        LastMinusFals = fals(TotalStep);
    else
        LastMinusFals = abs(fals(TotalStep) - fals(TotalStep-1));
    end
    
    totaltime = toc;
    disp(['Complete ', num2str(TotalStep),  ' time, ', 'take ', num2str(totaltime - passtime), 's' ]);
    passtime = totaltime;
end

disp(['totaltime:', num2str(totaltime), 's' ]);
% figure;
% plot(fals, 'r-');

%-----------------------------------------------------------------
function [A1, t1] = reg(data1, data2, corr)
n = length(corr); 
M = data1(:,corr(:,1)); 
mm = mean(M,2);
S = data2(:,corr(:,2));
ms = mean(S,2); 
% Sshifted = [S(1,:)-ms(1); S(2,:)-ms(2); S(3,:)-ms(3)];
% Mshifted = [M(1,:)-mm(1); M(2,:)-mm(2); M(3,:)-mm(3)];
Sshifted = [S(1,:)-ms(1); S(2,:)-ms(2)];
Mshifted = [M(1,:)-mm(1); M(2,:)-mm(2)];
F = Mshifted*Sshifted';
K = Sshifted*Sshifted';
A1 = F*(K^-1);

% ddd = A1*Sshifted;
% dddd= ddd - Mshifted;
% sum(sum(dddd.^2))/size(ddd,2)

t1 = mm - A1*ms;



