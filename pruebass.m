clear options;
A=importdata("S1.DAT")
xi=A(:,1); yi = A(:,2);

qrfunc = @(xi, p) p(3)*(1 -exp(p(1)*xi.^p(2)));
p = [0, 0.4,yi(end)]; wt = ones(size(yi));
dp = [0.001; 0.001; 0.001]; % bidirectional numeric gradient stepsize

[f, pint, kvg, iter, corp, covp, covr, stdresid, Z, r] =  leasqr(xi, yi, p, qrfunc);
pint

xinterp = linspace(xi(1), xi(end),40)';  yinterp = qrfunc(xinterp,pint);
figure(1)
plot(xi, yi,'bo', xinterp, yinterp)
legend('Data', 'Interpolation', 'location', 'southeast')

%% now try with a constraint on p(2)
options.bounds = [-28, 30; -1, 2 ;-20 , 20];
pint(2) = 0;

[f, pint, kvg, iter, corp, covp, covr, stdresid, Z, r] = ...
   leasqr(xi, yi, p, qrfunc, 0.000001, 200, wt, dp, "dfdp", options);
pint
yinterp = qrfunc(xinterp,pint);
figure(2)
plot(xi, yi,'bo', xinterp, yinterp)
legend('Data', 'Interpolation', 'location', 'southeast')
