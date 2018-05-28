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

% PLOT THE 3D TRAJECTORY OF OS4

glob;

% ********* DEG2RAD ********* 
%roll=roll*deg2rad;  % Transform deg2rad [rad]
%pitch=pitch*deg2rad;  % Transform deg2rad [rad]
%yaw=yaw*deg2rad;  % Transform deg2rad [rad]


hf = figure(1);
cameratoolbar('Show');
cameratoolbar('SetMode','orbit');
set(gcf,'MenuBar','figure','Renderer','OpenGL');
hold on;
axis vis3d;
view(3);
zoom(0.6);
set(gca,'Visible','On','Box','On','XGrid', 'Off','YGrid', 'Off','ZGrid', 'Off','projection','perspective');
% display coordinate frame at origin
hold off;
hold on;
drawH(eye(4),1,'ORIGIN',[0 0 0]);
for i=1:length(x),
    if (i>1),
        drawnow;
        delete(h.hx);
        delete(h.hy);
        delete(h.hz);
        delete(h.htext);
    end
    H_w_heli = Hom([x(i),y(i),z(i),yaw(i),pitch(i),roll(i)]');
    h = drawH(H_w_heli,0.3,'heli',[1 0 0]);
    
    %set camera
    campos([x(i),y(i)-(i*0.01+2),z(i)]);
    camup([0 0 1]');
    camtarget([x(i),y(i),z(i)]);
end
hold off;
out=0;
