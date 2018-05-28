%---------------------------------------------------------
%
% This function draws the OS4 robot.
%
%
% Developed by   Marcelo Becker & Samir Bouabdallah
%                EPFL - October, 2005
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
%
%----------------------------------------------------------

function draw_results_roll(phi)


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

cph=cos(phi);
sph=sin(phi);

       
% YZ PLANE 
% --------

 % Local Frame 

xxc = [0; cph*R4];
zzc = [0; -sph*R4];
LINHA=line(xxc, zzc, 'Parent',EIXOS1,'Color',[0 0 1],'LineStyle','-', 'LineWidth',2);
pz=[-0.02 0 0.02 0 -0.02];
px=[(R4-0.02) (R4+0.02) (R4-0.02) R4 (R4-0.02)];
npx = cph*px + sph*pz;
npz = cph*pz - sph*px;
efe=patch(npx, npz, [0 0 1],'LineStyle','none','Parent',EIXOS1);
 
xxc = [0; sph*R4];
zzc = [0; cph*R4];
LINHA=line(xxc, zzc, 'Parent',EIXOS1,'Color',[0 1 1],'LineStyle','-', 'LineWidth',2);
px=[-0.02 0 0.02 0 -0.02];
pz=[(R4-0.02) (R4+0.02) (R4-0.02) R4 (R4-0.02)];
npx = cph*px  + sph*pz;
npz = cph*pz - sph*px;
efe=patch(npx, npz, [0 1 1],'LineStyle','none','Parent',EIXOS1);

% OS4 Avionics Box

gh = L1*sqrt(2)/2;
py = [-gh gh gh -gh -gh];
pz = [L1/2 L1/2 -L1/2 -L1/2 L1/2];
npz = cph*pz - sph*py;
npy = sph*pz + cph*py;
efe=patch(npy, npz,[0.5 0.7 0.5],'Parent',EIXOS1);
npy = cph*L1/2;
npz = sph*L1/2;
xxc = [0; npy];
yyc = [0; npz];
LINHA=line(yyc, xxc,'Parent',EIXOS1,'Color',[0 0 0],'LineStyle','-', 'LineWidth',1);
npy = -cph*L1/2;
npz = -sph*L1/2;
xxc = [0; npy];
yyc = [0; npz];
LINHA=line(yyc, xxc,'Parent',EIXOS1,'Color',[0 0 0],'LineStyle','-', 'LineWidth',1);


% OS4 Structure bars and Rotors

hlinha = R2*tan(ang1);
h2inha = 0.06 - hlinha;
npz = -sph*R2 + cph*(hlinha + h2inha + L1/2);
npy = cph*R2 + sph*(hlinha + h2inha + L1/2);
npzo = cph*(h2inha + L1/2);
npyo = sph*(h2inha + L1/2);

zzc = [npzo; npz];
yyc = [npyo; npy];

LINHA=line(yyc, zzc,'Parent',EIXOS1,'Color',[0 0 0],'LineStyle','-', 'LineWidth',2);

if npz < 0, aquz = npz+0.06; else, aquz = npz-0.06; end
if npy < 0, aquy = npy+0.06; else, aquy = npy-0.06; end
text(aquy,aquz,'4','FontSize',10,'Parent',EIXOS1);

pz = [0 0.01 0.01 0 0];
py = [R2/2 R2/2 -R2/2 -R2/2 R2/2];
npzh = cph*pz - sph*py + npz;
npyh = sph*pz + cph*py + npy;
efe=patch(npyh, npzh,[0.9 0.9 0.9],'Parent',EIXOS1);


npz = sph*R2 + cph*(hlinha + h2inha + L1/2);
npy = -cph*R2 + sph*(hlinha + h2inha + L1/2);
npzo = cph*(h2inha + L1/2);
npyo = sph*(h2inha + L1/2);

zzc = [npzo; npz];
yyc = [npyo; npy];

LINHA=line(yyc, zzc,'Parent',EIXOS1,'Color',[0 0 0],'LineStyle','-', 'LineWidth',2);

if npz < 0, aquz = npz+0.06; else, aquz = npz-0.06; end
if npy < 0, aquy = npy+0.06; else, aquy = npy-0.06; end
text(aquy,aquz,'2','FontSize',10,'Parent',EIXOS1);

pz = [0 0.01 0.01 0 0];
py = [R2/2 R2/2 -R2/2 -R2/2 R2/2];
npzh = cph*pz - sph*py + npz;
npyh = sph*pz + cph*py + npy;
efe=patch(npyh, npzh,[0.9 0.9 0.9],'Parent',EIXOS1);

% Phi Angle

 cade = phi*180/pi;
 text(0.2,-0.2,'\phi = ','FontSize',12,'Parent',EIXOS1);
 text(0,-0.2,sprintf('%2.2f ^{o}',cade),'FontSize',12,'Parent',EIXOS1);

 % Local Frame 

% xxc = [0; -cth*cps1*R2];
% yyc = [0; -sps1*cph*R2];
% zzc = [0; - sth*(-cps1*R2)];
% LINHA=line(yyc, xxc, zzc, 'Parent',EIXOS3,'Color',[1 0 0],'LineStyle','-', 'LineWidth',2);
% py=[-0.02 0 0.02 0 -0.02];
% px=[0.33 0.37 0.33 0.35 0.33];
% pz=[0 0 0 0 0];
% npx = cth*(-cps1*(px) + sps1*(py));
% npy = cph*(-sps1*(px) - cps1*(py));
% npz = -sph*(-sps1*px - cps1*py) + cth*cph*pz - sth*(-cps1*px + sps1*py);
% efe=patch(npy, npx, npz, [1 0 0],'LineStyle','none','Parent',EIXOS3);
% 
% xxc = [0; cth*cps*R2];
% yyc = [0; cph*sps*R2];
% zzc = [0; -sth*(cps*R2)];
% LINHA=line(yyc, xxc, zzc, 'Parent',EIXOS3,'Color',[0 0 1],'LineStyle','-', 'LineWidth',2);
% py=[-0.02 0 0.02 0 -0.02];
% px=[0.33 0.37 0.33 0.35 0.33];
% pz=[0 0 0 0 0];
% npx = cth*(cps*(px) - sps*(py));
% npy = cph*(sps*(px) + cps*(py));
% npz = -sph*(sps*px + cps*py) + cth*cph*pz - sth*(cps*px - sps*py);
% efe=patch(npy, npx, npz, [0 0 1],'LineStyle','none','Parent',EIXOS3);
% 
% xxc = [0; sth*R2];
% yyc = [0; sph*R2];
% zzc = [0; cth*cph*R2];
% LINHA=line(yyc, xxc, zzc, 'Parent',EIXOS3,'Color',[0 1 1],'LineStyle','-', 'LineWidth',2);
% px=[-0.02 0 0.02 0 -0.02];
% pz=[0.33 0.37 0.33 0.35 0.33];
% py=[0 0 0 0 0];
% npx = cth*(cps*px - sps*py) + sth*pz;
% npy = cph*(sps*px + cps*py) + sph*pz;
% npz = -sph*(sps*px + cps*py) + cth*cph*pz - sth*(cps*px - sps*py);
% efe=patch(npy, npx, npz, [0 1 1],'LineStyle','none','Parent',EIXOS3);

xxc = [0; 0];
yyc = [0; 0];
LINHA=line(yyc, xxc, 'Parent',EIXOS1,'Color',[1 0 0],'LineStyle','none', 'Marker','o');
LINHA=line(yyc, xxc, 'Parent',EIXOS1,'Color',[1 0 0],'LineStyle','none', 'Marker','x');
