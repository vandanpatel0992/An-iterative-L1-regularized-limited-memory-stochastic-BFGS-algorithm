function Grad= Gradient(w,input,output,lambda1,lambda2)
i=input;
o=output;

%%nocedal
   %cfunct= @(w,i)(1/(1+exp(-transpose(i)*w)));
   %Grad=(((cfunct(w,i)-o)*i))+lambda1*sign(w)+lambda2*w; 
%%fy
%   Grad=(((1-o-cfunct(w,i))*i))+lambda1*sign(w)+lambda2*w; 
%%roux
%if RouxObjective function is used (-1,1)
%o= output*2-1;
   %Grad=(-(o/(1+exp(o*transpose(i)*w)))*i+lambda1*sign(w)+lambda2*w); 
   Grad=-(o/(1+Exponential(w,i,o)))*i+lambda1*sign(w)+lambda2*w;
   
   
end