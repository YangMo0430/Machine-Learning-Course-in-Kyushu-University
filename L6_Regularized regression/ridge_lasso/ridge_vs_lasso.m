function []=ridge_vs_lasso(X,y,lambda)
[n p]=size(X);

b1=lasso(X,y,lambda); %lasso
b2=(X'*X+lambda*eye(p))\(X'*y); %ridge

disp(['sparsity lasso: ',num2str(sum(abs(b1)<0.001)/length(b1)),',sparsity ridge: ',num2str(sum(abs(b2)<0.001)/length(b2))]);
rssL1=sum((y-X*b1).^2);
rssL2=sum((y-X*b2).^2);
disp(['RSS lasso: ', num2str(rssL1), ' RSS ridge: ', num2str(rssL2)]);
disp(['norm size lasso: ', num2str(norm(b1,1)), ' norm size ridge: ', num2str(norm(b2,2))]);
subplot(1,2,1);
bar(b2);title('ridge coefficients');
subplot(1,2,2);
bar(b1);title('lasso coefficients');
