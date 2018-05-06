source=im2double(rgb2gray(imread('diodon.png')));
imshow(source), hold on ,source_point=ginput(12);source_point=source_point(:,1)+1i*source_point(:,2);

target=im2double(rgb2gray(imread('sunfish.png')));
imshow(target),hold on,target_point=ginput(12);target_point=target_point(:,1)+1i*target_point(:,2);

S=size(source);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Mobius registration


% scaling and transforming points to [-0.5,0.5]*[-0.5,0.5]
% note that S(2) is equal to S(1)

source_point=-0.5-0.5i+(source_point/S(2));target_point=-0.5-0.5i+(target_point/S(2)); 



In_Value_mobius=[1,0,0];
f=@(t)point_dis_mob(target_point,source_point,t);

options=optimset('Display','Iter','MaxFunEvals',10000,'TolFun',10^(-10));

[t1,res]=lsqnonlin(f,In_Value_mobius,[],[],options)

[~,trans_source_point_0]=point_dis_mob(target_point,source_point,t1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% registration in psl2psl2

trans_source_point_0=[real(trans_source_point_0),imag(trans_source_point_0)];
target_point=[real(target_point),imag(target_point)];

In_Value_psl2psl2=[1,0,0,1,0,0]
f=@(t)point_dis_psl2psl2(target_point,trans_source_point_0,t);

options=optimset('Display','Iter','MaxFunEvals',10000,'TolFun',10^(-10));

[t2,res]=lsqnonlin(f,In_Value_psl2psl2,[],[],options)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plotting

Non_defined_pixels_background=1;
[X,Y]=meshgrid((-0.5):1/(S(2)):((0.5)-1/(S(2))),(-0.5):1/(S(1)):((0.5)-1/(S(1))));

deformed_source_0=Mobius(X,Y,t1,source,Non_defined_pixels_background);

a=t1(1);b=t1(2);c=t1(3);d=(1+b*c)/a
Z0=X+1i*Y;
deformed_grid_0=(d*Z0-b)./(-c*Z0+a);
Z1=deformed_grid_0;

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

deformed_source_1=psl2psl2(X,Y,t2,deformed_source_0,Non_defined_pixels_background);

a1=t2(1);b1=t2(2);c1=t2(3);d1=(1+b1*c1)/a1;
a2=t2(4);b2=t2(5);c2=t2(6);d2=(1+b2*c2)/a2;
deformed_grid_1=(d1*real(Z1)-b1)./(-c1*real(Z1)+a1)+1i*(d2*imag(Z1)-b2)./(-c2*imag(Z1)+a2);

%transformation of grid
real_grid=real(deformed_grid_1)*S(2)+0.5*S(2);
imag_grid=imag(deformed_grid_1)*S(1)+0.5*S(1);


k=15;
plot(real_grid(:,1:k:end),imag_grid(:,1:k:end),'blue'),hold on
plot((real_grid(1:k:end,:))',(imag_grid(1:k:end,:))','blue');
imshow(deformed_source_1), hold on
plot(real_grid(:,1:k:end),imag_grid(:,1:k:end),'blue'),hold on
plot((real_grid(1:k:end,:))',(imag_grid(1:k:end,:))','blue'),




