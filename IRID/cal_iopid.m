s=tf('s');
kp=2.29;
ki=0.54;
kd=2.13;
c=kp+ki/s+kd*s;
cd=c2d(c,0.01,'tustin');
cd.num{1}
cd.den{1}