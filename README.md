# RobotStuff

scripts and utils to manage computer related tasks


# Audio Transcription to Markdown

This Ruby script transcribes dictated audio and writes the transcription directly into a markdown file. It uses the OpenAI whisper API for the transcription.

## Features

- Records audio from a selected input device.
- Transcribes the recorded audio using the OpenAI API.
- Writes the transcription directly to a selected markdown file.

## Installation

1. Clone this repository to your local machine.
2. Install the required Ruby gems by running `bundle install` in the project directory.
3. Set up your OpenAI API key as an environment variable named `OPENAI_ACCESS_TOKEN`.
4. Install `jack_capture` if you plan to use JACK as your audio input source. This can be done through your package manager (e.g., `sudo apt install jack_capture` on Ubuntu).

## Usage

1. Run the script by executing `ruby scriber.rb` in your terminal.
2. The script will prompt you to select an audio input source (either ALSA or JACK).
3. Next, you will be asked to select the markdown file where the transcription will be written.
4. The script will then record audio for a specified duration (default is 240 seconds) and transcribe it.
5. The transcription will be written directly to the selected markdown file.

## Using sxhkd, i3, input-remapper

The record button on the Dictaphone microphone is mapped to launch scriber.rb. This is set in sxhdrc. when the record button is pressed, scriber.rb is launched the recording starts. There is a funny little thing about what input Ruby standard input can interpret. At this point press 8 to stop the recording early. The stop button on the Dictaphone mic is mapped to a macro with input-remapper. When the stop button is pressed XF86RotateWindows is called which triggers an i3 binding which will focus any window that has the WM_CLASS "notepad" and the WM_NAME "scriber.rb", after which it will then append the number 8.




https://platform.openai.com/docs/guides/speech-to-text

https://platform.openai.com/playground/p/default-code-execution
