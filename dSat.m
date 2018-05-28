function value=dSat(x)
global P; global E; global p; global e; global K; global M; global N; global L;
x1 = x(1); x2 = x(2);
R=P/(1+E*cos(x1));
r=p/(1+e*cos(x2));

value=sqrt(R*R+r*r-2*R*r*(K*cos(x1)*cos(x2)+M*cos(x1)*sin(x2)+L*sin(x1)*cos(x2)+N*sin(x1)*sin(x2)));
end
