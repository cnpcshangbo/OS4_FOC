%% Error of the altitude calculation

function out=error_altitude(in)

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


roll=in(1);     % [rad]
pitch=in(2);
z=in(3);        % [m]

zd=in(4);  % desired altitude [m]
dotzd=0;

e_alt=z-zd; % altitude error

out(1)=e_alt; % altitude error
