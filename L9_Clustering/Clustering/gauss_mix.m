function [z]=gauss_mix(alpha,Mu,Sigma)

x=[-3:0.1:3]; y=[-3:0.1:3];
for i=1:length(x)
 for j=1:length(y)
   z(i,j)=0;
   for k=1:length(alpha)
     z(i,j)+=alpha(k)*g2_pdf(x(i),y(j),Mu(k,:)',Sigma(:,:,k));
   end
 end
end

%figure(2); 
%surf(x,y,z); view(45,60);
%print -deps gauss2d_pdf_surf.eps

figure(1);
contour(x,y,z);
%print -deps gauss2d_pdf_contour.eps

function [z] = g2_pdf(x,y,Mu,Sigma)
d=sqrt(det(Sigma));
v=[x;y]-Mu;
z=1/(2*pi*d)*exp(-1/2*v'*inv(Sigma)*v);
