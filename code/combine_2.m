%比较不同扩散系数或者水流速度的效果
N=36;
M=18;
u=[10,20,50];
D=10;
l=1;
T=0.5;

subplot(1,3,1);
[X,Y,C,v,w]=move_double(N,M,u(1),D,l,T);
mesh(X,Y,C);
txt_x=xlabel("$x$","FontSize",15);set(txt_x,'Interpreter','latex');
txt_y=ylabel("$t$","FontSize",15);set(txt_y,'Interpreter','latex');
txt_z=zlabel("$C$","FontSize",13);set(txt_z,'Interpreter','latex');
title(['u=',num2str(u(1)),', D=',num2str(D),', v=w=',num2str(v)]);

subplot(1,3,2);
[X,Y,C,v,w]=move_double(N,M,u(2),D,l,T);
mesh(X,Y,C);
txt_x=xlabel("$x$","FontSize",15);set(txt_x,'Interpreter','latex');
txt_y=ylabel("$t$","FontSize",15);set(txt_y,'Interpreter','latex');
txt_z=zlabel("$C$","FontSize",13);set(txt_z,'Interpreter','latex');
title(['u=',num2str(u(2)),', D=',num2str(D),', v=w=',num2str(v)]);

subplot(1,3,3);
[X,Y,C,v,w]=move_double(N,M,u(3),D,l,T);
mesh(X,Y,C);
txt_x=xlabel("$x$","FontSize",15);set(txt_x,'Interpreter','latex');
txt_y=ylabel("$t$","FontSize",15);set(txt_y,'Interpreter','latex');
txt_z=zlabel("$C$","FontSize",13);set(txt_z,'Interpreter','latex');
title(['u=',num2str(u(3)),', D=',num2str(D),', v=w=',num2str(v)]);

colormap("parula");
sgtitle('向后差分处理第三类移动边条件','FontSize',14);
