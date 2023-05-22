function [t]=lasso(X,y,lambda)
[n p]=size(X);
t0=randn(p,1);
itr=0;
for i=1:1000
  ++itr;
  t=(X'*X+lambda*pinv(diag(abs(t0))))\(X'*y);
  if norm(t-t0)<0.001, break, end
  t0=t;
end
%disp(['converged in ',num2str(itr),' iterations']);
%disp(['sparsity: ',num2str(sum(abs(t)<0.001)/length(t))]);
%errL1=sum((y-X*t).^2);
%b=X\y;
%errL2=sum((y-X*b).^2);
%disp(['error L1: ', num2str(errL1), ' error L2: ', num2str(errL2)]);
