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

% Aerodynamics function
% INPUT: glob, state, prop speeds
% OUTPUT: Aerodynamic forces and torques

function out=aero(in)
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

% ********* Actual rotor speeds *********
Omega=in(13:16);    % [rad/s]

% ********* Ratios *********
V=sqrt(dotx^2+doty^2);  % horizontal speed [m/s]
v1=sqrt(-0.5*V^2+sqrt((0.5*V^2)^2+(w/(2*rho*A))^2)); % Inflow velocity [m/s]
lambda=(v1+dotz)/(OmegaH*R); % Inflow ratio [less]
mu=V/(OmegaH*R); % advance ratio [less]
muX=dotx/(OmegaH*R); % advance ratio in x axis [less]
muY=doty/(OmegaH*R); % advance ratio in y axis [less]

Ct=sigma_*a*(((1/6)+(mu^2)/4)*theta0-((1+mu^2)*thetatw/8)-lambda/4); % Lift coeff [less]
ChX=sigma_*a*((muX*Cd/(4*a))+(0.25*lambda*muX*(theta0-0.5*thetatw))); % [less]
ChY=sigma_*a*((muY*Cd/(4*a))+(0.25*lambda*muY*(theta0-0.5*thetatw))); % [less]
Cq=sigma_*a*((1/(8*a))*(1+mu^2)*Cd+lambda*((theta0/6)-(thetatw/8)-(lambda/4))); % [less]

CrX= - sigma_*a*(muX*(theta0/6-thetatw/8-lambda/8)); % NEGATIVE ! % [less]
CrY= - sigma_*a*(muY*(theta0/6-thetatw/8-lambda/8)); % [less]

for i = 1:P
% ********* Thrust force *********
T(i)=Ct*rho*A*((Omega(i)*R)^2); % Thrust [N]

% ********* Hub force *********
HX(i)=ChX*rho*A*((Omega(i)*R)^2); % Hub force in X [N]
HY(i)=ChY*rho*A*((Omega(i)*R)^2); % Hub force in Y [N]

% ********* Torque *********
Q(i)=Cq*rho*A*(Omega(i)^2)*(R^3); % [Nm]

% ********* Rolling moment *********
RRX(i)=CrX*rho*A*(Omega(i)^2)*(R^3); % [Nm]
RRY(i)=CrY*rho*A*(Omega(i)^2)*(R^3); % [Nm]

end

out(1:4)=T;
out(5:8)=Q;
out(9:12)=HX;
out(13:16)=HY;
out(17:20)=RRX;
out(21:24)=RRY;