%%
%   COURSE: Master statistics and machine learning: intuition, math, code										
%      URL: udemy.com/course/statsml_x/?couponCode=202006 
% 
%  SECTION: Confidence intervals
%    VIDEO: Bootstrapping confidence intervals
% 
%  TEACHER: Mike X Cohen, sincxpress.com
%

%%

% a clear MATLAB workspace is a clear mental workspace
close all; clear; clc

%% simulate data

popN = 1e7; % lots and LOTS of data!!

% the data (note: non-normal!)
population = (4*randn(popN,1)).^2;

% we can calculate the exact population SD
stdDeviation = std(population);

%% draw a random sample

% parameters
samplesize = 40;
confidence = 95; % in percent

% compute sample SD
randSamples = randi(popN,samplesize,1);
sampledata  = population(randSamples);
samplestd  = std(sampledata);


%%% now for bootstrapping
numBoots  = 1000;
bootstds = zeros(numBoots,1);

% resample with replacement
for booti=1:numBoots
    bootstds(booti) = std( randsample(sampledata,samplesize,true) );
end

% find confidence intervals
confint(1) = prctile(bootstds,(100-confidence)/2);
confint(2) = prctile(bootstds,100-(100-confidence)/2);

%% graph the outcomes

figure(2), clf, hold on

% start with a histogram of the resampled SDs
[y,x] = histcounts(bootstds,40);
y=y./max(y);
x = (x(1:end-1)+x(2:end))/2;
bar(x,y)

% then the same stuff as in the previous code-video...
patch(confint([1 1 2 2]),[0 1 1 0],'g','facealpha',.5,'edgecolor','none')
plot([1 1]*stdDeviation,[0 1.5],'k:','linew',2)
plot([1 1]*samplestd,[0 1],'r--','linew',3)
set(gca,'xlim',[stdDeviation-30 stdDeviation+30],'ytick',[])
xlabel('Data values')
legend({'Empirical distribution';[ num2str(confidence) '% CI region' ];'True SD';'Sample SD'},'box','off')
%% done.
