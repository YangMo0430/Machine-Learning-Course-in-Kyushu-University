%% Codes prepared by Andrew Ng for Machine Learning Online Course
%% 
%% Initialization
%clear ; close all; clc

%% Setup the parameters you will use for this exercise
input_layer_size  = 256;  % 16x16 Input Images of Digits
hidden_layer_size = 25;   % 25 hidden units
num_labels = 10;          % 10 labels, from 1 to 10   
                          % (note that we have mapped "0" to label 10)

% Load Training Data
fprintf('Loading and Visualizing Data ...\n')

%load('ex4data1.mat');
load('MNIST.mat');
m = size(X, 1);
y = Xy;
% Randomly select 100 data points to display
sel = randperm(size(X, 1));
sel = sel(1:100);

displayData(X(sel, :));

fprintf('Program paused. Press enter to continue.\n');
pause;

% Randomly initialize parameters
fprintf('\nInitializing Neural Network Parameters ...\n')

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

fprintf('Program paused. Press enter to continue.\n');
pause;

%  Try different hyper parameters
lambda = 8.57;
options = optimset('MaxIter', 146);

% Network Training

fprintf('\nTraining Neural Network... \n')

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

fprintf('Program paused. Press enter to continue.\n');
pause;

% Visualize weights

fprintf('\nVisualizing Neural Network... \n')

displayData(Theta1(:, 2:end));

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

% Display prediction accuracy

[dummy pred] = predict(Theta1, Theta2, X);
fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);

[dummy pred] = predict(Theta1, Theta2, T);
fprintf('\nTest Set Accuracy: %f\n', mean(double(pred == Ty)) * 100);
