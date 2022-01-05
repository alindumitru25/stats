
% read data
spikes = csvread('spikes.csv');
%% pca

[coeffs,pcscores,~,~,explVar] = pca(spikes);

% k-means
% define number of gorups
k = 2;
data = [pcscores(:, 1) pcscores(:, 2)];
[groupidx, cents, sumdist, distances] = kmeans(data, k);

figure(1), clf
subplot(211)
lineColors = 'rkbgmrkbgm';
hold on;

for i=1:k
    plot(data(groupidx==i, 1), data(groupidx==i, 2), [lineColors(i) 'o'], 'markerface', 'w');
end

xlabel('PC_1'), ylabel('PC_2')
axis square
title('PC space')

% plot mean of both dimensions
meansGroup1 = mean(spikes(groupidx==1, :));
meansGroup2 = mean(spikes(groupidx==2, :));
subplot(212);
plot(meansGroup1, '-o', 'MarkerFaceColor', 'r', 'Color', 'r');
hold on
plot(meansGroup2, '-o', 'MarkerFaceColor', 'b', 'Color', 'b');
xlabel('Time Points');
legend('Time Class 1', 'Time Class 2');
