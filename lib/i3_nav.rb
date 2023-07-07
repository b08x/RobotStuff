#!/usr/bin/env ruby

class WorkspaceSwitcher
  def initialize(file)
    @file = file
  end

  # Opens the selected file in VSCode
  def open_file_in_vscode
    system("code --goto #{@file}")
  end
end
