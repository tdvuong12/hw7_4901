function [ u, v ] = LucasKanade( It, It1, rect )

th = 0.001;
maxIter = 50;

% It = double(It);
% It1 = double(It1);
x = rect(1);y = rect(2);w = rect(3);h = rect(4);

[X, Y] = meshgrid(x:x+w-1, y:y+h-1);
it = interp2(It, X, Y);


u = 0;
v = 0;

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