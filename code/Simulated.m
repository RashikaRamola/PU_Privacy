x = [-6:.1:6];
y1 = normpdf(x,-3,3);
y2 = normpdf(x,3,3);
% y1 = normpdf(x,-0.5,1.5);
% y2 = normpdf(x,0.5,1.5);
plot(x,y1, x, y2);


data.mu1 = [-3];
data.sg1 = [1.5];
data.mu2 = [3];
data.sg2 = [1.5];

data.X = [normrnd(data.mu1,data.sg1, 10000,1)' normrnd(data.mu2,data.sg2, 10000,1)']';
data.Y = [zeros(10000,1)', ones(10000,1)']';
save('../PU_datasets/Gaussian1.mat', 'data');


data.mu1 = [-3];
data.sg1 = [3];
data.mu2 = [3];
data.sg2 = [3];

data.X = [normrnd(data.mu1,data.sg1, 10000,1)' normrnd(data.mu2,data.sg2, 10000,1)']';
data.Y = [zeros(10000,1)', ones(10000,1)']';
save('../PU_datasets/Gaussian2.mat', 'data');


data.mu1 = [-3];
data.sg1 = [4.5];
data.mu2 = [3];
data.sg2 = [4.5];

data.X = [normrnd(data.mu1,data.sg1, 10000,1)' normrnd(data.mu2,data.sg2, 10000,1)']';
data.Y = [zeros(10000,1)', ones(10000,1)']';
save('../PU_datasets/Gaussian3.mat', 'data');


clear;
addpath('./data_generators/ballinbox/');
%% demoballinbox
%% low dimensionality, with error in labeling
close all;
d = 2; % dimensionality
% d = 1; % dimensionality
nPos = 10000;
nNeg = 10000;
errPos = 0;%0.05;
errNeg = 0; %0.05;
%boxEdgeHalfLength = 1;
 boxEdgeHalfLength = 2;
method = 0; % even by volume
% method = 1; % even by radius
% method = 2; % spherical coordinates
[data.X,data.Y] = ballinbox(d,nPos,nNeg,errPos,errNeg,method,boxEdgeHalfLength);
save('../PU_datasets/BallInBox.mat', 'data');


clear;

addpath('./data_generators/waveform/');
data_WF = generate_waveform(100000);
data.X = data_WF(:,1:21);
data.Y = (data_WF(:,23)==1 | data_WF(:,24)==1 );
save('../PU_datasets/WaveForm.mat', 'data');



