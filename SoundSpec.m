classdef SoundSpec < matlab.System & matlab.mixin.Copyable
    %A specification for a sound
    %   Contains a specification for a sound, two particular types that can
    %   be created. A simple sound that has a single frequency, ramps rates
    %   etc. The other is a complex sound that is formed by adding multiple
    %   sounds together and other operations.
    %
    %   Not currently designed to be able to be saved and loaded correctly.
    
    properties
        Frequency(1,1) double = 1000;
        Duration(1,1) double = 1;
        Sample_frequency(1,1) double = 44100;
        Amplitude(1,1) double = 0.9;
        Type = 'norm';
        Ear = 'na';
        Bitrate = 16;
        Ramp_length_start(1,1) double = 0.005;
        Ramp_length_end(1,1) double = 0.005;
        Delay(1,1) double = 0;
    end
    properties(Access = private)
        data
    end
    properties(Hidden,Transient)
        TypeSet = matlab.system.StringSet({'norm', 'phase', 'time', 'sing', 'complex'});
        EarSet = matlab.system.StringSet({'left', 'right', 'na'});
    end   
    
    methods
        %% Setter Methods
        function set.Frequency(obj,erIn)
            if erIn > 0 || isnan(erIn)
                obj.Frequency = erIn;
            else
                obj.Frequency = NaN;
                warning('Frequency must be positive');
            end
        end

        function set.Duration(obj,erIn)
            if erIn > 0 || isnan(erIn)
                obj.Duration = erIn;
            else
                obj.Duration = NaN;
                warning('Duration must be positive');
            end
        end
        
        function set.Sample_frequency(obj,erIn)
            if erIn > 0 || isnan(erIn)
                obj.Sample_frequency = erIn;
            else
                obj.Sample_frequency = NaN;
                warning('Sample_frequency must be positive');
            end
        end
        
        function set.Ramp_length_start(obj,erIn)
            if (erIn >= 0 && erIn <= obj.Duration) || isnan(erIn)
                obj.Ramp_length_start = erIn;
            else
                obj.Ramp_length_start = NaN;
                warning('Ramp_length_start must be positive and less than duration');
            end
        end
        
        function set.Ramp_length_end(obj,erIn)
            if (erIn >= 0 && erIn <= obj.Duration) || isnan(erIn)
                obj.Ramp_length_end = erIn;
            else
                obj.Ramp_length_end = NaN;
                warning('Ramp_length_end must be positive and less than duration');
            end
        end
        
        function set.Amplitude(obj,erIn)
            if (erIn >= 0 && erIn <= 1) || isnan(erIn)
                obj.Amplitude = erIn;
            else
                obj.Amplitude = NaN;
                warning('Amplitude must be between 0 and 1');
            end
        end
        
        function set.Delay(obj,erIn)
            if (erIn >= 0 && erIn <= obj.Duration) || isnan(erIn)
                obj.Delay = erIn;
            else
                obj.Delay = NaN;
                warning('Delay must be positive and less than duration');
            end
        end
        
        function value = get.Delay(obj)
            value = obj.Delay;
        end
        
        function set.Bitrate(obj,erIn)
            if erIn == 16 || erIn == 24 || erIn == 32
                obj.Bitrate = erIn;
            else
                obj.Bitrate = NaN;
                warning('Bitrate must be one of 16, 24 or 32');
            end
        end
    end
end