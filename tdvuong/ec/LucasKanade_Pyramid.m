function [u,v] = LucasKanade_Pyramid(IT, IT1, rect)

th = 0.001;
maxIter = 50;
numPyramid = 3; %>4 gives errors in size (2^4 is too big!)

% It = double(It);
% It1 = double(It1);
x = rect(1);y = rect(2);w = rect(3);h = rect(4);
cx = x + w/2;
cy = y + h/2;

% Build pyrymids
Its = pyramid(IT, numPyramid);
It1s = pyramid(IT1, numPyramid);

u = 0;
v = 0;

for level = numPyramid:-1:1
    scale = 2^(level - 1);
    x = cx / scale - w/2;
    y = cy / scale - h/2;
    
    It = Its{level};
    It1 = It1s{level};
    
    [X, Y] = meshgrid(x:x+w-1, y:y+h-1);
    it = interp2(It, X, Y);
    
    
        
    u = u * 2;
    v = v * 2;
    for i = 1:maxIter
        it1 = interp2(It1, X+u, Y+v);
        err = it1 - it;
        [dTx, dTy] = gradient(it1);
        A = [dTx(:), dTy(:)];
    
        H = A' * A;
        
        dP = H \ (A' * err(:));
        u = u - dP(1);
        v = v - dP(2);
        if u^2 + v^2 < th
            break;
        end
    end
end

end
