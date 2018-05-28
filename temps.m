function temps()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%\\\PARTIE 1///%%%%%%%%%%%%%%%%%%%%%%% 

%les 2 objets pris dans cette fonction sont la Terre et Eros.
%Dans cette partie, on calcule tc1, tc2 les instants de passage de la
%Terre, respectivement d'Eros par la conjonction. 
%Pour cela, on récupère les anomalies vraies renvoyées par Direct ensuite 
%on calcule Ec1, Ec2 par l'equation de Kepler.


%Q1,e1,v1: parametres de la Terre.
%Q2,e2,v2: parametres d'Eros.

Q1 = 0.98329; %(ua)
e1 = 0.01671123;
P1 = Q1*(1+e1); % parametre conique Terre

Q2 = 1.1332;    %(ua)
e2 = 0.222666 ;
P2 = Q2*(1+e2); % parametre conique Eros

% parametre gravitationnel
mu = 132712440018*10^9; %(m^3*s^-2)

% anomalies vraies, données par Direct au MOID
progSat;
v1=xmin(1);
v2=xmin(2);

x1=(P1*cos(v1))/(1+e1*cos(v1));
y1= (P1*sin(v1))/(1+e1*cos(v1));

x2=(P2*cos(v2))/(1+e2*cos(v2));
y2=(P2*sin(v2))/(1+e2*cos(v2));

Ec1 = 2*atan( -sqrt(1-e1)/ ( sqrt(1+e1)*tan(v1/2) ));
Ec1 = mod(Ec1,pi);

% équation de Kepler
M1 = Ec1-e1*sin(Ec1);    
a1 = Q1/(1-e1); %(ua)
tc1 = M1/sqrt(mu/(a1)^3);

Ec2 = 2*atan( -sqrt(1-e2)/ ( sqrt(1+e2)*tan(v2/2) ));
Ec2 = mod(Ec2,pi);

% équation de Kepler
M2 = Ec2-e2*sin(Ec2);   
a2 = Q2/(1-e2);
tc2 = M2/sqrt(mu/(a2)^3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%\\\PARTIE 2///%%%%%%%%%%%%%%%%%%%%%%%%

% calcul de dc1 et dc2

%T1:période de révolution de la Terre
%T2:période de révolution d'Eros

T1 = 365.25;    
T2 = 643.246;   

% calcul du seuil temporel
seuil_s = 0.01;  % (ua)
    % calcul des vitesses
    r1 = P1/(1+e1*cos(v1));
    r2 = P2/(1+e2*cos(v2));
    V1 = sqrt(mu*(1/r1-1/a1));     
    V2 = sqrt(mu*(1/r2-1/a2)); 
seuil_t = seuil_s/abs(v1-v2);


n1=0:10;
t1=n1*T1+tc1;
n2 = n1*T1/T2; 
if (mod(n2,fix(n2)) == 0)
    n2 = round(n2);
else
    n2 = round(n2) + 1;
t2=n2*T2+ tc2;
k=1;
dc1(1)=0;
dc2(1)=0;

for i=1:length(t1)
    for j=1:length(t2)
        if (abs(t1(i)-t2(j))< seuil_t) 
            risque=vrai
            
            dc1(k)=t1(i);
            dc2(k)=t2(j);
            k=k+1;
        end 
    end
end
%On continue les calculs que dans le cas de risque 
%donc dc1, dc2 non nuls
if (dc1~=0 && dc2~=0)
    
    %vecteur
    t=(dc2+dc1)/2;
    Mc1=(2*pi/T1)*t; 
    Mc2=(2*pi/T2)*t; 
    eps=0.0001;
    itmax=100;  
    it=0;
    %on calcule E1, E2, anomalies excentriques aux dates à risque 
    %(dc1 et dc2) par la methode du point fixe
    E1 = zeros(1, length(dc1));
    E2 = zeros(1, length(dc2));

    % au ième tour de la boucle for, on calcule E1(i) avec la boucle while
    for i=1:length(dc1)
        while (E1(i)-e1*sin(E1(i))-Mc1(i)>= eps && it<itmax)
           E1(i) = Mc1(i) + e1*sin(E1(i));
           it=it+1;
        end
        it=0;
    end
    
    
    for i=1:length(dc2)
        while (E2(i)-e2*sin(E2(i))-Mc2(i)>=eps && it<itmax)
            E2(i) = Mc2(i) + e2*sin(E2(i)); 
            it=it+1;
        end
        it=0;
    end

    vc1 = 2*atan(sqrt((1+e1)/(1-e1))*tan(E1/2))
    vc2 = 2*atan(sqrt((1+e2)/(1-e2))*tan(E2/2))  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%\\\PARTIE 3///%%%%%%%%%%%%%%%%%%%%%%% 
% on verifie que d(vc1,vc2) est toujours proche d'une distance critique

dist = sqrt(r1*r1+r2*r2-2*r1*r2*(K*cos(vc1)*cos(vc2)+M*cos(vc1)*sin(vc2)+L*sin(vc1)*cos(vc2)+N*sin(vc1)*sin(vc2)))

end

end
