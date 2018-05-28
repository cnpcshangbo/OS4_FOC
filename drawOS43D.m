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

function drawOS43D(L)


% Global variables declaration 

 global SwitchProc1  SwitchCompl                                     % used for the Selection of the Procedures
 global GRAF chbox                                                   % Radio Button
 global EDIT                                                         % Edit Text on Robox Window
 global EIXOS EIXOS1 EIXOS2 EIXOS3 EIXOS4 EIXOS5 EIXOS6
 global FIGU  FIGU1  FIGU2  FIGU3  FIGU4                             % Figure parameters      
 global LINHA XLIMI YLIMI
 global x y z
 global roll pitch yaw tout
 global OS4movie BOT_SAVE_F
 
% -------------------------------------------------------------------------

[cont1 cont2] = size(x);

az3d = -41;                            % Azimuth for the 3-D view [degrees]
el3d = 48;                             % Elevation for the 3-D view [degrees]

R1 = 0.15;                             % OS4 Rotor radius [m]
R2 = 0.37;                             % OS4 base [m]
R3 = 0.01;
% USSensorPos = [-pi/2 0 pi/2];          % OS4 Ultra-sound sensor positions [rd]
L1 = 0.1;                              % OS4 Avionics Box length [m]
H1 = 0.1;                              % OS4 Avionics Box height [m]
ang1= 5*pi/180;                        % OS4 motor structure inclination angle [rd]

hlinha = R2*tan(ang1);
h2inha = 0.06 - hlinha;

% area used to produce the movie

leftframe = -40;
bottomframe = -30;
widthframe = 440;
heightframe = 350;

% mb 2005
SwitchCompl=2;                          % Standard 3-D view: only the OS4 rotors

%% ================================================0

% Movie file declaration

% mb 2005
% OS4movie = [];
% OS4movie = struct(OS4movie);
% OS4movie = getframe;

%========================
% Building the Interface
%========================

% Screen Resolution 

TMP=get(0,'ScreenSize');
RSTELA=TMP(3:4);

FOLGA=20;
COR_JANELA=[1 1 1];

TAM_FIG=[600 600];
FIGU2 = figure('Name',sprintf('  OS4 3-D Path View'),...
   'NumberTitle','off',...
   'MenuBar','figure',...
   'Resize','on',...
   'NextPlot','replacechildren',...
   'Color',COR_JANELA,...
   'Position',[(RSTELA-TAM_FIG)/2 TAM_FIG]);

% Figure
% -------

% Position figure

POS_EIXOS6=[80 200];
TAM_EIXOS6=[350 350];
EIXOS6=axes('Box','on','Units','pixels','Position',[POS_EIXOS6 TAM_EIXOS6],'XDir','reverse','NextPlot','add');
TEXTOX6=xlabel('Y axis   [m]','Parent',EIXOS6);
TEXTOY6=ylabel('X axis   [m]','Parent',EIXOS6);
TEXTOZ6=zlabel('Z axis   [m]','Parent',EIXOS6);
TITULO6=title('OS4 3-D Path','Parent',EIXOS6,...
'FontSize',12,'FontWeight','bold');

set(EIXOS6,'XLimMode','manual'); 
set(EIXOS6,'YLimMode','manual');
set(EIXOS6,'ZLimMode','manual');
set(EIXOS6,'Box','off');

% Checking the environment borders

XmaxValue = max(x);
XminValue = min(x);
YmaxValue = max(y);
YminValue = min(y);
ZmaxValue = max(z);
ZminValue = min(z);

XYZmaxValue = max([XmaxValue YmaxValue ZmaxValue]) + 0.6;
XYZminValue = min([XminValue YminValue ZminValue]) - 0.6;

XLIMI=[XYZminValue XYZmaxValue]; 
YLIMI=[XYZminValue XYZmaxValue];
ZLIMI=[XYZminValue XYZmaxValue];
set(EIXOS6,'XLim',XLIMI); 
set(EIXOS6,'YLim',YLIMI);
set(EIXOS6,'ZLim',ZLIMI);

% Checkbox to enable or not the grid lines
% -------------------------------------------

GRADE1=uicontrol('Style','checkbox','Value',0,'Position',[100 90 110 20],...
   'BackgroundColor',COR_JANELA,'String','Enable Grid Lines','Callback',['TMP=get(gcbo,''Value'');',...
      'if TMP, set(EIXOS6,''XGrid'',''on'',''YGrid'',''on'');',...
      'else, set(EIXOS6,''XGrid'',''off'',''YGrid'',''off''); end;']);

% Checkbox to select the OS4 view
% -------------------------------

chbox(1)=uicontrol('Style','checkbox','Value',0,'Position',[100 120 140 20],...
   'BackgroundColor',COR_JANELA,'String','OS4 - Complete View','Callback',['MUDAGRAF(3);']);
chbox(2)=uicontrol('Style','checkbox','Value',1,'Position',[250 120 120 20],...
   'BackgroundColor',COR_JANELA,'String','OS4 - Rotors View','Callback',['MUDAGRAF(4);']);
chbox(3)=uicontrol('Style','checkbox','Value',0,'Position',[400 120 120 20],...
   'BackgroundColor',COR_JANELA,'String','OS4 - Frame View','Callback',['MUDAGRAF(5);']);

% Buttons
% -------

% SAVE Figure Button

BOT_SAVE_F=uicontrol('Position',[250 50 100 20],'String','Save Figure',...
   'BackgroundColor',COR_JANELA,'Enable','off','Callback','salvaimg(FIGU2,4);');

% EXIT Button

BOT_SAIDA=uicontrol('Position',[400 20 100 20],'String','Exit',...
   'BackgroundColor',COR_JANELA,'Enable','off','Callback','close all;');

% RETURN Button

BOT_RETURN=uicontrol('Position',[400 50 100 20],'String','Return',...
   'BackgroundColor',COR_JANELA,'Enable','off','Callback','close;');

% MOVIE Button

BOT_MOVIE=uicontrol('Position',[100 20 100 20],'Enable','off','String','Movie',...
   'BackgroundColor',COR_JANELA);

% SAVE MOVIE Button

BOT_SAVE_M=uicontrol('Position',[250 20 100 20],'Enable','off','String','Save Movie',...
   'BackgroundColor',COR_JANELA);

% REPEAT Button

BOT_REPEAT=uicontrol('Position',[100 50 100 20],'Enable','off','String','Repeat',...
   'BackgroundColor',COR_JANELA);

% loop
% ----

view(az3d,el3d);
set(FIGU2,'Pointer','watch');
pause(0.01);

for cont3 = 1:1:cont1,

    cth=cos(pi-pitch(cont3));
    sth=sin(pi-pitch(cont3));
    cph=cos(pi+roll(cont3));
    sph=sin(pi+roll(cont3));
    cps=cos(-yaw(cont3)+pi/2);
    sps=sin(-yaw(cont3)+pi/2);
    cps1=cos(-yaw(cont3)+pi);
    sps1=sin(-yaw(cont3)+pi);
    
    cla;
    
    % 3D View
    % -------

    if SwitchCompl == 1

        % OS4 Avionics Box

        aux=sqrt(2);

        py = [L1/aux 0 -L1/aux 0 L1/aux];             % box botton 
        px = [0 -L1/aux 0 L1/aux 0]; 
        pz = [-L1/2 -L1/2 -L1/2 -L1/2 -L1/2]; 
        npx = px*(cps1*cth + sps1*sph*sth) + py*sps1*cph + pz*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npy = px*(-sps1*cth + cps1*sph*sth) + py*cps1*cph + pz*(sps1*sth + cps1*sph*cth) + y(cont3);
        npz = px*(sth*cph) - py*sph + pz*(cth*cph) + z(cont3);
        efe=patch(npy, npx, npz,[0.5 0.7 0.5],'Parent',EIXOS6);

        py = [L1/aux 0 -L1/aux 0 L1/aux];             % box top
        px = [0 -L1/aux 0 L1/aux 0];
        pz = [L1/2 L1/2 L1/2 L1/2 L1/2];
        npx = px*(cps1*cth + sps1*sph*sth) + py*sps1*cph + pz*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npy = px*(-sps1*cth + cps1*sph*sth) + py*cps1*cph + pz*(sps1*sth + cps1*sph*cth) + y(cont3);
        npz = px*(sth*cph) - py*sph + pz*(cth*cph) + z(cont3);
        efe=patch(npy, npx, npz,[0.5 0.7 0.5],'Parent',EIXOS6);

        py = [L1/aux L1/aux 0 0 L1/aux];             % box sides
        px = [0 0 -L1/aux -L1/aux 0];
        pz = [-L1/2 L1/2 L1/2 -L1/2 -L1/2];
        npx = px*(cps1*cth + sps1*sph*sth) + py*sps1*cph + pz*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npy = px*(-sps1*cth + cps1*sph*sth) + py*cps1*cph + pz*(sps1*sth + cps1*sph*cth) + y(cont3);
        npz = px*(sth*cph) - py*sph + pz*(cth*cph) + z(cont3);
        efe=patch(npy, npx, npz,[0.5 0.7 0.5],'Parent',EIXOS6);

        py = [0 0 -L1/aux -L1/aux 0];
        px = [-L1/aux -L1/aux 0 0 -L1/aux];
        pz = [-L1/2 L1/2 L1/2 -L1/2 -L1/2];
        npx = px*(cps1*cth + sps1*sph*sth) + py*sps1*cph + pz*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npy = px*(-sps1*cth + cps1*sph*sth) + py*cps1*cph + pz*(sps1*sth + cps1*sph*cth) + y(cont3);
        npz = px*(sth*cph) - py*sph + pz*(cth*cph) + z(cont3);
        efe=patch(npy, npx, npz,[0.5 0.7 0.5],'Parent',EIXOS6);

        py = [-L1/aux -L1/aux 0 0 -L1/aux];            
        px = [0 0 L1/aux L1/aux 0];
        pz = [-L1/2 L1/2 L1/2 -L1/2 -L1/2];
        npx = px*(cps1*cth + sps1*sph*sth) + py*sps1*cph + pz*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npy = px*(-sps1*cth + cps1*sph*sth) + py*cps1*cph + pz*(sps1*sth + cps1*sph*cth) + y(cont3);
        npz = px*(sth*cph) - py*sph + pz*(cth*cph) + z(cont3);
        efe=patch(npy, npx, npz,[0.5 0.7 0.5],'Parent',EIXOS6);

        py = [0 0 L1/aux L1/aux 0];           
        px = [L1/aux L1/aux 0 0 L1/2];
        pz = [-L1/2 L1/2 L1/2 -L1/2 -L1/2];
        npx = px*(cps1*cth + sps1*sph*sth) + py*sps1*cph + pz*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npy = px*(-sps1*cth + cps1*sph*sth) + py*cps1*cph + pz*(sps1*sth + cps1*sph*cth) + y(cont3);
        npz = px*(sth*cph) - py*sph + pz*(cth*cph) + z(cont3);
        efe=patch(npy, npx, npz,[0.5 0.7 0.5],'Parent',EIXOS6);

        % OS4 Structure bars and Rotors

        % Rotor # 4

        npx = 0*(cps1*cth + sps1*sph*sth) + R2*sps1*cph + (hlinha + h2inha + L1/2)*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npy = 0*(-sps1*cth + cps1*sph*sth) + R2*cps1*cph + (hlinha + h2inha + L1/2)*(sps1*sth + cps1*sph*cth) + y(cont3);
        npz = 0*(sth*cph) - (R2)*sph + (hlinha + h2inha + L1/2)*(cth*cph) + z(cont3);
        npxo = 0*(cps1*cth + sps1*sph*sth) + 0*sps1*cph + (h2inha + L1/2)*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npyo = 0*(-sps1*cth + cps1*sph*sth) + 0*cps1*cph + (h2inha + L1/2)*(sps1*sth + cps1*sph*cth) + y(cont3);
        npzo = 0*(sth*cph) - 0*sph + (h2inha + L1/2)*(cth*cph) + z(cont3);
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
        efe=patch(yo,xo,zo,[0.9 0.9 0.9],'LineStyle','-','Parent',EIXOS6);
        LINHA=line(yyc, xxc, zzc,'Parent',EIXOS6,'Color',[0 0 0],'LineStyle','-', 'LineWidth',2);
        if npx < 0, aqux = npx-0.06; else, aqux = npx+0.16; end
        if npy < 0, aquy = npy-0.06; else, aquy = npy+0.16; end
        aquz = npz + 0.16;
        text(aquy,aqux,aquz,'4','FontSize',6,'Parent',EIXOS6);

        % Rotor # 2

        npx = 0*(cps1*cth + sps1*sph*sth) - R2*sps1*cph + (hlinha + h2inha + L1/2)*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npy = 0*(-sps1*cth + cps1*sph*sth) - R2*cps1*cph + (hlinha + h2inha + L1/2)*(sps1*sth + cps1*sph*cth) + y(cont3);
        npz = 0*(sth*cph) - (-R2)*sph + (hlinha + h2inha + L1/2)*(cth*cph) + z(cont3);
        npxo = 0*(cps1*cth + sps1*sph*sth) + 0*sps1*cph + (h2inha + L1/2)*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npyo = 0*(-sps1*cth + cps1*sph*sth) + 0*cps1*cph + (h2inha + L1/2)*(sps1*sth + cps1*sph*cth) + y(cont3);
        npzo = 0*(sth*cph) - 0*sph + (h2inha + L1/2)*(cth*cph) + z(cont3);
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
        efe=patch(yo,xo,zo,[0.9 0.9 0.9],'LineStyle','-','Parent',EIXOS6);
        LINHA=line(yyc, xxc, zzc,'Parent',EIXOS6,'Color',[0 0 0],'LineStyle','-', 'LineWidth',2);
        if npx < 0, aqux = npx-0.06; else, aqux = npx+0.16; end
        if npy < 0, aquy = npy-0.06; else, aquy = npy+0.16; end
        aquz = npz + 0.16;
        text(aquy,aqux,aquz,'2','FontSize',6,'Parent',EIXOS6);

        % Rotor # 3

        npx = -R2*(cps1*cth + sps1*sph*sth) + 0*sps1*cph + (hlinha + h2inha + L1/2)*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npy = -R2*(-sps1*cth + cps1*sph*sth) + 0*cps1*cph + (hlinha + h2inha + L1/2)*(sps1*sth + cps1*sph*cth) + y(cont3);
        npz = -R2*(sth*cph) - 0*sph + (hlinha + h2inha + L1/2)*(cth*cph) + z(cont3);
        npxo = 0*(cps1*cth + sps1*sph*sth) + 0*sps1*cph + (h2inha + L1/2)*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npyo = 0*(-sps1*cth + cps1*sph*sth) + 0*cps1*cph + (h2inha + L1/2)*(sps1*sth + cps1*sph*cth) + y(cont3);
        npzo = 0*(sth*cph) - 0*sph + (h2inha + L1/2)*(cth*cph) + z(cont3);
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
        efe=patch(yo,xo,zo,[0.9 0.9 0.9],'LineStyle','-','Parent',EIXOS6);
        LINHA=line(yyc, xxc, zzc,'Parent',EIXOS6,'Color',[0 0 0],'LineStyle','-', 'LineWidth',2);
        if npx < 0, aqux = npx-0.06; else, aqux = npx+0.16; end
        if npy < 0, aquy = npy-0.06; else, aquy = npy+0.16; end
        aquz = npz + 0.16;
        text(aquy,aqux,aquz,'3','FontSize',6,'Parent',EIXOS6);

        % Rotor # 1

        npx = R2*(cps1*cth + sps1*sph*sth) + 0*sps1*cph + (hlinha + h2inha + L1/2)*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npy = R2*(-sps1*cth + cps1*sph*sth) + 0*cps1*cph + (hlinha + h2inha + L1/2)*(sps1*sth + cps1*sph*cth) + y(cont3);
        npz = R2*(sth*cph) - 0*sph + (hlinha + h2inha + L1/2)*(cth*cph) + z(cont3);
        npxo = 0*(cps1*cth + sps1*sph*sth) + 0*sps1*cph + (h2inha + L1/2)*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npyo = 0*(-sps1*cth + cps1*sph*sth) + 0*cps1*cph + (h2inha + L1/2)*(sps1*sth + cps1*sph*cth) + y(cont3);
        npzo = 0*(sth*cph) - 0*sph + (h2inha + L1/2)*(cth*cph) + z(cont3);
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
        efe=patch(yo,xo,zo,[0.9 0.9 0.9],'LineStyle','-','Parent',EIXOS6);
        LINHA=line(yyc, xxc, zzc,'Parent',EIXOS6,'Color',[0 0 0],'LineStyle','-', 'LineWidth',2);
        if npx < 0, aqux = npx-0.06; else, aqux = npx+0.16; end
        if npy < 0, aquy = npy-0.06; else, aquy = npy+0.16; end
        aquz = npz + 0.16;
        text(aquy,aqux,aquz,'1','FontSize',6,'Parent',EIXOS6);

        % Local Frame 

        % X Axis

        xxc = [x(cont3) R2*(cps1*cth + sps1*sph*sth)+x(cont3)];
        yyc = [y(cont3) R2*(-sps1*cth + cps1*sph*sth)+y(cont3)];
        zzc = [z(cont3) R2*(sth*cph)+z(cont3)];
        LINHA=line(yyc, xxc, zzc, 'Parent',EIXOS6,'Color',[1 0 0],'LineStyle','-', 'LineWidth',2);
        py=[-0.02 0 0.02 0 -0.02];
        px=[0.33 0.37 0.33 0.35 0.33];
        pz=[0 0 0 0 0];
        npx = px*(cps1*cth + sps1*sph*sth) + py*sps1*cph + pz*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npy = px*(-sps1*cth + cps1*sph*sth) + py*cps1*cph + pz*(sps1*sth + cps1*sph*cth) + y(cont3);
        npz = px*(sth*cph) - py*sph + pz*(cth*cph) + z(cont3);
        efe=patch(npy, npx, npz, [1 0 0],'LineStyle','none','Parent',EIXOS6);

        % Y axis

        xxc = [x(cont3) R2*sps1*cph+x(cont3)];
        yyc = [y(cont3) R2*cps1*cph+y(cont3)];
        zzc = [z(cont3) -R2*sph+z(cont3)];
        LINHA=line(yyc, xxc, zzc, 'Parent',EIXOS6,'Color',[0 0 1],'LineStyle','-', 'LineWidth',2);
        px=[-0.02 0 0.02 0 -0.02];
        py=[0.33 0.37 0.33 0.35 0.33];
        pz=[0 0 0 0 0];
        npx = px*(cps1*cth + sps1*sph*sth) + py*sps1*cph + pz*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npy = px*(-sps1*cth + cps1*sph*sth) + py*cps1*cph + pz*(sps1*sth + cps1*sph*cth) + y(cont3);
        npz = px*(sth*cph) - py*sph + pz*(cth*cph) + z(cont3);
        efe=patch(npy, npx, npz, [0 0 1],'LineStyle','none','Parent',EIXOS6);

        % Z Axis

        xxc = [x(cont3); R2*(-cps1*sth + sps1*sph*cth)+x(cont3)];
        yyc = [y(cont3); R2*(sps1*sth + cps1*sph*cth)+y(cont3)];
        zzc = [z(cont3); R2*(cth*cph)+z(cont3)];
        LINHA=line(yyc, xxc, zzc, 'Parent',EIXOS6,'Color',[0 1 1],'LineStyle','-', 'LineWidth',2);
        px=[-0.02 0 0.02 0 -0.02];
        pz=[0.33 0.37 0.33 0.35 0.33];
        py=[0 0 0 0 0];
        npx = px*(cps1*cth + sps1*sph*sth) + py*sps1*cph + pz*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npy = px*(-sps1*cth + cps1*sph*sth) + py*cps1*cph + pz*(sps1*sth + cps1*sph*cth) + y(cont3);
        npz = px*(sth*cph) - py*sph + pz*(cth*cph) + z(cont3);
        efe=patch(npy, npx, npz, [0 1 1],'LineStyle','none','Parent',EIXOS6);

    elseif SwitchCompl == 2

        % OS4 Structure bars and Rotors

        % Rotor # 4

        npx = 0*(cps1*cth + sps1*sph*sth) + R2*sps1*cph + (hlinha + h2inha + L1/2)*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npy = 0*(-sps1*cth + cps1*sph*sth) + R2*cps1*cph + (hlinha + h2inha + L1/2)*(sps1*sth + cps1*sph*cth) + y(cont3);
        npz = 0*(sth*cph) - (R2)*sph + (hlinha + h2inha + L1/2)*(cth*cph) + z(cont3);
        npxo = 0*(cps1*cth + sps1*sph*sth) + 0*sps1*cph + (h2inha + L1/2)*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npyo = 0*(-sps1*cth + cps1*sph*sth) + 0*cps1*cph + (h2inha + L1/2)*(sps1*sth + cps1*sph*cth) + y(cont3);
        npzo = 0*(sth*cph) - 0*sph + (h2inha + L1/2)*(cth*cph) + z(cont3);
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
        efe=patch(yo,xo,zo,[0.9 0.9 0.9],'LineStyle','-','Parent',EIXOS6);
        LINHA=line(yyc, xxc, zzc,'Parent',EIXOS6,'Color',[0 0 0],'LineStyle','-', 'LineWidth',2);
        if npx < 0, aqux = npx-0.06; else, aqux = npx+0.16; end
        if npy < 0, aquy = npy-0.06; else, aquy = npy+0.16; end
        aquz = npz + 0.16;
        text(aquy,aqux,aquz,'4','FontSize',6,'Parent',EIXOS6);

        % Rotor # 2

        npx = 0*(cps1*cth + sps1*sph*sth) - R2*sps1*cph + (hlinha + h2inha + L1/2)*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npy = 0*(-sps1*cth + cps1*sph*sth) - R2*cps1*cph + (hlinha + h2inha + L1/2)*(sps1*sth + cps1*sph*cth) + y(cont3);
        npz = 0*(sth*cph) - (-R2)*sph + (hlinha + h2inha + L1/2)*(cth*cph) + z(cont3);
        npxo = 0*(cps1*cth + sps1*sph*sth) + 0*sps1*cph + (h2inha + L1/2)*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npyo = 0*(-sps1*cth + cps1*sph*sth) + 0*cps1*cph + (h2inha + L1/2)*(sps1*sth + cps1*sph*cth) + y(cont3);
        npzo = 0*(sth*cph) - 0*sph + (h2inha + L1/2)*(cth*cph) + z(cont3);
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
        efe=patch(yo,xo,zo,[0.9 0.9 0.9],'LineStyle','-','Parent',EIXOS6);
        LINHA=line(yyc, xxc, zzc,'Parent',EIXOS6,'Color',[0 0 0],'LineStyle','-', 'LineWidth',2);
        if npx < 0, aqux = npx-0.06; else, aqux = npx+0.16; end
        if npy < 0, aquy = npy-0.06; else, aquy = npy+0.16; end
        aquz = npz + 0.16;
        text(aquy,aqux,aquz,'2','FontSize',6,'Parent',EIXOS6);

        % Rotor # 3

        npx = -R2*(cps1*cth + sps1*sph*sth) + 0*sps1*cph + (hlinha + h2inha + L1/2)*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npy = -R2*(-sps1*cth + cps1*sph*sth) + 0*cps1*cph + (hlinha + h2inha + L1/2)*(sps1*sth + cps1*sph*cth) + y(cont3);
        npz = -R2*(sth*cph) - 0*sph + (hlinha + h2inha + L1/2)*(cth*cph) + z(cont3);
        npxo = 0*(cps1*cth + sps1*sph*sth) + 0*sps1*cph + (h2inha + L1/2)*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npyo = 0*(-sps1*cth + cps1*sph*sth) + 0*cps1*cph + (h2inha + L1/2)*(sps1*sth + cps1*sph*cth) + y(cont3);
        npzo = 0*(sth*cph) - 0*sph + (h2inha + L1/2)*(cth*cph) + z(cont3);
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
        efe=patch(yo,xo,zo,[0.9 0.9 0.9],'LineStyle','-','Parent',EIXOS6);
        LINHA=line(yyc, xxc, zzc,'Parent',EIXOS6,'Color',[0 0 0],'LineStyle','-', 'LineWidth',2);
        if npx < 0, aqux = npx-0.06; else, aqux = npx+0.16; end
        if npy < 0, aquy = npy-0.06; else, aquy = npy+0.16; end
        aquz = npz + 0.16;
        text(aquy,aqux,aquz,'3','FontSize',6,'Parent',EIXOS6);

        % Rotor # 1

        npx = R2*(cps1*cth + sps1*sph*sth) + 0*sps1*cph + (hlinha + h2inha + L1/2)*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npy = R2*(-sps1*cth + cps1*sph*sth) + 0*cps1*cph + (hlinha + h2inha + L1/2)*(sps1*sth + cps1*sph*cth) + y(cont3);
        npz = R2*(sth*cph) - 0*sph + (hlinha + h2inha + L1/2)*(cth*cph) + z(cont3);
        npxo = 0*(cps1*cth + sps1*sph*sth) + 0*sps1*cph + (h2inha + L1/2)*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npyo = 0*(-sps1*cth + cps1*sph*sth) + 0*cps1*cph + (h2inha + L1/2)*(sps1*sth + cps1*sph*cth) + y(cont3);
        npzo = 0*(sth*cph) - 0*sph + (h2inha + L1/2)*(cth*cph) + z(cont3);
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
        efe=patch(yo,xo,zo,[0.9 0.9 0.9],'LineStyle','-','Parent',EIXOS6);
        LINHA=line(yyc, xxc, zzc,'Parent',EIXOS6,'Color',[0 0 0],'LineStyle','-', 'LineWidth',2);
        if npx < 0, aqux = npx-0.06; else, aqux = npx+0.16; end
        if npy < 0, aquy = npy-0.06; else, aquy = npy+0.16; end
        aquz = npz + 0.16;
        text(aquy,aqux,aquz,'1','FontSize',6,'Parent',EIXOS6);

    elseif SwitchCompl == 3
        
        % Local Frame 

        % X Axis

        xxc = [x(cont3) R2*(cps1*cth + sps1*sph*sth)+x(cont3)];
        yyc = [y(cont3) R2*(-sps1*cth + cps1*sph*sth)+y(cont3)];
        zzc = [z(cont3) R2*(sth*cph)+z(cont3)];
        LINHA=line(yyc, xxc, zzc, 'Parent',EIXOS6,'Color',[1 0 0],'LineStyle','-', 'LineWidth',2);
        py=[-0.02 0 0.02 0 -0.02];
        px=[0.33 0.37 0.33 0.35 0.33];
        pz=[0 0 0 0 0];
        npx = px*(cps1*cth + sps1*sph*sth) + py*sps1*cph + pz*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npy = px*(-sps1*cth + cps1*sph*sth) + py*cps1*cph + pz*(sps1*sth + cps1*sph*cth) + y(cont3);
        npz = px*(sth*cph) - py*sph + pz*(cth*cph) + z(cont3);
        efe=patch(npy, npx, npz, [1 0 0],'LineStyle','none','Parent',EIXOS6);

        % Y axis

        xxc = [x(cont3) R2*sps1*cph+x(cont3)];
        yyc = [y(cont3) R2*cps1*cph+y(cont3)];
        zzc = [z(cont3) -R2*sph+z(cont3)];
        LINHA=line(yyc, xxc, zzc, 'Parent',EIXOS6,'Color',[0 0 1],'LineStyle','-', 'LineWidth',2);
        px=[-0.02 0 0.02 0 -0.02];
        py=[0.33 0.37 0.33 0.35 0.33];
        pz=[0 0 0 0 0];
        npx = px*(cps1*cth + sps1*sph*sth) + py*sps1*cph + pz*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npy = px*(-sps1*cth + cps1*sph*sth) + py*cps1*cph + pz*(sps1*sth + cps1*sph*cth) + y(cont3);
        npz = px*(sth*cph) - py*sph + pz*(cth*cph) + z(cont3);
        efe=patch(npy, npx, npz, [0 0 1],'LineStyle','none','Parent',EIXOS6);

        % Z Axis

        xxc = [x(cont3); R2*(-cps1*sth + sps1*sph*cth)+x(cont3)];
        yyc = [y(cont3); R2*(sps1*sth + cps1*sph*cth)+y(cont3)];
        zzc = [z(cont3); R2*(cth*cph)+z(cont3)];
        LINHA=line(yyc, xxc, zzc, 'Parent',EIXOS6,'Color',[0 1 1],'LineStyle','-', 'LineWidth',2);
        px=[-0.02 0 0.02 0 -0.02];
        pz=[0.33 0.37 0.33 0.35 0.33];
        py=[0 0 0 0 0];
        npx = px*(cps1*cth + sps1*sph*sth) + py*sps1*cph + pz*(-cps1*sth + sps1*sph*cth) + x(cont3);
        npy = px*(-sps1*cth + cps1*sph*sth) + py*cps1*cph + pz*(sps1*sth + cps1*sph*cth) + y(cont3);
        npz = px*(sth*cph) - py*sph + pz*(cth*cph) + z(cont3);
        efe=patch(npy, npx, npz, [0 1 1],'LineStyle','none','Parent',EIXOS6);
        
    end
    
    % Path
    
    LINHA=line(y(1:cont3),x(1:cont3),z(1:cont3),'Parent',EIXOS6,'Color',[1 0 0],'LineStyle','-','LineWidth',0.4);

    %view(az3d,el3d);
    pause(0.01);
    
    % MOVIE
    
    % mb 2005
%     OS4movie(cont3)=getframe(EIXOS6,[leftframe bottomframe widthframe heightframe]);
            
end

set(FIGU2,'Pointer','arrow');

% mb 2005
%set(BOT_MOVIE,'Enable','on','Callback', ['set(BOT_SAVE_F, ''Enable'',''off'');',...
%    'set(EIXOS6,''Visible'',''off''); movie(OS4movie,1);']);
% mb 2005
%set(BOT_SAVE_M,'Enable','on','Callback',['TMP=get(gcbo,''Value'');',...
%      'if TMP, savemovie(OS4movie);end;']);

set(BOT_SAVE_F,'Enable','on');
set(BOT_SAIDA,'Enable','on');
set(BOT_RETURN,'Enable','on');
set(BOT_REPEAT,'Enable','on','Callback','repeatview(1)');
