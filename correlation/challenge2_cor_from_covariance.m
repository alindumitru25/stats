N = 10;
M = 4; % channels

% relationship across channels (imposing covariance)
chanrel = sin(linspace(0,2*pi,M))';

t = linspace(0,6*pi,N);

% create the data
data = bsxfun(@times,repmat( sin(t),M,1 ),chanrel);
data = data + randn(M, N) * .5;

covariance = cov(data');

correlation = corrcoef(data');

figure(1), clf;
imagesc(covariance);
axis image
set(gca,'clim',[-1 1]*.5)
title('Data covariance matrix')
xlabel('??')
ylabel('??')

figure(2), clf;
imagesc(correlation);
axis image
set(gca,'clim',[-1 1]*.5)
title('Data correlation matrix')
xlabel('??')
ylabel('??')

sdMatrix = zeros(M, M);
for i=1:4
    sdMatrix(i, i) = std(data(i, :));
end

correlationFromCovariance = inv(sdMatrix) * covariance * inv(sdMatrix);
figure(3), clf;
imagesc(correlationFromCovariance);
axis image
set(gca,'clim',[-1 1]*.5)
title('Correlation from covariance')
xlabel('??')
ylabel('??')
