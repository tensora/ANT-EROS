function success = test_everything()
    success = 0;


    % TEST 1 START ===========================
    prevProcessedFrame = zeros(5,5);

    x_data_uint16 = uint16(ones(2,1)*3);
    y_data_uint16 = uint16(ones(2,1)*3);


    %multiplicative parameters
    kEROS = 2; %radius size
    gGAUSS = -2.2;
    hGAUSS = 0;
    kGAUSS = 0;
    r0 = 0;
    sGAUSS = 0.0;

    %event value
    setEvent = 0.1;

    %additive parameters
    kEVENT = 1; %radius size
    setEventTilt = 0;
    mEVENT = -3.9;

    eventType = 'add';

    processedFrame = EROS_all_double_setaddKernel_limit5(prevProcessedFrame,...
                         x_data_uint16, y_data_uint16,...
                         kEROS,gGAUSS,hGAUSS,kGAUSS,r0,sGAUSS,setEvent,kEVENT,setEventTilt,mEVENT,...
                         eventType);

    expectedFrame1 = [0 0 0 0 0;
                      0 0.1487 0.1487 0.1487 0;
                      0 0.1487 0.2 0.1487 0;
                      0 0.1487 0.1487 0.1487 0;
                      0 0 0 0 0];

    success = isequal( round(processedFrame,4), round(expectedFrame1,4) );
    % TEST 1 END ===========================


end