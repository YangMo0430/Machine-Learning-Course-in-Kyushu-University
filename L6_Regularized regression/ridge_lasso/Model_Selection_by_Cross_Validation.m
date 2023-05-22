init
crime=[y X];
n=size(crime,1);
%Split the crime data for 2-fold cross validation
cv=cvpartition(n,'KFold',2)
for idx = 1:2
% Split each fold into TrainData and TestData
    TrainIndex = training(cv,idx);
    TestIndex = test(cv,idx);
    TrainData = crime(TrainIndex,:);
    TestData = crime(TestIndex,:);
%Calculate the mean R-squared from test datasets
    Y_Train = TrainData(:,1);
    X_Train = TrainData(:,2:end);
    Y_Test = TestData(:,1);
    X_Test = TestData(:,2:end);
    [n p] = size(X_Train);
%In each fold, choose a regularization parameter from {1,100,10000}
    for lambda = [1 100 10000]
        b=(X_Train'*X_Train+lambda*eye(p))\(X_Train'*Y_Train); %ridge  
        err=sum((Y_Test-X_Test*b).^2);
        disp(['error:', num2str(err)]);
    endfor
endfor
    