function [ k, gx, gy ] = get_kernel( type, radius, w, h )
% this kernel should handle returning twp types of kernels of w by h, based
% on the type parameter. 
% type - Gaussian or Epanichnikov
% radius - parameters for kernel, radius = stddev for gaussian

if strcmp(type, 'Gaussian')
    k = fspecial('gaussian',[h,w],radius);
elseif strcmp(type, 'Epanichnikov') 
    k = zeros(h,w);
    for y = 1:h
        for x = 1:w
            d = norm([2*x/(w+1)-1,2*y/(h+1)-1]); %assume w and h to be odd
            k(y,x) = max(1 - d^2/radius, 0);
        end
    end
else
    error('Wrong type.');
end
[gx, gy] = gradient(k);

end
