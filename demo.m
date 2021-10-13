clc
clear all
fhd=@sphere;
nPop=50;
nVar=10;
VarMin=-100.*ones(1,nVar);
VarMax=100.*ones(1,nVar);
MaxIt=1000;
it=1;
while it<=30
    [BestCost(it,:),BestValue(it),XTarget(it,:)]=CLJAYA(fhd,nPop,nVar,VarMin,VarMax,MaxIt);
    it=it+1;
end
plot(1:1000,mean(BestCost),'r','LineWidth',1.5)
xlabel('The number of iterations','Fontname','Times New Roma','fontsize',18);
ylabel('Mean fitness value/log','Fontname','Times New Roman','fontsize',18);
