#!/bin/bash
#
# renumber lines in given file to itself

if [ $# -ne 3 ]; then
  echo "Usage: $(basename $0) FILE_NAME START_NUM INCREMENT"
  exit 1
fi

IN_FILE=$1
START_NUM=$2
INCR=$3

awk -v N=$START_NUM -v I=$INCR '
{
  if ($0 == "") {
    printf("%s ;\n", N);
  } else {
    printf("%s %s\n", N, $0);
  }
  N += I;
}
' $IN_FILE

