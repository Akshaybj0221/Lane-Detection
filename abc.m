a = imread('frame430.jpg');
b = medfilt3(a);
b = im2bw(b);

sb2 = edge(b,'Canny');
figure();
imshow(sb2);title('Canny Edge MED Filter');



c = [300 538 643 1202];
r = [667 436 438 655];
BW = roipoly(sb2,c,r);   %logical mask

[R C] = size(BW);        %Overlapping ROI and mask strategically

for i=1:R
    for j=1:C
        
        if BW(i,j)==1
            
            Out(i,j)=sb2(i,j);
            
        else
            
            Out(i,j)=0;
            
        end
    end
end

%figure;
%imshow(Out,[]);title('Output');

[H,theta,rho] = hough(Out);    %getting hough lines

P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));   %finding peak hough transform lines

lines = houghlines(Out,theta,rho,P,'FillGap',150,'MinLength',1);   %plotting hough lines%%
%figure, imshow(Out), hold on
imshow(Out), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',5,'Color','red');
   
end





