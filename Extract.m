function waves = Extract(waveform, threshold, length)
% Input parameters:
%   waveform = the original waveform to extract from - assumed to be
%   stereo
%   threshold = the value that determines a deviation from background
%   noise.
%   length = the number of datapoints under threshold before the sample is
%   taken to be finshed
run = length;
start_positions = zeros(0);
end_positions = zeros(0);
inwave = 0;

for i = 1:size(waveform, 1)
    if ((abs(waveform(i,1)) > threshold) || (abs(waveform(i,2)) > threshold))
        if (inwave == 0)
            start_positions = [start_positions i];
            inwave = 1;
        end
        run = 0;
    else
        if run < length
            run = run + 1;
        elseif (inwave == 1)
            end_positions = [end_positions i];
            inwave = 0;
        end
    end
end

waves = cell(0);

if (size(start_positions,2) == size(end_positions,2))
    for j = 1:size(start_positions,2)
        waves = [waves waveform(start_positions(1,j):end_positions(1,j), :)];
    end
end
        
