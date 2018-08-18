function [] = myBFL(sigma_e,r_e,sigma_g,r_g)
img = imread('einstein.jpg');

for p = 1:2
    s = size(img);
    S = 3*sigma_e;
    T = 3*sigma_g;
    max_ST = max(S,T);
    [img2, Tx, Ty] = myETF(img,max_ST+1,0.2);
    [Tmag, Tdir] = imgradient(Tx,Ty);
    Gx = Ty;
    Gy = -Tx;
    [Gmag, Gdir] = imgradient(Gx,Gy);
    s2 = size(img2);
    C_e2 = zeros(s2);
    C_g2 = zeros(s2);
    for i = 1:s2(1)-2*max_ST-1
        for j = 1:s2(2)-2*max_ST-1
            sum_u = 0;
            sum_n = 0;
            c_i = i;
            c_j = j;
            i2 = i;
            j2 = j;
            for k = 1:(2*S+1)
                exponent_s = ((k-S-1)*(k-S-1))/(2*sigma_e*sigma_e);
                g_s = exp(-exponent_s);
                if(-22.5 < Tdir(i2,j2) < 22.5)
                    diff_r = img2(i2,j2) - img2(i2+1,j2);
                    exponent_r = (diff_r*diff_r)/(2*r_e*r_e);
                    g_r = exp(-exponent_r);
                    sum_u = sum_u + img2(i2+1,j2)*g_s*g_r;
                    sum_n = sum_n + g_s*g_r;
                    i2 = i2+1;

                elseif(22.5 < Tdir(i2,j2) < 67.5)
                    diff_r = img2(i2,j2) - img2(i2+1,j2+1);
                    exponent_r = (diff_r*diff_r)/(2*r_e*r_e);
                    g_r = exp(-exponent_r);
                    sum_u = sum_u + img2(i2+1,j2+1)*g_s*g_r;
                    sum_n = sum_n + g_s*g_r;
                    i2 = i2+1;
                    j2 = j2+1;

                elseif(67.5 < Tdir(i2,j2) < 112.5)
                    diff_r = img2(i2,j2) - img2(i2,j2+1);
                    exponent_r = (diff_r*diff_r)/(2*r_e*r_e);
                    g_r = exp(-exponent_r);
                    sum_u = sum_u + img2(i2,j2+1)*g_s*g_r;
                    sum_n = sum_n + g_s*g_r;
                    j2 = j2+1;

                elseif(112.5 < Tdir(i2,j2) < 157.5)
                    diff_r = img2(i2,j2) - img2(i2-1,j2+1);
                    exponent_r = (diff_r*diff_r)/(2*r_e*r_e);
                    g_r = exp(-exponent_r);
                    sum_u = sum_u + img2(i2-1,j2+1)*g_s*g_r;
                    sum_n = sum_n + g_s*g_r;
                    i2 = i2-1;
                    j2 = j2+1;

                elseif(Tdir(i2,j2) > 157.5 || Tdir(i2,j2) < -157.5)
                    diff_r = img2(i2,j2) - img2(i2-1,j2);
                    exponent_r = (diff_r*diff_r)/(2*r_e*r_e);
                    g_r = exp(-exponent_r);
                    sum_u = sum_u + img2(i2-1,j2)*g_s*g_r;
                    sum_n = sum_n + g_s*g_r;
                    i2 = i2-1;

                elseif(-157.5 < Tdir(i2,j2) < -112.5)
                    diff_r = img2(i2,j2) - img2(i2-1,j2-1);
                    exponent_r = (diff_r*diff_r)/(2*r_e*r_e);
                    g_r = exp(-exponent_r);
                    sum_u = sum_u + img2(i2-1,j2-1)*g_s*g_r;
                    sum_n = sum_n + g_s*g_r;
                    i2 = i2-1;
                    j2 = j2-1;

                elseif(-112.5 < Tdir(i2,j2) < -67.5)
                    diff_r = img2(i2,j2) - img2(i2,j2-1);
                    exponent_r = (diff_r*diff_r)/(2*r_e*r_e);
                    g_r = exp(-exponent_r);
                    sum_u = sum_u + img2(i2,j2-1)*g_s*g_r;
                    sum_n = sum_n + g_s*g_r;
                    j2 = j2-1;

                elseif(-67.5 < Tdir(i2,j2) < -22.5)
                    diff_r = img2(i2,j2) - img2(i2+1,j2-1);
                    exponent_r = (diff_r*diff_r)/(2*r_e*r_e);
                    g_r = exp(-exponent_r);
                    sum_u = sum_u + img2(i2+1,j2-1)*g_s*g_r;
                    sum_n = sum_n + g_s*g_r;
                    i2 = i2+1;
                    j2 = j2-1;
                end

                if(k == S+1)
                    c_i = i2;
                    c_j = j2;
                end
            end
            C_e2(c_i,c_j) = sum_u/sum_n;
        end
    end

    for i = 1:s2(1)-2*max_ST-1
        for j = 1:s2(2)-2*max_ST-1
            sum_u = 0;
            sum_n = 0;
            c_i = i;
            c_j = j;
            i2 = i;
            j2 = j;
            for k = 1:(2*T+1)
                exponent_s = ((k-T-1)*(k-T-1))/(2*sigma_g*sigma_g);
                g_s = exp(-exponent_s);
                if(-22.5 < Gdir(i2,j2) < 22.5)
                    diff_r = img2(i2,j2) - img2(i2+1,j2);
                    exponent_r = (diff_r*diff_r)/(2*r_g*r_g);
                    g_r = exp(-exponent_r);
                    sum_u = sum_u + img2(i2+1,j2)*g_s*g_r;
                    sum_n = sum_n + g_s*g_r;
                    i2 = i2+1;

                elseif(22.5 < Gdir(i2,j2) < 67.5)
                    diff_r = img2(i2,j2) - img2(i2+1,j2+1);
                    exponent_r = (diff_r*diff_r)/(2*r_g*r_g);
                    g_r = exp(-exponent_r);
                    sum_u = sum_u + img2(i2+1,j2+1)*g_s*g_r;
                    sum_n = sum_n + g_s*g_r;
                    i2 = i2+1;
                    j2 = j2+1;

                elseif(67.5 < Gdir(i2,j2) < 112.5)
                    diff_r = img2(i2,j2) - img2(i2,j2+1);
                    exponent_r = (diff_r*diff_r)/(2*r_g*r_g);
                    g_r = exp(-exponent_r);
                    sum_u = sum_u + img2(i2,j2+1)*g_s*g_r;
                    sum_n = sum_n + g_s*g_r;
                    j2 = j2+1;

                elseif(112.5 < Gdir(i2,j2) < 157.5)
                    diff_r = img2(i2,j2) - img2(i2-1,j2+1);
                    exponent_r = (diff_r*diff_r)/(2*r_g*r_g);
                    g_r = exp(-exponent_r);
                    sum_u = sum_u + img2(i2-1,j2+1)*g_s*g_r;
                    sum_n = sum_n + g_s*g_r;
                    i2 = i2-1;
                    j2 = j2+1;

                elseif(Gdir(i2,j2) > 157.5 || Gdir(i2,j2) < -157.5)
                    diff_r = img2(i2,j2) - img2(i2-1,j2);
                    exponent_r = (diff_r*diff_r)/(2*r_g*r_g);
                    g_r = exp(-exponent_r);
                    sum_u = sum_u + img2(i2-1,j2)*g_s*g_r;
                    sum_n = sum_n + g_s*g_r;
                    i2 = i2-1;

                elseif(-157.5 < Gdir(i2,j2) < -112.5)
                    diff_r = img2(i2,j2) - img2(i2-1,j2-1);
                    exponent_r = (diff_r*diff_r)/(2*r_g*r_g);
                    g_r = exp(-exponent_r);
                    sum_u = sum_u + img2(i2-1,j2-1)*g_s*g_r;
                    sum_n = sum_n + g_s*g_r;
                    i2 = i2-1;
                    j2 = j2-1;

                elseif(-112.5 < Gdir(i2,j2) < -67.5)
                    diff_r = img2(i2,j2) - img2(i2,j2-1);
                    exponent_r = (diff_r*diff_r)/(2*r_g*r_g);
                    g_r = exp(-exponent_r);
                    sum_u = sum_u + img2(i2,j2-1)*g_s*g_r;
                    sum_n = sum_n + g_s*g_r;
                    j2 = j2-1;

                elseif(-67.5 < Gdir(i2,j2) < -22.5)
                    diff_r = img2(i2,j2) - img2(i2+1,j2-1);
                    exponent_r = (diff_r*diff_r)/(2*r_g*r_g);
                    g_r = exp(-exponent_r);
                    sum_u = sum_u + img2(i2+1,j2-1)*g_s*g_r;
                    sum_n = sum_n + g_s*g_r;
                    i2 = i2+1;
                    j2 = j2-1;
                end

                if(k == T+1)
                    c_i = i2;
                    c_j = j2;
                end
            end
            C_g2(c_i,c_j) = sum_u/sum_n;
        end
    end
    C_e = zeros(s);
    C_g = zeros(s);
    i = 1:s(1);
    j = 1:s(2);
    C_e(i,j) = C_e2(i+max_ST+1,j+max_ST+1);
    C_g(i,j) = C_g2(i+max_ST+1,j+max_ST+1);
    
    if(mod(p,2) == 1)
        C = C_e;
    else
        C = C_g;
    end
    img = C;
end

imshow(uint8(img));














