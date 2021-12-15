% Compare Kendall and Pearson correlation for data that is low correlated
% to high correlated.
N = 100; % number of samples

corrs = zeros(1, 200);
corrsKendall = zeros(1, 200);
corrsPearson = zeros(1, 200);
xaxis = -1:0.01:1;
nCategories = 6;

iterations = 100;
iterNum = 1;
for i=-100:1:100
    iterCorr = zeros(iterations, 2);
    for j=1:iterations
        r = i/100;
        % start with random numbers
        x = randi(nCategories,N,1)';
        y = randi(nCategories,N,1)';
        
        % impose the correlation on y
        y = round(x*r + y*sqrt(1-r^2));

        iterCorr(j, 1) = corr(x', y', 'type', 'K');
        iterCorr(j, 2) = corr(x', y', 'type', 'P');
    end

    corrMeanK = sum(iterCorr(:, 1)) / iterations;
    corrMeanP = sum(iterCorr(:, 2)) / iterations;
    % calculate and store correlation
    corrs(1, iterNum) = abs(corrMeanP - corrMeanK);
    corrsKendall(1, iterNum) = corrMeanK;
    corrsPearson(1, iterNum) = corrMeanP;
    iterNum = iterNum + 1;
end

figure(1), clf;
subplot(211)
plot(xaxis, corrs(1, :), 'k+');
xlabel("Correlation value");
ylabel("Absolute difference");

subplot(212)
plot(corrsPearson, corrsKendall, 'k+');
xlabel("Pearson Corr");
ylabel("Kendall Corr");
title("Pearson vs Kendall")
