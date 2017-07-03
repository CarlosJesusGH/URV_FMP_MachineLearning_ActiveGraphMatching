function []=coordinatorChanges(NI,ind,bestKeypoint,keypointChanged,folderInput,folderOutput,resolution,paths)

for ii=1:NI(ind(1))
    %increment for bestkeypoints structure
    inc=4*(ii-1);
    
    %all points (new/old) of the ii-th image
    keyOrig=[bestKeypoint(:,3+inc),bestKeypoint(:,4+inc)];
    KeyNew=[keypointChanged(:,3+inc),keypointChanged(:,4+inc)];
    
    %file extract
    system(sprintf('%s;gzip -d kermit00%d.key.gz"',paths,bestKeypoint(1,1+inc)));
    
    %file to open
    inputfile=sprintf('%s/kermit00%d.key',folderInput,bestKeypoint(1,1+inc));
    outputfile=sprintf('%s/kermit00%d.key',folderOutput,bestKeypoint(1,1+inc));
    
    %point adaptation
    keyOrig(:,1)=resolution(1)/2+keyOrig(:,1);
    keyOrig(:,2)=resolution(2)/2-keyOrig(:,2)-1;
    
    KeyNew(:,1)=resolution(1)/2+KeyNew(:,1);
    KeyNew(:,2)=resolution(2)/2-KeyNew(:,2)-1;
    
    %control key before overwrite
    key=bestKeypoint(:,2+inc);
    disp('prima_w')
    %writting
    writeOnIt(keyOrig,KeyNew,key,inputfile,outputfile);
    disp('dopo_w')
    %zip
    path=sprintf('%s/human',paths);
    system(sprintf('%s;gzip kermit00%d.key kermit00%d.key.gz"',path,bestKeypoint(1,1+inc),bestKeypoint(1,1+inc)));
    system(sprintf('%s/..;rm kermit00%d.key"',path,bestKeypoint(1,1+inc)));
    system(sprintf('%s;mv kermit00%d.key.gz ../"',path,bestKeypoint(1,1+inc)));

end
    
end