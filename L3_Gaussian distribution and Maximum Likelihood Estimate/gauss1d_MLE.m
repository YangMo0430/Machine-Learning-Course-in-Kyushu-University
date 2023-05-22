function[]=gauss1d_MLE(n,mu,sigma)
X = sigma*randn(n,1)+mu;
mu_MLE=mean_MLE(X);sigma_MLE=var_MLE(X);
X = -3:0.5:3;
Y = g1_pdf(X,mu,sigma);
disp(['true:',num2str(Y)]);
Y_MLE=g1_pdf(X,mu_MLE,sigma_MLE);
disp(['estimated:',num2str(Y_MLE)]);
plot(X,Y,'ro-',X,Y_MLE,'gx-');
legend('true','extimated');
endfunction

function[z]=g1_pdf(x,mu,sigma)
z=(2*pi*sigma.^2)^(-1/2)*exp(-(x-mu).^2./(2*sigma.^2));
endfunction

function [my_mean]=mean_MLE(X)
  N=size(X,1)
  my_mean=(1./N).*sum(X)
endfunction

function [my_var]=var_MLE(X)
  N=size(X,1)
  my_mean=(1./N).*sum(X);
  my_var=0;
  for k=1:N
      my_var=my_var+(X(k)-my_mean).^2;
  end
  my_var = (1./N).*my_var
endfunction
