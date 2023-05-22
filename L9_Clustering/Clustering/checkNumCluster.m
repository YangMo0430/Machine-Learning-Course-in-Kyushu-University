Amean=[];Bmean=[];
Astd=[];Bstd=[];
for k=1:5
  A=[];B=[]; 
  for i=1:10 
    [alpha mu sigma w AIC BIC]=EM(X,k,0);
    A=[A AIC];B=[B BIC];
  end
  Amean=[Amean mean(A)]
  Bmean=[Bmean mean(B)]
  Astd=[Astd std(A)]
  Bstd=[Bstd std(B)]
end
