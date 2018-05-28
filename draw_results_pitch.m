%---------------------------------------------------------
%
% This function draws the OS4 robot.
%
%
% Developed by   Marcelo Becker & Samir Bouabdallah
%                EPFL - October, 2005
%
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
%----------------------------------------------------------

function draw_results_pitch(theta)


% Global variables declaration 

 global SwitchProc1                                                  % used for the Selection of the Procedures
 global GRAF                                                         % Radio Button
 global EDIT                                                         % Edit Text on Robox Window
 global EIXOS EIXOS1 EIXOS2 EIXOS3 EIXOS4 EIXOS5 EIXOS6
 global FIGU  FIGU1  FIGU2  FIGU3  FIGU4                             % Figure parameters      
 global LINHA XLIMI YLIMI
 global x y z
 global roll pitch yaw tout

% -------------------------------------------------------------------------

R1 = 0.15;                             % OS4 Rotor radius [m]
R2 = 0.37;                             % OS4 base [m]
R3 = 0.01;
R4 = 0.2;
L1 = 0.1;                              % OS4 Avionics Box length [m]
H1 = 0.1;                              % OS4 Avionics Box height [m]
ang1= 5*pi/180;                        % OS4 motor structure inclination angle [rd]


cth=cos(theta);
sth=sin(theta);


% XZ PLANE 
% --------

 % Local Frame 

xxc = [0; cth*R4];
zzc = [0; -sth*R4];
LINHA=line(xxc, zzc, 'Parent',EIXOS2,'Color',[1 0 0],'LineStyle','-', 'LineWidth',2);
pz=[-0.02 0 0.02 0 -0.02];
px=[(R4-0.02) (R4+0.02) (R4-0.02) R4 (R4-0.02)];
npx = cth*px + sth*pz;
npz = cth*pz - sth*px;
efe=patch(npx, npz, [1 0 0],'LineStyle','none','Parent',EIXOS2);
 
xxc = [0; sth*R4];
zzc = [0; cth*R4];
LINHA=line(xxc, zzc, 'Parent',EIXOS2,'Color',[0 1 1],'LineStyle','-', 'LineWidth',2);
px=[-0.02 0 0.02 0 -0.02];
pz=[(R4-0.02) (R4+0.02) (R4-0.02) R4 (R4-0.02)];
npx = cth*px  + sth*pz;
npz = cth*pz - sth*px;
efe=patch(npx, npz, [0 1 1],'LineStyle','none','Parent',EIXOS2);

% OS4 Avionics Box

gh = L1*sqrt(2)/2;
px = [-gh gh gh -gh -gh];
pz = [L1/2 L1/2 -L1/2 -L1/2 L1/2];
npz = cth*pz - sth*px;
npx = sth*pz + cth*px;
efe=patch(npx, npz,[0.5 0.7 0.5],'Parent',EIXOS2);

npz = cth*L1/2;
npx = sth*L1/2;
xxc = [0; npx];
zzc = [0; npz];
LINHA=line(xxc, zzc,'Parent',EIXOS2,'Color',[0 0 0],'LineStyle','-', 'LineWidth',1);
npz = -cth*L1/2;
npx = -sth*L1/2;
xxc = [0; npx];
zzc = [0; npz];
LINHA=line(xxc, zzc,'Parent',EIXOS2,'Color',[0 0 0],'LineStyle','-', 'LineWidth',1);


% OS4 Structure bars and Rotors

hlinha = R2*tan(ang1);
h2inha = 0.06 - hlinha;
npz = -sth*R2 + cth*(hlinha + h2inha + L1/2);
npx = cth*R2 + sth*(hlinha + h2inha + L1/2);
npzo = cth*(h2inha + L1/2);
npxo = sth*(h2inha + L1/2);

zzc = [npzo; npz];
xxc = [npxo; npx];

LINHA=line(xxc, zzc,'Parent',EIXOS2,'Color',[0 0 0],'LineStyle','-', 'LineWidth',2);

if npz < 0, aquz = npz+0.06; else, aquz = npz-0.06; end
if npx < 0, aqux = npx+0.06; else, aqux = npx-0.06; end
text(aqux,aquz,'1','FontSize',10,'Parent',EIXOS2);

pz = [0 0.01 0.01 0 0];
px = [R2/2 R2/2 -R2/2 -R2/2 R2/2];
npzh = cth*pz - sth*px + npz;
npxh = sth*pz + cth*px + npx;
efe=patch(npxh, npzh,[0.9 0.9 0.9],'Parent',EIXOS2);

npz = sth*R2 + cth*(hlinha + h2inha + L1/2);
npx = -cth*R2 + sth*(hlinha + h2inha + L1/2);
npzo = cth*(h2inha + L1/2);
npxo = sth*(h2inha + L1/2);

zzc = [npzo; npz];
xxc = [npxo; npx];

LINHA=line(xxc, zzc,'Parent',EIXOS2,'Color',[0 0 0],'LineStyle','-', 'LineWidth',2);

if npz < 0, aquz = npz+0.06; else, aquz = npz-0.06; end
if npx < 0, aqux = npx+0.06; else, aqux = npx-0.06; end
text(aqux,aquz,'3','FontSize',10,'Parent',EIXOS2);

pz = [0 0.01 0.01 0 0];
px = [R2/2 R2/2 -R2/2 -R2/2 R2/2];
npzh = cth*pz - sth*px + npz;
npxh = sth*pz + cth*px + npx;
efe=patch(npxh, npzh,[0.9 0.9 0.9],'Parent',EIXOS2);

% Theta Angle

 cade = theta*180/pi;
 text(0.2,-0.2,'\theta = ','FontSize',12,'Parent',EIXOS2);
 text(0,-0.2,sprintf('%2.2f ^{o}',cade),'FontSize',12,'Parent',EIXOS2);

 % Local Frame 

xxc = [0; 0];
yyc = [0; 0];
LINHA=line(yyc, xxc, 'Parent',EIXOS2,'Color',[0 0 1],'LineStyle','none', 'Marker','o');
LINHA=line(yyc, xxc, 'Parent',EIXOS2,'Color',[0 0 1],'LineStyle','none', 'Marker','.');

