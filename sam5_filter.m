% BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
% FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
% OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
% PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
% OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
% MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
% TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
% PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
% REPAIR OR CORRECTION.
% 
%   12. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
% WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
% REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
% INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING
% OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED
% TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY
% YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
% PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
% POSSIBILITY OF SUCH DAMAGES.

% Noise filtering function
% INPUT: state
% OUTPUT: filtered states

function out=sam5_filter(in)

% global file for parameters
glob;

% ********* Operational Conditions *********
roll=in(1);     % [rad]
dotroll=in(2);  % [rad/s]
pitch=in(3);
dotpitch=in(4);
yaw=in(5);
dotyaw=in(6);
z=in(7);        % [m]
dotz=in(8);     % [m/s]
x=in(9);
dotx=in(10);
y=in(11);
doty=in(12);


global fIdx; % index for filtering

global rolli_1;
global rolli_2;
global frolli;
global frolli_1;
global frolli_2;

global dotrolli_1;
global dotrolli_2;
global fdotrolli;
global fdotrolli_1;
global fdotrolli_2;

global pitchi_1;
global pitchi_2;
global fpitchi;
global fpitchi_1;
global fpitchi_2;

global dotpitchi_1;
global dotpitchi_2;
global fdotpitchi;
global fdotpitchi_1;
global fdotpitchi_2;

global yawi_1;
global yawi_2;
global fyawi;
global fyawi_1;
global fyawi_2;

global dotyawi_1;
global dotyawi_2;
global fdotyawi;
global fdotyawi_1;
global fdotyawi_2;

global zi_1;
global zi_2;
global fzi;
global fzi_1;
global fzi_2;


rff=0;  % rotations filter flag (1=filter rotations, 0=do not filter)
rrff=0; % rotations rates ...
aff=0;  % altitude ...

% ********* ROTATIONS FILTER *********
if (rff==1)
    if (fIdx >= 5)
             
        rolli=roll;
%        frolli=((1/3)*(rolli+rolli_1+rolli_2)+frolli_1+frolli_2)/3;     % SAM5 filter (running average + lp filter)
%        frolli=((1/2)*(rolli+rolli_1)+frolli_1+frolli_2)/3;     % SAM5 filter (running average + lp filter)
        frolli=((1/2)*(rolli+rolli_1)+frolli_1)/2;     % SAM5 filter (running average + lp filter)
        
        pitchi=pitch;    
%        fpitchi=((1/3)*(pitchi+pitchi_1+pitchi_2)+fpitchi_1+fpitchi_2)/3;     % SAM5 filter (running average + lp filter)
%        fpitchi=((1/2)*(pitchi+pitchi_1)+fpitchi_1+fpitchi_2)/3;     % SAM5 filter (running average + lp filter)
        fpitchi=((1/2)*(pitchi+pitchi_1)+fpitchi_1)/2;     % SAM5 filter (running average + lp filter)
        
        
        yawi=yaw;    
%        fyawi=((1/3)*(yawi+yawi_1+yawi_2)+fyawi_1+fyawi_2)/3;     % SAM5 filter (running average + lp filter)
%        fyawi=((1/2)*(yawi+yawi_1)+fyawi_1+fyawi_2)/3;     % SAM5 filter (running average + lp filter)
        fyawi=((1/2)*(yawi+yawi_1)+fyawi_1)/2;     % SAM5 filter (running average + lp filter)
        
        rolli_2=rolli_1;  % DATA shifting
        rolli_1=rolli;
        frolli_2=frolli_1;
        frolli_1=frolli;
        
        pitchi_2=pitchi_1;
        pitchi_1=pitchi;
        fpitchi_2=fpitchi_1;
        fpitchi_1=fpitchi;

        yawi_2=yawi_1;
        yawi_1=yawi;
        fyawi_2=fyawi_1;
        fyawi_1=fyawi;
        
        out(1)=frolli;     % [rad]
        out(3)=fpitchi;
        out(5)=fyawi; 
    else
    out(1)=roll;     % [rad]
    out(3)=pitch;
    out(5)=yaw;
    end
else
out(1)=roll;     % [rad]
out(3)=pitch;
out(5)=yaw;
end

% ********* ROTATIONS RATES FILTER *********
if (rrff==1)
    if (fIdx >= 5)        
        dotrolli=dotroll;    
        fdotrolli=((1/2)*(dotrolli+dotrolli_1)+fdotrolli_1)/2;     % SAM5 filter (running average + lp filter)


        dotpitchi=dotpitch;    
        fdotpitchi=((1/2)*(dotpitchi+dotpitchi_1)+fdotpitchi_1)/2;     % SAM5 filter (running average + lp filter)        
        
        dotyawi=dotyaw;    
        fdotyawi=((1/2)*(dotyawi+dotyawi_1)+fdotyawi_1)/2;     % SAM5 filter (running average + lp filter)        
        
        dotrolli_2=dotrolli_1;  % DATA shifting
        dotrolli_1=dotrolli;
        fdotrolli_2=fdotrolli_1;
        fdotrolli_1=fdotrolli;

        dotpitchi_2=dotpitchi_1;
        dotpitchi_1=dotpitchi;
        fdotpitchi_2=fdotpitchi_1;
        fdotpitchi_1=fpitchi;

        dotyawi_2=dotyawi_1;
        dotyawi_1=dotyawi;
        fdotyawi_2=fdotyawi_1;
        fdotyawi_1=fdotyawi;
        
        out(2)=fdotrolli;     % [rad/s]
        out(4)=fdotpitchi;
        out(6)=fdotyawi;      
    else
    out(1)=dotroll;     % [rad]
    out(3)=dotpitch;
    out(5)=dotyaw;
    end
else
out(2)=dotroll;     % [rad/s]
out(4)=dotpitch;
out(6)=dotyaw;
end



% ********* ALTITUDE FILTER *********
if (aff==1)
    if (fIdx >= 5)        
        zi=z;    
        fzi=((1/2)*(zi+zi_1)+fzi_1)/2;     % SAM5 filter (running average + lp filter)
        
        zi_2=zi_1;  % DATA shifting
        zi_1=zi;
        fzi_2=fzi_1;
        fzi_1=fzi;
        
        out(7)=fzi;     % [m]        
    else
    out(7)=z;    
    end
else
out(7)=z;     % [m]    
end


fIdx=fIdx+1;    % index incrementation

% ********* REMAINING OUTPUTS (not filtered) *********  
out(8)=in(8);
out(9)=in(9);
out(10)=in(10);
out(11)=in(11);
out(12)=in(12);