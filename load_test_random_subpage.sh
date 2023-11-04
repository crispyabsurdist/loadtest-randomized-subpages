#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <url>"
  exit 1
fi

BASE_URL=$(echo "$1" | sed 's:/*$::')

generate_random_path() {
  local num_elements=$((RANDOM % 12 + 1))
  local path=""
  
  for ((i=0; i<num_elements; i++)); do
    if [[ $i -eq 0 ]]; then
      path+=$(LC_ALL=C tr -dc 'a-zA-Z0-9' < /dev/urandom | fold -w $((RANDOM % 6 + 5)) | head -n 1)
    else
      path+="/"$(LC_ALL=C tr -dc 'a-zA-Z0-9' < /dev/urandom | fold -w $((RANDOM % 6 + 5)) | head -n 1)
    fi
  done

  echo "/$path"
}

while true; do
  SUBPAGE=$(generate_random_path)
  FULL_URL="${BASE_URL}${SUBPAGE}"
  
  echo "Running -> $FULL_URL"
  curl -s -o /dev/null "$FULL_URL"
  
  sleep 0.2
done
