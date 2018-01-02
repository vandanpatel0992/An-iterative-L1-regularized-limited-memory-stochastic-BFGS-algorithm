function Obj = ObjFunction( w,input,output)
%Returns a scalar

i=input;
o=output;


%FUNCTIOINS
%nocedal
%cfunct= @(w,i)(1/(1+exp(-transpose(i)*w)));
%Obj=(-(o*log(cfunct(w,i))+(1-o)*log(1-cfunct(w,i))));

%fy
%cfunct=@(w,i)(1/(1+exp(transpose(i)*w)));
% Obj=@(w,i,o)(-(transpose(i)*w*(-1+o)-log(1+exp(-transpose(i)*w)))); 

%roux
%if RouxObjective function is used (-1,1)
%o= -(output*2-1);
%Obj=(log(1+exp(-o*transpose(i)*w))); 
Obj=log(1+ExponentialObj(w,i,o));

end

