function [Difference,trans_source_point]=point_dis_mob(target_point,source_point,t)

a=t(1);b=t(2);c=t(3);d=(1+b*c)/a;

trans_source_point=(a*(source_point)+b)./(c*(source_point)+d);

Difference=trans_source_point-target_point; 

return