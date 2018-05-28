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

% Speed control function
% INPUT: state, desired dotX & dotY
% OUTPUT: desired speeds

function out=spd_control(in)

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

dotxd=in(13);   % desired linear x speed [m/s]
dotyd=in(14);   % desired linear x speed [m/s]

U1=in(15);

% ********** CONTROL ************
ax=1;
ay=1;

ex=dotxd - dotx; % dot x error
ey=dotyd - doty; % dot y error

% Control and Roll and Pitch extraction

if (U1 > 0)
UX=(ax*ex)*m/U1;    % dot x ctrl
UY=(ay*ey)*m/U1;
rolld = asin(UX*sin(yaw) - UY*cos(yaw)); % desired roll
pitchd = asin ((UX - sin(roll)*sin(yaw))/(cos(roll)*cos(yaw))); % desired pitch  (the yaw must be -pi/2 < yaw < pi/2
else
U1=m*g;
rolld=0;
pitchd=0;
end

% phi and theta extraction




out(1)=rolld;   % required roll angle [rad]
out(2)=pitchd;   % required pitch angle [rad]

% out(1)=0;
% out(2)=0;