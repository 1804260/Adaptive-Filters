clc;
close all;
clear all;
dim=10000;
fs=8000;
[yss, fs] = audioread('C:\nearspeech.wav');
xss=yss(:,1);
speech=xss';
input=(speech(:,(60000:69999)));
% noise=2*rand(1,dim)-1;  %uniform noise
noise = awgn(input,10); % gaussian noise
sigwn=input+noise; %signal mixed with Noise
order=10;
mu=0.01; %Determines Rate and Accuracy of convergence
mu1=0.05;
mu2=0.01;
n=length(sigwn);
U=zeros(1,order);
adap=zeros(1,order);
noisermvdsig=zeros(1,dim);
vth=0.01;
mu_min=1e-4;    
mu_max=3e-4;     
alpha=0.01;
gamma=0.9;
mu(1)=0.01;
for k=1:n
     U(1,2:end) = U(1,1:end-1);  % Shifting of frame window
        U(1,1) = noise(k);              % Input
y=U*adap';
noisermvdsig(k)=sigwn(k)-y;
%LMS

% adap = adap + 2*mu*noisermvdsig(k) .* U;

%LMS/F

%adap=adap+mu1*((noisermvdsig(k)^3)/((noisermvdsig(k)^2)+0.001)).*U;

%NLMS

 %adap=adap+mu2*((noisermvdsig(k)*U)/(U*U'));
 
%VSS-LMS
 
  %adap=adap + 2*mu2*noisermvdsig(k)*U;
 
end
%Plotting the Graphs
subplot(4,1,1);
plot(input);
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
