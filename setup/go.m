% 2021 European GNU Radio Days baseband signal generator
% assumes the 2^10-1 long PRN sequences have been calculated
% using lfsr.c and stored in a 3-letter name matching the polynomial
% representation of the taps

clear all
close all
pkg load signal

d=dir('./???');   % load PRN sequence
for k=1:length(d)
  x(:,k)=load(d(k).name);x(:,k)=x(:,k)-mean(x(:,k));
end

if (1==0)         % check that the codes are orthogonal (not needed)
for k=1:length(d)-1
  subplot(length(d)-1,1,k)
  for l=k+1:length(d)
    plot(xcorr(x(:,k),x(:,l)));hold on
  end
end
end

for m=1:6         % 6 speakers that enjoy analyzing GPS (BPSK) signals
  if (m==1) c="Buongiorno";end
  if (m==2) c="Bonjour   ";end
  if (m==3) c="BuenosDias";end
  if (m==4) c="Zdravo    ";end
  if (m==5) c="GutenTag  ";end
  if (m==6) c="SeOnOkei  ";end
  s=[]
  p=1;
  for k=1:length(c)                % UART-like encoding
    s=[s; exp(j*pi*x(:,m))];       % start bit
    val=double(c(k))
    b(p,m)=1;p=p+1;
    for l=1:8
      b(p,m)=mod(val,2);p=p+1;
      if (mod(val,2)==1) 
         s=[s ; exp(j*pi*x(:,m))]; 
      else
         s=[s ; exp(-j*pi*x(:,m))];
      end
      val=floor(val/2);
    end
    s=[s ; exp(-j*pi*x(:,m))];     % stop bit
    b(p,m)=0;p=p+1;
  end
  sortie(:,m)=s;
end
signal=sum(sortie');
plot(signal,'x');title('constellation diagram');xlabel('I');ylabel('Q')
% return  % stop here to just display the constellation diagram
  
for m=4:4 % 1:6
  % subplot(6,1,m)
  s=-imag(xcorr(signal,x(:,m)));
  plot(s(floor(length(s)/2):end)/max(abs(s)))
  hold on
  t=linspace(0,length(s)/2-1024,length(b(:,m)));
  plot(t,(b(:,m))-0.5,'x')
end
signal=signal';
  
c="Hello"              % OOK modulated message to hint at UART encoding
s=[]
p=1;
for k=1:length(c)
  s=[s; signal];       % start bit
  val=double(c(k))
  b(p,m)=0;p=p+1;
  for l=1:8
    b(p,m)=mod(val,2);p=p+1;
    if (mod(val,2)==1) 
       s=[s ; signal]; 
    else
       s=[s ; zeros(length(signal),1)];
    end
    val=floor(val/2);
  end
  s=[s ; zeros(length(signal),1)];        % stop bit
end
s=[s; zeros(floor(length(s)/2),1)];
write_complex_binary(s,"challenge.bin")
