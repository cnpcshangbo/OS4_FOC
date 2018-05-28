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

function out = Hom(in)

x1      = in(1);
y1      = in(2);
z1      = in(3);
phi1    = in(4); % rotation around global z-axis
theta1  = in(5); % rotation around global y-axis
psi1    = in(6); % rotation around global x-axis

out = [ cos(phi1)*cos(theta1)   cos(phi1)*sin(theta1)*sin(psi1) - sin(phi1)*cos(psi1)   cos(phi1)*sin(theta1)*cos(psi1) + sin(phi1)*sin(psi1)   x1;...
        sin(phi1)*cos(theta1)   sin(phi1)*sin(theta1)*sin(psi1) + cos(phi1)*cos(psi1)   sin(phi1)*sin(theta1)*cos(psi1) - cos(phi1)*sin(psi1)   y1;...
        -sin(theta1)            cos(theta1)*sin(psi1)                                   cos(theta1)*cos(psi1)                                   z1;...
        0                       0                                                       0                                                       1];

    
