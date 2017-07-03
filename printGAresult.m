function printGAresult( parameters )
filename = fopen('result.txt','a');
fprintf(filename, '%3.5f\t %3.5f\t %3.5f\t %3.5f\t %3.5f\t %3.5f\n',parameters(1), parameters(2), ...
parameters(3), parameters(4), parameters(5), parameters(6));

fclose(filename);
end