function [ newrect ] = meanshift_track( q, newframe, rect, k, gx, gy)

thresh = 0.5;
patience_thresh = 0.05*thresh;

dx_new = 100;
dy_new = 100;

maxIter = 20;
iter = 0;

while (norm([dx_new,dy_new]) > thresh) && (iter < maxIter)
    fprintf('iter# %d\n',iter);
    dx_old = dx_new;
    dy_old = dy_new;
    
    w = rect(3); 
    h = rect(4);
    
    % 1.compute the histogram of the current frames's tamplate
    [hist_new, hue_new] = get_hue_histogram(newframe, rect, k);

    % 2. Calculate the weights
    weight_new = get_weights(hist_new,q,hue_new);

    % 3. Compute dx and dy
    [dx_new, dy_new] = calculate_mean_shift(w,h,weight_new,gx,gy);

    % 4. Update the tracker
    rect(1) = rect(1) + dx_new;
    rect(2) = rect(2) + dy_new;
    
%     if norm([dx_new-dx_old,dy_new-dy_old]) > patience_thresh
%         iter = 0;
%     end
    
    iter = iter + 1;
end
newrect = rect;

end
