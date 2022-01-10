%%  %  Chimp Optimization Algorithm (ChOA) source codes version 1.0   
% By: M. Khishe, M. R. Musavi
% m_khishe@alumni.iust.ac.ir
%For more information please refer to the following papers:
% M. Khishe, M. R. Mosavi, “Chimp Optimization Algorithm,” Expert Systems
% With Applications, 2020.
%https://www.sciencedirect.com/science/article/abs/pii/S0957417420301639
% Please note that some files and functions are taken from the GWO algorithm
% such as: Get_Functions_details, PSO, initialization.
%  For more information please refer to the following papers:
% Mirjalili, S., Mirjalili, S. M., & Lewis, A. (2014). Grey Wolf Optimizer. Advances in engineering software, 69, 46-61.
%% --------------------------------------------------------------------------------------------------------------------%

function O=chaos(index,max_iter,Value)

O=zeros(1,max_iter);
x(1)=0.7;
switch index
%Chebyshev map
    case 1
for i=1:max_iter
    x(i+1)=cos(i*acos(x(i)));
    G(i)=((x(i)+1)*Value)/2;
end
    case 2
%Circle map
a=0.5;
b=0.2;
for i=1:max_iter
    x(i+1)=mod(x(i)+b-(a/(2*pi))*sin(2*pi*x(i)),1);
    G(i)=x(i)*Value;
end
    case 3
%Gauss/mouse map
for i=1:max_iter
    if x(i)==0
        x(i+1)=0;
    else
        x(i+1)=mod(1/x(i),1);
    end
    G(i)=x(i)*Value;
end

    case 4
%Iterative map
a=0.7;
for i=1:max_iter
    x(i+1)=sin((a*pi)/x(i));
    G(i)=((x(i)+1)*Value)/2;
end

    case 5
%Logistic map
a=4;
for i=1:max_iter
    x(i+1)=a*x(i)*(1-x(i));
    G(i)=x(i)*Value;
end
    case 6
%Piecewise map
P=0.4;
for i=1:max_iter
    if x(i)>=0 && x(i)<P
        x(i+1)=x(i)/P;
    end
    if x(i)>=P && x(i)<0.5
        x(i+1)=(x(i)-P)/(0.5-P);
    end
    if x(i)>=0.5 && x(i)<1-P
        x(i+1)=(1-P-x(i))/(0.5-P);
    end
    if x(i)>=1-P && x(i)<1
        x(i+1)=(1-x(i))/P;
    end    
    G(i)=x(i)*Value;
end

    case 7
%Sine map
for i=1:max_iter
     x(i+1) = sin(pi*x(i));
     G(i)=(x(i))*Value;
 end
    case 8
 %Singer map 
 u=1.07;
 for i=1:max_iter
     x(i+1) = u*(7.86*x(i)-23.31*(x(i)^2)+28.75*(x(i)^3)-13.302875*(x(i)^4));
     G(i)=(x(i))*Value;
 end
    case 9
%Sinusoidal map
 for i=1:max_iter
     x(i+1) = 2.3*x(i)^2*sin(pi*x(i));
     G(i)=(x(i))*Value;
 end
 
    case 10
 %Tent map
 x(1)=0.6;
 for i=1:max_iter
     if x(i)<0.7
         x(i+1)=x(i)/0.7;
     end
     if x(i)>=0.7
         x(i+1)=(10/3)*(1-x(i));
     end
     G(i)=(x(i))*Value;
 end

end
O=G;
