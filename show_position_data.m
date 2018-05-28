% ----------------------------------------------------------------
%                   ---  show_data  ----
%
%  This function displaies the OS4 simulation data. 
%    
%  
% Developed by Marcelo Becker & Samir Bouabdallah
%              - EPFL ASL October, 2005 -
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

% -----------------------------------------------------------------

function show_position_data(L)

% Global variables declaration 

 global SwitchProc1                                                  % used for the Selection of the Procedures
 global GRAF                                                         % Radio Button
 global EDIT                                                         % Edit Text on Robox Window
 global EIXOS EIXOS1 EIXOS2 EIXOS3 EIXOS4 EIXOS5 EIXOS6
 global FIGU  FIGU1  FIGU2  FIGU3  FIGU4                             % Figure parameters      
 global LINHA XLIMI YLIMI
 global x y z
 global roll pitch yaw tout
 global OS4movie BOT_SAVE_F

% -------------------------------------------------------------------------

%========================
% Building the Interface
%========================

% Screen Resolution 

TMP=get(0,'ScreenSize');
RSTELA=TMP(3:4);

FOLGA=20;
COR_JANELA=[1 1 1];

TAM_FIG=[900 600];
FIGU2 = figure('Name',sprintf('  OS4 - Position Data'),...
   'NumberTitle','off',...
   'MenuBar','figure',...
   'Resize','on',...
   'NextPlot','replacechildren',...
   'Color',COR_JANELA,...
   'Position',[(RSTELA-TAM_FIG)/2 TAM_FIG]);

% Figures
% -------

% Position figure

POS_EIXOS4=[80 200];
TAM_EIXOS4=[350 350];
EIXOS4=axes('Box','on','Units','pixels','Position',[POS_EIXOS4 TAM_EIXOS4]);
TEXTOX4=xlabel('Time   [sec]','Parent',EIXOS4);
TEXTOY4=ylabel('Position   [m]','Parent',EIXOS4);
TITULO4=title('OS4 Position','Parent',EIXOS4,...
'FontSize',12,'FontWeight','bold');

% Position Ratio figure

POS_EIXOS5=[500 200];
TAM_EIXOS5=[350 350];
EIXOS5=axes('Box','on','Units','pixels','Position',[POS_EIXOS5 TAM_EIXOS5]);
TEXTOX5=xlabel('Time   [sec]','Parent',EIXOS5);
TEXTOY5=ylabel('Position Ratio   [m/sec]','Parent',EIXOS5);
TITULO5=title('OS4 Position Ratios','Parent',EIXOS5,...
'FontSize',12,'FontWeight','bold');


% Checkboxes to enable or not the grid lines
% -------------------------------------------

GRADE1=uicontrol('Style','checkbox','Value',0,'Position',[100 120 110 20],...
   'BackgroundColor',COR_JANELA,'String','Enable Grid Lines','Callback',['TMP=get(gcbo,''Value'');',...
      'if TMP, set(EIXOS4,''XGrid'',''on'',''YGrid'',''on'');',...
      'else, set(EIXOS4,''XGrid'',''off'',''YGrid'',''off''); end;']);

GRADE2=uicontrol('Style','checkbox','Value',0,'Position',[520 120 110 20],...
   'BackgroundColor',COR_JANELA,'String','Enable Grid Lines','Callback',['TMP=get(gcbo,''Value'');',...
      'if TMP, set(EIXOS5,''XGrid'',''on'',''YGrid'',''on'');',...
      'else, set(EIXOS5,''XGrid'',''off'',''YGrid'',''off''); end;']);

  
% Checkboxes to enable or not the position data
% ----------------------------------------------

POS(1)=uicontrol('Style','checkbox','Value',1,'Position',[100 80 100 20],...
   'BackgroundColor',COR_JANELA,'String','X position','ForegroundColor','red','UserData',1);

POS(2)=uicontrol('Style','checkbox','Value',1,'Position',[220 80 100 20],...
   'BackgroundColor',COR_JANELA,'String','Y position','ForegroundColor',[0.75 0 0.75],'UserData',2);

POS(3)=uicontrol('Style','checkbox','Value',1,'Position',[340 80 110 20],...
   'BackgroundColor',COR_JANELA,'String','Z position','ForegroundColor','blue','UserData',3);


% Checkboxes to enable or not the position ratio data
% ----------------------------------------------------

POS(4)=uicontrol('Style','checkbox','Value',1,'Position',[520 80 100 20],...
   'BackgroundColor',COR_JANELA,'String','X ratio','ForegroundColor','red','UserData',4);

POS(5)=uicontrol('Style','checkbox','Value',1,'Position',[640 80 100 20],...
   'BackgroundColor',COR_JANELA,'String','Y ratio','ForegroundColor',[0.75 0 0.75],'UserData',5);

POS(6)=uicontrol('Style','checkbox','Value',1,'Position',[760 80 110 20],...
   'BackgroundColor',COR_JANELA,'String','Z ratio','ForegroundColor','blue','UserData',6);


% Buttons
% -------

% SAVE Figure Button

BOT_SAVE=uicontrol('Position',[400 20 100 20],'String','Save Figure',...
   'BackgroundColor',COR_JANELA,'Callback','salvaimg(FIGU2,3);');

% EXIT Button

BOT_SAIDA=uicontrol('Position',[250 20 100 20],'String','Exit',...
   'BackgroundColor',COR_JANELA,'Callback','close all;');

% RETURN Button

BOT_RETURN=uicontrol('Position',[550 20 100 20],'String','Return',...
   'BackgroundColor',COR_JANELA,'Callback','close;');

% Initial Plots
% -------------

LINHA(1)=line(tout,x, 'Parent',EIXOS4,'Color',[1 0 0],'LineStyle','-', 'LineWidth',0.4);
LINHA(2)=line(tout,y, 'Parent',EIXOS4,'Color',[0.75 0 0.75],'LineStyle','-', 'LineWidth',0.4);
LINHA(3)=line(tout,z, 'Parent',EIXOS4,'Color',[0 0 1],'LineStyle','-', 'LineWidth',0.4);

ddx=diff(x);
ddy=diff(y);
ddz=diff(z);

[cont1 cont2]=size(x);

LINHA(4)=line(tout(1:cont1-1),ddx, 'Parent',EIXOS5,'Color',[1 0 0],'LineStyle','-', 'LineWidth',0.4);
LINHA(5)=line(tout(1:cont1-1),ddy, 'Parent',EIXOS5,'Color',[0.75 0 0.75],'LineStyle','-', 'LineWidth',0.4);
LINHA(6)=line(tout(1:cont1-1),ddz, 'Parent',EIXOS5,'Color',[0 0 1],'LineStyle','-', 'LineWidth',0.4);

for I2=1:6
   
   set(POS(I2),'Enable','on','Callback',...
      ['TMP=get(gcbo,''Value''); I2=get(gcbo,''UserData'');',...
         'if TMP, set(LINHA(I2),''Visible'',''on'');',...
         'else, set(LINHA(I2),''Visible'',''off''); end;']);
end



