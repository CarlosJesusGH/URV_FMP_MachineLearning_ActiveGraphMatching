function []=coordinatorAdapted(keyOrig,keyNew,key,inputFile,outputFile)

fin = fopen(inputFile);
fout = fopen(outputFile,'wt');

jj=1;
ii=0;
while ~feof(fin)
    s = fgetl(fin);
    
    for ii=1:size(keyOrig,1)
        cond=size(strfind(s,sprintf('%3.2f', keyOrig(ii,1))),2)+size(strfind(s,sprintf('%3.2f', keyOrig(ii,2))),2);
        
        if cond > 1 && jj==(key(ii)*8+2)
   
            s = strrep(s,sprintf('%3.2f', keyOrig(ii,1)),sprintf('%3.2f', keyNew(ii,1)));
            s = strrep(s,sprintf('%3.2f', keyOrig(ii,2)),sprintf('%3.2f', keyNew(ii,2)));
            
            ii=ii+1;
        end
    end
    jj=jj+1;
    fprintf(fout,'%s\n',s);
    
end

fclose(fin);
fclose(fout);
end