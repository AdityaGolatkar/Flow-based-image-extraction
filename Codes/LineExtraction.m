function [] = LineExtraction2(sigma_m,sigma_c)
img = imread('einstein.jpg');
sz = size(img);
sigma_s = 1.6*sigma_c;
T = floor(3*sigma_s);
S = floor(3*sigma_m);
max_ST = max(S,T);
%win = 7;
win = 2*max_ST + 1;
winby2 = floor(win/2);
[t,image] = ETF(img,win);
%[Tx, Ty, image] = myETF(img,win,0.2);
%sz_t = size(Tx);
%s_t = [sz_t(1) sz_t(2) 2];
%t = zeros(s_t);
%t(:,:,1) = Tx;
%t(:,:,2) = Ty;
%[image , t(:,:,1),t(:,:,2)] = myETF(img,11,1);
sz2 = size(image);
tau1 = 0.5;
tau2 = 0.9;
rho = 0.999;
g(:,:,1) = t(:,:,2);
g(:,:,2) = -t(:,:,1);
H_g = zeros(size(image));

[gmag ,gdir] = imgradient(g(:,:,1),g(:,:,2));
[tmag ,tdir] = imgradient(t(:,:,1),t(:,:,2));
%imshow(tmag);
%imshow(tdir);
%result = zeros(sz);
%thresh = max(tmag(:))/300;

%for v= winby2 +1: winby2 +sz(2)
%	for u = winby2+1:winby2+sz(1)
%    if tmag(u,v) < thresh
%        result(u,v) = 256;
%    end
%    end
%end
%imshow(result);
        
for run = 1:1
    imgline = zeros(1,2*T+1);
    for v= 1: sz2(2)-2*max_ST-1
        for u = 1:sz2(1)-2*max_ST-1
            %angle = atan2d(g(u,v,2),g(u,v,1)); 
            %angle = tdir(u,v);
            sin = -T:T;
             f(1:2*T+1) = normpdf(sin,0,sigma_c) - rho*normpdf(sin,0,sigma_s);
            fct =1 ;
            u2 = u;
            v2 = v;
            xc = u;
            yc = v;
            for f=1:2*T+1
                angle = gdir(u2,v2);
                if ((angle >= -22.5) && (angle <= 22.5) ) 
                    %for q = -S:S
                        %flowline(1,q+S+1) = H_g(u+q,v);
                        if(f == T+1)
                            xc=u2+1;
                            yc=v2;
                        end
                        imgline(1,fct) = image(u2+1,v2);
                        u2 = u2+1;
                    %end
                elseif ( angle <=-157.5) || (angle >= 157.5)

                        imgline(1,fct) = image(u2-1,v2);
                        if(f == t+1)
                            xc=u2-1;
                            yc=v2;
                        end
                        u2 = u2-1;
                        
                elseif ((angle >= 22.5) && (angle <= 67.5) )
                    %for q = -S:S
                        imgline(1,fct) = image(u2+1,v2+1);
                        if(f == T+1)
                            xc=u2+1;
                            yc=v2+1;
                        end
                        u2 = u2+1;
                        v2 = v2+1;
                    %end

                elseif (-157.5< angle < -112.5)

                        imgline(1,fct) = image(u2-1,v2-1);
                        if(f == T+1)
                            xc=u2-1;
                            yc=v2-1;
                        end
                        u2 = u2-1;
                        v2 = v2-1;
                        
                elseif (angle >= 67.5) && (angle <= 112.5)   
                    %for q = -S:S
                        imgline(1,fct) = image(u2,v2+1);
                        if(f == T+1)
                            xc=u2;
                            yc=v2+1;
                        end
                    %end
                        v2 = v2+1;
                        
                elseif (angle <= -67.5) && (angle >= -112.5)

                        imgline(1,fct) = image(u2,v2-1);
                        if(f == T+1)
                            xc=u2;
                            yc=v2-1;
                        end
                        v2 = v2-1;
                        
                elseif (angle >= -67.5) && (angle <= -22.5)  
                    %for q = -S:S
                        imgline(1,fct) = image(u2+1,v2-1);
                        if(f == T+1)
                            xc=u2+1;
                            yc=v2-1;
                        end
                    %end
                        u2 = u2+1;
                        v2 = v2-1;
                        
                elseif ( 112.5 < angle && angle < 157.5)

                        imgline(1,fct) = image(u2-1,v2+1);
                        if(f == T+1)
                            xc=u2-1;
                            yc=v2+1;
                        end
                        u2 = u2-1;
                        v2 = v2+1;
                end;
                 fct = fct+1;
            end

            temp = f.*imgline;
            H_g(xc,yc) = sum(temp(:));
        end
    end
    
    %imshow(H_g);
    
    flowline = zeros(1,2*S+1);
    H_e = zeros(size(image));
    %for v= winby2 +1: winby2 +sz(2)
     %   for u = winby2+1:winby2+sz(1)
    for v= 1: sz2(2)-2*max_ST-1
        for u = 1:sz2(1)-2*max_ST-1
            %angle = atan2d(t(u,v,2),t(u,v,1)); 
            %angle = tdir(u,v);
            sin = -S:S;
            g_sigma_m(1:2*S+1) = normpdf(sin,0,sigma_m);
            fct =1 ;
            u2 = u;
            v2 = v;
            xc = u;
            yc = v;
            for f=1:2*S+1
                angle = tdir(u2,v2);
                if ((angle >= -22.5) && (angle <= 22.5) ) 
                    %for q = -S:S
                        %flowline(1,q+S+1) = H_g(u+q,v);
                        if(f == S+1)
                            xc=u2+1;
                            yc=v2;
                        end
                        flowline(1,fct) = H_g(u2+1,v2);
                        u2 = u2+1;
                    %end
                elseif ( angle <=-157.5) || (angle >= 157.5)

                        flowline(1,fct) = H_g(u2-1,v2);
                        if(f == S+1)
                            xc=u2-1;
                            yc=v2;
                        end
                        u2 = u2-1;
                        
                elseif ((angle >= 22.5) && (angle <= 67.5) )
                    %for q = -S:S
                        flowline(1,fct) = H_g(u2+1,v2+1);
                        if(f == S+1)
                            xc=u2+1;
                            yc=v2+1;
                        end
                        u2 = u2+1;
                        v2 = v2+1;
                    %end

                elseif (-157.5< angle < -112.5)

                        flowline(1,fct) = H_g(u2-1,v2-1);
                        if(f == S+1)
                            xc=u2-1;
                            yc=v2-1;
                        end
                        u2 = u2-1;
                        v2 = v2-1;
                        
                elseif (angle >= 67.5) && (angle <= 112.5)   
                    %for q = -S:S
                        flowline(1,fct) = H_g(u2,v2+1);
                        if(f == S+1)
                            xc=u2;
                            yc=v2+1;
                        end
                    %end
                        v2 = v2+1;
                        
                elseif (angle <= -67.5) && (angle >= -112.5)

                        flowline(1,fct) = H_g(u2,v2-1);
                        if(f == S+1)
                            xc=u2;
                            yc=v2-1;
                        end
                        v2 = v2-1;
                        
                elseif (angle >= -67.5) && (angle <= -22.5)  
                    %for q = -S:S
                        flowline(1,fct) = H_g(u2+1,v2-1);
                        if(f == S+1)
                            xc=u2+1;
                            yc=v2-1;
                        end
                    %end
                        u2 = u2+1;
                        v2 = v2-1;
                        
                elseif ( 112.5 < angle && angle < 157.5)

                        flowline(1,fct) = H_g(u2-1,v2+1);
                        if(f == S+1)
                            xc=u2-1;
                            yc=v2+1;
                        end
                        u2 = u2-1;
                        v2 = v2+1;
                end;
                 fct = fct+1;
            end

            temp = g_sigma_m.*flowline;
            H_e(xc,yc) = sum(temp(:));
        end
    end
    %save('file.txt',H_e);
    %%imshow(H_e);
    %H_e
    linedimg = zeros(size(image));
    for v= winby2 +1: winby2 +sz(2)
        for u = winby2+1:winby2+sz(1)
            if((H_e(u,v) < 10.^-15 )) %%&& (1+tanh(H_e(u,v)) <0.5)) %%tau1))
            %%if((H_e(u,v) < 0) ||(H_e(u,v) > 0 && tanh(H_e(u,v)) < 0.8))
            %%if(H_e(u,v) <= 0.0001) 
                linedimg(u,v) = 0;
            else
                linedimg(u,v) = 255;
            end
        end
    end
    image = (image.*linedimg)/255;
end
s = size(img);
image_op = zeros(s);
i = 1:s(1);
j = 1:s(2);
image_op(i,j) = linedimg(i+winby2,j+winby2);
imshow(uint8(image_op));


