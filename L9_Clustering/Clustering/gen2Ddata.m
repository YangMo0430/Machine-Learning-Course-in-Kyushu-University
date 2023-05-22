function [X] = gen2Ddata(N,meanX,meanY)
% generate 2D data from gaussian disturibution
% Inputs
% N: number of data points
% meanX: 2-dimensional vector specifying two x coordinates
% meanY: 2-dimensional vector specifying two y coordinates
%
% example: meanX=[-1 1], meanY=[-1 1], X=gen2Ddata(50,meanX,meanY);

var = 1;
mid = floor(N/2);
for i=1:mid
  x(i)=normrnd(meanX(1),var);
  y(i)=normrnd(meanY(1),var);
end
for i=mid+1:N
  x(i)=normrnd(meanX(2),var);
  y(i)=normrnd(meanY(2),var);
end
X=[x' y'];

