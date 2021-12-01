%%
cx = 230;
cy = 192;
w = 193;%213;
h = 172;%192;
l = cx-floor(w/2);
t = cy-floor(h/2);
tracker = [l t w h];  % TODO Pick a bounding box in the format [x y w h]

video = VideoWriter('../results/car3.avi');
open(video);

% Initialize the tracker
figure;
prev_frame = imread('../data/car/frame0020.jpg');

% Start tracking
new_tracker = tracker;
for i = 21:280
    new_frame = imread(sprintf('../data/car/frame%04d.jpg', i));
    [u, v] = LucasKanade(prev_frame, new_frame, tracker);

    new_tracker(1) = tracker(1) + u;
    new_tracker(2) = tracker(2) + v;

    clf;
    hold on;
    imshow(new_frame);
    title(num2str(i));
    rectangle('Position', new_tracker, 'EdgeColor', [1 1 0]);
    drawnow;
    
    F = getframe;
    writeVideo(video,F);

    prev_frame = new_frame;
    tracker = new_tracker;
end
close(video);

%%
%-------------------------------------------------------------------------
cx = 501;
cy = 112;
w = 181;%161;
h = 91;%87;
l = cx-floor(w/2);
t = cy-floor(h/2);
tracker = [l t w h];  % TODO Pick a bounding box in the format [x y w h]

video = VideoWriter('../results/landing3.avi');
open(video);

% Initialize the tracker
figure;

prev_frame = imread('../data/landing/frame0190_crop.jpg');

% Start tracking
new_tracker = tracker;
for i = 191:308
    imgdir = sprintf('../data/landing/frame%04d_crop.jpg', i);
    if (~exist(imgdir,'file'))
        continue;
    end
    new_frame = imread(imgdir);
    [u, v] = LucasKanade(prev_frame, new_frame, tracker);

    new_tracker(1) = tracker(1) + u;
    new_tracker(2) = tracker(2) + v;

    clf;
    hold on;
    imshow(new_frame);
    title(num2str(i));
    rectangle('Position', new_tracker, 'EdgeColor', [1 1 0]);
    drawnow;
    
    F = getframe;
    writeVideo(video,F);

    prev_frame = new_frame;
    tracker = new_tracker;
end
close(video);


