% ----------------------------------------------------------------
%                   ---  show_sensor_data  ----
%
%  This function displaies the ROBOX robot data. 
%    
%  
% Developed by Marcelo Becker - EPFL ASL September, 2005
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

function show_sensor_data(L)

% Global variables declaration 

global SwitchProc1  SwitchProc2  SwitchProc3                        % used for the Selection of the Procedures
global minNr                                                        % Initial File Number
global maxNr                                                        % Final File Number
global GRAF                                                         % Radio Button
global EDIT                                                         % Edit Text on Robox Window
global L
global InitialFileName                                              % Name of the Initial File
global FinalFileName                                                % Name of the Final File
global InitialFilePath                                              % Path of the Initial File
global FinalFilePath                                                % Path of the Final File
global Root_FN                                                      % File Name Root
global Folder_Path                                                  % File Path
global TEXTOX TEXTOY                                                % Figure2 parameters
global TITULO  EIXOS  LEGENDA                                       % Figure2 parameters      
global FIGURA  FIGU  FIGU2                                          % Figure parameters      
global obstQuantity  obstBeginning  obstEnd  dist2Obst  ang2Obst    % Sensor data derivation Approach
global der1  der2  der3  SSMedian1                                  % Sensor data derivation Approach variables
global LINHA XLIMI YLIMI
global Observation_radius  positionROBOX cellQuantity               % Figure Parameters
global xxc yyc scans_p_sensor CGx CGy maxNrsets                     % Figure Parameters
global obstBeginning obstEnd angulo distancia nrset                 % Figure Parameters
global sizegrid robotradius contmob setcells Ka ncells
global xrealoccup yrealoccup OldSetCells time2GetNewScan 
global NewMoMatched OldMoMatched VelObst ThetaObst
global minimumdist nrcellp

% -------------------------------------------------------------------------

%========================
% Building the Interface
%========================

% Screen Resolution 

TMP=get(0,'ScreenSize');
RSTELA=TMP(3:4);

FOLGA=20;
COR_JANELA=[1 1 1];

TAM_FIG=[600 500];
FIGU2 = figure('NumberTitle','off',...
   'MenuBar','figure',...
   'Resize','on',...
   'NextPlot','replacechildren',...
   'Color',COR_JANELA,...
   'Position',[(RSTELA-TAM_FIG)/2 TAM_FIG]);


% Checkbox to use grid on figure

GRADE=uicontrol('Style','checkbox','Value',0,'Position',[450 230 110 20],...
   'BackgroundColor',COR_JANELA,'String','Enable Grid Lines','Callback',['TMP=get(gcbo,''Value'');',...
      'if TMP, set(EIXOS,''XGrid'',''on'',''YGrid'',''on'');',...
      'else, set(EIXOS,''XGrid'',''off'',''YGrid'',''off''); end;']);

% Checkbox to show the data uncertainties on figure

Uncert=uicontrol('Style','checkbox','Value',0,'Position',[450 200 110 20],...
   'BackgroundColor',COR_JANELA,'String','Data Uncertainties','Callback',['TMP=get(gcbo,''Value'');',...
      'if TMP, set(EIXOS,''XGrid'',''on'',''YGrid'',''on'');',...
      'else, set(EIXOS,''XGrid'',''off'',''YGrid'',''off''); end;']);


POS_EIXOS=[80 100];
TAM_EIXOS=[350 350];
EIXOS=axes('Box','on','Units','pixels','Position',[POS_EIXOS TAM_EIXOS]);
TEXTOX=xlabel('X axis   [m]','Parent',EIXOS);
TEXTOY=ylabel('Y axis   [m]','Parent',EIXOS);
TITULO=title('ROBOX Sensor Data in Cartesian Plane','Parent',EIXOS,...
'FontSize',12,'FontWeight','bold');

% Restore Figure Button

BOT_REST=uicontrol('Position',[450 350 100 20],'String','Restore Figure',...
   'BackgroundColor',COR_JANELA,'Callback',...
   ['set(EIXOS,''XLimMode'',''manual''); set(EIXOS,''YLimMode'',''manual'');',...
      'XLIMI=[-10 10];','YLIMI=[-10 10];','set(EIXOS,''XLim'',XLIMI);',...
      'set(EIXOS,''YLim'',YLIMI);',...
      'set(EDIT(3),''String'',num2str(XLIMI(1)));',...
      'set(EDIT(4),''String'',num2str(XLIMI(2)));',...
      'set(EDIT(5),''String'',num2str(YLIMI(1)));',...
      'set(EDIT(6),''String'',num2str(YLIMI(2)));']);


% SAVE Figura Button

BOT_SAVE=uicontrol('Position',[450 310 100 20],'String','Save Figure',...
   'BackgroundColor',COR_JANELA,'Callback','savegraph(FIGU);');

% Return Button

L=1;
BOT_SAIDA=uicontrol('Position',[450 270 100 20],'String','Return',...
   'BackgroundColor',COR_JANELA,'Callback','close; robox;');


% Controle para ZOOM da Figura

uicontrol('Style','text','Position',[60 15 40 20],'BackgroundColor',COR_JANELA,...
   'String','Xmin:');
uicontrol('Style','text','Position',[180 15 40 20],'BackgroundColor',COR_JANELA,...
   'String','Xmax:');
uicontrol('Style','text','Position',[300 15 40 20],'BackgroundColor',COR_JANELA,...
   'String','Ymin:');
uicontrol('Style','text','Position',[420 15 40 20],'BackgroundColor',COR_JANELA,...
   'String','Ymax:');


% counters initialization
	
cont1 = 0;      % Total data storaged

% Data input
% ----------

for nr=minNr:1:maxNr,
   
  cont1 = cont1 + 1;
    
  % Read the sensor data
  
  if nr < 10
    name=[strcat(Root_FN, sprintf('_0000%1d_scan.dat',nr))]; 
  elseif nr < 100
    name=[strcat(Root_FN, sprintf('_000%2d_scan.dat',nr))];  
  elseif nr < 1000
    name=[strcat(Root_FN, sprintf('_00%3d_scan.dat',nr))];  
  elseif nr < 10000
    name=[strcat(Root_FN, sprintf('_0%4d_scan.dat',nr))];  
  elseif nr < 100000
    name=[strcat(Root_FN, sprintf('_%5d_scan.dat',nr))];  
  end
  
  scan=importdata([Folder_Path name]);
  
  disp('Openning Files...')
  
  % Read the Robox data

  if nr < 10
    name=[strcat(Root_FN, sprintf('_0000%1d_misc.dat',nr))]; 
  elseif nr < 100
    name=[strcat(Root_FN, sprintf('_000%2d_misc.dat',nr))];  
  elseif nr < 1000
    name=[strcat(Root_FN, sprintf('_00%3d_misc.dat',nr))];  
  elseif nr < 10000
    name=[strcat(Root_FN, sprintf('_0%4d_misc.dat',nr))];  
  elseif nr < 100000
    name=[strcat(Root_FN, sprintf('_%5d_misc.dat',nr))];  
  end

    [position] = textread([Folder_Path name],'%n','delimiter','\n','whitespace','');

   % position' = [1 time x y theta] 

    time(cont1) = position(2);                           % processing time [msec]
    posXROBOX(cont1) = position(3);
    posYROBOX(cont1) = position(4);
    thetaROBOX(cont1) = position(5);
    positionROBOX = [posXROBOX' posYROBOX' thetaROBOX'];

	% input data storage: polar data
    % One should observe that we are using a local and polar coordenate system
	
	distancia = scan(:,2);
    angulo = thetaROBOX(cont1) + scan(:,1);
    [xxc, yyc] = polar2cart(distancia,angulo);
	[s1 s2] = size(distancia);
    
    
    cla;            % Clear de axes area
    
    set(FIGU2,'Name',sprintf('Sensor Data - [%s]',name));

    set(EIXOS,'XLimMode','manual');
    set(EIXOS,'YLimMode','manual');
    XLIMI=[-10 10];
    YLIMI=[-10 10];
    set(EIXOS,'XLim',XLIMI);
    set(EIXOS,'YLim',YLIMI);

    efe=patch(xxc, yyc,[0.95 0.95 0.95],'LineStyle','-');
 
    LINHA=line(xxc,yyc,'Parent',EIXOS,'Marker','.','Color','blue', 'LineStyle', 'none');

    drawROBOX2D(0,0,positionROBOX(cont1,3));
	
    pause(0.5);

    
end

EDIT(3)=uicontrol('Style','edit','Position',[100 20 60 20],'BackgroundColor',[1 1 1],...
   'String',num2str(XLIMI(1)),'Callback',['XLIMI(1)=str2num(get(gcbo,''String''));',...
      'set(EIXOS,''XLim'',XLIMI);']);
EDIT(4)=uicontrol('Style','edit','Position',[220 20 60 20],'BackgroundColor',[1 1 1],...
   'String',num2str(XLIMI(2)),'Callback',['XLIMI(2)=str2num(get(gcbo,''String''));',...
      'set(EIXOS,''XLim'',XLIMI);']);
EDIT(5)=uicontrol('Style','edit','Position',[340 20 60 20],'BackgroundColor',[1 1 1],...
   'String',num2str(YLIMI(1)),'Callback',['YLIMI(1)=str2num(get(gcbo,''String''));',...
      'set(EIXOS,''YLim'',YLIMI);']);
EDIT(6)=uicontrol('Style','edit','Position',[460 20 60 20],'BackgroundColor',[1 1 1],...
   'String',num2str(YLIMI(2)),'Callback',['YLIMI(2)=str2num(get(gcbo,''String''));',...
      'set(EIXOS,''YLim'',YLIMI);']);
