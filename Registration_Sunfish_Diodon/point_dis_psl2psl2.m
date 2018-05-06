function [Difference,trans_source_point_x,trans_source_point_y]=point_dis_psl2psl2(target_point,source_point,t)

a1=t(1);b1=t(2);c1=t(3);d1=(1+b1*c1)/a1;
a2=t(4);b2=t(5);c2=t(6);d2=(1+b2*c2)/a2;

trans_source_point_x=(a1*source_point(:,1)+b1)./(c1*source_point(:,1)+d1); 
trans_source_point_y=(a2*source_point(:,2)+b2)./(c2*source_point(:,2)+d2);

Difference=[trans_source_point_x-target_point(:,1), trans_source_point_y-target_point(:,2)]; 

return

