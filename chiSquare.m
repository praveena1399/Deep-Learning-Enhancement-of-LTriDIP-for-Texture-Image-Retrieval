function cs = chiSquare(v1,v2)
 % sm=0;
  %for xx=1:768
    %sm = abs((v2(1,xx)-v1(1,xx))/(1+v1(1,xx)+v2(1,xx)));
    cs = (1/2)*((v2-v1).^2/(v1+v2));
  %end 
end
