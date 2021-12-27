% create four visualization to exemplify overfitting. Compute R square.
x = linspace(1, 10, 10);
data1 = (1.5 * x) + (randn(1, 10) * 3);
data2 = (1.5 * x) + (randn(1, 10) * 3);

figure(1), clf;
subplot(2, 2, 1);
plot(x, data1, 'square', 'MarkerSize', 12);

pterms = polyfit(x, data1, 1);
yHatPol2 = polyval(pterms, x);
hold on;
plot(yHatPol2, 'o', 'MarkerSize', 12);

% r2 value for yHatPol2 data 1
ss_eta = sum((data1-yHatPol2).^2); % numerator
ss_tot = sum((data1-mean(data1)).^2); % denominator
r2Pol2data1 = 1 - ss_eta/ss_tot; % R^2
title(["R squared: ", r2Pol2data1]);

subplot(2, 2, 2);
plot(x, data2, 'square', 'MarkerSize', 12);
hold on;
plot(yHatPol2, 'o', 'MarkerSize', 12);

% r2 value for yHatPol2 data 2
ss_eta = sum((data2-yHatPol2).^2); % numerator
ss_tot = sum((data2-mean(data2)).^2); % denominator
r2Pol2data2 = 1 - ss_eta/ss_tot; % R^2
title(["R squared: ", r2Pol2data2]);

pterms10 = polyfit(x, data1, 10);
yHatPol10 = polyval(pterms10, x);
subplot(2, 2, 3);
plot(x, data1, 'square', 'MarkerSize', 12);
hold on;
plot(yHatPol10, 'o', 'MarkerSize', 12);

% r2 value for yHatPol10 data 1
ss_eta = sum((data1-yHatPol10).^2); % numerator
ss_tot = sum((data1-mean(data1)).^2); % denominator
r2Pol10data1 = 1 - ss_eta/ss_tot; % R^2
title(["R squared: ", r2Pol10data1]);

subplot(2, 2, 4);
plot(x, data2, 'square', 'MarkerSize', 12);
hold on;
plot(yHatPol10, 'o', 'MarkerSize', 12);

% r2 value for yHatPol10 data 2
ss_eta = sum((data2-yHatPol10).^2); % numerator
ss_tot = sum((data2-mean(data2)).^2); % denominator
r2Pol10data2 = 1 - ss_eta/ss_tot; % R^2
title(["R squared: ", r2Pol10data2]);
