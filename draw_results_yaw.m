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
%
%----------------------------------------------------------

function draw_results_yaw(psi)


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


cps=cos(psi+pi/2);
sps=sin(psi+pi/2);
cps1=cos(psi+pi);
sps1=sin(psi+pi);
cps2=cos(psi+3*pi/4);
sps2=sin(psi+3*pi/4);


% XY PLANE 
% --------

% OS4 Avionics Box

py = [-L1/2 L1/2 L1/2 -L1/2 -L1/2];
px = [L1/2 L1/2 -L1/2 -L1/2 L1/2];
npx = cps2*px - sps2*py;
npy = sps2*px + cps2*py;
efe=patch(npy, npx,[0.5 0.7 0.5],'Parent',EIXOS);

% OS4 Structure bars and Rotors

npx = cps*R2;                   
npy = sps*R2;
xxc = [0; npx];
yyc = [0; npy];
como = 0;
for tt=0:0.1:6.28,
    como = como + 1;
    xo(como) = R1*cos(tt) + npx;
    yo(como) = R1*sin(tt) + npy;  
end
efe=patch(yo,xo,[0.9 0.9 0.9],'LineStyle','-','Parent',EIXOS);
LINHA=line(yyc, xxc,'Parent',EIXOS,'Color',[0 0 0],'LineStyle','-', 'LineWidth',2);
if npx < 0, aqux = npx-0.06; else, aqux = npx+0.06; end
if npy < 0, aquy = npy-0.06; else, aquy = npy+0.06; end
text(aquy,aqux,'4','FontSize',10,'Parent',EIXOS);

npx = -cps*R2;
npy = -sps*R2;
xxc = [0; npx];
yyc = [0; npy];
como = 0;
for tt=0:0.1:6.28,
    como = como + 1;
    xo(como) = R1*cos(tt) + npx;
    yo(como) = R1*sin(tt) + npy;  
end
efe=patch(yo,xo,[0.9 0.9 0.9],'LineStyle','-','Parent',EIXOS);
LINHA=line(yyc, xxc, 'Parent',EIXOS,'Color',[0 0 0],'LineStyle','-', 'LineWidth',2);
if npx < 0, aqux = npx-0.06; else, aqux = npx+0.06; end
if npy < 0, aquy = npy-0.06; else, aquy = npy+0.06; end
text(aquy,aqux,'2','FontSize',10,'Parent',EIXOS);


npx = cps1*R2;
npy = sps1*R2;
xxc = [0; npx];
yyc = [0; npy];
como = 0;
for tt=0:0.1:6.28,
    como = como + 1;
    xo(como) = R1*cos(tt) + npx;
    yo(como) = R1*sin(tt) + npy;  
end
efe=patch(yo,xo,[0.9 0.9 0.9],'LineStyle','-','Parent',EIXOS);
LINHA=line(yyc, xxc, 'Parent',EIXOS,'Color',[0 0 0],'LineStyle','-', 'LineWidth',2);
if npx < 0, aqux = npx-0.06; else, aqux = npx+0.06; end
if npy < 0, aquy = npy-0.06; else, aquy = npy+0.06; end
text(aquy,aqux,'3','FontSize',10,'Parent',EIXOS);


npx = -cps1*R2;
npy = -sps1*R2;
xxc = [0; npx];
yyc = [0; npy];
como = 0;
for tt=0:0.1:6.28,
    como = como + 1;
    xo(como) = R1*cos(tt) + npx;
    yo(como) = R1*sin(tt) + npy;  
end
efe=patch(yo,xo,[0.9 0.9 0.9],'LineStyle','-','Parent',EIXOS);
LINHA=line(yyc, xxc, 'Parent',EIXOS,'Color',[0 0 0],'LineStyle','-', 'LineWidth',2);
if npx < 0, aqux = npx-0.06; else, aqux = npx+0.06; end
if npy < 0, aquy = npy-0.06; else, aquy = npy+0.06; end
text(aquy,aqux,'1','FontSize',10,'Parent',EIXOS);



% OS4 Structure Joint

px = [R3 R3 -R3 -R3 -2*R3 -2*R3 -R3 -R3 R3 R3 2*R3 2*R3 R3];
py = [R3 2*R3 2*R3 R3 R3 -R3 -R3 -2*R3 -2*R3 -R3 -R3 R3 R3];
npx = cps*px - sps*py;
npy = sps*px + cps*py;
efe=patch(npy, npx,'w','Parent',EIXOS);

% Psi Angle

 cade = psi*180/pi;
 text(0.2,-0.7,'\psi = ','FontSize',12,'Parent',EIXOS);
 text(0,-0.7,sprintf('%2.2f ^{o}',cade),'FontSize',12,'Parent',EIXOS);

 % Local Frame 

xxc = [0; -cps1*R4];
yyc = [0; -sps1*R4];
LINHA=line(yyc, xxc, 'Parent',EIXOS,'Color',[1 0 0],'LineStyle','-', 'LineWidth',2);
py=[-0.02 0 0.02 0 -0.02];
px=[(R4-0.02) (R4+0.02) (R4-0.02) R4 (R4-0.02)];
npx = -cps1*(px) + sps1*(py);
npy = -sps1*(px) - cps1*(py);
efe=patch(npy, npx,[1 0 0],'LineStyle','none','Parent',EIXOS);

xxc = [0; cps*R4];
yyc = [0; sps*R4];
LINHA=line(yyc, xxc, 'Parent',EIXOS,'Color',[0 0 1],'LineStyle','-', 'LineWidth',2);
py=[-0.02 0 0.02 0 -0.02];
px=[(R4-0.02) (R4+0.02) (R4-0.02) R4 (R4-0.02)];
npx = cps*(px) - sps*(py);
npy = sps*(px) + cps*(py);
efe=patch(npy, npx,[0 0 1],'LineStyle','none','Parent',EIXOS);

xxc = [0; 0];
yyc = [0; 0];
LINHA=line(yyc, xxc, 'Parent',EIXOS,'Color',[0 1 1],'LineStyle','none', 'Marker','o');
LINHA=line(yyc, xxc, 'Parent',EIXOS,'Color',[0 1 1],'LineStyle','none', 'Marker','.');


