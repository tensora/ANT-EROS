function array_out = countEvents(array_in)
%Counts occcurences of numbers in order and adds zeros when a number is
%missing.
%
%Example:
%IN = [1,2,2,3,4,4,6,8] (input can be both row or column matrix)
%OUT = [1,2,1,2,0,1,0,1]' (returns a column matrix)

    timespan = array_in(end)-array_in(1)+1;
    array_out = zeros(1,timespan);
    e = 0;
    j = 1;
    aSize = max(size(array_in));
    
    for i = 1:aSize
        a = array_in(i);
        b = array_in( min(i+1,aSize) );
        d = b - a;
        
        %add event counts
        if a == b
            e = e + 1;
        else
            e = e + 1;
            array_out(j) = e;
            j = j + 1;
            e = 0;
        end

        %add zeros
        if(d>1)
            for k = 1:d-1;
                array_out(j) = 0;
                j = j + 1;
            end
        end

    end
    
    array_out(j) = e;
    j = j + 1;

    array_out = array_out';
end



