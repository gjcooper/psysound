classdef Sound < matlab.System & matlab.mixin.Copyable
    %A specification for a sound
    %   Contains a specification for a sound, two particular types that can
    %   be created. A simple sound that has a single frequency, ramps rates
    %   etc. The other is a complex sound that is formed by adding multiple
    %   sounds together and other operations.
    %
    %   Not currently designed to be able to be saved and loaded correctly.
    
    properties
        spec@PsySound.SoundSpec;
        Filename = 'temp.wav';
    end
    properties(Access = private)
        data
    end
    
    methods
        %%
        function obj = Sound(s)
            obj.spec = s;
            obj.Generate();
        end
        
        function Plot(obj)
            sstep=1/double(obj.spec.Sample_frequency);
            bins=round(obj.spec.Duration/sstep);
            dbins=round(obj.spec.Delay/sstep);
            if strcmp(obj.spec.Type,'time')
                t=(1:bins+dbins).*sstep;
            else
                t=(1:bins).*sstep;
            end
            lchan = obj.data(:,1)';
            rchan = obj.data(:,2)';
            plot(t,lchan)
            hold
            plot(t,rchan,'r')
            xlabel('seconds')
        end
        
        function Play(obj)
            sound(obj.data,obj.spec.Sample_frequency)
        end
        
        function Save(obj)
            audiowrite(obj.Filename, obj.data, obj.spec.Sample_frequency, 'BitsPerSample', obj.spec.Bitrate)
        end
    end
    methods(Access = private)
        function Generate(obj)
            sstep=1/obj.spec.Sample_frequency;
            numcycles=obj.spec.Frequency*obj.spec.Duration;
            bins=round(obj.spec.Duration/sstep);
            dbins=round(obj.spec.Delay/sstep);
            rfisteps=((obj.spec.Ramp_length_start/sstep)/bins)*100;
            rfosteps=((obj.spec.Ramp_length_end/sstep)/bins)*100;
            StartPhase=obj.spec.Delay/(1/obj.spec.Frequency);
            
            % generate two sounds 
            chan1=obj.spec.Amplitude*PsySound.rcos(sin(linspace(0,numcycles*2*pi,bins)),rfisteps,rfosteps);
            if strcmp(obj.spec.Type,'phase')
                chan2=obj.spec.Amplitude*PsySound.rcos(sin(linspace(StartPhase*2*pi,(StartPhase*2*pi + numcycles*2*pi),bins)),rfisteps,rfosteps);
                if strcmp(obj.spec.Ear,'left')
                    obj.data = [chan1',chan2'];
                else
                    obj.data = [chan2',chan1'];
                end
            elseif strcmp(obj.spec.Type, 'sing')
                chan2=0*PsySound.rcos(sin(linspace(0,numcycles*2*pi,bins)),rfisteps,rfosteps);
                if strcmp(obj.spec.Ear,'left')
                    obj.data = [chan1',chan2'];
                else
                    obj.data = [chan2',chan1'];
                end
            elseif strcmp(obj.spec.Type,'time')
                chan2=obj.spec.Amplitude*PsySound.rcos(sin(linspace(0,numcycles*2*pi,bins)),rfisteps,rfosteps);                
                % add some trailing zeros
                chan1=[chan1 zeros(1,dbins)];
                chan2=[chan2 zeros(1,dbins)];
                % delay one sound by delay ms
                chan2d=[zeros(1,dbins) chan2(1:(length(chan2)-dbins))];
                if strcmp(obj.spec.Ear,'left')
                    obj.data = [chan2d',chan1'];
                else
                    obj.data = [chan1',chan2d'];
                end
            else
                chan2=obj.spec.Amplitude*PsySound.rcos(sin(linspace(0,numcycles*2*pi,bins)),rfisteps,rfosteps);                
                obj.data = [chan1', chan2'];
            end
        end
    end
end

