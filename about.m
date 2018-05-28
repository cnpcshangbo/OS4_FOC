% ----------------------------------------------------------------
%                   ---  about  ---
%
%  This function shows the About... 
%    
%  
% Developed by Marcelo Becker & Samir Bouabdallah
%              - EPFL ASL September, 2005 -
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
% -----------------------------------------------------------------

function about(L)

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

%============================================
% Design of the Main Window  20/09/2005 (MB)
%============================================

disp('Openning About application...')

% Window parameters

TMP=get(0,'ScreenSize');
RSTELA=TMP(3:4);
COR_JANELA=[1 1 1];
TAM_FIG=[480 380];

FIGU3=figure('Name',sprintf('About...'),...
   'NumberTitle','off',...
   'MenuBar','none',...
   'Resize','on',...
   'Color',COR_JANELA,...
   'Position',[(RSTELA-TAM_FIG)/2 TAM_FIG]);


% Figure view

% % EPFL LOGO
% 
% POS_EIXOS2=[50 350];
% TAM_EIXOS2=[45 15];
% EIXOS2=axes('Box','on','Units','pixels','Position',[POS_EIXOS2 TAM_EIXOS2]);
% RGB = imread('epfl_logo.jpg');
% imshow(RGB)
% 
% % ASL LOGO
% 
% POS_EIXOS3=[380 350];
% TAM_EIXOS3=[60 20];
% EIXOS3=axes('Box','on','Units','pixels','Position',[POS_EIXOS3 TAM_EIXOS3]);
% RGB = imread('logoASL.jpg');
% imshow(RGB)
% 
% uicontrol('Style','text','Position',[120 350 250 20],'BackgroundColor',COR_JANELA,...
%    'String','École Polytechnique Fédérale de Lausanne','FontSize',8,'FontWeight','bold');
% uicontrol('Style','text','Position',[120 330 250 20],'BackgroundColor',COR_JANELA,...
%    'String','Autonomous System Lab','FontSize',10,'FontWeight','bold');

% % Marcelo Image
% 
% POS_EIXOS1=[20 100];
% TAM_EIXOS1=[100 100];
% EIXOS1=axes('Box','on','Units','pixels','Position',[POS_EIXOS1 TAM_EIXOS1]);
% RGB = imread('marcelobecker.jpg');
% imshow(RGB)
% 
% % Samir Image
% 
% POS_EIXOS1=[20 220];
% TAM_EIXOS1=[100 100];
% EIXOS1=axes('Box','on','Units','pixels','Position',[POS_EIXOS1 TAM_EIXOS1]);
% RGB = imread('samir.jpg');
% imshow(RGB)

% Text 

uicontrol('Style','text','Position',[130 170 320 150],'BackgroundColor',COR_JANELA,...
    'FontSize',10,'HorizontalAlignment','Left','String',sprintf('OS4 (Omnidirectional Stationary Flying OUtstretched Robot) is an electrically powered four-rotors miniature helicopter developed towards fully autonomous operation in indoor/outdoor environments. The major goal of this research is the development and implementation of an active control system for a quadrotor helicopter.'));
uicontrol('Style','text','Position',[130 100 320 90],'BackgroundColor',COR_JANELA,...
   'FontSize',10,'HorizontalAlignment','Left','String','This software was developed in order to facilitate the OS4 obstacle avoidance procedure development. We started the work at the Autonomous System Lab - EPFL, Lausanne - Switzerland in October 2005.');
uicontrol('Style','text','Position',[130 50 320 40],'BackgroundColor',COR_JANELA,...
   'FontSize',10,'HorizontalAlignment','Left','String','Feel free to contact us by e-mail:');
uicontrol('Style','text','Position',[130 30 320 40],'BackgroundColor',COR_JANELA,...
   'FontSize',10,'HorizontalAlignment','Left','String','samir.bouabdallah@epfl.ch     marcelo.becker@epfl.ch');

% Ok Button

BOT_MAPA=uicontrol('Position',[380 10 40 20],'String','Ok',...
   'BackgroundColor',COR_JANELA,'Callback','close;');
