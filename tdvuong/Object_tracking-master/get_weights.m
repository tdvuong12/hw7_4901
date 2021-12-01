function [ w ] = get_weights( p, q, hue )
% hue - the quantized template from get_hue_histogram
% p - histogram of the current frame template
% q - histogram of the original template
% output
% w - weight

[rows,cols] = size(hue);
ratio = zeros(360,1);
for m = 1:360
    if p(m) == 0
        ratio(m) = 0;
    else
        ratio(m) = q(m)/p(m);
    end
end

w = zeros(rows,cols);
for i = 1:rows
    for j = 1:cols
        delta = ~(hue(i,j) - (1:360)');
        w(i,j) = sum(ratio.^0.5.*delta);
    end
end

end