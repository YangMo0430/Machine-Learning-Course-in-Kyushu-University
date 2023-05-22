function [alpha,mu,sigma,w,AIC,BIC] = EM(X,K,opt)
% EM algorithm for gaussian mixture
% usage examle:EM(X)
%
% Inputs:
% X:data points
% K:number of clusters
%
% Outputs:
% Centers:x and y coordinates of cluster centers
%
% NOTE that visualization works only for two-dimensional data,
% i.e., when X has two columns.

if nargin != 3
  opt = 1;
end

itr = 0; 
%K = 2; % number of clusters
[N,D] = size(X);
%alpha = [0.5, 0.5]; % mixture weights
alpha = ones(K,1)./K;

% set clupster centers randomly
% one can alternatively set cluster centers manually as,for example., mu=[0.3 0.5;-0.9 -0.7];
for k=1:K
  ind = ceil(N*rand(1,1));
  mu(k,:) = X(ind,:);
end

% initial covariance matrices
sigma=zeros(D,D,K);
for k=1:K
  sigma(:,:,k)=eye(D);
end

w = zeros(N,K); % posterior probabilities

LogL = 0;
% start main loop
while 1
  itr = itr + 1;
  disp(['iteration: ',num2str(itr)]);
  prev_LogL = LogL;
  LogL = 0;

  % E-step
  for i = 1:N
    SumP = 0;
    for k = 1:K
      p(i,k) = exp(-(X(i,:)'-mu(k,:)')'*inv(sigma(:,:,k))*(X(i,:)'-mu(k,:)'))./( (2*pi).^(2/2)*sqrt(det(sigma(:,:,k))));
      SumP = SumP + alpha(k)*p(i,k);
    end
    for k = 1:K
      w(i,k) = alpha(k)*p(i,k)./SumP;
    end
    LogL = LogL + log(SumP);
  end
  disp(['logL:',num2str(LogL)]);
  AIC = -2*LogL + 2*(K+2*K+K*(K+1)./2);
%  disp(['AIC:',num2str(AIC)]);
  BIC = -2*LogL + log(N)*(K+2*K+K*(K+1)./2);
%  disp(['BIC:',num2str(BIC)]);

  % check convergence by the difference of log-likelihood from the
  % previous iteration
  if abs(prev_LogL - LogL) < 0.1
    disp(['convergence after iterations:',num2str(itr)]);
    break;
  end

  % M-step 
  % update mixture weights
  alpha = sum(w)/N; 
  
  % update means
  for k=1:K
    tmpSum = 0;
    for i=1:N
      tmpSum = tmpSum + w(i,k)*X(i,:);
    end
    mu(k,:) = tmpSum./(alpha(k)*N);
  end
  
  % update covariance matrices
  for k=1:K
    tmpSum2 = zeros(2);
    for i=1:N
      tmpSum2 = tmpSum2 + w(i,k)*(X(i,:)'-mu(k,:)')*(X(i,:)'-mu(k,:)')';
    end
    sigma(:,:,k)=tmpSum2./(alpha(k)*N);
  end
  
end
disp(' ');
for k=1:K
  disp([num2str(k),'th center = (', num2str(mu(k,1)),',', ...
	num2str(mu(k,2)),')']);
  disp(['mixture weight:',num2str(alpha(k))]);
  disp('covariance matrix');
  disp(sigma(:,:,k));
  disp(' ');
end

% visualize clustering result. Setting opt==0 can skip visualization.
if opt != 0
  x=X(:,1);      y=X(:,2);
  plot(x,y,'ko');
  axis square
  title(['N:',num2str(N),' K:',num2str(K),' Iteration: ', ...
	 num2str(itr)]);
  hold on;
  if K==1
    gauss_plot(mu,sigma);
  else 
    gauss_mix(alpha,mu,sigma);
  end
  hold off;
end

endfunction
