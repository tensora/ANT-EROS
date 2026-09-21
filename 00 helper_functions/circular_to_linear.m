function linear_t = circular_to_linear(in_t,mint,maxt)

    %Takes a circular time vector circular_t = [1 1 5 7  2  2  5  7  0  1  2 10  0  0  2 10]'
    %and makes it linear            linear_t = [0 0 4 6 12 12 15 17 21 22 23 31 32 32 34 42]'
    %mint and maxt define the max and min values in the time array.

    circular_t = double(in_t);

    length = size(circular_t,1);

    linear_t = zeros(size(circular_t));

    for i = 1:length-1
        
        current_t = linear_t(i);

        diff = circular_t(i+1)-circular_t(i);

        if(diff>=0)
            next_t = current_t + diff;
        else
            part1 = maxt - circular_t(i);
            part2 = circular_t(i+1) + 1;
            next_t = current_t + part1 + part2;
        end
        linear_t(i+1) = next_t;

    end

end