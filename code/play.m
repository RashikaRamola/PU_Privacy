addpath('./data_generators/ballinbox/');
%% demoballinbox
%% low dimensionality, with error in labeling
close all;
% d = 2; % dimensionality
% d = 1; % dimensionality
nPos = 1000;
nNeg = 1000;
errPos = 0;%0.05;
errNeg = 0; %0.05;
%boxEdgeHalfLength = 1;
 boxEdgeHalfLength = 2;
method = 0; % even by volume
% method = 1; % even by radius
% method = 2; % spherical coordinates
[x,t] = ballinbox(d,nPos,nNeg,errPos,errNeg,method,boxEdgeHalfLength);
figure
if d == 1
    plot(x(t==1,1),ones(size(x(t==1,1))),'r.',x(t==0,1),ones(size(x(t==0,1))),'g.');
else
    plot(x(t==1,1),x(t==1,2),'r.',x(t==0,1),x(t==0,2),'g.');
end
    
setFigureSize(gcf,[400,400],'a');

%% high dimensionality, without error in labeling
d = 3; % dimensionality
% d = 10; % dimensionality
% d = 100; % dimensionality
nPos = 1000;
nNeg = 1000;
errPos = 0;
errNeg = 0;
method = 0; % even by volume
% method = 1; % even by radius
% method = 2; % spherical coordinates
[x,t] = ballinbox(d,nPos,nNeg,errPos,errNeg,method,boxEdgeHalfLength);
figure
if d == 1
    plot(x(t==1,1),ones(size(x(t==1,1))),'r.',x(t==0,1),ones(size(x(t==0,1))),'g.');
else
    plot(x(t==1,1),x(t==1,2),'r.',x(t==0,1),x(t==0,2),'g.');
end
setFigureSize(gcf,[400,400],'a');
if d > 2
    figure
    plot(x(t==1,end-1),x(t==1,end),'r.',x(t==0,end-1),x(t==0,end),'g.');
    setFigureSize(gcf,[400,400],'a');
end
