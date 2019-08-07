
q = a(5);
w = a(6);


minFrames = min(q.nFrames,w.nFrames);


distance = q.data(1:minFrames,:)-w.data(1:minFrames,:);
distance = nansum(nansum(distance));





for f = 1:minFrames
    for m = 1:q.nMarkers
        
        
        d(f,m) = (q.data(f,m*3-2)-w.data(f,m*3-2))^2 + (q.data(f,m*3-1)-w.data(f,m*3-1))^2 + (q.data(f,m*3)-w.data(f,m*3))^2;
        
        
    end
    
end

nansum(nansum(d/q.nFrames/q.nMarkers))