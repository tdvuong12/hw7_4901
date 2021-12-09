function [affineMBContext] = initAffineMBTracker(img, rect)
x=rect(1);
y=rect(2);
w=rect(3);
h=rect(4);

T = img(y:y+h-1, x:x+w-1);
[dTx,dTy] = gradient(T);
dT = [dTx(:), dTy(:)];

[X,Y] = meshgrid(x:x+w-1, y:y+h-1);
X=X(:);
Y=Y(:);
o=ones(size(X));

J = [dT dT dT].*[X X Y Y o o];
H = J'*J;

affineMBContext.J = J;
affineMBContext.invH = H^(-1);