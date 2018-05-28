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

% Altitude control function
% INPUT: state, desired altitude
% OUTPUT: desired speeds

function out=alt_control(in)

% global file for parameters
glob;

% ********* Operational Conditions *********
% roll=in(1);     % [rad]
% dotroll=in(2);  % [rad/s]
% pitch=in(3);
% dotpitch=in(4);
% yaw=in(5);
% dotyaw=in(6);
% z=in(7);        % [m]
% dotz=in(8);     % [m/s]
% x=in(9);
% dotx=in(10);
% y=in(11);
% doty=in(12);


global e_i;

roll=in(1);     % [rad]
pitch=in(2);
z=in(3);        % [m]

zd=in(4);  % desired altitude [m]
dotzd=0;

dotz=diff(z);
dotz(1)=0;

% ********** CONTROL 1 ************
a1=2;
a2=3;
a3=5.0;
e_alt=z-zd

e_i=e_i-(z-zd)*0.01;
%r1=-a1*dotz-a2*(z-zd);
r1=a3*e_i-a2*(z-zd);
U1=(r1+m*g)/(cos(roll)*cos(pitch));


% % ********** CONTROL 2 ************
% alpha7= 4;
% alpha8= 4;
% z7=zd-z;
% z8=dotz - dotzd - alpha7*z7;
% U1=(m/(cos(roll)*cos(pitch)))*(z7 + g - alpha7*(z8 + alpha7*z7) - alpha8*z8);



% out(1)=5.1972;   % required thrust [N]
out(1)=U1; % required thrust [N]
