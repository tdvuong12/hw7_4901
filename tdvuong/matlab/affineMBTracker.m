function [Wout] = affineMBTracker(img, tmp, rect, Win, context)

maxIter = 30;

x=rect(1);y=rect(2);w=rect(3);h=rect(4);
T = tmp(:);
invH = context.invH;
J = context.J;

[X,Y] = meshgrid(x:x+w-1, y:y+h-1);
X=X(:);
Y=Y(:);
o=ones(size(X));

Wout = Win;

for i = 1:maxIter
    C = Wout * [X';Y';o'];
    C = C ./ C(3,3); 
    warpedX = floor(C(1,:)');
    warpedY = floor(C(2,:)');
    try 
        I = img(sub2ind(size(img),warpedY,warpedX));
    catch
        break;
    end
    I = I.*(sum(T(:))/sum(I(:)));

    err = I - T;
    dP = invH * J' * err ;
    Wout = Wout/gen_affine_warp(dP);
    Wout = Wout./Wout(3,3);
end
end