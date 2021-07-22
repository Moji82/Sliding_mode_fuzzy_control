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
sizes.NumContStates = 4;
sizes.NumDiscStates = 0;
sizes.NumOutputs = 4;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0 =[pi/4,0,0,0];str = [];ts = [];
function dx=Dynamics(t,x,u)
L=1;I=1;K=1;g=9.8;M=1;J=1;
x1=x(1);x2=x(2);x3=x(3);x4=x(4);
dx(1)=x2;
dx(2)=-M*g*L/I*sin(x1)-K/I*(x1-x3);
dx(3)=x4;
dx(4)=K/J*(x1-x3)+1/J*u;
function sys=Outputs(t,x,u)
sys(1)=x(1);
sys(2)=x(2);
sys(3)=x(3);
sys(4)=x(4);