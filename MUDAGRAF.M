% --------------------------------------------------------------
%                   ---  MUDAGRAF  ----
%
%  This function permits the user to select each approach he/she
%    wants to use to simulate the OS4 helicopter.
%  
%    Developed by Marcelo Becker & Samir Bouabdallah
%                   - EPFL ASL September, 2005 -
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
% ---------------------------------------------------------------

function MUDAGRAF(TIPO)

% Global variables declaration 

 global SwitchProc1  SwitchCompl                                     % used for the Selection of the Procedures
 global GRAF chbox                                                   % Radio Button
 global EDIT                                                         % Edit Text on Robox Window
 global EIXOS  EIXOS1  EIXOS2  EIXOS3
 global FIGU  FIGU1  FIGU2  FIGU3                                    % Figure parameters      
 global LINHA XLIMI YLIMI
 global x y z

% -------------------------------------------------------------------------

switch TIPO
   
case 1          %  Control Simulation
   
    set(GRAF(2),'Value',0);
    SwitchProc1 = 1;
   
case 2          % Obstacle Avoidance Simulation
   
    set(GRAF(1),'Value',0);
    SwitchProc1 = 2;

case 3
    
   SwitchCompl=1;
   set(chbox(2),'Value',0);
   set(chbox(3),'Value',0);
    
case 4
       
   SwitchCompl=2;
   set(chbox(1),'Value',0);
   set(chbox(3),'Value',0);
    
case 5
        
   SwitchCompl=3;
   set(chbox(1),'Value',0);
   set(chbox(2),'Value',0);

end


