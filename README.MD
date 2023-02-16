# Spectroflip
## A MATLAB script for "mirroring" audio files.

Interpolating an audio file creates a mirror of the spectrogram above the original audio file's Nyquist frequency. This script isolates the mirrored part and shifts it back to the original range, resulting in some nightmare-inducing sounds. The script may have possible applications in sound design and signal processing. Audio signals with low samplerates usually result in more audible results.

## Toolbox dependencies
* Signal Processing Toolbox

## Usage
The funcion works as a drop-in replacement for ```audioread()```.

```[wave, sampleRate] = spectroflip("path_to_file.wav");```

## Screenshots
Spectrograms of the original and "flipped" audio files, respectively.

<img src="https://i.postimg.cc/xjRmNq87/original.png" alt="Spectrogram of the original audio" width="40%"/> <img src="https://i.postimg.cc/Pr5wWh8q/flipped.png" alt="Spectrogram of the flipped audio" width="40%"/>

