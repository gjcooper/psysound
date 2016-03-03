function [stim]=glides(omega, fs)
        t=[0:ceil((max(omega(:, end)))*fs)]'/fs;
        sampmax=length(t);
        stim=zeros(sampmax, 1);
        for ii=1:size(omega, 1),
                samp0=ceil(omega(ii, end-1)*fs);
                samp1=ceil(omega(ii, end)*fs)+1;
                if samp0 == 0
                    samp0 = 1;
                end
                tt=t(samp0:samp1)-t(samp0);
                % evol ving frequency
                eomega=omega(ii, 1)*(tt.*tt)+omega(ii, 2)*tt+omega(ii, 3);
                % windowed to remove spreading energy across spectrum at onset impulses
                stim(samp0:samp1)=stim(samp0:samp1)+...
                        sin(2*pi*eomega.*tt+rand);
%                     .*hanning(length(tt));
                clear eomega;
        end;
