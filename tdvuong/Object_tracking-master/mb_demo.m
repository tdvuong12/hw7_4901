cx = 230;
cy = 192;
w = 213;
h = 177;
l = cx-floor(w/2);
t = cy-floor(h/2);
tracker = [l t w h];

video = VideoWriter('../results/car_mb_2.avi');
open(video);

% Initialize the tracker
figure;

% TODO run the Matthew-Baker alignment in both landing and car sequences
prev_frame = imread('../data/car/frame0020.jpg');
template = prev_frame(t:(t+h-1),l:(l+w-1));   % TODO
Win = Warp_with(zeros(6,1));        % TODO

context = initAffineMBTracker(prev_frame, tracker);

% Start tracking
new_tracker = tracker;
for i = 21:280
    imgdir = sprintf('../data/car/frame%04d.jpg', i);
    if (~exist(imgdir,'file'))
        continue;
    end
    im = imread(imgdir);
    Wout = affineMBTracker(im, template, tracker, Win, context);

    new_c = Wout*[cx;cy;1];
    new_tracker = [round(new_c(1)-floor(w/2)), round(new_c(2)-floor(h/2)), w, h]; % TODO calculate the new bounding rectangle
    
    clf;
    hold on;
    imshow(im);   
    rectangle('Position', new_tracker, 'EdgeColor', [1 1 0]);
    title(num2str(i));
    drawnow;

    F = getframe;
    writeVideo(video,F);
    
    prev_frame = new_frame;
    tracker = new_tracker;
end
close(video);

%%
%------------------------------------------------------------------------
cx = 501;
cy = 112;
w = 201;%181;
h = 101;%107;
l = cx-floor(w/2);
t = cy-floor(h/2);
tracker = [l t w h];         % TODO Pick a bounding box in the format [x y w h]

video = VideoWriter('../results/landing_mb_3.avi');
open(video);

% Initialize the tracker
figure;

% TODO run the Matthew-Baker alignment in both landing and car sequences
prev_frame = imread('../data/landing/frame0190_crop.jpg');
template = prev_frame(t:(t+h-1),l:(l+w-1));   % TODO
Win = Warp_with(zeros(6,1));        % TODO

context = initAffineMBTracker(prev_frame, tracker);

% Start tracking
new_tracker = tracker;
for i = 191:308
    imgdir = sprintf('../data/landing/frame%04d_crop.jpg', i);
    if (~exist(imgdir,'file'))
        continue;
    end
    im = imread(imgdir);
    Wout = affineMBTracker(im, template, tracker, Win, context);

    new_c = Wout*[cx;cy;1];
    new_tracker = [round(new_c(1)-floor(w/2)), round(new_c(2)-floor(h/2)), w, h]; % TODO calculate the new bounding rectangle
    
    clf;
    hold on;
    imshow(im);   
    rectangle('Position', new_tracker, 'EdgeColor', [1 1 0]);
        title(num2str(i));
    drawnow;
    
    F = getframe;
    writeVideo(video,F);

    prev_frame = new_frame;
    tracker = new_tracker;
end
close(video);

