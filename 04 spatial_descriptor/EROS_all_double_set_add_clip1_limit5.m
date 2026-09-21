function frame = EROS_all_double_set_add_clip1_limit5(frame,x,y,kEROS,gGAUSS,hGAUSS,kGAUSS,r0,sGAUSS,setEvent,kEVENT,setEventTilt,mEVENT,eventType)

    %IMPORTANT: save the event in every loop so that it is not overwritten
    %By the masks!!!

    %ALSO important!! The surface place for the incoming event is set to NAN!! this saves it from
    %faulty code trying to add something to it. This is very confusing but
    %saves my program from a strange bug where my fluffy kernel tries to
    %add itself when it has radius 0. It should actually be turned
    %off!!!

    %decayKernel = gaussianKernel(kEROS,gGAUSS,hGAUSS,kGAUSS,r0,sGAUSS);
    %frame: double [n x m]
    %x: uint16 [n x 1]
    %y: uint16 [n x 1]
    %kEROS double
    %hGAUSS double
    %kGAUSS double
    %r0 double
    %sGAUSS double
    %setEvent double

    %OBS: these 3 fluffy edges variables are removed to make things easier.
    %Look at older versions if you need them!
    %kEVENT double
    %setEventTilt double
    %mEvent double

    %eventType = chararray [1xn]

    %Used for adding or setting an event.
    q = NaN;
    switch eventType
        case 'set'
            q = 1;

        case 'add' 
            q = 0;

        otherwise
            q = NaN;
            error('Unknown processing method: %s', eventType);
            
    end


    xMid = kEROS+1;
    yMid = kEROS+1;

    totalKernelSize = kEROS*2+1;
    decayKernel = ones(totalKernelSize);
   
    
    for xi=1:totalKernelSize
        for yi=1:totalKernelSize
            %Can be effectivisized maybe by not recalculating for every
            %point. Also vectorize possible but not so critical.
            r = sqrt((xMid-xi)^2+(yMid-yi)^2);
            decayKernel(xi,yi) = 5/( 1 + exp( -( gGAUSS + hGAUSS*r + kGAUSS*exp(-( (r - r0)^2 )/(2*sGAUSS^2) ) ) ) );
        end
    end

    % %generate an event with fluffy edges
    % kEVENTMid = kEVENT+1;
    % eventTotalSize = kEVENT*2+1;
    % eventKernel = ones(eventTotalSize);
    % for exi=1:eventTotalSize
    %     for eyi=1:eventTotalSize
    %         r = sqrt((kEVENTMid-exi)^2+(kEVENTMid-eyi)^2);
    %         %eventKernel(exi,eyi) = r*setEventTilt + setEvent;
    %         eventKernel(exi,eyi) = 5/( 1 + exp( -( r*setEventTilt + mEVENT ) ) );
    %     end
    % end

    
    xlimit = size(frame,2);
    ylimit = size(frame,1);

    eNr = size(x,1);

    for i = 1:eNr
        ex = x(i);
        ey = y(i);

        %IMPORTANT: save the event. Otherwise the two masks overwrite it!
        e_old = frame(ey,ex);

        %Limit the X-scale windows
        wxmin = max(ex-kEROS, 1);
        wxmax = min(ex+kEROS, xlimit);
    
        %Limit the Y-scale windows
        wymin = max(ey-kEROS, 1);
        wymax = min(ey+kEROS, ylimit);

        limitedDecayKernel = limitedKernel(ex,ey,decayKernel,frame);
        
        %Multiply a submatrix block with the total decay for both
        %polarities.
        previousRegion = frame(wymin:wymax, wxmin:wxmax);
        newRegion = previousRegion.*limitedDecayKernel;

        %We clip the regio to max 1 for every event update!!
        frame(wymin:wymax, wxmin:wxmax) = min(newRegion,1);

        % %%%%THIS IS CODE FOR ADDING A variable even
        % What? FOr fluffy edges right?
        % 
        % %Limit the X-scale windows
        % wxmin2 = max(ex-kEVENT, 1);
        % wxmax2 = min(ex+kEVENT, xlimit);
        % 
        % %Limit the Y-scale windows
        % wymin2 = max(ey-kEVENT, 1);
        % wymax2 = min(ey+kEVENT, ylimit);
        % 
        % limitedEventKernel = limitedKernel(ex,ey,eventKernel,frame);
        % previousRegion = frame(wymin2:wymax2, wxmin2:wxmax2);
        % newRegion = previousRegion+limitedEventKernel;
        % frame(wymin2:wymax2, wxmin2:wxmax2) = newRegion;


        %SET: overwrite the existing value with value in setEvent
        if q == 1
            %clip here also!
            frame(ey, ex) = min(setEvent,1);
        
        %ADD:add the value in setEvent to the existing value
        elseif q == 0
           addE = setEvent;
           %clip here tooo
           frame(ey, ex) = min(e_old + addE,1);
        else
            error("q is NaN! Do not continue!")
        end

        %  if i == 100000
        %      ibreak = i;
        % end

    end
    %limiting the max values to one, pretty fast function.
    %seems to be a bit problematic to set events = 1 or bigger
    %result should maybe be limited between every event instead of in the
    %end of the frame?
    %frame = min(frame,1);
    endingLoop = true;
end
