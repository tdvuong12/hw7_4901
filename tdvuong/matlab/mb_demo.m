%
x = 170;
y = 150;
w = 100;
h = 80;
tracker = [x y w h];         % TODO Pick a bounding box in the format [x y w h]
% You can use ginput to get pixel coordinates

video = VideoWriter('../results/car_mb.avi');
open(video);

figure;
prev_frame = im2double(imread('../data/car/frame0020.jpg'));

template = prev_frame(y:y+h-1,x:x+w-1);   % TODO
Win = gen_affine_warp(zeros(6,1));        % TODO

context = initAffineMBTracker(prev_frame, tracker);

new_tracker = tracker;
for i = 21:280
    imgdir = sprintf('../data/car/frame%04d.jpg', i);
    if (~exist(imgdir,'file'))
        continue;
    end
    im = im2double(imread(imgdir));
    Wout = affineMBTracker(im, template, tracker, Win, context);

    new_tracker = gen_tracker(Wout, tracker); % TODO calculate the new bounding rectangle
    
    clf;
    hold on;
    imshow(im);   
    rectangle('Position', new_tracker, 'EdgeColor', [1 1 0]);
    drawnow;    
    
    F = getframe(gca);
    %F1 = imresize(F.cdata, [669 668]);
    writeVideo(video,F);
    
    prev_frame = im;
    %tracker = new_tracker;
    Win = Wout;
end
%}
%{
x = 425;
y = 80;
w = 150;
h = 60;
tracker = [x y w h];         % TODO Pick a bounding box in the format [x y w h]

video = VideoWriter('../results/landing_mb.avi');
open(video);

% Initialize the tracker
figure;

% TODO run the Matthew-Baker alignment in both landing and car sequences
prev_frame = im2double(imread('../data/landing/frame0190_crop.jpg'));

template = prev_frame(y:(y+h-1),x:(x+w-1));   % TODO
Win = gen_affine_warp(zeros(6,1));        % TODO

context = initAffineMBTracker(prev_frame, tracker);

new_tracker = tracker;
for i = 191:308
    imgdir = sprintf('../data/landing/frame%04d_crop.jpg', i);
    if (~exist(imgdir,'file'))
        continue;
    end
    im = im2double(imread(imgdir));
    Wout = affineMBTracker(im, template, tracker, Win, context);

    new_tracker = gen_tracker(Wout, tracker); % TODO calculate the new bounding rectangle
    
    clf;
    hold on;
    imshow(im);   
    rectangle('Position', new_tracker, 'EdgeColor', [1 1 0]);
    drawnow;   
    
    
    F = getframe(gca);
    F1 = imresize(F.cdata, [669 668]);
    writeVideo(video,F1);
    
    prev_frame = im;
    %tracker = new_tracker;
    Win = Wout;
end
%}
close(video);
