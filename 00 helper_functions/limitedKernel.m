function output = limitedKernel(midx,midy,smallFrame,bigFrame)

        midx = double(midx);
        midy = double(midy);

        N = size(smallFrame,1);
        radius = (N-1)/2;
        xlimit = size(bigFrame, 2);
        ylimit = size(bigFrame, 1);

        %1.) Unlimited global small frame limits.
        global_wxmin_unlimited = midx-radius;
        global_wxmax_unlimited = midx+radius;
        global_wymin_unlimited = midy-radius;
        global_wymax_unlimited = midy+radius;

        %2.) Limited global small frame limits.
        global_wxmin = max(midx-radius, 1);
        global_wxmax = min(midx+radius, xlimit);
        global_wymin = max(midy-radius, 1);
        global_wymax = min(midy+radius, ylimit);

        %3.) Calculate differences
        diff_xmin = global_wxmin_unlimited - global_wxmin;
        diff_xmax = global_wxmax_unlimited - global_wxmax;
        diff_ymin = global_wymin_unlimited - global_wymin;
        diff_ymax = global_wymax_unlimited - global_wymax;

        output = smallFrame(1-diff_ymin:N-diff_ymax,1-diff_xmin:N-diff_xmax);

end