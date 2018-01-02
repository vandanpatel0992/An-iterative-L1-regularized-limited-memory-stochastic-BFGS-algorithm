%codes to write values in to excel sheet

 hh=waitbar(0,'you are awsome!');
 counter=1;
 for ii=1:12
 for jj=1:4
 %load the data
 load(strcat('S',num2str(ii),'_',num2str(jj),'.mat'),'OBJ','sparsity')
 counter=counter+1;
 f=OBJ(20);  %last objective function value i.e 20th
 s=sparsity(20);
 v=var(OBJ);  %variance in the objective function value array
 %xlswrite(name of excel sheet, value, cell number)
 xlswrite('output.xlsx',f,strcat('G',num2str(counter),':','G',num2str(counter)));
 xlswrite('output.xlsx',v,strcat('H',num2str(counter),':','H',num2str(counter)));
 xlswrite('output.xlsx',s,strcat('I',num2str(counter),':','I',num2str(counter)));
 end
 waitbar(ii/12);
 end
   
 
 