#!/usr/bin/env ruby

# where the git metadata is stored
dots_git_folder = File.join(ENV['HOME'], '.dots/')

dots_ignore_file = File.join(dots_git_folder, '.gitignore')

dots_repo_address = "git@github.com:b08x/dots"

# alias command that tells git the files are in a
# different location than the metadata
git_dots = "/usr/bin/git --git-dir=#{dots_git_repo} --work-tree=#{ENV['HOME']}"

hostname = ARGV[0]

# add the dots repo to .gitignore
`echo ".dots" >> "#{ignore_file}"`

`git clone --bare #{dots_repo} #{dots_git_folder}`



`#{git_dots} checkout #{hostname}`

mkdir -p .dots-backup && \
dots checkout lapbot 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .dots-backup/{}
