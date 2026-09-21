function output = scaleConverter(input,minIn,maxIn,minOut,maxOut)

output = ((maxOut-minOut)/(maxIn-minIn))*(input-maxIn)+maxOut;

end