function HG= TwoLoopRec(a,w,b, sp, yp,lambda1,lambda2)

[row, col]=size(sp);

q=Gradient(a,w,b,lambda1,lambda2);

Ah=zeros(1,col);
rho=zeros(1,col); 

for i=col:-1:1
    rho(1,i)=1/(transpose(yp(:,i))*sp(:,i));
    Ah(1,i)=rho(1,i)*transpose(sp(:,i))*q;
    q=q- Ah(1,i)*yp(:,i);
end

H=((transpose(sp(:,col))*yp(:,col))/(transpose(yp(:,col))*yp(:,col)))*speye(row,row);
r=H*q;
for i=1:col
    B=rho(1,i)*transpose(yp(:,i))*r;
    r= r+ sp(:,i)*(Ah(1,i)-B);
end
HG=r;
end

