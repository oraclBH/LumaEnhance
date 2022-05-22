%*****function : lumaEnhance ******%
%*****tone :enhancement factor*********%
%******iter：number of iterations, degree of brightness enhancement******%
%******c：contrast enhancement factor******%
%*****author:oraclBH***********%

function  outIM = lumaEnhance(inIM, tone, iter, c)

if ~exist('tone', 'var')
    tone = 0.95;
end

if ~exist('iter', 'var')
    iter = 3;
end

if ~exist('c', 'var')
    c = 3;
end

inIM = double(inIM);
inIM = inIM / 255;

r = inIM(:,:,1);
g = inIM(:,:,2);
b = inIM(:,:,3);
gray =  0.2989 * r + 0.5870 * g + 0.1140 * b;
V = mean(gray(:));

for i = 1:iter
    r = r .* sqrt((1 + tone) - tone*(r + gray - r .* gray));
    g = g .* sqrt((1 + tone) - tone*(g + gray - g .* gray));
    b = b .* sqrt((1 + tone) - tone*(b + gray - b .* gray));
    gray =  0.2989 * r + 0.5870 * g + 0.1140 * b;
    V = mean(gray(:));
end

r = r + (r - V) * c;
g = g + (g - V) * c;
b = b + (b - V) * c;

outIM = cat(3, r, g, b) * 255;
outIM(outIM>255) = 255;
outIM(outIM<0) = 0;

end
