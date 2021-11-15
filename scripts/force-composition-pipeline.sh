#!/bin/bash

# Get current nvidia settings and enable ForceFullCompositionPipeline

s="$(nvidia-settings -q CurrentMetaMode -t)"

if [[ "${s}" != "" ]]; then
  s="${s#*" :: "}"
  nvidia-settings -a CurrentMetaMode="${s//\}/, ForceFullCompositionPipeline=On\}}"
fi
