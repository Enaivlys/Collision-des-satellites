global Q; global E; global P; global R;
global q; global e; global p; global r;
global K; global M; global N; global L;

%orbite terrestre
Q=0.9832898912; %UA
E=0.01671022;
i1=0.00005*2*pi/360;    %radian
%OMEGA1=174.873*2*pi/360;
OMEGA1=-11.26064*2*pi/360;  %radian
%omega1=288.064*2*pi/360;
omega1=114.2078*2*pi/360;   %radian

%{
%orbite de 2004LG
q=0.2126;   %UA
e=0.897079;
i2=70.933*2*pi/360; %radian
OMEGA2=256.89*2*pi/360; %radian
omega2=164.675*2*pi/360;    %radian
%}

%orbite d'Eros
q=1.1332;   %UA
e=0.222679;
i2=10.829*2*pi/360; %radian
OMEGA2=304.33*2*pi/360; %radian
omega2=178.798*2*pi/360;    %radian


h1=0.01;
h2=0.01;
v1=[0:h1:2*pi]';
v2=[0:h2:2*pi]';
P=Q*(1+E);  %pour la terre
p=q*(1+e);  %pour 2004LG

%R=P./(1+E*cos(v1)); %vecteur
%r=p./(1+e*cos(v2)); %vecteur

Px=cos(omega1);
Py=sin(omega1)*cos(i1);
Pz=sin(omega1)*sin(i1);
Qx=-sin(omega1);
Qy=cos(omega1)*cos(i1);
Qz=cos(omega1)*sin(i1);
px=cos(omega2)*cos(OMEGA2-OMEGA1)-sin(omega2)*cos(i2)*sin(OMEGA2-OMEGA1);
py=cos(omega2)*sin(OMEGA2-OMEGA1)+sin(omega2)*cos(i2)*cos(OMEGA2-OMEGA1);
pz=sin(omega2)*sin(i2);
qx=-sin(omega2)*cos(OMEGA2-OMEGA1)-cos(omega2)*cos(i2)*sin(OMEGA2-OMEGA1);
qy=-sin(omega2)*sin(OMEGA2-OMEGA1)+cos(omega2)*cos(i2)*cos(OMEGA2-OMEGA1);
qz=cos(omega2)*sin(i2);

K=Px*px+Py*py+Pz*pz
L=Qx*px+Qy*py+Qz*pz
M=Px*qx+Py*qy+Pz*qz
N=Qx*qx+Qy*qy+Qz*qz

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%D=dist(R,r,K,L,M,N,v1,v2);
%surf(D)
%contour(D)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bounds = [0 2*pi; 0 2*pi];%les bornes de v1 et v2
options.testflag  = 0; %0/1 le min_global est inconnu/connu
options.globalmin = 0.; %la valeur du min_global
options.showits   = 0; %0/1 afficher les iterations O/N
options.tol       = 0.01; %marge d'erreur avec le min_global si connu
options.maxits = 20; %nbr max d'iterations
options.maxevals  = 300;%nbr max d'évaluations

Problem.f = 'dSat'; 
[fmin,xmin] = Direct(Problem,bounds,options)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%








