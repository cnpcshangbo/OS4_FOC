% Calculating IOPID controller parameters.

s=tf('s');
kp=1.58;
ki=0.182;
kd=1.49;
c=kp+ki/s+kd*s;
% cd=c2d(c,0.01,'matched');
cd=c2d(c,0.01,'tustin');
num=cd.num{1};
den=cd.den{1};