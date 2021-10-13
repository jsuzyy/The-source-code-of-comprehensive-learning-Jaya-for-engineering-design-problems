%% JAYA algorithms
function [BestCost,BestValue,XTarget]=CLJAYA(fhd,nPop,nVar,VarMin,VarMax,MaxIt)
%%Input parameters
%%fhd----------------objective function
%%nPop---------------population size 
%%nVar---------------the number of variables
%%VarMin-------------the lower boundaries of variables
%%VarMin-------------the upper boundaries of variables
%%MaxIt--------------the maximum number of iterations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Output parameters
%%BestCost-----------convergence curve
%%BestValue----------the optimal fitness value
%%XTarget------------the optimal solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:nPop
    X(i,:)=VarMin+(VarMax-VarMin).*rand(1,nVar); 
end
for i=1:nPop
    f(i) = fhd(X(i,:));
end

%%  Main Loop
gen=1;
[BestCost(1),ind]=min(f);
XTarget=X(ind,:);
while(gen+1 <= MaxIt)
    [row,col]=size(X);
    [t,tindex]=min(f);
    Best=X(tindex,:);
    [w,windex]=max(f);
    worst=X(windex,:);
    xnew=zeros(row,col);
    
    for i=1:row
        a=randperm(nPop,1);
        b=randperm(nPop,1);
        while a==b | a==i |b==i
            a=randperm(nPop,1);
            b=randperm(nPop,1);
        end
        fi=rand;
        if fi<=1/3
            xnew(i,:)=(X(i,:))+randn.*(Best-abs(X(i,:)))-randn.*(worst-abs(X(i,:)));  %
        elseif fi>=2/3
            xnew(i,:)=X(i,:)+rand(1,nVar).*(Best-(X(i,:)))+rand(1,nVar).*(X(a,:)-X(b,:));
        else
            xnew(i,:)=(X(i,:))+randn.*(Best-abs(X(i,:)))-randn.*(mean(X)-abs(X(i,:)));
        end
    end
    
    for i=1:row
        xnew(i,:) = max(min(xnew(i,:),VarMax),VarMin);
        fnew(i) = fhd(xnew(i,:));
    end
    
    for i=1:nPop
        if(fnew(i)<f(i))
            X(i,:) = xnew(i,:);
            f(i) = fnew(i);
        end
    end
    gen = gen+1;
    [BestCost(gen),ind]=min(f);
    XTarget=X(ind,:);
end
BestValue=min(f);
%%

end
