x=[600 700 800 950 1100 1300 1500]';
y=[253 337 395 451 495 534 573]';

% linear model
X=[ones(7,1) x];
beta=X\y;
r2=1-sum((X*beta-y).^2)/var(y)

% quadratic model
X=[ones(7,1) x x.^2];
beta=X\y;
r2=1-sum((X*beta-y).^2)/var(y)

% cubic model
X=[ones(7,1) x x.^2 x.^3];
beta=X\y;
r2=1-sum((X*beta-y).^2)/var(y)

X=[ones(7,1) x x.^2 x.^3 x.^4];
beta=X\y;
r2=1-sum((X*beta-y).^2)/var(y)

X=[ones(7,1) x x.^2 x.^3 x.^4 x.^5];
beta=X\y;
r2=1-sum((X*beta-y).^2)/var(y)