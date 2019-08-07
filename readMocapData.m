function data = readMocapData(datafolder)

    if nargin == 0
        datafolder = './data/';
    end


    files = dir([datafolder '*.mat']);
    
    for i = 1:length(files)
        
        data(i) = mcread([datafolder files(i).name]);
        
    end
    

end