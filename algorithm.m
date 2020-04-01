clear

global g;
global Ts;


global simdata;
altitude=52;
latitude=59.3325;
Ts = 1.0/125;
Ts = 1.0/1000;
g=gravity(latitude,altitude);

simdata.g=g;
simdata.sigma_a=0.01; 
simdata.sigma_g=0.1*pi/180;

% simdata.sigma_a=5; 
% simdata.sigma_g=100*pi/180; 

simdata.Window_size=3;
simdata.gamma=0.3e5; 


u=load('output.txt');


% Data=importdata('sensorLog_20200326T165424_standing.txt');    %Import the data
% %Data=importdata('sensorLog_20200326T165545_walking.txt');    %Import the data
% Data=importdata('sensorLog_20200326T165939_running.txt');    %Import the data
% 
% formatedData=zeros(6,size(Data.data,1)/2);
% kacc=1;
% kgyro=1;
% for ii=1:size(Data.data,1)
% 
%     if ~isempty(strfind(Data.textdata{ii},'ACC'))
%         formatedData(1:3,kacc)=Data.data(ii,:);
%         kacc=kacc+1;
%     end
% 
%     
%     if ~isempty(strfind(Data.textdata{ii},'GYR'))
%         formatedData(4:6,kgyro)=Data.data(ii,:);
%         kgyro=kgyro+1;
%     end
% end
% u=formatedData;
%%
[zupt T]=zero_velocity_detector(u(2:7,:));


function [zupt T]=zero_velocity_detector(u)


% Global struct holding the simulation settings
global simdata;

% Allocate memmory
zupt=zeros(1,length(u));

% calculated test statistics T. 

T=GLRT(u);


% Check if the test statistics T are below the detector threshold. If so, 
% chose the hypothesis that the system has zero velocity 
W=simdata.Window_size;
for k=1:length(T)
    if T(k)<simdata.gamma
       zupt(k:k+W-1)=ones(1,W); 
    end    
end

% Fix the edges of the detector statistics
T=[max(T)*ones(1,floor(W/2)) T max(T)*ones(1,floor(W/2))];
end


%>  T          The test statistics of the detector 
%>  u          The IMU data vector.     

function T=GLRT(u)

global simdata;

g=simdata.g;
sigma2_a=simdata.sigma_a^2;
sigma2_g=simdata.sigma_g^2;
W=simdata.Window_size;


N=length(u);
T=zeros(1,N-W+1);

for k=1:N-W+1
   
    ya_m=mean(u(1:3,k:k+W-1),2);
    
    for l=k:k+W-1
        tmp=u(1:3,l)-g*ya_m/norm(ya_m);
        T(k)=T(k)+u(4:6,l)'*u(4:6,l)/sigma2_g+tmp'*tmp/sigma2_a;    
    end    
end

T=T./W;

end

function g=gravity(lambda,h)

lambda=pi/180*lambda;
gamma=9.780327*(1+0.0053024*sin(lambda)^2-0.0000058*sin(2*lambda)^2);
g=gamma-((3.0877e-6)-(0.004e-6)*sin(lambda)^2)*h+(0.072e-12)*h^2;
end
