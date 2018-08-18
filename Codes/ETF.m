function [t_next1,imgret] = ETF(image,win)

%===================================
% Getting the image and smoothing it
%===================================
%win = 7;												%Lenght of the windown patch.
winby2 = floor(win/2);
inp = image;
%inp = imread(image);
sz = size(inp);
img = zeros(sz(1)+2*winby2,sz(2)+2*winby2);
sz1 = size(img);
img(winby2+1:winby2+sz(1),winby2+1:winby2+sz(2)) = inp; 	%Zero Padding the input image.
img = double(img);                                          %Converting the image to double,
imgret = img;
img = imgaussfilt(img,1);                                   %Gaussian filtering the image.
                                                            %Get the size of the image.

%====================
%Gradient Computation
%====================
%.................................................
%g is sz x 2 matrix where first page will store 
%gradient along x and second along y.
%................................................

[g(:,:,1) ,g(:,:,2)] = gradient(img);
[gmag, gdir] = imgradient(img);

%========================================
%Intial ETF computation and Normalization
%========================================
%........................................................
%t is obtained from g by taking perpendicular vectors in 
%counter clockwise direction hence t(x) = -g(y) and 
%t(y) = g(x) as it is ACW. Then Normalize it.
%........................................................

t(:,:,1) = -g(:,:,2);
t(:,:,2) =  g(:,:,1);

%=====================
%Iterations to get ETF
%=====================

t_next = zeros(sz1(1),sz1(2),2);
for run =1:3
%tnx = t(:,:,1).^2;
%tny = t(:,:,2).^2;
sxy = sqrt(t(:,:,1).^2 + t(:,:,2).^2);
normfact = max(sxy(:));
t(:,:,1) = t(:,:,1)/normfact;
t(:,:,2) = t(:,:,2)/normfact;
[tmag tdir] = imgradient(t(:,:,1),t(:,:,2));
%=======================
%ETF construction filter
%=======================

for i= winby2 +1: winby2 +sz(2)
	for j = winby2+1:winby2+sz(1)
        m = repmat(gmag(i,j),win,win);
        %w_s = ones(win,win);
		w_s = fspecial('gaussian',[win,win],winby2);
        w_m = (gmag(i-winby2:i+winby2,j-winby2:j+winby2)- m + ones(win,win))/2;
		t_x = repmat(t(i,j,1),win,win);
		t_y = repmat(t(i,j,2),win,win);
		w_d1 = t(i-winby2:i+winby2,j-winby2:j+winby2,1).*t_x; 
        w_d2 = t(i-winby2:i+winby2,j-winby2:j+winby2,2).*t_y;
		w_d = w_d1 + w_d2;
        %divfac = max(w_d(:));
        %w_d = w_d/divfac;
        k = w_m.*w_d;
        k = k.*w_s;
		t_win1 = t(i-winby2:i+winby2,j-winby2:j+winby2,1).*k;
        t_win2 = t(i-winby2:i+winby2,j-winby2:j+winby2,2).*k;
		num = sum(t_win1(:));
        t_next(i,j,1) = num/(win*win);
        num = sum(t_win2(:));
		t_next(i,j,2) = num/(win*win);
	end
end
end
%imshow(t1(:,:,2));
sxy = sqrt(t_next(:,:,1).^2 + t_next(:,:,2).^2);
normfact = max(sxy(:));
%normfact = mean(sxy(:));
%normfact = 1.8*(normfact.^2);
t_next1(:,:,1) = t_next(:,:,1)/normfact;
t_next1(:,:,2) = t_next(:,:,2)/normfact;
[tmag1 ,tdir1] = imgradient(t_next1(:,:,1),t_next1(:,:,2));
%dir = atan2(t_next1(:,:,2),t_next1(:,:,1));
%imshow(tdir1);
