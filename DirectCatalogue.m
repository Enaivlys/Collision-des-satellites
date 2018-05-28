%Ce script renvoie le MOID de chaque satellite du catalogue à l'aide de
%DIRECT, dans un vecteur MoidCatalogue

%Le fichier data contient un vecteur ligne de taille 99*6=594
%99: nombre de satellite
%6: nombre de parametres (nom,a,e,i,w,omega)
%chaque 6 cases consécutives correspondent aux 6 parametres de chaque
%satellite

%PS: avant de lancer le programme, penser à importer le fichier data.txt
%(nécessaire pour la construction la matrice), en selectionnant l'option
%"numeric matrix". 


global Q_Terre; global E; global P_Terre; 
global q_autre; global e; global p_autre; 
global K; global M; global N; global L


%S: matrice de taille 99*6
S=zeros(99,6);
for nl=1:99
    for nc=1:6
        S(nl,nc)=data(6*(nl-1)+nc);
    end
end

%Q: perihelion distance de la terre
Q_Terre=0.98329;
E=0.01671123;
P_Terre=Q_Terre*(1+E);
w1=114.20783*pi/180;
omega1=348.73936*pi/180;
i1= 0.00005*pi/180;
Px = cos(w1);
Py = sin(w1)*cos(i1);
Pz = sin(w1)*sin(i1);

Qx = -sin(w1) ;
Qy = cos(w1)*cos(i1); 
Qz = cos(w1)*sin(i1);

%Q: perihelion distance de la terre
%q: perihelion distance du satellite

% E:excentricité de la terre 
% e: excentricité du satellite

%w1: argument of perihelion de la terre
%w2: argument of perihelion du satellite

%omega1:longitude du periapside (terre)
%omega2:longitude du periapside du satellite

%i1: inclination de la terre
%i2: inclinaison du satellite

% true anomaly
V1=[0:0.01:2*pi];
V2=[0:0.01:2*pi];
bounds = [0 2*pi; 0 2*pi];

for h=1:99
    
% conic parameters
    e=S(h,3);
    if e>0 && e<1
        a=S(h,2);
        i2=S(h,4)*pi/180;
        omega2=S(h,5)*pi/180;
        w2=S(h,6)*pi/180;
        q_autre=(1-e)*a; 
        p_autre=q_autre*(1+e);


        %On prend que les ellipses. 

        % orbits components
        px = cos(w2)*cos(omega2-omega1)- sin(w2)*cos(i2)*sin(omega2-omega1);
        py = cos(w2)*sin(omega2-omega1) + sin(w2)*cos(i2)*cos(omega2-omega1);
        pz = sin(w2)*sin(i2);

        qx = -sin(w2)*cos(omega2-omega1) - cos(w2)*cos(i2)*sin(omega2-omega1);
        qy = -sin(w2)*sin(omega2-omega1) + cos(w2)*cos(i2)*cos(omega2-omega1);
        qz = cos(w2)*sin(i2);

        K = Px*px + Py*py + Pz*pz;
        L = Qx*px + Qy*py + Qz*pz;
        M = Px*qx + Py*qy + Pz*qz;
        N = Qx*qx + Qy*qy + Qz*qz;
    end
    
    Problem.f = 'dCat';
    [fmin,xmin] = Direct(Problem,bounds);
    MoidCatalogue(h)=fmin;
end

seuil_temporel = 0.2;
i=find(MoidCatalogue<seuil_temporel);
risque=S(i,1);
%risque est le vecteur contenant le nom des satellites ayant un MOID < 0.2



