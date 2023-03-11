%比较不同扩散系数或者水流速度的效果
N=35;
M=30;
u=[-1,-10,-20];
D=1;

subplot(1,3,1);
[X,Y,C]=one_back(N,M,u(1),D);
mesh(X,Y,C);
txt_x=xlabel("$x$","FontSize",15);set(txt_x,'Interpreter','latex');
txt_y=ylabel("$t$","FontSize",15);set(txt_y,'Interpreter','latex');
txt_z=zlabel("$C$","FontSize",13);set(txt_z,'Interpreter','latex');
title(['N=',int2str(N),', M=',int2str(M),', u=',num2str(u(1)),', D=',num2str(D)]);

subplot(1,3,2);
[X,Y,C]=one_back(N,M,u(2),D);
mesh(X,Y,C);
txt_x=xlabel("$x$","FontSize",15);set(txt_x,'Interpreter','latex');
txt_y=ylabel("$t$","FontSize",15);set(txt_y,'Interpreter','latex');
txt_z=zlabel("$C$","FontSize",13);set(txt_z,'Interpreter','latex');
title(['N=',int2str(N),', M=',int2str(M),', u=',num2str(u(2)),', D=',num2str(D)]);

subplot(1,3,3);
[X,Y,C]=one_back(N,M,u(3),D);
mesh(X,Y,C);
txt_x=xlabel("$x$","FontSize",15);set(txt_x,'Interpreter','latex');
txt_y=ylabel("$t$","FontSize",15);set(txt_y,'Interpreter','latex');
txt_z=zlabel("$C$","FontSize",13);set(txt_z,'Interpreter','latex');
title(['N=',int2str(N),', M=',int2str(M),', u=',num2str(u(3)),', D=',num2str(D)]);

% subplot(2,3,4);
% [X,Y,C]=one_back(N,M,u,D(4));
% surf(X,Y,C);
% txt_x=xlabel("$x$","FontSize",15);set(txt_x,'Interpreter','latex');
% txt_y=ylabel("$t$","FontSize",15);set(txt_y,'Interpreter','latex');
% txt_z=zlabel("$C$","FontSize",13);set(txt_z,'Interpreter','latex');
% title(['N=',int2str(N),', M=',int2str(M),', u=',num2str(u),', D=',num2str(D(4))]);
% 
% subplot(2,3,5);
% [X,Y,C]=one_back(N,M,u,D(5));
% surf(X,Y,C);
% txt_x=xlabel("$x$","FontSize",15);set(txt_x,'Interpreter','latex');
% txt_y=ylabel("$t$","FontSize",15);set(txt_y,'Interpreter','latex');
% txt_z=zlabel("$C$","FontSize",13);set(txt_z,'Interpreter','latex');
% title(['N=',int2str(N),', M=',int2str(M),', u=',num2str(u),', D=',num2str(D(5))]);
% 
% subplot(2,3,6);
% [X,Y,C]=one_back(N,M,u,D(6));
% surf(X,Y,C);
% txt_x=xlabel("$x$","FontSize",15);set(txt_x,'Interpreter','latex');
% txt_y=ylabel("$t$","FontSize",15);set(txt_y,'Interpreter','latex');
% txt_z=zlabel("$C$","FontSize",13);set(txt_z,'Interpreter','latex');
% title(['N=',int2str(N),', M=',int2str(M),', u=',num2str(u),', D=',num2str(D(6))]);

colormap("cool");
sgtitle('向后差分处理第一类边条件','FontSize',14);
