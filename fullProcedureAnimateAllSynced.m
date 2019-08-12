
disp('reading data..')
data = mcarrayRead('../MacarenaData/');


for i = 1:length(data)
    data(i) = reorderMarkers(data(i)); %make sure that marer order is equal across the set, and remove right offset marker 
    data(i).data(1:400,:) = []; %removing first 400 frames
    data(i).nFrames = data(i).nFrames-400;
    data(i).syncpoint = 0; 
end

%%
disp('syncing...')
data = mcarraySyncWindowed(data,0,4000); %masterIndex (second argument) = 0, means that the dataset will be synced to the average across the set.


%%
disp('trimming...')
data = mcarrayTrimSyncedData(data);


%%
disp('marker-to-joint mapping...')
m2jpar = mcinitm2jpar; %help struct to specify marker-2-joint mapping
m2jpar.markerNum = {[1 1 2 3],[4 5],6,7,8,9,10,11,12,13,14,[15 15 16 17],16,18,20,22,17,19,21,23};
m2jpar.markerName = {'Head','neck','lsho','lelb','lwri','lhan','rsho','relb','rwri','rhan','t10','root','lhip','lknee','lank','lfoot','rhip','rknee','rank','rfoot'};
m2jpar.nMarkers = 20;


for i = 1:length(data)
    data(i) = mcm2j(data(i),m2jpar);
end


%%
disp('animating')
close all

apar = mcinitanimpar('3d'); %3d version
apar.conn = [1 2;2 3;3 4;4 5;5 6;2 7;7 8;8 9;9 10;2 11;11 12;12 13;13 14;14 15;15 16;12 17;17 18;18 19;19 20];
apar.cwidth = 1; %connection (bone) width
apar.msize = 2;  %marker size
apar.colors = 'kbwww'; % black, blue, white, white, white
apar.animate = 1;
apar.videoformat = 'mp4';
apar.fps= 15;

apar.par3D.drawfloor = 1;
apar.par3D.floorimage = 'woodenfloor.jpg';
apar.par3D.shadowalpha = 0;

apar.scrsize = [700 450];
apar.par3D.cameraposition = [45000,6000,25000];
apar.output = ['MacarenaVideo' num2str(randi(9999))];

mcarrayAnimate(data,apar,0.5,10) %arguments are: data array, animation parameter struct, distance between avatars, number of avatar rows 
