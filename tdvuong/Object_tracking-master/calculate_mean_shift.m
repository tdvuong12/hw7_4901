function [ dx, dy ] = calculate_mean_shift( width, height, w, gx, gy )
% width and height should be the tmp window size
% w - matrix of weights calculated using get_weights
% gx,gy - gradients of the kernel
% output:
% dx,dy - shift of the tracking window

[xs,ys] = meshgrid(1:width,1:height);

gx = abs(gx);
gy = abs(gy);

mean_x = sum(xs(:).*w(:).*gx(:))/sum(w(:).*gx(:));
mean_y = sum(ys(:).*w(:).*gy(:))/sum(w(:).*gy(:));

dx = round(mean_x) - (width+1)/2;
dy = round(mean_y) - (height+1)/2;

end