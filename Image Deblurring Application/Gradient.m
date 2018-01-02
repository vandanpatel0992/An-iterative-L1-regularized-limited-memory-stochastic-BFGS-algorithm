function Grad= Gradient(a,w,b,lambda1,lambda2)

 Grad=2*(a*w-b)*transpose(a)+lambda1*sign(w)+lambda2*w;
   
end