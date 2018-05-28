
% ------------------------------------------------------------------
%                   ---  OS4  ----
%
%  This Program shows the initial window for the obstacle avoidance 
%      procedure developed for the OS4 helicopter. 
%      
%      Developed by Marcelo Becker & Samir Bouabdallah 
%               
%                   - EPFL ASL October, 2005 -
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
% ------------------------------------------------------------------

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

%============================================
% Design of the Main Window  05/10/2005 (MB)
%============================================

L=1;

% Window parameters

TMP=get(0,'ScreenSize');
RSTELA=TMP(3:4);
COR_JANELA=[1 1 1];
TIPOGRAF=1;
TAM_FIG=[480 380];
SwitchProc1 = 1;                      % Initialization of the parameter: Show Sensor Data


FIGU=figure('Name',sprintf('  OS4 - EPFL - Autonomous System Lab'),...
   'NumberTitle','off',...
   'MenuBar','none',...
   'Resize','on',...
   'Color',COR_JANELA,...
   'Position',[(RSTELA-TAM_FIG)/2 TAM_FIG]);


% Figure view
% -----------

% % OS4 Image
% 
%  POS_EIXOS1=[20 0];
%  TAM_EIXOS1=[200 200];
%  EIXOS1=axes('Box','on','Units','pixels','Position',[POS_EIXOS1 TAM_EIXOS1]);
%  RGB = imread('newos4vlr.jpg');
%  imshow(RGB)
% 
% % EPFL LOGO
% 
%  POS_EIXOS2=[20 340];
%  TAM_EIXOS2=[90 30];
%  EIXOS2=axes('Box','on','Units','pixels','Position',[POS_EIXOS2 TAM_EIXOS2]);
%  RGB = imread('epfl_logo.jpg');
%  imshow(RGB)
% 
% % ASL LOGO
% 
%  POS_EIXOS3=[380 330];
%  TAM_EIXOS3=[120 40];
%  EIXOS3=axes('Box','on','Units','pixels','Position',[POS_EIXOS3 TAM_EIXOS3]);
%  RGB = imread('logoASL.jpg');
%  imshow(RGB)

 uicontrol('Style','text','Position',[135 350 250 20],'BackgroundColor',COR_JANELA,...
    'String','École Polytechnique Fédérale de Lausanne','FontSize',8,'FontWeight','bold');
 uicontrol('Style','text','Position',[135 330 250 20],'BackgroundColor',COR_JANELA,...
    'String','Autonomous System Lab','FontSize',10,'FontWeight','bold');
uicontrol('Style','text','Position',[20 200 200 120],'BackgroundColor',COR_JANELA,...
   'String','OS4','FontSize',65,'FontWeight','bold','HorizontalAlignment','Center');
uicontrol('Style','text','Position',[20 255 250 15],'BackgroundColor',COR_JANELA,...
   'String',' ','FontSize',8,'FontWeight','bold');
uicontrol('Style','text','Position',[20 180 200 40],'BackgroundColor',COR_JANELA,...
   'String','Omnidirectional Stationary Flying OUtstretched Robot','FontSize',11,'FontWeight','bold');

% Function Selection 
% ------------------

uicontrol('Style','text','Position',[240 160 100 20],'BackgroundColor',COR_JANELA,...
   'FontSize',10,'HorizontalAlignment','Left','String','Select an option:');

GRAF(1)=uicontrol('Style','radiobutton','Value',1,'Position',...
   [250 130 200 20],...
   'BackgroundColor',COR_JANELA,'String','Control Simulation',...
   'UserData',1,'FontSize',10,'Callback',['TIPOGRAF=get(gcbo,''UserData'');',...
      'mudagraf(TIPOGRAF);']);

GRAF(2)=uicontrol('Style','radiobutton','Value',0,'Enable','on','Position',...
      [250 100 210 20],...
      'BackgroundColor',COR_JANELA,'String','Obstacle Avoidance Simulation',...
      'UserData',2,'FontSize',10,'Callback',['TIPOGRAF=get(gcbo,''UserData'');',...
      'mudagraf(TIPOGRAF);']);


% Buttons
% -------

% SAVE Button

BOT_SALVA=uicontrol('Position',[360 50 100 20],'String','Save Figure',...
   'BackgroundColor',COR_JANELA,'Callback','salvaimg(FIGU,1);');

% Ok Button

BOT_SIM=uicontrol('Position',[240 50 100 20],'String','Ok',...
   'BackgroundColor',COR_JANELA,'Callback',['if SwitchProc1 == 1, close; visual(L);',...
       'else,  end']);   % still missing... the obstacle avoidance simulation   % mb 2005

% Exit Button

BOT_SAIDA=uicontrol('Position',[240 20 100 20],'String','Exit',...
   'BackgroundColor',COR_JANELA,'Callback','close;');

% About Button

BOT_ABOUT=uicontrol('Position',[360 20 100 20],'String','About...',...
   'BackgroundColor',COR_JANELA,'Callback','about(L);');

