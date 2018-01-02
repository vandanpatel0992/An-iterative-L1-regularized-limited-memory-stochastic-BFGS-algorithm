%%%%%%%%%%%%%%%%%%%%%%%% iL1 Reg Stoc BFGS for Image Deblurring%%%%%%%%%%

%InputImage
X=imread('cameraman.pgm');
%figure, imshow(X), title('OriginalImage')
[l, ~]=size(X);

%convert matrix into vector
x=double(X(:)); %original image vector
[n,~]=size(x);

%To find motionblur matrix using block Toeplitz matrix
A = mblur(l,5,'x');

%To get blurred image.
b=A*sparse(x); %b is sparse vector

%to display blurred image
% B=reshape(b,[l l]); %B is sparse matrix
% B=full(B); %B is double
% B=uint8(B); % B is uint8 for imshow()
%figure, imshow(B), title('BluredImage');

%load simulation parameters matrix
load('SimPara.mat') 

%Number of iterations
maxIter=1000;
%Batch size
m= 20;
%Objective function check points
epoch=20; 
%Fixed L2 regularization parameter
lambda2 = 0.001;


for i=1%:12
    
for j=1%:4

%Simulation parameter input:(i*4-(4-j)) gives out the relevant row number in SimPara.mat
 theta=SimPara((i*4-(4-j)),1);
 lambda=SimPara((i*4-(4-j)),2);
 alpha=SimPara((i*4-(4-j)),3);
 beta=SimPara((i*4-(4-j)),4);
 
%FUNCTIONS:
%Iterative stepsize
StepSizeFunction=@(k)(theta/k^alpha); 
%Iterative L1 reg parameter
Lambda1Function=@(k)(lambda/k^beta);

%INTIALIZATION
index=1; %to move in xleg to plot
temp=100*sparse(n,1);
w=sparse(n,1);
OBJ=zeros(1,epoch);
xleg=zeros(1,epoch);
xleg(index)=maxIter/epoch;
sparsity=zeros(1,epoch);
s=sparse(n, m+1);
y=sparse(n, m+1);
oldS=sparse(n,m);
oldY=sparse(n,m);

for k=1:m
    stepsize=StepSizeFunction(k);
    %L1 regularization
    %iterative L1
    lambda1=Lambda1Function(k);
    %No L1 reg
    %lambda1=0;
    
    w=temp-stepsize*Gradient(A(k,:),temp,b(k,:),lambda1,lambda2);
    s(:,k+1)=w-temp;%starts with k+1 as k will have temp_start
    y(:,k+1)=Gradient(A(k,:),w,b(k,:),0,lambda2)- Gradient(A(k,:),temp,b(k,:),0,lambda2);

 %objective function value 
    if mod(k,maxIter/epoch)==0
       sum=0;
       for tempct=1:n
        sum=sum + ObjFunction(A(tempct,:),w,b(tempct,:));
       end
        OBJ(index)=sum/n + lambda1*(ones(1,n)*abs(w))+lambda2/2*transpose(w)*w;
        %OBJ(index)=sum/maxIter +lambda2/2*transpose(w)*w;
        sparsity(index)=nnz(w);
        index=index+1;
        xleg(index)=xleg(index-1)+ maxIter/epoch;
    end %end of if_objective fun cal
    temp=w;
    
end %end of k_first part

oldS=s(:,2:m+1);  
oldY=y(:,2:m+1);
      
for k=(m+1):(maxIter)
   stepsize=StepSizeFunction(k);
   lambda1=Lambda1Function(k);
   %lambda1=0;   
  
    w_HG=temp;
    i_HG=A(k,:);
    o_HG=b(k,:);
    
    w=temp-stepsize*TwoLoopRec(i_HG,w_HG,o_HG,oldS, oldY, lambda1, lambda2);
    newS=w-temp;
    newY=Gradient(A(k,:),w,b(k,:),0,lambda2)- Gradient(A(k,:),temp,b(k,:),0,lambda2);
    
    %objective fn calculation%
    if mod(k,maxIter/epoch)==0
        sum=0;
        for tempct=1:n
        sum=sum + ObjFunction(A(tempct,:),w,b(tempct,:));
        end
        
        OBJ(index)=sum/n + lambda1*(ones(1,n)*abs(w))+lambda2/2*transpose(w)*w;
        %OBJ(index)=sum/maxIter +lambda2/2*transpose(w)*w;
        
        sparsity(index)=nnz(w);
        index=index+1;
        xleg(index)=xleg(index-1)+ maxIter/epoch;
    end %end of if_objective function cal
    
 %removes first column and replace with newly calculated S/Y at the end
    oldS=[oldS(:,2:m),newS];
    oldY=[oldY(:,2:m),newY];
    temp=w;
    
end %end of k

%To save the data according to the Simulation parameter identifiers 
if     i==1&& j==1
save S1_1.mat;
elseif i==1&& j==2
save S1_2.mat;
elseif i==1&& j==3
save S1_3.mat;    
elseif i==1&& j==4
save S1_4.mat;    
  
elseif i==2&& j==1
save S2_1.mat;
elseif i==2&& j==2
save S2_2.mat;
elseif i==2&& j==3
save S2_3.mat;    
elseif i==2&& j==4
save S2_4.mat;   
    
elseif i==3&& j==1
save S3_1.mat;
elseif i==3&& j==2
save S3_2.mat;
elseif i==3&& j==3
save S3_3.mat;    
elseif i==3&& j==4
save S3_4.mat;   
    
elseif i==4 && j==1
save S4_1.mat;
elseif i==4 && j==2
save S4_2.mat;
elseif i==4 && j==3
save S4_3.mat;    
elseif i==4 && j==4
save S4_4.mat;   

elseif i==5 && j==1
save S5_1.mat;
elseif i==5 && j==2
save S5_2.mat;
elseif i==5 && j==3
save S5_3.mat;    
elseif i==5 && j==4
save S5_4.mat;   

elseif i==6 && j==1
save S6_1.mat;
elseif i==6 && j==2
save S6_2.mat;
elseif i==6 && j==3
save S6_3.mat;    
elseif i==6 && j==4
save S6_4.mat;   

elseif i==7 && j==1
save S7_1.mat;
elseif i==7 && j==2
save S7_2.mat;
elseif i==7 && j==3
save S7_3.mat;    
elseif i==7 && j==4
save S7_4.mat;   

elseif i==8 && j==1
save S8_1.mat;
elseif i==8 && j==2
save S8_2.mat;
elseif i==8 && j==3
save S8_3.mat;    
elseif i==8 && j==4
save S8_4.mat;   

elseif i==9 && j==1
save S9_1.mat;
elseif i==9 && j==2
save S9_2.mat;
elseif i==9 && j==3
save S9_3.mat; 
elseif i==9 && j==4
save S9_4.mat; 

elseif i==10 && j==1
save S10_1.mat;
elseif i==10 && j==2
save S10_2.mat;
elseif i==10 && j==3
save S10_3.mat;  
elseif i==10 && j==4
save S10_4.mat;  

elseif i==11 && j==1
save S11_1.mat;
elseif i==11 && j==2
save S11_2.mat;
elseif i==11 && j==3
save S11_3.mat;  
elseif i==11 && j==4
save S11_4.mat;  

elseif i==12 && j==1
save S12_1.mat;
elseif i==12 && j==2
save S12_2.mat;
elseif i==12 && j==3
save S12_3.mat;   
elseif i==12 && j==4
save S12_4.mat;   

end %end of if_save
end %end of j
end %end of i
