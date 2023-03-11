function V=two_1(m,n,a,b)
x_f=0;y_f=0;

%确定输入的等分数，计算步长，确定起始点
h_1=pi/m;
h_2=pi/n;
miu=(a+sqrt(a*a-4*b))/2;
Q=2*miu*h_1^2+2*miu*h_2^2+b*h_1^2*h_2^2;

%生成计算正则内点的常数向量
F=zeros((m-1)*(n-1),1);

%为提高精度，设置两方向等距节点,【修改，不设置等距节点】
a_c=-1;
af(1)=-miu*h_2^2/Q;
af(2)=-miu*h_1^2/Q;
af(3)=-miu*h_2^2/Q;
af(4)=-miu*h_1^2/Q;

%生成被填充的矩阵B
B=diag(repmat(a_c,1,m-1))+diag(repmat(-af(1),1,m-2),1)+diag(repmat(-af(3),1,m-2),-1);

%生成系数矩阵A
C=-af(2)*eye(m-1);
D=-af(4)*eye(m-1);
s=blkdiag(kron(eye(n-1),B));  %对角块
mid=mat2cell(s,(m-1)*ones(1,n-1),(m-1)*ones(1,n-1));
mid(find(diag(ones(1,n-2),1)==1))={C};   %上三角块
mid(find(diag(ones(1,n-2),-1)==1))={D};   %下三角块
A=cell2mat(mid); 

%根据边界条件生成边界节点的值
y_n=zeros(m-1);y_p=zeros(m-1);
x_n=zeros(n-1);x_p=zeros(n-1);
%顺便做一个等分点
x_ord=zeros(m-1,1);y_ord=zeros(n-1,1);
for i=1:m-1
    y_n(i)=0;
    y_p(i)=(-1/miu-1)*pi*sin(y_f+i*h_2);
    x_ord(i)=x_f+h_1*i;
end
for i=1:n-1
    x_n(i)=0;
    x_p(i)=(-1/miu-1)*pi*sin(x_f+i*h_1);
    y_ord(i)=y_f+i*h_2;
end

%矩形区域中有四个内点的计算需要两个边界点
%确定右边函数
F(1)=f(x_f+h_1,y_f+h_2)-(miu*h_1^2/Q)*y_n(1)-(miu*h_2^2/Q)*x_n(1);
F(m-1)=f(x_f+(m-1)*h_1,y_f+h_2)-(miu*h_2^2/Q)*x_p(1)-(miu*h_1^2/Q)*y_n(m-1);
F((m-1)*(n-2)+1)=f(x_f+h_1,y_f+(n-1)*h_2)-(miu*h_1^2/Q)*y_p(1)-(miu*h_2^2/Q)*x_n(n-1);
F((m-1)*(n-1))=f(x_f+(m-1)*h_1,y_f+(n-1)*h_2)-(miu*h_1^2/Q)*x_p(n-1)-(miu*h_2^2/Q)*y_p(m-1);

%矩形区域有2*(m-3)+2*(n-3)个内点的计算需要一个边界点
if m>3
    for i=2:m-2
        F(i)=f(x_f+i*h_1,y_f+h_2)-(miu*h_1^2/Q)*y_n(i);
        F((m-1)*(n-2)+i)=f(x_f+i*h_1,y_f+(n-1)*h_2)-(miu*h_1^2/Q)*y_p(i);
    end
end
if n>3
    for i=2:n-2
        F((i-1)*(m-1)+1)=f(x_f+h_1,y_f+i*h_2)-(miu*h_2^2/Q)*x_n(i);
        F(i*(m-1))=f(x_f+(m-1)*h_1,y_f+i*h_2)-(miu*h_2^2/Q)*x_p(i);
    end
end

%矩形区域有(m-3)*(n-3)个正则内点的右端值
for i=2:m-2
    for j=2:n-2
        F((j-1)*(m-1)+i)=f(x_f+i*h_1,y_f+j*h_2);%怀疑有问题
    end
end

U_cal=A\F;  %获得计算的U值

U_cal_m=reshape(U_cal,[m-1,n-1]);  %将向量转化为矩阵，用于画图
U_acc_m=zeros(m-1,n-1);  
for i=1:m-1
    for j=1:n-1
      U_acc_m(i,j)=(-1/miu-1)*((y_f+j*h_2)*sin(x_f+i*h_1)+(x_f+i*h_1)*sin(y_f+j*h_2));%获得精确解矩阵
    end
end
U_acc_v=reshape(U_acc_m,[(m-1)*(n-1),1]);

% disp(norm(U_cal-U_acc_v,'inf'));%计算误差向量的无穷范数，可以尝试

V=U_cal_m;

    function s=f(x,y)
       s=h_1*h_1*h_2*h_2*(1+a+b)*(y*sin(x)+x*sin(y))/Q;
    end

end