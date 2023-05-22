% find returns the indices of the
% rows meeting the specified condition
X=load('ex4x.dat');
y=load('ex4y.dat');
pos = find(y == 1); neg = find(y == 0);

% Assume the features are in the 2nd and 3rd
% columns of x
plot(X(pos, 1), X(pos,2), 'go'); hold on
plot(X(neg, 1), X(neg,2), 'rx')
X=[ones(80,1) X];
hold off