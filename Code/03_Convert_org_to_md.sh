#! /bin/env bash

# Convert *.org in "Posts org-mode" to *.qmd files in "Posts md" directory

cd Posts\ org-mode
for fn in `ls *.org`;
  do
  #echo $fn
  #echo "../Posts md/${fn%.org}.md"
  pandoc "$fn" -s --wrap=none --to=markdown --atx-headers -o "../Posts md/${fn%.org}.qmd"
  done
