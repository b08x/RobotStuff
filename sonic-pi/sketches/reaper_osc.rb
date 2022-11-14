define :osc_setup do
  use_osc "localhost", 8000
  osc "/tempo/raw", 99
  a = sync "s/track/1/name"
  print a[0]

end

use_osc_logging true
use_debug true

osc_setup
