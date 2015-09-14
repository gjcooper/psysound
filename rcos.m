% function fsig=rcos(sig,P1,P2)
%
% rcos puts a raised cosine window on a sound stimulus
% (imposes a raised cos window on the first and last
% P percent of the buffer)
%
%%%%%%%%% Output Arguments %%%%%%%%%
% fsig is the windowed signal
%%%%%%%%% Mandatory Arguments %%%%%%%%%
% sig is the original signal
% P1/P2 indicates the percentage of the signal to impose the raised cosine

function fsig=rcos(sig,P1,P2)
[r,c]=size(sig);
if (c > 1)
   sig = sig.';
   r=size(sig,1);
end

if ((P1 ~= 0) && (P2 ~= 0))
   fi=round(r*(P1/100));
   fo=round(r*(P2/100));
   wi=PsySound.hanning(fi.*2);
   wo=PsySound.hanning(fo.*2);
   fsig=[sig(1:fi).*wi(1:fi);sig(fi+1:r-fo);sig(r-fo+1:r).*wo((fo+1):(fo.*2))];
   %fsig=[sig(1:fl).*w(1:fl);sig(fl+1:r)];
elseif (P1 ~= 0)
   fi=round(r*(P1/100));
   wi=PsySound.hanning(fi.*2);
   fsig=[sig(1:fi).*wi(1:fi);sig(fi+1:r)];
elseif (P2 ~= 0)
   fo=round(r*(P2/100));
   wo=PsySound.hanning(fo.*2);
   fsig=[sig(1:r-fo);sig(r-fo+1:r).*wo((fo+1):(fo.*2))];
else
   fsig = sig;
end

if (c > 1)
   fsig = fsig.';
end

