function b=one_forward(N,M)
u=1;%水流速度
D=1;%扩散系数
l=1;%溢油区域长度
T=0.1;%溢油区域宽度,自定义取值
t=T/M;%时间步长
h=l/N;%空间步长
a=u*t/(2*h);
b=D*t/(h*h);

down=zeros(N-1,1);
for j=1:N-1
    down(j)=sin(pi*j*h);%k=0
end

A=diag(repmat(1-2*b,1,N-1))+diag(repmat(b-a,1,N-2),1)+diag(repmat(b+a,1,N-2),-1);
C=zeros(M,N-1);

C(1,:)=(A*down(:))';%启动层
for i=2:M
    C(i,:)=(A*(C(i-1,:))')';
end
mesh(C);
colormap('winter');
xlabel('溢油区域长度');
ylabel('溢油区域宽度');
zlabel('溢油浓度');
title('向前差分处理第一类边条件');
end