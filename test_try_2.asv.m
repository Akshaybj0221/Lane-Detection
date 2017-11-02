a = imread('frame43.jpg');
b = medfilt3(a);
b = im2bw(b);

sb2 = edge(b,'Canny');
figure();
imshow(sb2);title('Canny Edge MED Filter');

x = [222 272 300 270 221 194];
y = [21 21 75 121 121 75];
J = regionfill(sb2,x,y);

figure();
imshow(J);title('Final Canny Edge MED Filter');


