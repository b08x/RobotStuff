#!/usr/bin/env bash

# find files with fd then execute rename
fd "__bak" -a -x rename -a -v '__bak' '' {}
