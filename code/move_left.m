function [X,Y,C,w]=move_left(N,M,u,D,l,T)
%基于向后差分格式,M=N
if N~=M
    disp('划分数输入不规范');
    return;
end
% u=0.1;%水流速度
% D=3;%扩散系数
% l=1;%溢油区域长度
% T=0.3;%溢油时间
t=T/M;%时间步长
h=l/N;%空间步长
a=u*t/(2*h);
b=D*t/(h*h);
w=h/t;%出油装置速度
down=zeros(N,1);
x_ord=zeros(N,1);
y_ord=zeros(N,1);

for j=1:N
    down(j)=sin(pi*j*h);%k=0
    x_ord(j)=j*h;
    y_ord(j)=j*t;
end

A=diag(repmat(1+2*b,1,N))+diag(repmat(-b+a,1,N-1),1)+diag(repmat(-b-a,1,N-1),-1);
A(1,2)=-2*b;
C=zeros(N,N);
C(1,:)=(A\down(:))';%启动层

for i=2:M-1
    B=diag(repmat(1+2*b,1,N-i+1))+diag(repmat(-b+a,1,N-i),1)+diag(repmat(-b-a,1,N-i),-1);
    B(1,2)=-2*b;
    C(i,i:N)=(B\(C(i-1,i:N))')';
end

X=repmat(x_ord',N,1);
Y=repmat(y_ord,1,N);
mesh(X,Y,C);
colormap('pink');
txt_x=xlabel("$x$","FontSize",15);set(txt_x,'Interpreter','latex');
txt_y=ylabel("$t$","FontSize",15);set(txt_y,'Interpreter','latex');
txt_z=zlabel("$C$","FontSize",15);set(txt_z,'Interpreter','latex');
title('向后差分处理左移动边条件','FontSize',14);
subtitle(['N=',int2str(N),',M=',int2str(M),',w=',num2str(w)]);

end