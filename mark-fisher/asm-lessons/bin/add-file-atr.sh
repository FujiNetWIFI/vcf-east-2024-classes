#!/bin/bash
#
# inserts file into ATR after converting it to ATASCII
# using franny and aac to convert and insert

if [ $# -ne 2 ]; then
  echo "Usage: $(basename $0) ATR_FILE FILE_NAME"
  exit 1
fi

FRANNY=$(which franny)
if [ $? -ne 0 ] ; then
  echo "ERROR: franny executable missing in path"
  exit 1
fi

AAC=$(which aac)
if [ $? -ne 0 ] ; then
  echo "ERROR: aac executable missing in path"
  exit 1
fi

ATR_FILE=$1
IN_FILE=$2
BASE_IN_FILE=$(basename $IN_FILE)

if [ ! -f $ATR_FILE ]; then
  echo "ERROR: could not find ATR file $ATR_FILE"
  exit 1
fi

TMPF1=$(mktemp)

${AAC} -q -t $IN_FILE $TMPF1 > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "[AAC ERROR] Failed to convert file. Aborting"
  exit 1
fi

UPPER=$(echo -n $BASE_IN_FILE | tr 'a-z' 'A-Z')

COUNT=$(franny -L"$UPPER" $ATR_FILE | grep 'Total:' | awk '{print $2}')
if [ $? -ne 0 ]; then
  echo "[FRANNY ERROR] Failed to see if file exists. Aborting"
  exit 1
fi

if [ "$COUNT" -ne 0 ]; then
  # need to remove it first, else we can't add it back in
  ${FRANNY} -U "$UPPER" $ATR_FILE
  if [ $? -ne 0 ]; then
    echo "[FRANNY ERROR] Failed to delete existing file from $ATR_FILE. Aborting"
    exit 1
  fi
fi

${FRANNY} -A -i $TMPF1 -o "$UPPER" $ATR_FILE
if [ $? -ne 0 ]; then
  echo "[FRANNY ERROR] Failed to add converted file. Aborting"
  exit 1
fi

rm $TMPF1

