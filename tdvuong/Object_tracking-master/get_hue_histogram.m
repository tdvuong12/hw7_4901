function [ hist, hue ] = get_hue_histogram( img, rect, k )
% img is the entire frame
% rect defines the template rectangle
% convert the template to HSV colorspace using rgd2hsv and use H channel
% output:
% h - L1 normalized histogram of the hues in template 
% hue - a matrix of size w by h where each element is an integer denoting
% which histogram bin that pixel belongs to. 

x = rect(1); y = rect(2); w = rect(3); h = rect(4);
t = y; l = x; b = y+h-1; r = x+w-1;

hsv = rgb2hsv(img);
H = hsv(:,:,1);

t = max(t,1); l = max(l,1); b = min(b,size(img,1)); r = min(r,size(img,2));
tmp = H(t:b,l:r);
tmp = imresize(tmp,[h,w]);

nbins = 360;
hue = min(floor(tmp*nbins)+1,nbins);

values = zeros(360,1);
for i = 1:h
    for j = 1:w
        bin_idx = hue(i,j);
        values(bin_idx) = values(bin_idx) + k(i,j);
    end
end
hist = values./sum(values);

% range = max(tmp(:))-min(tmp(:));
% bin_edges = min(tmp(:)):range/nbins:(max(tmp(:)));
% figure;
% plot(bin_edges(1:end-1),hist);
end



