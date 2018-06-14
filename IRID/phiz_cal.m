gam=0.9885;
Ts=.01;
dfod=irid_fod(gam,Ts,5);
kp=1.5489;
ki=0.8829;
cd=kp*(1+ki*dfod);

s=tf('s');
K=0.8592; T1=1.0710;
p=K/(T1*s+1)/s;
pd=c2d(p,Ts,'tustin');%plant

phiz=cd*pd/(1+cd*pd);%