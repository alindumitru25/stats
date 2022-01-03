% challenge: Compare k-means with dbscan on 2 datasets.

close all; clear; clc

%% create data (identical to k-means!)

nPerClust = 50;

% blur around centroid (std units)
blur = 0.9;

% XY centroid locations
A = [  1 1 ];
B = [ -3 1 ];
C = [  3 3 ];

% generate data
a = [ A(1)+randn(nPerClust,1)*blur A(2)+randn(nPerClust,1)*blur ];
b = [ B(1)+randn(nPerClust,1)*blur B(2)+randn(nPerClust,1)*blur ];
c = [ C(1)+randn(nPerClust,1)*blur C(2)+randn(nPerClust,1)*blur ];

% concatanate into a list
data = [a; b; c];

figure(1), clf

% k-means
k = 3;
[groupidx, cents, sumdist, distances] = kmeans(data, k);

% plot data
subplot(221)
plot(data(:,1),data(:,2),'s','markerfacecolor','k')
axis square
title('How we see the data')

% plot k-means
subplot(222);
lineColors = 'rkbgmrkbgm';
hold on
for i=1:length(data)
    plot([ data(i, 1) cents(groupidx(i), 1)], [data(i, 2) cents(groupidx(i), 2)], lineColors(groupidx(i)))
end

% use different colors
for i=1:k
    plot(data(groupidx==i, 1), data(groupidx==i, 2), [lineColors(i), 'o'], 'markerface', 'w')
end

% plot centroid locations
plot(cents(:, 1), cents(:, 2), 'ko', 'markerface', 'g', 'markersize', 10);
xlabel('Axis 1'), ylabel('Axis 2');
title(['Result of kmeans clustering (k = ' num2str(k) ')']);

% plot the ground truth centers based on known data
plot(A(1),A(2),'kp','linew',2,'markersize',20,'markerfacecolor','y')
plot(B(1),B(2),'kp','linew',2,'markersize',20,'markerfacecolor','y')
plot(C(1),C(2),'kp','linew',2,'markersize',20,'markerfacecolor','y')

% db-scan
groupidx = dbscan(data,0.6,3);

nclust = max(groupidx);

% compute cluster centers
cents = zeros(nclust,2);
for ci=1:nclust
    cents(ci,:) = mean(data(groupidx==ci,:));
end

% draw lines from each data point to the centroids of each cluster
subplot(223)
lineColors = 'rmbgmrkbgmrkbgmrkbgmrkbgmrkbgmrkbgmrkbgmrkbgmrkbgmrkbgmrkbgm';
hold on
for i=1:length(data)
    if groupidx(i)==-1
        plot(data(i,1),data(i,2),'w+')
    else
        plot([ data(i,1) cents(groupidx(i),1) ],[ data(i,2) cents(groupidx(i),2) ],lineColors(groupidx(i)))
    end
end

% now draw the raw data in different colors
for i=1:nclust
    plot(data(groupidx==i,1),data(groupidx==i,2),[ lineColors(i) 'o' ],'markerface','w')
end

% and now plot the centroid locations
plot(cents(:,1),cents(:,2),'ko','markerface','g','markersize',10);
xlabel('Axis 1'), ylabel('Axis 2')
title([ 'Result of dbscan clustering (k=' num2str(size(cents,1)) ')' ])

% finally, the "ground-truth" centers
plot(A(1),A(2),'kp','linew',2,'markersize',20,'markerfacecolor','y')
plot(B(1),B(2),'kp','linew',2,'markersize',20,'markerfacecolor','y')
plot(C(1),C(2),'kp','linew',2,'markersize',20,'markerfacecolor','y')