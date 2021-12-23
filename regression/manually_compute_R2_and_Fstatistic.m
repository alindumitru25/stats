% manually compute r squared and F statistic for the following data:
close all; clear, clc


%% example: effects of sleep on food spending

data = [
    5	47
    5.5	53
    6	52
    6	44
    7	39
    7	49
    7.5	50
    8	38
    8.5	43
    9	40
];


% start by showing the data
figure(1), clf, hold on
plot(data(:,1),data(:,2),'ko','markerfacecolor','k','markersize',10)
xlabel('Hours of sleep'), ylabel('Fijian dollars')
set(gca,'xlim',[4 10],'ylim',[36 54])

%% "manual" regression via least-squares fitting

% create the design matrix
desmat = cat(2,ones(10,1),data(:,1));

% compute the beta parameters (regression coefficients)
beta = desmat\data(:,2);

% predicted data values
yHat = desmat*beta;

%% show the predicted results on top of the "real" data

% predicted results
plot(data(:,1),yHat,'s-','color','b','markersize',10,'markerfacecolor','b')

% show the residuals
for i=1:10
    plot([1 1]*data(i,1),[data(i,2) yHat(i)],'m--')
end

h = legend({'Data (y)';'Model (\^{y})';'Residuals'},'Interpreter','latex');
set(h,'box','off')

residuals = data(:, 2) - yHat;

% R squared
numerator = sum(residuals .^ 2);
denonimator = sum((data(:, 2) - mean(data(:, 2))) .^ 2);
R2 = 1 - (numerator / denonimator);

% F stastic
model = yHat - mean(data(:, 2));
dataSize = size(data);
k = dataSize(2);
N = dataSize(1);
Fs = (sum(model.^ 2) / (k - 1)) / (sum(residuals .^ 2) / (N - k));
