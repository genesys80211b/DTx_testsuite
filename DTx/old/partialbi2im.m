function [image,varargout] = partialbi2im(bin,frame,h,w,d)
if nargin < 2
    frame  = 2;
    if nargin < 3
        h = 110; w = 118; d = 1;
    end
end
if (frame==1)
    bin_size = bin(1:24);
    h = bi2de((bin_size(1:11))');
    w = bi2de((bin_size(12:22))');
    d = bi2de((bin_size(23:24))');
    if nargout > 1
        varargout{1} = uint16(h); 
        if nargout > 2 
            varargout{2} = uint16(w); 
            if nargout > 3
                varargout{3} = uint16(d);
            end
        end
    end
end
bin_image = bin(25:end);
num_bits = length(bin_image);
bin_matrix = zeros(floor(num_bits/8),8);
for ii = 1:num_bits/8
    bin_matrix(ii,:) = (bin_image((ii-1)*8+1:ii*8))';
end
dec_vector = bi2de(bin_matrix);
image = uint8(partialvec2im(dec_vector, h, w, d));
return;
end %FUNCTION PARTIALBI2IM

function y = partialvec2im(x, h, w, c3)
if nargin < 2
    h = 371;
    if nargin < 3
        w = 415;
        if nargin < 4
            c3 = 1;
        end
    end
end
num_elem = length(x);
num_cols = ceil(num_elem./(h*c3));
num_lastcol = mod(num_elem,(h*c3));
y = zeros(h, w, c3);
for ii = 1:num_cols % Fill in image one column at a time
    if ((ii*h*c3)<=num_elem)
        xmat = reshape(x((ii-1)*h*c3+1:ii*h*c3),c3,h,1);
        xprm = permute(xmat,[2,3,1]);
        y(1:h,ii,1:c3) = xprm;
    else % If last column is incomplete, fill in as many pixels as possible
        num_pix_lastcol = floor(num_lastcol/c3);
        xmat = reshape(x((ii-1)*h+1:(ii-1)*h+c3*num_pix_lastcol),c3,num_pix_lastcol,1);
        xprm = permute(xmat,[2,3,1]);
        y(1:num_pix_lastcol,ii,1:c3) = xprm;
    end
end
return;
end %FUNCTION PARTIALVEC2IM
