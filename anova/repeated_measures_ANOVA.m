% subjects per group
N = 30;

% pick 3 means
mean1 = 7;
mean2 = 7.5;
mean3 = 4;

% same sdandard deviation accross groups
std1 = 2;

% repeated measure of temperature
data1 = mean1 + randn(N, 1) * std1;
data2 = mean2 + randn(N, 1) * std1;
data3 = mean3 + randn(N, 1) * std1;

% create table for model fit
table1 = table(data1, data2, data3, 'VariableNames', {'BeforeCold';'DuringCold';'AfterCold'});

% make the variables repeated measures
repeatedFactor = table(["BeforeCold"; "DuringCold"; "AfterCold"], 'VariableNames', {'levels'});

% create model
rm = fitrm(table1, 'BeforeCold-AfterCold ~ 1', 'WithinDesign', repeatedFactor);

% fit the model Repeated Measures Anove
ranove_table = ranova(rm, 'WithinModel', 'levels')
% first row is intercept with mean of 0.