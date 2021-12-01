function [W_out] = affineMBTracker(img, tmp, rect, W_in, context)
% img is a geyscale image
% tmp is the template image
% rect is the bounding box
% W_in is the previous frame
% context is the precomputed J and H^-1 matrices
%
% W_out should be 3 by 3 that contains the new affine warp matrix updated so
% that it aligns the CURRENT frame with the TEMPLATE

[m0,n0] = size(img);
%[m1,n1] = size(img);

x = rect(1); y = rect(2); w = rect(3); h = rect(4);
t = y; l = x; b = y+h-1; r = x+w-1;

% dWdp = @(x,y) [x,0,y,0,1,0; 0,x,0,y,0,1];

J0 = context.J;
invH0 = context.invH;

maxIter = 30;
iter = 0;
dp = 100*ones(6,1);
thresh = 1.6;
patience_thresh = 0.05*thresh;

W = W_in;

%for i = 1:maxIter
while (norm(dp) > thresh) && (iter < maxIter)
    dp_prev = dp;
    % Warp image - I(W(x;p))
    warpedI = warpH(img,W,[m0,n0],0);
    
    % Compute error image - [T(x)-I(W(x;p))]^2
    I = double(warpedI(t:b,l:r));
    T = double(tmp);
    E = (I-T); % w by h

    % Compute - dp
    dp = invH0*J0'*E(:); % 6 by 6 * 6 by m * m by 1

    % Update parameters - W(x;p) = W(x;p) * inv(W(x;dp))
    Wdp = Warp_with(dp);
    W = W*inv(Wdp);    
    
    if norm(dp-dp_prev) > patience_thresh
        iter = 0;
    end
    
    iter = iter+1;
    fprintf('iter# %d\n',iter);
end

W_out = W;
end


