function [mu] = kmeans(X,k,opt)
  
% k-means algorithm
% usage examle > kmeans(X,2)
%
% Inputs:
% X:data points
% k:number of clusters
%
% Outputs:
% mu:x coordinates of cluster centers

% Visualization works only if the dimension of X = 2.
% Setting opt == 0 can skip visualization

if nargin == 2
  opt = 1
end

[N P]=size(X);


itr = 0;
% randomly select cluster centers
for i=1:k
  j = ceil(N*rand(1,1));
  mu(i,:)=X(j,:);
end

% start main loop
while 1
  itr = itr + 1;

    % compute euclidian distance between each data point and each
    % cluster center, then assing data point to the closest cluster center.
    for n=1:N 
      DIST = [];
      for i=1:k
	dist = norm(mu(i)-X(n,:));
	DIST = [DIST dist];
      end
      if itr > 2
	prev_cls(n) = cls(n);
      end
      [D I]=min(DIST);
      cls(n) = I;
    end

    % Update cluster centers by taking means of their membership
    % data points.
    prev_mu = mu;

    for i=1:k
      mu(i,:) = mean( X(cls==i,:) );
    end

    if opt==1
      x=X(:,1);      y=X(:,2);
      meanX = [1, -1];      meanY = [1, -1];
      plot(x(cls==1),y(cls==1),'bo',x(cls==2),y(cls==2),'go',mu(:,1), mu(:,2),'r*', meanX, meanY,'m*');
      axis square;
      title(['N:',num2str(N),' k:',num2str(k),' Iteration: ',num2str(itr)]);
      pause(0.5);
%      file=sprintf('%d.png',itr);
%      print(file,'-color');
    end

    % Terminate if the assignments do not change.
    if itr > 2 && sum(prev_cls == cls) == N
      disp(['convergence after iterations:',num2str(itr)]);
      break;
    end

end


% display results
for i=1:k
  disp([num2str(i),'th center = ', num2str(mu(i,:)) ]);
end
disp([' ']);
endfunction


