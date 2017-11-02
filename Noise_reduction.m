a = imread('frame43.jpg');
figure();
subplot(2,2,1);imshow(a);title('Normal RGB');


%%bw = im2bw(a);subplot(2,2,2);imshow(bw);title('Normal BW');
        %%b = medfilt3(a);

%%sb = edge(bw,'Sobel');
        %b = wiener2(a,[5 5]);
%%subplot(2,2,3);imshow(sb);title('Sobel Edge BW');

b = medfilt3(a);
subplot(2,2,4);imshow(b);title('Median Filter RGB');
b = im2bw(b);

sb2 = edge(b,'Canny');
figure();
imshow(sb2);title('Canny Edge MED Filter');

centerIndex = round(size(sb2,1)/2);         %# Get the center index for the rows
sb2(1:centerIndex+80,:) = cast(0,class(sb2));  %# ROW    Set the lower half to the value 0 (of the same type as A)
sb2(660:720,:) = cast(0,class(sb2));  %# Set the lower half to the value 0 (of the same type as A)

centerCIndex = round(size(sb2,2)/2);         %# COLOUMN Get the center index for the rows
sb2(:,1:centerIndex) = cast(0,class(sb2));  %# Set the lower half to the value 0 (of the same type as A)
sb2(:,centerIndex+680:end) = cast(0,class(sb2));  %# Set the lower half to the value 0 (of the same type as A)
figure();
imshow(sb2);title('Final Canny Edge MED Filter');

[H,theta,rho] = hough(sb2);

figure
imshow(imadjust(mat2gray(H)),[],...
       'XData',theta,...
       'YData',rho,...
       'InitialMagnification','fit');
xlabel('\theta (degrees)')
ylabel('\rho')
axis on
axis normal 
hold on
colormap(gca,hot)

P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));

x = theta(P(:,2));
y = rho(P(:,1));
plot(x,y,'s','color','black');

lines = houghlines(BW,theta,rho,P,'FillGap',20,'MinLength',10);

figure, imshow(sb2), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end
% highlight the longest line segment
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');

