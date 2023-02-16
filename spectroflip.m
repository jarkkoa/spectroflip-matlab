function [flippedWave, sampleRate] = spectroflip(audioPath)

    [wave, sampleRate] = audioread(audioPath);

    interpFactor = 2;
    channelCount = width(wave);

    for channel = 1:channelCount

        channelData = wave(:,channel);

        % Interpolate by 2 to create a "mirror image" of the sound file's spectrogram
        z = zeros([interpFactor*length(channelData) 1]);
        z(1:interpFactor:end) = channelData;
    
        highPass = fir1(2000, (0.25)*2, "high", blackman(2001)); % For removing original frequencies
    
        mirrorWaveIsolated = conv(z, highPass);
    
        % Shift the spectrum down
        n = (1:length(mirrorWaveIsolated));
        shifted = mirrorWaveIsolated' .* cos(2*pi* n * (sampleRate/2) / (interpFactor*sampleRate));
    
        % Resample back to original sample rate
        antiAliasFilter = fir1(2000, (0.25)*2, "low", blackman(2001));
        shifted = conv(shifted, antiAliasFilter);
        channelData = shifted(1:2:end);
        channelData = channelData(1:length(wave));

        % Replace the original channel with an inverted channel
        wave(:,channel) = channelData';

    end

    % Normalize to -0.1 dB
    peak = 10^(99/100)/10; % (dB)
    wave = wave * peak / max(abs( wave(:)));

    flippedWave = wave;

end