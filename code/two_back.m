function [X,Y,C]=two_back(N,M,u,D)
%N和M可以不相同
% u=1;%水流速度
% D=1;%扩散系数
l=1;%溢油区域长度
T=1;%溢油时间
t=T/M;%时间步长
h=l/N;%空间步长
a=u*t/(2*h);
b=D*t/(h*h);
x_ord=zeros(N-1,1);
y_ord=zeros(M,1);
down=zeros(N-1,1);

for j=1:N-1
    down(j)=sin(pi*j*h);%k=0
    x_ord(j)=j*h;
end
for i=1:M
    y_ord(i)=i*t;
end

A=diag(repmat(1+2*b,1,N-1))+diag(repmat(-b+a,1,N-2),1)+diag(repmat(-b-a,1,N-2),-1);
A(1,2)=-2*b;%回应第二类边条件
C=zeros(M,N-1);
C(1,:)=(A\down(:))';%启动层

for i=2:M
    C(i,:)=(A\(C(i-1,:))')';
end

X=repmat(x_ord',M,1);
Y=repmat(y_ord,1,N-1);
% surf(X,Y,C);
% colormap('winter');
% txt_x=xlabel("$x$","FontSize",15);set(txt_x,'Interpreter','latex');
% txt_y=ylabel("$t$","FontSize",15);set(txt_y,'Interpreter','latex');
% txt_z=zlabel("$C$","FontSize",15);set(txt_z,'Interpreter','latex');
% title('向后差分处理第二类边条件','FontSize',13);
% subtitle(['N=',int2str(N),',M=',int2str(M)]);
end