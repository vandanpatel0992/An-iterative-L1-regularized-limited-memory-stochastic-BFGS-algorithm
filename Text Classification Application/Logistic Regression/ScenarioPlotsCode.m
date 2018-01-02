%Modes, 1 if a mode is to be selected. Only one scenario at a time
IndividualPlots=0; 
AllScenarios=1;
 FirstScenarioOnly=0;
 SecondScenarioOnly=0;
 ThirdScenarioOnly=0;
 FourthScenarioOnly=0;
 
 %To start wait bar if all scenario mode used
 if AllScenarios==1
h=waitbar(0,'you are awsome!');
 end
 
 for i=1:12
     
 if IndividualPlots==1
     load(strcat('S',num2str(i),'_1.mat'),'xleg','OBJ')
    figure; plot(xleg(1:20),log(OBJ),'--*b');
    xlabel('Number of data points');
    ylabel('log(Avg loss)');
    title(strcat('S',num2str(i),'_1'));
     saveas(gcf,strcat('S',num2str(i),'_1.jpg'))
     
      load(strcat('S',num2str(i),'_2.mat'),'xleg','OBJ')
      figure; plot(xleg(1:20),log(OBJ),'--*b');
    xlabel('Number of data points');
    ylabel('log(Avg loss)');
    title(strcat('S',num2str(i),'_2'));
     saveas(gcf,strcat('S',num2str(i),'_2.jpg'))
     
      load(strcat('S',num2str(i),'_3.mat'),'xleg','OBJ')
      figure; plot(xleg(1:20),log(OBJ),'--*b');
    xlabel('Number of data points');
    ylabel('log(Avg loss)');
    title(strcat('S',num2str(i),'_3'));
     saveas(gcf,strcat('S',num2str(i),'_3.jpg'))
     
      load(strcat('S',num2str(i),'_4.mat'),'xleg','OBJ')
      figure; plot(xleg(1:20),log(OBJ),'--*b');
    xlabel('Number of data points');
    ylabel('log(Avg loss)');
    title(strcat('S',num2str(i),'_4'));
     saveas(gcf,strcat('S',num2str(i),'_4.jpg'))
     
     
 elseif AllScenarios==1
     
     
load(strcat('S',num2str(i),'_1.mat'),'xleg','OBJ')
a(1)=plot(xleg(1:20),log(OBJ),'--or');
hold on;
load(strcat('S',num2str(i),'_2.mat'),'xleg','OBJ')
a(2)=plot(xleg(1:20),log(OBJ),':xb');

load(strcat('S',num2str(i),'_3.mat'),'xleg','OBJ')
a(3)=plot(xleg(1:20),log(OBJ),'-^y');

load(strcat('S',num2str(i),'_4.mat'),'xleg','OBJ')
a(4)=plot(xleg(1:20),log(OBJ),'-.+g');

xlabel('Number of data points')
ylabel('log(Avg loss)')

legend([a(1),a(2),a(3),a(4)],strcat('S',num2str(i),'_1'),strcat('S',num2str(i),'_2'),strcat('S',num2str(i),'_3'),strcat('S',num2str(i),'_4'));
hold off;
saveas(gcf,strcat('S',num2str(i),'_all.jpg'))
 waitbar(i/12);
 
 elseif FirstScenarioOnly==1
load(strcat('S',num2str(i),'_1.mat'),'xleg','OBJ')
a(1)=plot(xleg(1:20),log(OBJ),'--or');
xlabel('Number of data points')
ylabel('log(Avg loss)')
legend(a(1),strcat('S',num2str(i),'_1'));
saveas(gcf,strcat('S',num2str(i),'_1.jpg'))         
     
 elseif SecondScenarioOnly==1
load(strcat('S',num2str(i),'_2.mat'),'xleg','OBJ')
a(2)=plot(xleg(1:20),log(OBJ),'--or');
xlabel('Number of data points')
ylabel('log(Avg loss)')
legend(a(2),strcat('S',num2str(i),'_2'));
saveas(gcf,strcat('S',num2str(i),'_2.jpg')) 
     
  elseif ThirdScenarioOnly==1
load(strcat('S',num2str(i),'_3.mat'),'xleg','OBJ')
a(3)=plot(xleg(1:20),log(OBJ),'--or');
xlabel('Number of data points')
ylabel('log(Avg loss)')
legend(a(3),strcat('S',num2str(i),'_3'));
saveas(gcf,strcat('S',num2str(i),'_3.jpg'))         
         
 else FourthScenarioOnly==1
load(strcat('S',num2str(i),'_4.mat'),'xleg','OBJ')
a(4)=plot(xleg(1:20),log(OBJ),'--or');
xlabel('Number of data points')
ylabel('log(Avg loss)')
legend(a(4),strcat('S',num2str(i),'_4'));
saveas(gcf,strcat('S',num2str(i),'_4.jpg'))  
 end
 end
 