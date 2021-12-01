%% Given tracker initializations
% These are in the format [x y w h]
track_cup = [ 135 152 41 55];
track_ball = [215 84 15 25 ];

% Pick one of the above
tracker = track_cup(:);

video = VideoWriter('../results/desk.avi');
open(video);

%% Initialize the tracker
figure;

first = imread('../data/desk/frame001.png');

[k, gx, gy] = get_kernel('Epanichnikov', 2, tracker(3), tracker(4));
q = get_hue_histogram(first, tracker, k);

%% Start tracking
new_tracker = tracker;
for i = 2:145
    im = imread(sprintf('../data/desk/frame%03d.png', i));
    [~,~,d] = size(im);
    if d ~= 3
        error('Not RGB img!');
    end
    
    new_tracker = meanshift_track(q, im, new_tracker, k, gx, gy);
    
    clf;
    hold on;
    imshow(im);
    rectangle('Position', new_tracker, 'EdgeColor', [1 1 0]);
    title(num2str(i));
    drawnow;
    
    F = getframe;
    writeVideo(video,F);
end

close(video);