function [affineMBContext] = initAffineMBTracker(img, rect)
% img is a greyscale image with a bouunding box rect
% affineMBContext is a Matlab structure that contains the Jacobian of the
% affine warp with respect to the 6 affine warp parameters and the inverse
% of the approximated Hessian matrix (J and H^-1)

x = rect(1); y = rect(2); w = rect(3); h = rect(4);
t = y; l = x; b = y+h-1; r = x+w-1;

% dWdp = @(x,y) [x,0,y,0,1,0; 0,x,0,y,0,1];

% Jacobian -> evaluated at W(x;0)
T = double(img(t:b,l:r));

% Gradient of template - dT
[dTx,dTy] = gradient(T);
dTx = dTx(:); % m by 1
dTy = dTy(:); % m by 1

[xs,ys] = meshgrid(t:b,l:r);
xs = xs(:); % m by 1
ys = ys(:); % m by 1

J = [xs.*dTx, xs.*dTy, ys.*dTx, ys.*dTy, dTx, dTy]; % m by 6

% Hessian -> sum(dT*dW/dp)^2
H = J'*J; % 6 by 6

affineMBContext = struct('J',J,'invH',H^(-1));

end

