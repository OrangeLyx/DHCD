function rate=compare(num1,num2,fix,choice)
%num1和num2是同一方向两个步长，另一步长fix固定
%问题一和问题二的选择需要手动修改
%a=1,b=0;
if choice==1
    mist_1=two_2(num1,fix);
    mist_2=two_2(num2,fix);
    rate=log(mist_1/mist_2)/log((pi/num1)/(pi/num2));
end
if choice==2
    mist_1=two_2(fix,num1);
    mist_2=two_2(fix,num2);
    rate=log(mist_1/mist_2)/log((pi/num1)/(pi/num2));
end
end