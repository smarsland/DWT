source=imresize(im2double(rgb2gray(imread('human1.png'))),1/4);
target=imresize(im2double(rgb2gray(imread('chimpanzee1.png'))),1/4);
S=size(source);
[X,Y]=meshgrid((-0.5):1/(S(2)):((0.5)-1/(S(2))),(-0.5):1/(S(1)):((0.5)-1/(S(1))));
sigma=[4,1/3]; 
Non_defined_pixels_background=1 % here backgrounds are white, so we assign 1. 


%(second step of the following loop, when j=2, I did not do smoothing. sigma=1/3 means no smoothing)


for j=1:2      
smooth_source=smoothing(source,X,Y,sigma(j));
smooth_target=smoothing(target,X,Y,sigma(j));

f=@(Initial_value)Mobius(X,Y,Initial_value,smooth_source,smooth_target,Non_defined_pixels_background);

options=optimset('Display','Iter','MaxFunEvals',10000,'TolFun',10^(-15));

Initial_value=[1,0,0,0,0,0];
[T,res]=lsqnonlin(f,Initial_value,[],[],options)
Initial_value=T;
end

out_Parameters=[T(1)+1i*T(2),T(3)+1i*T(4),T(5)+1i*T(6), 
(1+(T(3)+1i*T(4))*(T(5)+1i*T(6)))/(T(1)+1i*T(2))];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plotting:

[~,deformed_source]=Mobius(X,Y,out_Parameters,source,target,Non_defined_pixels_background);

deformed_grid=(out_Parameters(4)*(X+1i*Y)-out_Parameters(2)*(X+1i*Y))/(-out_Parameters(3)*(X+1i*Y)+out_Parameters(1)*(X+1i*Y));
real_grid=real(deformed_grid)*S(2)+0.5*S(2) ; 
imag_grid=imag(deformed_grid)*S(1)+0.5*S(1);


k=15;
plot(real_grid(:,1:k:end),imag_grid(:,1:k:end),'blue'),hold on
plot((real_grid(1:k:end,:))',(imag_grid(1:k:end,:))','blue');
imshow(deformed_source), hold on
plot(real_grid(:,1:k:end),imag_grid(:,1:k:end),'blue'),hold on
plot((real_grid(1:k:end,:))',(imag_grid(1:k:end,:))','blue'),






 

  

 

 
  