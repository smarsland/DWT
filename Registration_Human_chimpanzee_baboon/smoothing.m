function smooth_image=smoothing(input_image,X,Y,sigma)
s=size(input_image);image_0=zeros(s(1),s(2));
for k=1:s(1)
    for h=1:s(2)
A=(1/(2*pi*sigma^2)^(1/2))*(exp(-((X-h+(s(2)/2)).^2+(Y-k+(s(1)/2)).^2)/(sigma)^2));

Sum_A=sum(sum(A));
image_0(k,h)=sum(sum(input_image.*(A/Sum_A)));
    end
end
smooth_image=image_0;
return
