function [u,v] = LucasKanade(It, It1, rect)

[Ih,Iw] = size(It);
rect = round(rect);
x = rect(1); y = rect(2); w = rect(3); h = rect(4);
t = y; l = x; b = y+h-1; r = x+w-1;

p_init = zeros(6,1);
% dWdp = @(x,y) [x,0,y,0,1,0; 0,x,0,y,0,1];

dp = ones(6,1)*100; % arbitrary large number to start
threshold = 3;
maxIter = 30;
iter = 0;
p = p_init;

while (norm(dp) > threshold) && (iter < maxIter)
    W = [1+p(1), p(3), p(5);
       p(2), 1+p(4), p(6);
       0,      0,    1];
    % 1. Warp Image : I(W(x;p))
    warpedIt1 = warpH(It1,W,[Ih,Iw],0);

    % 2. Compute error image : T(x)-I(W(x;p))
    I = double(warpedIt1(t:b,l:r));
    T = double(It(t:b,l:r));
    E = (T-I);

    % 3. Compute gradient : dI(x)
    [dIt1x,dIt1y] = gradient(I); %warpedIt1
    dIt1x = dIt1x(:); % m by 1
    dIt1y = dIt1y(:); % m by 1

    % 4. Evaluate Jacobian : dW/dp and compute A
    [xs,ys] = meshgrid(t:b,l:r);
    xs = xs(:); % m by 1
    ys = ys(:); % m by 1
    
    J = [xs.*dIt1x, xs.*dIt1y, ys.*dIt1x, ys.*dIt1y, dIt1x, dIt1y]; % m by 6
    
    % 5. Compute Hessian : H
    H = J'*J; % 6 by 6
    
    % 6. Compute : dp
    dp = H\(J'*E(:)); % 6 by 6 \ (6 by m * m by 1) => 6 by 1

    % 7. Update parameters : p->p+dp
    p = p - dp;
    
    iter = iter+1;
    fprintf('iter# %d\n',iter);
end

u = p(5);
v = p(6);

end

