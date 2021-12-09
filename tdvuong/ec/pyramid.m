function O = pyramid(I, level)
O = cell(1, level);
O{1} = I;
for i=2:level
    O{i} = impyramid(O{i-1}, 'reduce');
end
end