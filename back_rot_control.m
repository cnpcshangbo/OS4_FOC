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

% Rotations control function
% INPUT: state, (phi,theta,psi)(ref)
% OUTPUT: desired prop speeds

function out=back1_rot_control(in)

% global file for parameters
glob;

global Om_old;  % 
global x1_1;
global x2_1;
global x3_1;

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

rolld=in(13);   % desired ROLL angle [rad]
pitchd=in(14);   % desired PITCH angle [rad]

Td=in(15);   % desired thrust [N]

yawd=in(16);    % desired yaw angle [rad]

% ******************************************************** CONTROL ******************************************************** 

dotrolld = 0;

dotpitchd = 0;

dotyawd = 0;


% ********* + FILTER + NOISE **************
lam1=3;  % lam > 0   integral term parameter
lam2=3;
lam3=3;

% Controls
c1= 5;       % c1,2,3,4> 0  parameter for convergence speed of the ROLL tracking loop
c2= 8;      % parameter for convergence speed of the DOTROLL tracking loop
c3= 5;
c4= 8;
c5= 2;
c6= 1;

k1=0.5;
k2=0.5;
k3=0.5;



e1=k1*(rolld-roll);  % roll error
e3=k2*(pitchd-pitch);  % pitch error
e5=k3*(yawd-yaw);  % pitch error


x1=x1_1+e1*sp;  % integrator
x2=x2_1+e3*sp;  % integrator
x3=x3_1+e5*sp;  % integrator


e2=c1*e1+dotrolld+lam1*x1-dotroll;  % dotroll error

e4=c3*e3+dotpitchd+lam2*x2-dotpitch;  % dotpitch error
e6=c5*e5+dotyawd+lam3*x3-dotyaw;  % dotyaw error


% Coconut controller
U(1)=Td; % [N]

U(2)=(Ixx/L)*((1-c1^2+lam1)*e1 + (c1+c2)*e2 - c1*lam1*x1);
U(3)=(Iyy/L)*((1-c3^2+lam2)*e3 + (c3+c4)*e4 - c3*lam2*x2);
 
U(4)=(Izz)* ((1-c5^2+lam3)*e5 + (c5+c6)*e6 - c5*lam3*x3);


% update integrator
x1_1=x1;
x2_1=x2;
x3_1=x3;

% Outputs
out(1)=U(1);
out(2)=U(2);
out(3)=U(3);
out(4)=U(4);

out(5)=e1;
out(6)=e3;