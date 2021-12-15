close all; clear; clc

%% simulate data

% simulation parameters
N = 1000;     % time points
M =   20;     % channels

% time vector (radian units)
t = linspace(0,6*pi,N);

% relationship across channels (imposing covariance)
chanrel = sin(linspace(0,2*pi,M))';

% create the data
matrices = zeros(20, M, N);

% simulate 20 different noise structures
for i=1:20
    data = bsxfun(@times,repmat( sin(t),M,1 ),chanrel);
    data = data + randn(M, N) * 0.1 * i;
    matrices(i, :, :) = data;
end

averagedMatrix = sum(matrices(:, :, :)) / 20;
dataCovMat = cov(data');

figure(1), clf
imagesc(dataCovMat)
axis image
title('Data covariance matrix')
xlabel('??')
ylabel('??')

dataCovMatrices = zeros(20, M, M);
for i=1:20
    mat = squeeze(matrices(i, :, :));
    display(size(cov(mat')));
    dataCovMatrices(i, :, :) = cov(mat');
end

dataCovAvg = squeeze(sum(dataCovMatrices(:, :, :)) / 20);

hold on
figure(2), clf
imagesc(dataCovAvg)
axis image
title('Data covariance matrix with summed covs')
xlabel('??')
