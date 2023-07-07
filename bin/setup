#!/usr/bin/env bash

APP_ROOT="$HOME/Workspace/robotstuff"

# Check if pyenv is installed
if ! command -v pyenv &> /dev/null; then
    # install pyenv
    paru -S pyenv --noconfirm
fi

# Check if Python 3.10.6 environment is installed
if ! pyenv versions --bare | grep -q '3.10.6'; then
    # create environment, using python 3.10.6
    env CONFIGURE_OPTS="--enable-shared" pyenv install 3.10.6
fi

pyenv local 3.10.6

# Check if spacy is installed
if ! python -c "import spacy" &> /dev/null; then
    # install spacy
    pip install spacy
fi

# Check if language models are installed
if ! python -c "import spacy; spacy.load('en_core_web_sm')" &> /dev/null; then
    python -m spacy download en_core_web_sm
fi

if ! python -c "import spacy; spacy.load('en_core_web_lg')" &> /dev/null; then
    python -m spacy download en_core_web_lg
fi

# Check if postgresql-libs is installed
if ! $(paru -Q | awk '{ print $1}' |grep postgresql-libs) &> /dev/null; then
    # install pyenv
    paru -S postgresql-libs --noconfirm
fi

cd $APP_ROOT && sudo bundle update
