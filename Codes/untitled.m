 fct =1 ;
        for f=1:2*T+1
            if ((angle >= -22.5) && (angle <= 22.5) ) 
                %for q = -S:S
                    %imgline(1,q+S+1) = image(u+q,v);
                    imgline(1,fct) = image(u+1,v);
                %end
            elseif ( angle <=-157.5) || (angle >= 157.5)
                    
                    imgline(1,fct) = image(u-1,v);

            elseif ((angle >= 22.5) && (angle <= 67.5) )
                %for q = -S:S
                    imgline(1,fct) = image(u+1,v+1);
                %end

            elseif (-157.5< angle < -112.5)
                
                    imgline(1,fct) = image(u-1,v-1);
                
            elseif (angle >= 67.5) && (angle <= 90)   
                %for q = -S:S
                    imgline(1,fct) = image(u,v+1);
                %end
                
            elseif (angle <= -67.5) && (angle >= -90)
                    
                    imgline(1,fct) = image(u,v+1);
            
            elseif (angle >= -67.5) && (angle <= -22.5)  
                %for q = -S:S
                    imgline(1,fct) = image(u+1,v-1);
                %end

            elseif ( 112.5 < angle < 157.5)
                
                    imgline(1,fct) = image(u-1,v+1);
            end;
             fct = fct+1;
        end
        
        
        if (((angle >= -22.5) && (angle <= 22.5) )||( angle <=-157.5) || (angle >= 157.5)) 
            for q = -T:T
                imgline(1,q+T+1) = image(u+q,v);
            end
            
        elseif (((angle >= 22.5) && (angle <= 67.5) )|| ( -157.5< angle < -112.5))
            for q = -T:T
                imgline(1,q+T+1) = image(u+q,v+q);
            end
           
        elseif ((angle >= 67.5) && (angle <= 112.5) ||  (angle <= -67.5) && (angle >= -112.5))
             for q = -T:T
                imgline(1,q+T+1) = image(u,v+q);
            end
        
        elseif ((angle >= -67.5) && (angle <= -22.5) || ( 112.5 < angle < 157.5))
             for q = -T:T
                imgline(1,q+T+1) = image(u+q,v-q);
            end
        end;
        
        
        
         fct =1 ;
        for f=1:2*T+1
            if ((angle >= -22.5) && (angle <= 22.5) ) 
                %for q = -S:S
                    %imgline(1,q+S+1) = image(u+q,v);
                    imgline(1,fct) = image(u+1,v);
                    if(f == T+1)
                        xc=u+1;
                        yc=v;
                    end
                    %end
            elseif ( angle <=-157.5) || (angle >= 157.5)
                    
                    imgline(1,fct) = image(u-1,v);
                    if(f == T+1)
                        xc=u-1;
                        yc=v;
                    end
                    
            elseif ((angle >= 22.5) && (angle <= 67.5) )
                %for q = -S:S
                    imgline(1,fct) = image(u+1,v+1);
                    if(f == T+1)
                        xc=u+1;
                        yc=v+1;
                    end
                    %end

            elseif (-157.5< angle < -112.5)
                
                    imgline(1,fct) = image(u-1,v-1);
                    if(f == T+1)
                        xc=u-1;
                        yc=v-1;
                    end
                    
            elseif (angle >= 67.5) && (angle <= 90)   
                %for q = -S:S
                    imgline(1,fct) = image(u,v+1);
                    if(f == T+1)
                        xc=u;
                        yc=v+1;
                    end
                    %end
                
            elseif (angle <= -67.5) && (angle >= -90)
                    
                    imgline(1,fct) = image(u,v-1);
                    if(f == T+1)
                        xc=u;
                        yc=v-1;
                    end
                    
            elseif (angle >= -67.5) && (angle <= -22.5)  
                %for q = -S:S
                    imgline(1,fct) = image(u+1,v-1);
                    if(f == T+1)
                        xc=u+1;
                        yc=v-1;
                    end
                    %end

            elseif ( 112.5 < angle < 157.5)
                
                    imgline(1,fct) = image(u-1,v+1);
                    if(f == T+1)
                        xc=u-1;
                        yc=v+1;
                    end
            end;
             fct = fct+1;
        end