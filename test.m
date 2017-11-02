clc;

a = imread('frame300.jpg');

b = medfilt3(a);
b = im2bw(b);
sb2 = edge(b,'Canny');


c = [300 538 643 1202];
r = [667 436 438 655];
BW = roipoly(sb2,c,r);   %logical mask

[R, C] = size(BW);        %Overlapping ROI and mask strategically

for i=1:R
    for j=1:C
        
        if BW(i,j)==1
            
            Out(i,j)=sb2(i,j);
            
        else
            
            Out(i,j)=0;
            
        end
    end
end

figure;
imshow(Out,[]);title('Output');


function [edgelist, edgeim] = edgelink(Out, minlength, location)
    
    global EDGEIM;      % Some global variables to avoid passing (and
                        % copying) of arguments, this improves speed.
    global ROWS;
    global COLS;
    
    elist = {};
    
    EDGEIM = Out ~= 0;                     % make sure image is binary.

    EDGEIM = bwmorph(EDGEIM,'thin',Inf);  % make sure edges are thinned.
    show(EDGEIM,1)

    EDGEIM = double(EDGEIM);
    [ROWS, COLS] = size(EDGEIM);
    edgeNo = 1;
        
    
    % Perform raster scan through image looking for edge points.  When a
    % point is found trackedge is called to find the rest of the edge
    % points.  As it finds the points the edge image pixels are labeled
    % with the -ve of  their edge No
    
    for r = 1:ROWS
	for c = 1:COLS
	    if EDGEIM(r,c) == 1
		edgepoints = trackedge(r,c, edgeNo, minlength);
		if ~isempty(edgepoints)
		    edgelist{edgeNo} = edgepoints;
		    edgeNo = edgeNo + 1;
		end
	    end
	end
    end
    
    edgeim = -EDGEIM;  % Finally negate image to make edge encodings +ve.
    
    % If subpixel edge locations are supplied upgrade the integer precision
    % edgelists that were constructed with data from 'location'.
    if nargin == 3
	for I = 1:length(edgelist)
	    ind = sub2ind(size(Out),edgelist{I}(:,1),edgelist{I}(:,2));
	    edgelist{I}(:,1) = real(location(ind))';
	    edgelist{I}(:,2) = imag(location(ind))';    
	end
    end
  figure();  
  imshow(edgeim); colormap(flag);
end