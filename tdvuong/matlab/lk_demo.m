%
%tracker = [125 100 210 180];  %big template doesn't work well
tracker = [170 150 100 80];       % TODO Pick a bounding box in the format [x y w h]
% You can use ginput to get pixel coordinates

%video = VideoWriter('../results/car_lk.avi');
%video = VideoWriter('../results/car_robust.avi');
video = VideoWriter('../results/car_pyramid.avi');
open(video);

figure;
prev_frame = im2double(imread('../data/car/frame0020.jpg'));
imshow(prev_frame);

for i = 21:280
    new_frame = im2double(imread(sprintf('../data/car/frame%04d.jpg', i)));
    %[u, v] = LucasKanade(prev_frame, new_frame, tracker);
    %[u, v] = LucasKanade_Robust(prev_frame, new_frame, tracker);  
    [u, v] = LucasKanade_Pyramid(prev_frame, new_frame, tracker);
    
    tracker(1) = tracker(1) + u;
    tracker(2) = tracker(2) + v;
    
    clf;
    hold on;
    imshow(new_frame);   
    rectangle('Position', tracker, 'EdgeColor', [1 1 0]);
    drawnow;
    
    F = getframe(gca);
    %F1 = imresize(F.cdata, [669 668]);
    writeVideo(video,F);

    prev_frame = new_frame;
end
%}
%{
tracker = [420 80 150 60];  % TODO Pick a bounding box in the format [x y w h]

video = VideoWriter('../results/landing_lk.avi');

open(video);

% Initialize the tracker
figure;

prev_frame = im2double(imread('../data/landing/frame0190_crop.jpg'));

% Start tracking
new_tracker = tracker;
for i = 191:308
    imgdir = sprintf('../data/landing/frame%04d_crop.jpg', i);
    if (~exist(imgdir,'file'))
        continue;
    end
    new_frame = im2double(imread(imgdir));
    [u, v] = LucasKanade(prev_frame, new_frame, tracker);
    
    new_tracker(1) = tracker(1) + u;
    new_tracker(2) = tracker(2) + v;

    clf;
    hold on;
    imshow(new_frame);
    rectangle('Position', new_tracker, 'EdgeColor', [1 1 0]);
    drawnow;
    
    F = getframe(gca);
    F1 = imresize(F.cdata, [669 668]);
    writeVideo(video,F1);
    
    prev_frame = new_frame;
    tracker = new_tracker;
end
%}
close(video);
