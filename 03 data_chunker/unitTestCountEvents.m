function success = unitTestCountEvents()

    success = [false,false,false,false];

    A1in = [1,2,2,3,4,4,6,8];
    A1out = [1,2,1,2,0,1,0,1]';
    success(1) = isequal( countEvents(A1in), A1out );
    
    A2in = [10,10,10,14,14,14,15,16,20,21,21];
    A2out = [3,0,0,0,3,1,1,0,0,0,1,2]';
    success(2) = isequal( countEvents(A2in), A2out );

    A3in = [0];
    A3out = [1];
    success(3) = isequal( countEvents(A3in), A3out );
    
    A4in = [10,14,14,14,15,16,20,21,21,21]';
    A4out = [1,0,0,0,3,1,1,0,0,0,1,3]';
    A4outF = countEvents(A4in);
    success(4) = isequal( A4outF, A4out );

    if all(success)
        fprintf('Testing of <countEvents()> was successful!')
    else
        fprintf('Testing of <countEvents()> was NOT successful...')
    end
end