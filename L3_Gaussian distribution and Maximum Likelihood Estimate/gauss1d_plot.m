function[] = gauss1d_plot(x,mu,sigma)
for i=1:length(x)
  z(i)=g1_pdf(x(i),mu,sigma);
end
 
 figure(1);clf
 plot(x,z);
 %print -deps guass1d_pdf.eps
 
 function [z]=g1_pdf(x,mu,sigma)
 z=(2*pi*sigma.^2)^(-1/2)*exp(-(x-mu).^2./(2*sigma.^2));
 
