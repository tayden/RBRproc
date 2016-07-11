function out = correctHoldRBR(in,replaceWith)
%
% usage: out = correctHoldRBR(in,replaceWith)
%
%
%   where
%     in        : structure of rbr data created by output from
%                 rbrExtractVals.m
%
%    replaceWith : How to treat the flagged values:
%                :   one of 'interp' or 'NaN'
%                :     'interp'   - linear interpolation over flagged values
%                :     'NaN'      - replace flagged values with NaN
%
% correctHoldRBR interpolates over or replaces what are effectively
% erroneous values created by what is called a "zero-order hold". In
% some instruments the A2D converter must recalibrated peridically.
% In the time it takes for this to occur, a sample is missed.  RBR
% fills this missed scan with the same data as the previous scan,
% which is called a first-order hold.  This function identifies
% zero-hold points by looking for where consecutive pressure
% differences are equal to zero.
%
% Some care should be taken to determine whether this function should
% be applied, because in some instruments the hold seems to last for
% more than one scan.  The function currently does not address these
% cases.
%
%  Mark Halverson, July 2016
    

if nargin==1,
    replaceWith = 'interp';
end

    
% testing
% in = profile;
    
out = in;    
    
% the zero-order hold points to be replaced
ind = find(diff(in.Pressure)==0) + 1;

% % are they the same as conductivity?
% cind = find(diff(in.Conductivity)==0) + 1;
% % all(ind == cind)
% 
% % are they the same as temperature?
% tind = find(diff(in.Temperature)==0) + 1;
% % all(ind == tind)
% 
% ismember(ind,cind) % are all dP==0 in dC==0?
% ismember(ind,tind) % are all dP==0 in dT==0?


if length(ind)>0,

    % loop through channels

    channels = in.channels;

    for k=1:length(channels),
  
        tvar = in.(channels{k});  

        switch replaceWith
      
          case 'interp'
            
            nind = [ind-1 ind+1]; % neighbouring points
            newVal = mean(tvar(nind),2);   % mean of points surrounding the hold
            tvar(ind) = newVal;  
            
          case 'NaN'
            
            tvar(ind) = NaN;
        
        end
  
        out.(channels{k}) = tvar;
  
    end


    %% append the processing log

    nlog = length(in.processingLog);

    out.processingLog(nlog+1) = {['Zero-order hold scans replaced with ' replaceWith '.']};

else
   
    disp('No zero-order hold points found.')

    nlog = length(in.processingLog);

    out.processingLog(nlog+1) = {'No zero-order hold points found.'};

end



