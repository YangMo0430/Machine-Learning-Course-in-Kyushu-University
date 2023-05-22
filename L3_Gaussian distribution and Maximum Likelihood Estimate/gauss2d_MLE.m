function[]=gauss2d_MLE(n,Mu,sigma)
%usage: gauss2d_MLE(10,[0 0]',[1 -0.5;-0.5 1])
X = randn(n,length(Mu))*sigma+ones(n,1)*Mu';
Mu_MLE = mean(X)';
Sigma_MLE = cov(X);
X = -3:0.1:3;
Y = -3:0.1:3;
for i=1:length(X)
    for j=1:length(Y)
        Z(i,j) = g2_pdf(X(i),Y(j),Mu,sigma);
        Z_MLE(i,j) = g2_pdf(X(i),Y(j),Mu_MLE,Sigma_MLE);
    end 
end
figure(1);clf;
surface(Z);
title('\fontsize{24}true distribution')
figure(2);clf;
surface(Z_MLE);
title('\fontsize{24}estimated distribution')
%print -deps gauss2d_MLE.eps
endfunction


  
  
  
  
  
 
