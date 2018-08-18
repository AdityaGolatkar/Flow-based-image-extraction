function [] = myTangent(mu,sigma)
img = imread('einstein.jpg');
img = imgaussfilt(img,sigma);
s = size(img);
%mu = (mu-1)/2;
s2_1 = s(1) + 2*mu;
s2_2 = s(2) + 2*mu;
s2 = [s2_1 s2_2];
img2 = zeros(s2);
i = 1:s(1);
j = 1:s(2);
img2(i+mu,j+mu) = img(i,j);
[Gx,Gy] = imgradientxy(img2);
[Gmag,Gdir] = imgradient(Gx,Gy);
max_mag = max(Gmag(:));
Gmag_normalized = Gmag/max_mag;
%Tmag = Gmag_normalized;
%Tmag = real(Tmag);
%Tdir = 90 + Gdir;
Tx = -Gy/max_mag;
Ty = Gx/max_mag;
%Tdir2 = atan2d(Ty,Tx);
[Tmag,Tdir] = imgradient(Tx,Ty);
for p = 1:3
    Tx2 = zeros(size(Tx));
    Ty2 = zeros(size(Ty));
    %Tdir2 = zeros(size(Tdir));
    %sumX = 0;
    %sumY = 0;
    %sum_mag = 0;
    for i = 1+mu:s(1)
        for j = 1+mu:s(2)
            %s_mu = [mu mu];
            %c_x = zeros(s_mu);
            %c_y = zeros(s_mu);
            %w_i = -mu:mu;
            %w_j = -mu:mu;
            %k = 0;
            sum_x = 0;
            sum_y = 0;
            for w_i = -mu:mu
                for w_j = -mu:mu
                    exponent = ((w_i*w_i) + (w_j*w_j))/(2*mu*mu);
                    ws = 1;
                    wm = (Tmag(i+w_i,j+w_j) - Tmag(i,j) + 1)/2;
                    wd = Tx(i,j)*Tx(i+w_i,j+w_j) + Ty(i,j)*Ty(i+w_i,j+w_j);
                    % phi(x,y) seems redundant, remove the modulus sign in wd
                    %c_x((w_i+mu+1),(w_j+mu+1)) = Tx(i+w_i,j+w_j)*ws*wm*wd;
                    %c_y((w_i+mu+1),(w_j+mu+1)) = Ty(i+w_i,j+w_j)*ws*wm*wd;
                    sum_x = sum_x + Tx(i+w_i,j+w_j)*ws*wm*wd;
                    sum_y = sum_y + Ty(i+w_i,j+w_j)*ws*wm*wd;
                    %k = k + ws*wm*wd;
                end
            end
            %sum_x = sum(c_x(:));
            %sum_y = sum(c_y(:));
            %sum_x = sum_x;
            %sum_y = sum_y;
            k = (2*mu+1)*(2*mu+1);
            Tx2(i,j) = sum_x/k;
            Ty2(i,j) = sum_y/k;
            %sum_mag = sum_mag + sqrt((sum_x*sum_x) + (sum_y*sum_y));
        end
    end
    %sum_mag = sqrt(sumX*sumX+sumY*sumY);
    %sum_mag
    %Tx2 = Tx2/sum_mag;
    %Ty2 = Ty2/sum_mag;
    Tx = Tx2;
    Ty = Ty2;
    Tmag = sqrt(Tx.*Tx+Ty.*Ty);
    max_mag = max(Tmag(:));
    Tmag = Tmag/max_mag;
    Tx = Tx/max_mag;
    Ty = Ty/max_mag;
end
Tx_final = zeros(s);
Ty_final = zeros(s);
i = 1:s(1);
j = 1:s(2);
Tx_final(i,j) = Tx(i+mu,j+mu);
Ty_final(i,j) = Ty(i+mu,j+mu);
%Tmag_final = sqrt(Tx_final.*Tx_final + Ty_final.*Ty_final)
Tdir_final = atan2d(Ty_final,Tx_final);
[Tmag_final,Tdir_final2] = imgradient(Tx_final,Ty_final);
subplot(2,2,1),imshow(Tdir_final), title('atan2dWala');
subplot(2,2,2),imshow(Tdir_final2), title('imgradientWala');
subplot(2,2,3),imshow(Tdir), title('Original');
%imwrite(uint8(filtered_img),'..\images\barbara256_gaussian_low_pass.png');
    
 
    
    
