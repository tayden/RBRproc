function ctd = blankRBRstruct(n);

% Creates empty structure with correct fields for use with RBRproc
% functions.
%
%  usage:  
% 
%      ctd = blankRBRstruct(n);
%
%   where n specifies the number of profiles.
%
%  Mark Halverson, June 28, 2016

if nargin==0,
    n = 1;
end


ctd = struct('fileName',[],...
             'serialID',[],...
             'model',[],...
             'samplingPeriod',[],...
             'mtime',[],...
             'tzone',[],...
             'Latitude',[],...
             'Longitude',[],...
             'Station',[],...
             'BottomDepth',[],...
             'profiles',[],...
             'channels',[],...
             'units',[],...
             'Conductivity',[],...
             'Temperature',[],...
             'Pressure',[],...
             'PAR',[],...
             'Turbidity',[],...
             'Chlorophyll',[],...
             'DissolvedO2',[],...
             'Salinity',[],...
             'Depth',[],...
             'DescentRate',[],...
             'DecelRate',[],...
             'processingLog',[]);


ctd = repmat(ctd,1,n);


