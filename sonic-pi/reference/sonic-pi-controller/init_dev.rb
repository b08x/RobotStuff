# Script to be used in development. Instead of `require '.../init'` from
# SonicPi, `load '.../init_dev.rb'` and code will be reloaded on each Alt+R.

dir = File.join(__dir__, 'lib', 'sonic-pi-control')

load "#{dir}/core_extensions/range.rb"
load "#{dir}/helpers.rb"
load "#{dir}/api.rb"
load "#{dir}/controller.rb"

# bypass the mechanism that avoids hot-changing the model, forcing a reload of
# the config on each call:
SonicPiControl::Controller.instance_variable_set(:@_model, nil)

include SonicPiControl::API
