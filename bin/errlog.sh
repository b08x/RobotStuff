#!/usr/bin/env bash

declare -rx ERRLOG="$HOME/errlog.md"

cat <<EOF >$ERRLOG
# Good news!

> The system made it this far.
> You have something to live for.
> You're doing great.

# log entries of note for $(date)
\`\`\`bash
$(journalctl -p 3 -b )
\`\`\`

# services that failed to start:

\`\`\`ruby
$(systemctl --failed)
\`\`\`


EOF

# i3-msg "exec /usr/bin/kitty --hold --class 'changelog' sh -c 'cat ~/changelog.md | gum format -t markdown | gum style --border thick --margin '10 10' --padding '1 1'  --border-foreground 198 --background 34 --foreground 12'"

i3-msg "exec --no-startup-id /usr/bin/kitty --hold --class 'changelog' sh -c 'cat ~/errlog.md | gum format -t markdown | gum style --border-foreground 12 --background 0 --foreground 58 --border normal'"

# # /usr/bin/kitty --hold --class 'changelog' sh -c 'gum style --border normal --margin "10 10" --padding "1 2" --border-foreground 212 < $ERRLOG | gum format -t code'
