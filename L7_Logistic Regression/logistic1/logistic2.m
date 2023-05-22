function [b]=logistic2(X,y,lambda)
[n p] = size(X); 
pos = find(y == 1); neg = find(y == 0);
b = zeros(p,1); J = 0; itr = 0;

while 1
  itr = itr + 1;
  disp(["iteration: ",num2str(itr)]);
  prev_J = J;

  % Compute J here
  J = -(y'*X*b - sum(log(1+exp(X*b))))+lambda*(b'*b)/2
  if abs(prev_J-J) < 1/n, break, end
  % Compute the first gradient here
  nabla_J=X'*(h(X*b)-y)+lambda*b;
  % Compute the second gradient here
  W=diag(h(X*b).*(1-h(X*b)));
  H=X'*W*X+lambda*eye(3);
  % Update beta here
  b=b-H\nabla_J
end

  %At decision boundary, b0+b1*x1+b2*x2=0
  x1=X(:,2);
  x2=(-b(1,:)-b(2,:)*X(:,2))/b(3,:);
  
  %Plot the decision boundary 
  figure(1);
  plot(X(pos, 2), X(pos,3), 'go'); 
  hold on
  plot(X(neg, 2), X(neg,3), 'rx')
  plot(x1,x2);
  hold off
   
  %How norm of b changes
  N=norm(b)
  %How accuracy changes
  Accuracy=sum((h(X*b)>0.5)==y)/length(y)
end


