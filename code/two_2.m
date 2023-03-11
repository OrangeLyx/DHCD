function mistake=two_2(m,n)
a=3;b=1;
x_f=0;y_f=0;
V=two_1(m,n,a,b);%计算第一步的v矩阵，得到内点值

miu=(a+sqrt(a*a-4*b))/2;
h_1=pi/m;
h_2=pi/n;

%生成计算正则内点的常数向量
F=zeros((m-1)*(n-1),1);

%为提高精度，设置两方向等距节点,【修改，不设置等距节点】
a_c=-2*h_1^2-2*h_2^2-miu*h_1^2*h_2^2;
ar(1)=-h_2^2;
ar(2)=-h_1^2;
ar(3)=-h_2^2;
ar(4)=-h_1^2;

%生成被填充的矩阵B
B=diag(repmat(a_c,1,m-1))+diag(repmat(-ar(1),1,m-2),1)+diag(repmat(-ar(3),1,m-2),-1);

%生成系数矩阵A
C=-ar(2)*eye(m-1);
D=-ar(4)*eye(m-1);
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
    y_p(i)=pi*sin(y_f+i*h_2);
    x_ord(i)=x_f+h_1*i;
end
for i=1:n-1
    x_n(i)=0;
    x_p(i)=pi*sin(x_f+h_1*i);
    y_ord(i)=y_f+i*h_2;
end

%矩形区域中有四个内点的计算需要两个边界点
%确定右边函数
F(1)=ff(x_f+h_1,y_f+h_2)+ar(3)*y_n(1)-ar(4)*x_n(1);
F(m-1)=ff(x_f+(m-1)*h_1,y_f+h_2)+ar(1)*x_p(1)-ar(4)*y_n(m-1);
F((m-1)*(n-2)+1)=ff(x_f+h_1,y_f+(n-1)*h_2)+ar(2)*y_p(1)+ar(3)*x_n(n-1);
F((m-1)*(n-1))=ff(x_f+(m-1)*h_1,y_f+(n-1)*h_2)+ar(1)*x_p(n-1)+ar(2)*y_p(m-1);

%矩形区域有2*(m-3)+2*(n-3)个内点的计算需要一个边界点
if m>3
    for i=2:m-2
        F(i)=ff(x_f+i*h_1,y_f+h_2)-ar(4)*y_n(i);
        F((m-1)*(n-2)+i)=ff(x_f+i*h_1,y_f+(n-1)*h_2)+ar(2)*y_p(i);
    end
end
if n>3
    for i=2:n-2
        F((i-1)*(m-1)+1)=ff(x_f+h_1,y_f+i*h_2)+ar(3)*x_n(i);
        F(i*(m-1))=ff(x_f+(m-1)*h_1,y_f+i*h_2)+ar(1)*x_p(i);
    end
end

%矩形区域有(m-3)*(n-3)个正则内点的右端值
for i=2:m-2
    for j=2:n-2
        F((j-1)*(m-1)+i)=ff(x_f+i*h_1,y_f+j*h_2);
    end
end

U_cal=A\F;  %获得计算的U值

U_cal_m=reshape(U_cal,[m-1,n-1]);  %将向量转化为矩阵，用于画图
U_acc_m=zeros(m-1,n-1);  
for i=1:m-1
    for j=1:n-1
      U_acc_m(i,j)=(y_f+j*h_2)*sin(x_f+i*h_1)+(x_f+i*h_1)*sin(y_f+j*h_2);%获得精确解矩阵
    end
end
U_acc_v=reshape(U_acc_m,[(m-1)*(n-1),1]);

X=repmat(x_ord,1,n-1);
Y=repmat(y_ord',m-1,1);

sgtitle('Q2重调和问题的向后差分格式');

subplot(1,2,1);
surf(X,Y,U_cal_m);
title('数值解');
subtitle(['a=',num2str(a),',b=',num2str(b),',M=',num2str(m),',N=',num2str(n)]);
txt_x=xlabel("$x$","FontSize",13);set(txt_x,'Interpreter','latex');
txt_y=ylabel("$y$","FontSize",13);set(txt_y,'Interpreter','latex');
txt_z=zlabel("$u$","FontSize",13);set(txt_z,'Interpreter','latex');

subplot(1,2,2);
surf(X,Y,U_acc_m);
title('解析解');
subtitle(['a=',num2str(a),',b=',num2str(b),',M=',num2str(m),',N=',num2str(n)]);
txt_x=xlabel("$x$","FontSize",13);set(txt_x,'Interpreter','latex');
txt_y=ylabel("$y$","FontSize",13);set(txt_y,'Interpreter','latex');
txt_z=zlabel("$u$","FontSize",13);set(txt_z,'Interpreter','latex');
colormap autumn;

mistake=norm(U_cal-U_acc_v,"inf");%计算误差向量的无穷范数

%等式右边函数
    function s=ff(x,y)
        s=miu*h_1*h_1*h_2*h_2*V(round((x-x_f)/h_1),round((y-y_f)/h_2));
    end

end