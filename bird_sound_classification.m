%% 1. Load Audio
filename = 'bird sound.mp3'; 
[audioIn, fs] = audioread(filename);
if size(audioIn,2) > 1, audioIn = mean(audioIn,2); end

%% 2. Apply a Filter (The "Separator")
% Most bird sounds live between 1,000Hz and 8,000Hz. 
% We will cut out the low rumbling wind and very high static.
lowCut = 1000; 
highCut = 8000;

% Create the filter "sieve"
audioClean = bandpass(audioIn, [lowCut highCut], fs);

%% 3. Play and Compare
fprintf('Playing original audio...\n');
sound(audioIn(1:fs*5), fs); % Play 5 seconds of original
pause(6); 

fprintf('Playing "Separated" bird sounds...\n');
sound(audioClean(1:fs*5), fs); % Play 5 seconds of filtered

%% 4. Save the result
audiowrite('only_birds.wav', audioClean, fs);
disp('Saved as only_birds.wav!');

%% 5. Visual Proof
figure;
subplot(2,1,1); plot(audioIn); title('Original Waveform (Messy)');
subplot(2,1,2); plot(audioClean); title('Separated Waveform (Clean)');