%lim=[-100 100]
%y = @(x) prueba(x,lim)
%o = optimset('MaxIter', 100, 'TolFun', 1E-10)
%s = 1
%[x_optim, y_min, conv, iters, nevs] = powell(@(x) prueba(x, lim), 1, o);

%function R = prueba(x,lim)
%  lim
%  if (p<lim(1) | x>lim(2))
%    R=1e32
%  else
%    R=x^2+3*x+1;
%  end
%end
%f_min = @(p) prueba (p, x, y, lim);
%[x_optim, y_min, conv, iters, nevs] = powell(f_min, 1, o);

function R=f_bounded_powell_nm(p,x,y,lim,selectedModel)
  if(sum(p<lim(1))>.5|sum(p>lim(2))>.5)
    R=1e32;
  else
    switch(selectedModel)
    case 1
    R=sum((y-p(1).*exp(-x.*p(2))).^2);
    case 2
    R=sum([y-p(1).*exp(-x.*p(2)+p(3).*(x.^2))].^2);
    case 3
    R=sum([y-p(1).*exp(-p(2).*(x./(1+p(3).*x)))].^2);
    case 4
    R=sum([y-[p(1).*(1+p(3).*x).^2].*exp(-(p(2).*(x./(1+p(3).*x))))].^2);
    case 5
    R=sum([y-(p(1).*x).^(-p(2))].^2);@(p) sum([y-(p(1).*x).^(-p(2))].^2);
    case 6
    R=sum([y-(p(1)+p(2).*x).^(-p(3))].^2);
    case 7
    R=sumsq(y-p(1)./(1+(p(3)-1).*p(2).*x.*p(1).*exp([p(3)-1].*log(p(1)))).^(1./(p(3)-1)));sumsq(y-p(1)./(1+(p(3)-1).*p(2).*x.*p(1).*exp([p(3)-1].*log(p(1)))).^(1./(p(3)-1)));
    case 8
    R=sumsq(y-p(1)./(1+p(2).*x));
  end
end


f_min=@(p)pruebapowell(p,x,y,lim,selectedModel)






