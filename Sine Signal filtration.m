close all;
clear all;
clc;
t=1:0.025:10; %defining time array
signal=5*sin(2*pi*t);
L=length(signal);
noise=randn(1,L);
sigwn=signal+noise;
order=2;
mu=0.005;
n=length(sigwn);
delayed=zeros(1,order);
adap=zeros(1,order);
noisermvdsig=zeros(1,n);
alpha=20;
beta=0.2;
for k=1:n,
  
  delayed(1)=noise(k);
  y=delayed*adap';
  noisermvdsig(k)=sigwn(k)-y;
  mu(k)=beta*(1/(1+exp(-alpha*abs(noisermvdsig(k))))-0.5);
  %LMS
  
  %adap = adap + 2*mu(k)*noisermvdsig(k) .* delayed;
  
  %LMS-F
  
  %adap=adap+2*mu(k)*((noisermvdsig(k)^3)/((noisermvdsig(k)^2)+0.001)).*delayed;
  
  %NLMS
  %adap=adap+mu(k)*((noisermvdsig(k)*delayed)/(delayed*delayed'));
  
  %VSS-LMS
 
  %adap=adap + 2*mu(k)*noisermvdsig(k)*delayed;
  
  delayed(2:order)=delayed(1:order-1);
end
%Plotting the Graphs
subplot(4,1,1);
plot(signal);
xlabel('Samples/Time');
ylabel('Magnitude');
title('Input Signal');
subplot(4,1,2);
plot(noise);
xlabel('Samples/Time');
ylabel('Magnitude');
title('Noise Signal');
subplot(4,1,3);
plot(sigwn);
xlabel('Samples/Time');
ylabel('Magnitude');
title('Signal with Noise');
subplot(4,1,4);
plot(noisermvdsig);
xlabel('Samples/Time');
ylabel('Magnitude');
title('Noise Cleared Signal');