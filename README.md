# Notes

This collection of scripts uses the MATLAB package format.

These files should be placed in folder named +PsySound, and the +PsySound folder shouldbe be viewable on the MATLAB path (contained in a folder on the MATLAB search path, or in the directory where your script that calls this package resides).

## Using the package

## Specifying a sound

```matlab
ss = PsySound.SoundSpec();
ss.Ramp_length_start = 5*10^-4;
ss.Ramp_length_end = 5*10^-4;
ss.Duration=1;
ss.Sample_frequency=48000;
ss.Frequency=1000;
```

## Making the sound

```
snd = PsySound.Sound(ss);
snd.Filename = strcat('1kH_1sec.wav');
snd.Save();
```

## Other operations

Sounds can be combined to form complex sounds, phase and time can be shifted to one channel or another to change apparent location of the resulting sound and more.
