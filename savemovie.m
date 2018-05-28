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

function savemovie(OS4movie)

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

SEMNOME=1;

while SEMNOME
   [ARQUIVO,CAMINHO]=uiputfile('*.avi','Save Movie As...');
   if ARQUIVO==0
      return
   end
   
   NTMP=length(ARQUIVO);
   if NTMP>4
      FLAG=~strcmp(upper(ARQUIVO(NTMP-3:NTMP)),'.AVI');
   else
      FLAG=1;
   end
   
   if FLAG
      ARQUIVO=strcat(ARQUIVO,'.AVI'); 
            
      if exist(strcat(CAMINHO,ARQUIVO))
         RESP=questdlg('There is a file which name is the same! Do you want to overwrite it?',...
            'Save file','YES','NO','NO');
         if strcmp(RESP,'YES')
            SEMNOME=0;
         end
      else
         SEMNOME=0;
      end
   else
      SEMNOME=0;
   end 
   
end 

set(FIGU2,'Pointer','watch');

pause(0.01);

movie2avi(OS4movie,strcat(CAMINHO,ARQUIVO),'quality',100, 'compression','none');

set(FIGU2,'Pointer','arrow');

% Recommended options for compression

%'Indeo3'
%'Indeo5'  -> standard
%'None'

