function [x,y,x1,x2,w]=checkNaN(xRaw,yRaw)
  B=isnan(yRaw);
  a=find(B==0);
  x=xRaw(a,:);
  x1=0;x2=0;w=0;
  if (size(x)(2)==2)
    x1=x(:,1);
    x2=x(:,2);
    w=repelem(1,length(x1));
  endif 
  y=yRaw(a);
  endfunction