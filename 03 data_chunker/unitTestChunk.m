function success = unitTestChunk()
%Chunks together a 1-dim vector by summing together a static nr of
%elements (chunkSize). It throws away the end if the vector is too short.

    success = [false,false,false,false,false];

    A1in = [1,2,2,3,4,4,6,8];
    A1in2 = 2;
    A1out = [3,5,8,14]';
    success(1) = isequal( chunk(A1in,A1in2), A1out );
    
    A2in = [0,2,2,3,4,4,6,8,0,1];
    A2in2 = 4;
    A2out = [7,22]';
    A2outF = chunk(A2in,A2in2);
    success(2) = isequal( A2outF, A2out );
 
    A3in = [0,2,2,3,4,4,6,8,0,1];
    A3in2 = 10;
    A3out = [30];
    A3outF = chunk(A3in,A3in2);
    success(3) = isequal( A3outF, A3out );
  
    A4in = [0,2,2,3,4,4,6,8,0,1];
    A4in2 = 11;
    A4out = zeros(1,0)';
    A4outF = chunk(A4in,A4in2);
    success(4) = isequal( A4outF, A4out );

    A5in = [0,2,2,3,4,4,6,8,0,1]';
    A5in2 = 4;
    A5out = [7,22]';
    A5outF = chunk(A5in,A5in2);
    success(5) = isequal( A5outF, A5out );

    if all(success)
        fprintf('Testing of <chunk()> was successful!')
    else
        fprintf('Testing of <chunk()> was NOT successful...')
    end


end