function [new_tracker] = gen_tracker(W, tracker)
x = tracker(1); y = tracker(2); w = tracker(3); h = tracker(4); 
cx = x + round(w/2); cy = y + round(h/2);
new_c = W*[cx;cy;1];
%warped_corner = W * [x; y; 1];
%new_x = round(warped_corner(1));
%new_y = round(warped_corner(2));
new_tracker = [round(new_c(1)-floor(w/2)), round(new_c(2)-floor(h/2)), w, h];
%new_tracker = [new_x, new_y, w, h];

end

