
function b = reorderMarkers(a,markerOrderTemplate)
%Reorders the markers in the mocap struct. If any
%markers are missing, insert empty (NaN) marker 
%
% TODO: allow path and file name of 'correctMarkerOrder.csv' to be specified as input argument to the function

try
    %correctmarkers = importdata('correctMarkerOrderDrums.csv');
    correctmarkers = importdata(markerOrderTemplate);
catch
    disp('WARNING: correctMarkerOrder.csv not found. Using defaults.')
    %correctmarkers = {'RFHD'; 'LFHD'; 'LBHD'; 'RBHD'; 'C7'; 'LBK'; 'STRN'; 'RSHO'; 'LSHO'; 'RELB'; 'LELB'; 'RWRI'; 'LWRI'; 'RHAND'; 'LHAND'; 'RSB'; 'RST'; 'LSB'; 'LST'; 'RKNEE'; 'LKNEE'; 'RHEEL'; 'RTOE'; 'LHEEL'; 'LTOE'; 'HHL'; 'HHR'; 'HHT'; 'SNL'; 'SNR'; 'SNT'; 'BTB'; 'BTT'};
    macarenaMarkers = {'FHD'; 'RBHD'; 'LBHD'; 'CLAV'; 'C7';'RSHO'; 'RELB'; 'RWR';'RFIN';'LSHO'; 'LELB'; 'LWR'; 'LFIN'; 'T10';'ROOT'; 'RHIP'; 'LHIP'; 'RKNEE'; 'LKNEE';'RANKLE';'LANKLE';'RTOE'; 'LTOE'};
    %macarenaMarkersFull = {'FHD'; 'RBHD'; 'LBHD'; 'CLAV'; 'C7';'RSHO' ; 'RELB'  ; 'RWR';'RFIN' ;'LSHO' ; 'LELB'; 'LWR' ; 'LFIN'; 'RBACK'; 'T10';'ROOT'; 'RHIP'; 'LHIP' ; 'RKNEE'; 'LKNEE';'RANKLE';'LANKLE';'RTOE'; 'LTOE'};

    correctmarkers = macarenaMarkers
end



for i = 1:length(correctmarkers)
    d(i)=max([0,find(strcmp(correctmarkers(i),a.markerName))]);
end

a.data(1:a.nFrames,(a.nMarkers*3+1):(length(correctmarkers)*3)) = NaN;
a.markerName((a.nMarkers+1):length(correctmarkers)) = correctmarkers(d==0);
d(d==0)=(a.nMarkers+1):length(correctmarkers);
%a.nMarkers = length(correctmarkers);

b= mcconcatenate(a,d);


end
