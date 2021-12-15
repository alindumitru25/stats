% correlation confidence intervals.
N = 100;

% generate the data.
data1 = randn(1, N);
data2 = randn(1, N);

% defined correlation coefficient.
r = .6;

data2 = data1 * r + data2 * sqrt(1 - r^2); 

empiricalCorr = corr(data1', data2');
disp(empiricalCorr);

% sample size
samplesize = 100;
confidence = 95;

% compute sample corr
randSamples = randi(N, samplesize, 1);
sampledata1 = data1(randSamples);
sampledata2 = data2(randSamples);
sampleCorr = corr(sampledata1', sampledata2');
disp(sampleCorr);

% draw a random sample
numBoots  = 1000;
bootCor = zeros(numBoots, 1);

for booti=1:numBoots
    randSamples = randi(N, samplesize, 1);
    randSample1 = data1(randSamples);
    randSample2 = data2(randSamples);
    bootCor(booti) = corr(randSample1', randSample2');
    disp(bootCor(booti));
end

confidences = zeros(2, 1);
confidences(1) = prctile(bootCor, (100 - confidence)/2);
confidences(2) = prctile(bootCor, 100 - (100 - confidence) / 2);
avgCorr = mean(bootCor);

disp(confidences(2));

figure(2), clf, hold on

% start with a histogram of the resampled means
[y,x] = histcounts(bootCor,40);
y=y./max(y);
x = (x(1:end-1)+x(2:end))/2;
bar(x,y)

% then the same stuff as in the previous code-video...
patch(confidences([1 1 2 2]),[0 1 1 0],'g','facealpha',.5,'edgecolor','none')
plot([1 1]*empiricalCorr,[0 1.5],'k:','linew',2)
plot([1 1]*avgCorr,[0 1],'r--','linew',3)
set(gca,'xlim',[min(bootCor) max(bootCor)],'ytick',[])
xlabel('Data values')
legend({'Empirical distribution';[ num2str(confidence) '% CI region' ];'True mean';'Sample mean'},'box','off')