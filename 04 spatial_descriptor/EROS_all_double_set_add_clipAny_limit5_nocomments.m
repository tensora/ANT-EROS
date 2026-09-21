function frame = ANTEROS(frame,x,y,kEROS,gGAUSS,hGAUSS,...
                         kGAUSS,r0,sGAUSS,setEvent,...
                         eventType,clipLevel)

    xMid = kEROS+1;
    yMid = kEROS+1;

    totalKernelSize = kEROS*2+1;
    decayKernel = ones(totalKernelSize);
   
    for xi=1:totalKernelSize
        for yi=1:totalKernelSize
            r = sqrt((xMid-xi)^2+(yMid-yi)^2);
            decayKernel(xi,yi) = 5/(1+exp(-(gGAUSS+hGAUSS*r...
                                 +kGAUSS*exp(-((r-r0)^2)/...
                                 (2*sGAUSS^2)))));
        end
    end

    xlimit = size(frame,2);
    ylimit = size(frame,1);

    eNr = size(x,1);

    for i = 1:eNr
        ex = x(i);
        ey = y(i);

        e_old = frame(ey,ex);

        wxmin = max(ex-kEROS, 1);
        wxmax = min(ex+kEROS, xlimit);
    
        wymin = max(ey-kEROS, 1);
        wymax = min(ey+kEROS, ylimit);

        limitedDecayKernel = limitedKernel(ex,ey,decayKernel,...
                                           frame);
        
        previousRegion = frame(wymin:wymax, wxmin:wxmax);
        newRegion = previousRegion.*limitedDecayKernel;

        frame(wymin:wymax, wxmin:wxmax) = min(newRegion,...
                                              clipLevel);

        if strcmp(eventType, 'set')
            frame(ey, ex) = min(setEvent,clipLevel);
        elseif strcmp(eventType, 'add')            
           addE = setEvent;
           frame(ey, ex) = min(e_old + addE,clipLevel);
        else
            error("q is NaN! Do not continue!")
        end

    end
end

function output = limitedKernel(midx,midy,smallFrame,bigFrame)

        midx = double(midx);
        midy = double(midy);

        N = size(smallFrame,1);
        radius = (N-1)/2;
        xlimit = size(bigFrame, 2);
        ylimit = size(bigFrame, 1);

        global_wxmin_unlimited = midx-radius;
        global_wxmax_unlimited = midx+radius;
        global_wymin_unlimited = midy-radius;
        global_wymax_unlimited = midy+radius;

        global_wxmin = max(midx-radius, 1);
        global_wxmax = min(midx+radius, xlimit);
        global_wymin = max(midy-radius, 1);
        global_wymax = min(midy+radius, ylimit);

        diff_xmin = global_wxmin_unlimited - global_wxmin;
        diff_xmax = global_wxmax_unlimited - global_wxmax;
        diff_ymin = global_wymin_unlimited - global_wymin;
        diff_ymax = global_wymax_unlimited - global_wymax;

        output = smallFrame(1-diff_ymin:N-diff_ymax,...
                            1-diff_xmin:N-diff_xmax);

end
