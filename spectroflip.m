function flipped = spectroflip(audioPath)

    [wave, sampleRate] = audioread(audioPath);

    interpFactor = 2;

    if width(wave) > 1
        wave = mean(wave, width(wave)); % Mix down to mono
    end

    % Interpolate by 2 to create a "mirror image" of the sound file's spectrogram
    z = zeros([interpFactor*length(wave) 1]);
    z(1:interpFactor:end) = wave;

    highPass = fir1(2000, (0.25)*2, "high", blackman(2001)); % For removing original frequencies

    mirrorWave = conv(z, highPass);

    % Shift the spectrum to 0 - sampleRate Hz
    n = (1:length(mirrorWave));
    shifted = mirrorWave' .* cos(2*pi* n * (sampleRate/2) / (interpFactor*sampleRate));

    % Resample vack to original sample rate
    antiAliasFilter = fir1(2000, (0.25)*2, "low", blackman(2001));
    shifted = conv(shifted, antiAliasFilter);
    finalWave = shifted(1:2:end);

    % Normalize to -0.1 dB & save
    peak = 10^(99/100)/10; % (dB)
    finalWave = finalWave * peak / max(finalWave);
    newFileName = "spectroflip_output.wav";
    audiowrite(newFileName, finalWave, sampleRate);

    flipped = finalWave;

end