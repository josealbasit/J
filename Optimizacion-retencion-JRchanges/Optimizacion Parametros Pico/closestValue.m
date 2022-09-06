%Looks for the closest element to I in vector w and returns its position.
function  position=closestValue(w,I)  %w vector vertical. I vector de elementos.
          n=length(w);
          m=length(I);
          position=zeros(1,m);
            for i=1:m
                distance= abs(w-I(i));
                minimal=min(distance);
                p=find(distance==minimal);
                if length(p)>1
                   p=p(2);
                endif
                position(i)=p;
            end
 end
