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

function draw_results_3D(phi,theta,psi)


% Global variables declaration 

 global SwitchProc1  SwitchCompl                                     % used for the Selection of the Procedures
 global GRAF  chbox                                                  % Radio Button
 global EDIT                                                         % Edit Text on Robox Window
 global EIXOS EIXOS1 EIXOS2 EIXOS3 EIXOS4 EIXOS5 EIXOS6
 global FIGU  FIGU1  FIGU2  FIGU3  FIGU4                             % Figure parameters      
 global LINHA XLIMI YLIMI
 global x y z
 global roll pitch yaw tout
 global OS4movie

% -------------------------------------------------------------------------

az3d = -41;                            % Azimuth for the 3-D view [degrees]
el3d = 48;                             % Elevation for the 3-D view [degrees]

R1 = 0.15;                             % OS4 Rotor radius [m]
R2 = 0.37;                             % OS4 base [m]
R3 = 0.01;
L1 = 0.1;                              % OS4 Avionics Box length [m]
H1 = 0.1;                              % OS4 Avionics Box height [m]
ang1= 5*pi/180;                        % OS4 motor structure inclination angle [rd]

hlinha = R2*tan(ang1);
h2inha = 0.06 - hlinha;

cth=cos(pi-theta);
sth=sin(pi-theta);
cph=cos(pi+phi);
sph=sin(pi+phi);
cps=cos(-psi+pi/2);
sps=sin(-psi+pi/2);
cps1=cos(-psi+pi);
sps1=sin(-psi+pi);

% 3D View
% -------

% OS4 Avionics Box

aux=sqrt(2);

py = [L1/aux 0 -L1/aux 0 L1/aux];             % box botton 
px = [0 -L1/aux 0 L1/aux 0]; 
pz = [-L1/2 -L1/2 -L1/2 -L1/2 -L1/2]; 
npx = px*(cps1*cth + sps1*sph*sth) + py*sps1*cph + pz*(-cps1*sth + sps1*sph*cth);
npy = px*(-sps1*cth + cps1*sph*sth) + py*cps1*cph + pz*(sps1*sth + cps1*sph*cth);
npz = px*(sth*cph) - py*sph + pz*(cth*cph);
efe=patch(npy, npx, npz,[0.5 0.7 0.5],'Parent',EIXOS3);
 
py = [L1/aux 0 -L1/aux 0 L1/aux];             % box top
px = [0 -L1/aux 0 L1/aux 0];
pz = [L1/2 L1/2 L1/2 L1/2 L1/2];
npx = px*(cps1*cth + sps1*sph*sth) + py*sps1*cph + pz*(-cps1*sth + sps1*sph*cth);
npy = px*(-sps1*cth + cps1*sph*sth) + py*cps1*cph + pz*(sps1*sth + cps1*sph*cth);
npz = px*(sth*cph) - py*sph + pz*(cth*cph);
efe=patch(npy, npx, npz,[0.5 0.7 0.5],'Parent',EIXOS3);

py = [L1/aux L1/aux 0 0 L1/aux];             % box sides
px = [0 0 -L1/aux -L1/aux 0];
pz = [-L1/2 L1/2 L1/2 -L1/2 -L1/2];
npx = px*(cps1*cth + sps1*sph*sth) + py*sps1*cph + pz*(-cps1*sth + sps1*sph*cth);
npy = px*(-sps1*cth + cps1*sph*sth) + py*cps1*cph + pz*(sps1*sth + cps1*sph*cth);
npz = px*(sth*cph) - py*sph + pz*(cth*cph);
efe=patch(npy, npx, npz,[0.5 0.7 0.5],'Parent',EIXOS3);
 
py = [0 0 -L1/aux -L1/aux 0];
px = [-L1/aux -L1/aux 0 0 -L1/aux];
pz = [-L1/2 L1/2 L1/2 -L1/2 -L1/2];
npx = px*(cps1*cth + sps1*sph*sth) + py*sps1*cph + pz*(-cps1*sth + sps1*sph*cth);
npy = px*(-sps1*cth + cps1*sph*sth) + py*cps1*cph + pz*(sps1*sth + cps1*sph*cth);
npz = px*(sth*cph) - py*sph + pz*(cth*cph);
efe=patch(npy, npx, npz,[0.5 0.7 0.5],'Parent',EIXOS3);
 
py = [-L1/aux -L1/aux 0 0 -L1/aux];            
px = [0 0 L1/aux L1/aux 0];
pz = [-L1/2 L1/2 L1/2 -L1/2 -L1/2];
npx = px*(cps1*cth + sps1*sph*sth) + py*sps1*cph + pz*(-cps1*sth + sps1*sph*cth);
npy = px*(-sps1*cth + cps1*sph*sth) + py*cps1*cph + pz*(sps1*sth + cps1*sph*cth);
npz = px*(sth*cph) - py*sph + pz*(cth*cph);
efe=patch(npy, npx, npz,[0.5 0.7 0.5],'Parent',EIXOS3);
 
py = [0 0 L1/aux L1/aux 0];           
px = [L1/aux L1/aux 0 0 L1/2];
pz = [-L1/2 L1/2 L1/2 -L1/2 -L1/2];
npx = px*(cps1*cth + sps1*sph*sth) + py*sps1*cph + pz*(-cps1*sth + sps1*sph*cth);
npy = px*(-sps1*cth + cps1*sph*sth) + py*cps1*cph + pz*(sps1*sth + cps1*sph*cth);
npz = px*(sth*cph) - py*sph + pz*(cth*cph);
efe=patch(npy, npx, npz,[0.5 0.7 0.5],'Parent',EIXOS3);

% OS4 Structure bars and Rotors

% Rotor # 4

npx = 0*(cps1*cth + sps1*sph*sth) + R2*sps1*cph + (hlinha + h2inha + L1/2)*(-cps1*sth + sps1*sph*cth);
npy = 0*(-sps1*cth + cps1*sph*sth) + R2*cps1*cph + (hlinha + h2inha + L1/2)*(sps1*sth + cps1*sph*cth);
npz = 0*(sth*cph) - (R2)*sph + (hlinha + h2inha + L1/2)*(cth*cph);
npxo = 0*(cps1*cth + sps1*sph*sth) + 0*sps1*cph + (h2inha + L1/2)*(-cps1*sth + sps1*sph*cth);
npyo = 0*(-sps1*cth + cps1*sph*sth) + 0*cps1*cph + (h2inha + L1/2)*(sps1*sth + cps1*sph*cth);
npzo = 0*(sth*cph) - 0*sph + (h2inha + L1/2)*(cth*cph);
xxc = [npxo; npx];
zzc = [npzo; npz];
yyc = [npyo; npy];
como = 0;
for tt=0:0.1:6.28,
    como = como + 1;
    xo(como) = R1*cos(tt)*(cps1*cth + sps1*sph*sth) + R1*sin(tt)*sps1*cph + 0*(-cps1*sth + sps1*sph*cth) + npx;
    yo(como) = R1*cos(tt)*(-sps1*cth + cps1*sph*sth) + R1*sin(tt)*cps1*cph + 0*(sps1*sth + cps1*sph*cth) + npy;
    zo(como) = R1*cos(tt)*(sth*cph) - R1*sin(tt)*sph + 0*(cth*cph) + npz;
end
efe=patch(yo,xo,zo,[0.9 0.9 0.9],'LineStyle','-','Parent',EIXOS3);
LINHA=line(yyc, xxc, zzc,'Parent',EIXOS3,'Color',[0 0 0],'LineStyle','-', 'LineWidth',2);
if npx < 0, aqux = npx-0.06; else, aqux = npx+0.06; end
if npy < 0, aquy = npy-0.06; else, aquy = npy+0.06; end
aquz = npz + 0.16;
text(aquy,aqux,aquz,'4','FontSize',10,'Parent',EIXOS3);

% Rotor # 2

npx = 0*(cps1*cth + sps1*sph*sth) - R2*sps1*cph + (hlinha + h2inha + L1/2)*(-cps1*sth + sps1*sph*cth);
npy = 0*(-sps1*cth + cps1*sph*sth) - R2*cps1*cph + (hlinha + h2inha + L1/2)*(sps1*sth + cps1*sph*cth);
npz = 0*(sth*cph) - (-R2)*sph + (hlinha + h2inha + L1/2)*(cth*cph);
npxo = 0*(cps1*cth + sps1*sph*sth) + 0*sps1*cph + (h2inha + L1/2)*(-cps1*sth + sps1*sph*cth);
npyo = 0*(-sps1*cth + cps1*sph*sth) + 0*cps1*cph + (h2inha + L1/2)*(sps1*sth + cps1*sph*cth);
npzo = 0*(sth*cph) - 0*sph + (h2inha + L1/2)*(cth*cph);
xxc = [npxo; npx];
zzc = [npzo; npz];
yyc = [npyo; npy];
como = 0;
for tt=0:0.1:6.28,
    como = como + 1;
    xo(como) = R1*cos(tt)*(cps1*cth + sps1*sph*sth) + R1*sin(tt)*sps1*cph + 0*(-cps1*sth + sps1*sph*cth) + npx;
    yo(como) = R1*cos(tt)*(-sps1*cth + cps1*sph*sth) + R1*sin(tt)*cps1*cph + 0*(sps1*sth + cps1*sph*cth) + npy;
    zo(como) = R1*cos(tt)*(sth*cph) - R1*sin(tt)*sph + 0*(cth*cph) + npz;
end
efe=patch(yo,xo,zo,[0.9 0.9 0.9],'LineStyle','-','Parent',EIXOS3);
LINHA=line(yyc, xxc, zzc,'Parent',EIXOS3,'Color',[0 0 0],'LineStyle','-', 'LineWidth',2);
if npx < 0, aqux = npx-0.06; else, aqux = npx+0.06; end
if npy < 0, aquy = npy-0.06; else, aquy = npy+0.06; end
aquz = npz + 0.16;
text(aquy,aqux,aquz,'2','FontSize',10,'Parent',EIXOS3);
 
% Rotor # 3

npx = -R2*(cps1*cth + sps1*sph*sth) + 0*sps1*cph + (hlinha + h2inha + L1/2)*(-cps1*sth + sps1*sph*cth);
npy = -R2*(-sps1*cth + cps1*sph*sth) + 0*cps1*cph + (hlinha + h2inha + L1/2)*(sps1*sth + cps1*sph*cth);
npz = -R2*(sth*cph) - 0*sph + (hlinha + h2inha + L1/2)*(cth*cph);
npxo = 0*(cps1*cth + sps1*sph*sth) + 0*sps1*cph + (h2inha + L1/2)*(-cps1*sth + sps1*sph*cth);
npyo = 0*(-sps1*cth + cps1*sph*sth) + 0*cps1*cph + (h2inha + L1/2)*(sps1*sth + cps1*sph*cth);
npzo = 0*(sth*cph) - 0*sph + (h2inha + L1/2)*(cth*cph);
xxc = [npxo; npx];
zzc = [npzo; npz];
yyc = [npyo; npy];
como = 0;
for tt=0:0.1:6.28,
    como = como + 1;
    xo(como) = R1*cos(tt)*(cps1*cth + sps1*sph*sth) + R1*sin(tt)*sps1*cph + 0*(-cps1*sth + sps1*sph*cth) + npx;
    yo(como) = R1*cos(tt)*(-sps1*cth + cps1*sph*sth) + R1*sin(tt)*cps1*cph + 0*(sps1*sth + cps1*sph*cth) + npy;
    zo(como) = R1*cos(tt)*(sth*cph) - R1*sin(tt)*sph + 0*(cth*cph) + npz;
end
efe=patch(yo,xo,zo,[0.9 0.9 0.9],'LineStyle','-','Parent',EIXOS3);
LINHA=line(yyc, xxc, zzc,'Parent',EIXOS3,'Color',[0 0 0],'LineStyle','-', 'LineWidth',2);
if npx < 0, aqux = npx-0.06; else, aqux = npx+0.06; end
if npy < 0, aquy = npy-0.06; else, aquy = npy+0.06; end
aquz = npz + 0.16;
text(aquy,aqux,aquz,'3','FontSize',10,'Parent',EIXOS3);

% Rotor # 1

npx = R2*(cps1*cth + sps1*sph*sth) + 0*sps1*cph + (hlinha + h2inha + L1/2)*(-cps1*sth + sps1*sph*cth);
npy = R2*(-sps1*cth + cps1*sph*sth) + 0*cps1*cph + (hlinha + h2inha + L1/2)*(sps1*sth + cps1*sph*cth);
npz = R2*(sth*cph) - 0*sph + (hlinha + h2inha + L1/2)*(cth*cph);
npxo = 0*(cps1*cth + sps1*sph*sth) + 0*sps1*cph + (h2inha + L1/2)*(-cps1*sth + sps1*sph*cth);
npyo = 0*(-sps1*cth + cps1*sph*sth) + 0*cps1*cph + (h2inha + L1/2)*(sps1*sth + cps1*sph*cth);
npzo = 0*(sth*cph) - 0*sph + (h2inha + L1/2)*(cth*cph);
xxc = [npxo; npx];
zzc = [npzo; npz];
yyc = [npyo; npy];
como = 0;
for tt=0:0.1:6.28,
    como = como + 1;
    xo(como) = R1*cos(tt)*(cps1*cth + sps1*sph*sth) + R1*sin(tt)*sps1*cph + 0*(-cps1*sth + sps1*sph*cth) + npx;
    yo(como) = R1*cos(tt)*(-sps1*cth + cps1*sph*sth) + R1*sin(tt)*cps1*cph + 0*(sps1*sth + cps1*sph*cth) + npy;
    zo(como) = R1*cos(tt)*(sth*cph) - R1*sin(tt)*sph + 0*(cth*cph) + npz;
end
efe=patch(yo,xo,zo,[0.9 0.9 0.9],'LineStyle','-','Parent',EIXOS3);
LINHA=line(yyc, xxc, zzc,'Parent',EIXOS3,'Color',[0 0 0],'LineStyle','-', 'LineWidth',2);
if npx < 0, aqux = npx-0.06; else, aqux = npx+0.06; end
if npy < 0, aquy = npy-0.06; else, aquy = npy+0.06; end
aquz = npz + 0.16;
text(aquy,aqux,aquz,'1','FontSize',10,'Parent',EIXOS3);


% Local Frame 

% X Axis

xxc = [0 R2*(cps1*cth + sps1*sph*sth)];
yyc = [0 R2*(-sps1*cth + cps1*sph*sth)];
zzc = [0 R2*(sth*cph)];
LINHA=line(yyc, xxc, zzc, 'Parent',EIXOS3,'Color',[1 0 0],'LineStyle','-', 'LineWidth',2);
py=[-0.02 0 0.02 0 -0.02];
px=[0.33 0.37 0.33 0.35 0.33];
pz=[0 0 0 0 0];
npx = px*(cps1*cth + sps1*sph*sth) + py*sps1*cph + pz*(-cps1*sth + sps1*sph*cth);
npy = px*(-sps1*cth + cps1*sph*sth) + py*cps1*cph + pz*(sps1*sth + cps1*sph*cth);
npz = px*(sth*cph) - py*sph + pz*(cth*cph);
efe=patch(npy, npx, npz, [1 0 0],'LineStyle','none','Parent',EIXOS3);

% Y axis

xxc = [0 R2*sps1*cph];
yyc = [0 R2*cps1*cph];
zzc = [0 -R2*sph];
LINHA=line(yyc, xxc, zzc, 'Parent',EIXOS3,'Color',[0 0 1],'LineStyle','-', 'LineWidth',2);
px=[-0.02 0 0.02 0 -0.02];
py=[0.33 0.37 0.33 0.35 0.33];
pz=[0 0 0 0 0];
npx = px*(cps1*cth + sps1*sph*sth) + py*sps1*cph + pz*(-cps1*sth + sps1*sph*cth);
npy = px*(-sps1*cth + cps1*sph*sth) + py*cps1*cph + pz*(sps1*sth + cps1*sph*cth);
npz = px*(sth*cph) - py*sph + pz*(cth*cph);
efe=patch(npy, npx, npz, [0 0 1],'LineStyle','none','Parent',EIXOS3);

% Z Axis

xxc = [0; R2*(-cps1*sth + sps1*sph*cth)];
yyc = [0; R2*(sps1*sth + cps1*sph*cth)];
zzc = [0; R2*(cth*cph)];
LINHA=line(yyc, xxc, zzc, 'Parent',EIXOS3,'Color',[0 1 1],'LineStyle','-', 'LineWidth',2);
px=[-0.02 0 0.02 0 -0.02];
pz=[0.33 0.37 0.33 0.35 0.33];
py=[0 0 0 0 0];
npx = px*(cps1*cth + sps1*sph*sth) + py*sps1*cph + pz*(-cps1*sth + sps1*sph*cth);
npy = px*(-sps1*cth + cps1*sph*sth) + py*cps1*cph + pz*(sps1*sth + cps1*sph*cth);
npz = px*(sth*cph) - py*sph + pz*(cth*cph);
efe=patch(npy, npx, npz, [0 1 1],'LineStyle','none','Parent',EIXOS3);
  
view(az3d,el3d);
