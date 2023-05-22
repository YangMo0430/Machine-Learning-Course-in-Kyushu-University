load Longley.dat

x = Longley(:,2:7);
y = Longley(:,1);
%Corresponding to the constant term，add a column of 1s.
column = [1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1];
x1 = [column x];
%Certified values of Beta
Bhat_Values = [-3482258.63459582,15.0618722713733,-0.358191792925910e-01,-2.02022980381683,-1.03322686717359,-0.511041056535807e-01,1829.15146461355]'

bhat = x1\y;
%Compare bhat with certified values
ans = bhat-Bhat_Values;

%The least squares fit
y_fit = (bhat'*x1')'
%The difference between y and the least squares fit
err = y - y_fit;
x_plot = 1:1:16;
errorbar(x_plot,y,err);

%Compute the correlation coefficients for x
R = corrcoef(x);

%Normallize the vector y and columns of x
y = y - mean(y);
y = y/std(y);
for i = 1:6
  x(:,i)=x(:,i)-mean(x(:,i));
  x(:,i)=x(:,i)/std(x(:,i));
end

%Plot all seven normallized variables on the same axis
normal = [y x];
plot(normal)
legend('y','x1','x2','x3','x4','x5','x6')





