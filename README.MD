# Spectroflip
## A MATLAB script for "mirroring" audio files.

Interpolating an audio file creates a mirror of the spectrogram above the original audio file's Nyquist frequency. This script isolates the mirrored part and shifts it back to the original range, resulting in some nightmare-inducing sounds. The script may have possible applications in sound design. I recommend using audio files with low sample rates for best results.

## Toolbox dependencies
* Signal Processing Toolbox

## Usage
Call the function with the path to the audio file as its parameter. The function writes the audio file to "spectroflip_output.wav" and returns the flipped audio file as an array.
```spectroflip("path_to_file.wav");```