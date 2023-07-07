#!/usr/bin/env bash

if [[ -z "$1" ]]; then
  echo "load or kill. which is it?"
fi

function run {
  if ! pgrep -x -f "$1" ; then
    $@&
  fi
}

function murder {
  pid=$(pgrep -x -f "$1")

  if [[ ! -z $pid ]]  ; then
    kill -9 $pid
  fi
}

EQ=("http://moddevices.com/plugins/caps/EqFA4p"
"http://plugin.org.uk/swh-plugins/mbeq"
"http://plugin.org.uk/swh-plugins/singlePara"
"http://moddevices.com/plugins/tap/eqbw"
"http://moddevices.com/plugins/tap/eq"
"http://plugin.org.uk/swh-plugins/triplePara"
"http://moddevices.com/plugins/caps/Eq10X2"
"http://moddevices.com/plugins/caps/Eq10X2")

COMPRESSOR=("http://plugin.org.uk/swh-plugins/se4"
"http://plugin.org.uk/swh-plugins/sc2"
"http://plugin.org.uk/swh-plugins/dysonCompress"
"http://moddevices.com/plugins/caps/CompressX2"
"http://lsp-plug.in/plugins/lv2/sc_mb_compressor_lr")

case $1 in
  load )
    for e in "${EQ[@]}"; do
       run "jalv.gtk $e" || continue
    done

    sleep 1

    for c in "${COMPRESSOR[@]}"; do
      run "jalv.gtk $c" || continue
    done
    ;;
  kill )
    for ec in "${COMPRESSOR[@]}" "${EQ[@]}"; do
      murder "jalv.gtk $ec"
    done
    ;;
esac
