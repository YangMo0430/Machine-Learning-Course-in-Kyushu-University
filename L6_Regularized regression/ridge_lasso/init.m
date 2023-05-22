load crime.txt
y=crime(:,1);
X=crime(:,3:end);

X=(X-mean(X))./std(X);
y=(y-mean(y))./std(y);

disp('crime data loaded and normalized');

