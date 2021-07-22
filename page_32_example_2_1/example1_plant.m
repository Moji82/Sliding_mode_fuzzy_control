function [sys,x0,str,ts] = example1_plant(t,x,u,flag)
switch flag,
    case 0,
        [sys,x0,str,ts]=InitSizes;
    case 1,
        sys=Dynamics(t,x,u);
    case 3,
        sys=Outputs(t,x,u);
    case {2,4,9}
        sys=[];
    otherwise
        error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=InitSizes
sizes = simsizes;
sizes.NumInputs = 1;
sizes.DirFeedthrough = 0;
sizes.NumContStates = 2;
sizes.NumDiscStates = 0;
sizes.NumOutputs = 2;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0 =[pi/4,0];str = [];ts = [];
function dx=Dynamics(t,x,u)
g=9.6;mc=1.0;m=0.1;l=0.9;a=1/(mc+m);
d=0.1*sin(t);
ut=u(1);x1=x(1);x2=x(2);
dx(1)=x(2);
dx(2)=(g*sin(x1)-m*l*a^2*x2^2*cos(x1)*sin(x1))/l/(4/3-m*a*(cos(x1))^2)...
    +a*cos(x1)/l/(4/3-m*a*(cos(x1))^2)*u+d;
function sys=Outputs(t,x,u)
sys(1)=x(1);
sys(2)=x(2);