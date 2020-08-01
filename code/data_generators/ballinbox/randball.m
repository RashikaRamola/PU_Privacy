function x = randball(d,n,method)
% Function randball generate sample from random variables with even
% distributions in a d-dimensional unit sphere (i.e. with radius 1).    
% Input
%   d: dimensionality of the sphere;
%   n: sample size, default = 1;
%   method: 
%       0 - Gaussian Distribution based, even distribution w.r.t. volume
%       (default);
%       1 - Gaussian Distribution based, even distribution w.r.t. radius
%       2, sphere coordinate based, leads to non-even distribution
%       3, conditional density based, can not compute
% Output
%   x: n*d matrix, with each row one instance.
% Method 0,1:
%   Pick a random dirction by d-dimensional Gaussian distribution and then,
%   pick a radius
% Method 2:
%   By Spherical Coordinates, however, even distribution of the angles does
%   not lead to the even distribution of the dots on the sphere (ref:
%   http://mathworld.wolfram.com/SpherePointPicking.html)
% Method 3:
%   for  1*d vector x,
%   let r(k, x) = sqrt(1-x(1:k)*x(1:k)'), wiht r(0,x) = 1;
%   let v(k, r) =  pi^(k/2)*r^n/Gamma(1+n/2) be the volume of k-d ball with
%   radius r;
%   then conditional density f(x(k+1)|x(1:k)) = 
%       v(n-k-1, r(k+1,x))/v(n-k, r(k,x));
%   the problem is that generate r.v. with this conditional density is hard
% Exaple:
%   close all
%   x = randball(100,1000);
%   scatter(x(:,1),x(:,2));
%   % axis([-1 1 -1 1]*0.4);
%   figure;
%   scatter(x(:,end-1),x(:,end));
%   % axis([-1 1 -1 1]*0.4);
%   x = randball(2,1000);
%   scatter(x(:,1),x(:,2));
%   x = randball(2,1000,1);
%   scatter(x(:,1),x(:,2));
% Ref for random direction generation:
% http://mathworld.wolfram.com/HyperspherePointPicking.html
% Ref for ball volume: http://mathworld.wolfram.com/Ball.html
% Yong Fuga Li, yonli@umail.iu.edu
% Oct.27-28, 2010
if ~exist('n','var'), n = 1;end;
if ~exist('method','var'), method = 0;end;
if method == 1
    r = repmat(rand(n,1),1,d); % radius
elseif any(method == [0 2])
    r = repmat(rand(n,1).^(1/d),1,d); % radius
else
    error('Not implemented yet!');
end
if method == 2
    theta = rand(n,d-1)*pi;
    theta(:,d-1) = theta(:,d-1)*2; % angles
    S = [ones(n,1) cumprod(sin(theta),2)]; % products of sine
    C = [cos(theta) ones(n,1)]; % cosine values
    x = r.*S.*C;
else
    u = randn(n,d); % random directions
    u = u./repmat(sum(u.^2,2).^(1/2),1,d); % random directions;
    x = r.*u;
end