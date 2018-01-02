%---------------CHECKS BEFORE RUNNING THE CODE-----------------------------
% 1. Objective functions
% 2. Gradient function
% 3. i, j, m, maxIter
% 4. Waitbar

%try %error handling mechanism

%load simulation parameters matrix
load('SimPara.mat') 

%load main datafile'
load('data01.mat')
input= transpose(X);
out=transpose(sparse(y));
output=2*out-1;
% %if RouxObjective function is used (-1,1)
% output=output*2-ones(size(output)); % to make 0s to -1s 
% %output(output==0)=-1; % to make 0s to -1s
[n, p]=size(input);
%MAXIMUM ITERATONS
maxIter=10000;
%BATCH SIZE
m= 20;
%NUMBER OF OBJECTIVE FUNCITON POINTS
epoch=20; 
%FIXED L2 REG PARAMETER
lambda2 = 0.1;
%WAITBAR
%h=waitbar(0,'good job!!');
%count=1;
for i=1:12
    
for j=1:4
%DEFINE SIMULATION PARAMETERS 
% theta=SimPara(count,1);
% lambda=SimPara(count,2);
% alpha=SimPara(count,3);
% beta=SimPara(count,4);
% count=count+1;

%(i*4-(4-j)) gives out the relevant row number in SimPara.mat
 theta=SimPara((i*4-(4-j)),1);
 lambda=SimPara((i*4-(4-j)),2);
 alpha=SimPara((i*4-(4-j)),3);
 beta=SimPara((i*4-(4-j)),4);
 


%FUNCTIONS:
%STEPSIZE
StepSizeFunction=@(k)(theta/k^alpha); 
%L1 PARAMETER
Lambda1Function=@(k)(lambda/k^beta);

%INTIALIZATION
index=1; %to move in xleg to plot
temp=sparse(n,1);
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
    lambda1=Lambda1Function(k);
   %lambda1=0;
    w=temp-stepsize*Gradient(temp,input(:,k),output(:,k),lambda1,lambda2);
    s(:,k+1)=w-temp;%starts with k+1 as k will have temp_start
    %y(:,k+1)=Gradient(w,input(:,k),output(:,k),lambda1,lambda2)- Gradient(temp,input(:,k),output(:,k),lambda1,lambda2);
    
    %fy suggestion
   y(:,k+1)=Gradient(w,input(:,k),output(:,k),0,lambda2)- Gradient(temp,input(:,k),output(:,k),0,lambda2);

 %objective function value 
    if mod(k,maxIter/epoch)==0
       sum=0;
       for tempct=1:maxIter
        sum=sum + ObjFunction(w,input(:,tempct),output(:,tempct));
       end
        OBJ(index)=sum/maxIter + lambda1*(ones(1,n)*abs(w))+lambda2/2*transpose(w)*w;
        %OBJ(index)=sum/maxIter +lambda2/2*transpose(w)*w;
        sparsity(index)=nnz(w);
        index=index+1;
        xleg(index)=xleg(index-1)+ maxIter/epoch;
    end %end of if_objective fun cal
    temp=w;
     %waitbar(k/maxIter);
end %end of k_first part

oldS=s(:,2:m+1);  
oldY=y(:,2:m+1);
      
for k=(m+1):(maxIter)
   stepsize=StepSizeFunction(k);
   lambda1=Lambda1Function(k);
   %lambda1=0;   
  
    w_HG=temp;
    i_HG=input(:,k);
    o_HG=output(:,k);
    
   
    w=temp-stepsize*TwoLoopRec(w_HG,i_HG,o_HG,oldS, oldY, lambda1, lambda2);
    newS=w-temp;
    %newY=Gradient(w,input(:,k),output(:,k),lambda1,lambda2)- Gradient(temp,input(:,k),output(:,k),lambda1,lambda2);
%fy suggestions
    newY=Gradient(w,input(:,k),output(:,k),0,lambda2)- Gradient(temp,input(:,k),output(:,k),0,lambda2);

    
    %objective fn calculation%
    if mod(k,maxIter/epoch)==0
        sum=0;
        for tempct=1:maxIter
        sum=sum + ObjFunction(w,input(:,tempct),output(:,tempct));
        end
        
        OBJ(index)=sum/maxIter + lambda1*(ones(1,n)*abs(w))+lambda2/2*transpose(w)*w;
        %OBJ(index)=sum/maxIter +lambda2/2*transpose(w)*w;
        
        sparsity(index)=nnz(w);
        index=index+1;
        xleg(index)=xleg(index-1)+ maxIter/epoch;
    end %end of if_objective function cal
    
 %removes first column and replace with newly calculated S/Y at the end
    oldS=[oldS(:,2:m),newS];
    oldY=[oldY(:,2:m),newY];
    temp=w;
    %waitbar(k/maxIter);
end %end of k

%save S2_2.mat OBJ xleg sparsity temp 
% name=strcat('S',num2str(i),'_',num2str(j),'.mat');
% save name OBJ xleg sparsity temp 
%SaveWorkSpace(i,j); % doesnt work, saves local variable in the function

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
%waitbar(i/12);
end %end of i

% catch
%     save WorkSpaceBfrError.mat;
% end % end of try
