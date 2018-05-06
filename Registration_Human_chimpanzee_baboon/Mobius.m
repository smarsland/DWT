function [Difference,deformed_source]=Mobius(X,Y,T,source,target,Non_defined_pixels_background)

a=T(1)+1i*T(2); b=T(3)+1i*T(4); c=T(5)+1i*T(6);d=(1+b*c)/a;
Z=(a*(X+1i*Y)+b)./(c*(X+1i*Y)+d);


deformed_source=interp2(X,Y,source,real(Z),imag(Z));
deformed_source(isnan(deformed_source))=Non_defined_pixels_background;

Difference=deformed_source-target; 

return