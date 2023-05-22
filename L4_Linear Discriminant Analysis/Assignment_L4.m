load digit.mat
who %show variables
size(X) %show size
size(T) %show size

%Computation of a common covariance matrix 
[a b c] = size(X);
S = zeros(a);
mu = zeros(a,c);
for i=1:c
    mu(:,i) = mean(X(:,:,i),2); 
    S = S+cov(X(:,:,i)');
end
S=S/c;
invS = inv(S);

table=[];
for i=1:10
    a=[];
    %prepare test data, 7-th subject
    t=T(:,7,i); 
    for k=1:10
        %posterior probability for digit "i"
        p=t'*invS*mu(:,k)-mu(:,k)'*invS*mu(:,k)/2;        
        a=[a;p]
    end
    table=[table,a]
end
[M,I]=max(table)
imshow(reshape(T(:,7,10),[16 16])');
