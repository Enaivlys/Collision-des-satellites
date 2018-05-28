%Ce script calcule et renvoie le MOID entre Eros et et la terre, les valeurs d'albert
%étant commentées.
%le programme doit renvoyer ~0.1489 


% perihelion distance
Q_Terre=0.98329;
q_autre=1.1332;  % Eros
%q_autre=1.973;  % Albert

% eccentricity
E=0.01671123;   
e=0.222666;    % Eros
%e=0.546287;     % Albert

% argument of perihelion
w1=114.20783*pi/180;
%w2=156.138*pi/180;  % Albert
w2=178.802*pi/180;    % Eros

% ascending node
omega1=348.73936*pi/180;
%omega2=183.899*pi/180;  % Albert
omega2=304.317*pi/180;    % Eros

% inclination
i1= 0.00005*pi/180;
%i2=11.566*pi/180;   % Albert
i2=10.828*pi/180;     % Eros

% true anomaly
V=[0:0.01:2*pi];

% conic parameters
P_Terre=Q_Terre*(1+E);
p_autre=q_autre*(1+e);

% orbits' components
Px = cos(w1);
Py = sin(w1)*cos(i1);
Pz = sin(w1)*sin(i1);

Qx = -sin(w1) ;
Qy = cos(w1)*cos(i1); 
Qz = cos(w1)*sin(i1);

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

% MOID
    for i=1:length(V)
        R=P_Terre/(1+E*cos(V(i)));
        for j=1:length(V)
            r=p_autre/(1+e*cos(V(j)));

            d2(i,j)=R^2+r^2-2*R*r*cos(V(i))*cos(V(j))*K-2*R*r*cos(V(i))*sin(V(j))*M-2*R*r*sin(V(i))*cos(V(j))*L-2*R*r*sin(V(j))*sin(V(i))*N;

        end
    end

moid=sqrt(min(min(d2)))

[i,j]=find(d2==min(min(d2)))

j %est l'ordonnee du MOID^2

V(j)
%v(j) est l'anomalie vrai au periapside

%[i,j]=find(matrice==valeur)
%i, j sont les coordonnées de valeur dans matrice 




