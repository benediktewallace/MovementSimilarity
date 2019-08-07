clear,clc,close all


data = readMocapData('../MacarenaData/');


%select only one recording for now...
a = data(14);
a = mcrotate(a,80);

a = reorderMarkers(a);

anipar = mcinitanimpar;

anipar.showmnum = 1;
anipar.conn = [1 2;2 3;3 1;2 4; 3 4;4 6; 4 10; 5 6; 5 10; 6 7; 7 8; 8 9;10 11; 11 12; 12 13; 5 14; 14 15; 15 16; 15 18; 15 19; 16 17; 15 17; 4 16; 4 17; 16 18; 18 20; 20 22; 17 19; 19 21; 21 23;];

%mcplotframe(a,1500,anipar)


m2jpar = mcinitm2jpar; %help struct to specify marker-2-joint mapping

m2jpar.markerNum = {[1 1 2 3],[4 5],6,7,8,9,10,11,12,13,14,[15 15 16 17],16,18,20,22,17,19,21,23};
m2jpar.markerName = {'Head','neck','lsho','lelb','lwri','lhan','rsho','relb','rwri','rhan','t10','root','lhip','lknee','lank','lfoot','rhip','rknee','rank','rfoot'};
m2jpar.nMarkers = 20;

aj = mcm2j(a,m2jpar); %convert from markers to joints


%set up animation parameter struct 
aniparj = mcinitanimpar;%('3D');
aniparj.showmnum = 1;
aniparj.conn = [1 2;2 3;3 4;4 5;5 6;2 7;7 8;8 9;9 10;2 11;11 12;12 13;13 14;14 15;15 16;12 17;17 18;18 19;19 20];


%mcplot3Dframe(aj,1500,aniparj)
%mcplotframe(aj,1500,aniparj)

%Now let's convert our data to segments


%initiate a joint-to-segment parameter struct
j2spar = mcinitj2spar;
j2spar.rootMarker = [12];
j2spar.frontalPlane  = [1 3 7];
j2spar.parent = [2, 11, 2, 3, 4, 5, 2, 7, 8, 9, 12, 0, 12, 13, 14, 15, 12, 17, 18, 19];
      %          1   2  3  4  5  6  7  8  9  10 11  12 13  14  15  16  17  18  19, 20
j2spar.segmentName = {'neck','upperBack','leftshoulder','leftupperarm','leftlowerarm','lefthand','rightsoulder','righupperarm','rightlowerarm','righthand','lowerback','lefthip','leftthigh','leftcalf','leftfoot','rigthhip','rghtthigh','rightcalf','rigthfoot'}; 

%convert to a segment structure
ajs = mcj2s(aj,j2spar);





%mc2frontal()
%mcrotate()

