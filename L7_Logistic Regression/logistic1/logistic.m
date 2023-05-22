function [b,J]=logistic(X,y)
[n p] = size(X); 
pos = find(y == 1); neg = find(y == 0);
b = zeros(p,1); J = 0; itr = 0;

while 1
  itr = itr + 1;
  disp(["iteration: ",num2str(itr)]);
  prev_J = J;

  % Compute J here
  J = -(y'*X*b - sum(log(1+exp(X*b))))
  if abs(prev_J-J) < 1/n, break, end
  % Compute the first gradient here
  nabla_J=X'*(h(X*b)-y);
  % Compute the second gradient here
  W=diag(h(X*b).*(1-h(X*b)));
  H=X'*W*X;
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
  
  %plot decision boundary in 3D
  figure(2);
  p=h(X*b);
  plot3(X(pos,2),X(pos,3),p(pos),'go');
  hold on 
  plot3(X(neg,2),X(neg,3),p(neg),'rx');
  
  xq = linspace(min(x1), max (x1));
  yq = linspace(min(x2), max (x2));
   [XQ,YQ] = meshgrid(xq,yq);
  Z= griddata(x1,x2,p, XQ, YQ, 'natural');
  surf(XQ,YQ,Z);
  hold off
  
  %compare the results with that of OLS
  b_ols = X\y;
  y_ols = X * b_ols;
  figure(3);
  plot3(X(pos,2),X(pos,3),y_ols(pos),'go');
  hold on 
  plot3(X(neg,2),X(neg,3),y_ols(neg),'rx');
  hold off
  
end
