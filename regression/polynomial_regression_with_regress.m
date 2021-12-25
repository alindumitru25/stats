% Calculate y hat on polynomial regression by using regress instead of polyval and polyfit.
%% generate the data
n  = 30;
x  = linspace(-2,4,n);
y1 = x.^2 + randn(1,n);
y2 = x.^3 + randn(1,n);

%%% plot the data
figure(1), clf, hold on
plot(x,y1,'ko','markersize',10,'markerfacecolor','r','linew',2)
plot(x,y2,'ko','markersize',10,'markerfacecolor','g','linew',2)
legend({'Quadratic','Cubic'})

% compute R2 for several polynomial orders
orders = 1:5;

% output matrices
r2 = zeros(2,length(orders));
sse = zeros(2,length(orders));

desmaty1 = [ones(n, 1) x' x.^2'];
desmaty2 = [ones(n, 1) x' x.^2' x.^3'];

[beta,b_CI,resids,rint,stats] = regress(y1', desmaty1);
yHat1 =  beta(1) + beta(2) * x + beta(3) * x.^2;
[beta,b_CI,resids,rint,stats] = regress(y2', desmaty2);
yHat2 = beta(1) + beta(2) * x + beta(3) * x.^2 + beta(4) * x.^3;

plot(x,yHat1,'r','linew',2)
plot(x,yHat2,'g','linew',2)
