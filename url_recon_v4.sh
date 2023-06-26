#!/bin/bash

read -p "Enter the host name: " website

if curl --output /dev/null --silent --head --fail "$website"; then
  echo "$website is live with IP: $(dig +short $website)"
  if [ -d $website ]; then
    read -p "$website folder already exists. Overwrite? (y/n): " choice
    if [ "$choice" == "y" ]; then
      rm -r $website
      mkdir $website
    else
      exit
    fi
  else
    mkdir $website
  fi
else
  echo "$website is not reachable"
      exit
fi

echo "[+] Loading Sub-domains + WaybackUrls + CommonUrls"
assetfinder -subs-only $website | sort -u | cut -d"/" -f3 >> subs.txt && waybackurls $website >> wburl.txt && gau $website | httpx -silent >> wb_commonurl.txt | mv subs.txt wburl.txt wb_commonurl.txt $website

while true; do

  read -p "Select a URL action (y/n): " choice
if [ "$choice" == "y" ]; then
echo "[+] View URL actions"
     gf --list 

echo "[+] Select URL action"
    read y
    action=$y


if [[($action == "ssrf")]]; then

echo "[+] Enter burpCollab"

    read x 
    burp=$x

    gf $action $website/wburl.txt >> $website/ssrf.txt && cat $website/ssrf.txt | httpx -silent | qsreplace $burp >> $website/ssrf1.txt | ffuf -c -w $website/ssrf1.txt -u FUZZ -t 200

else

gf $action $website/wburl.txt 

fi

  elif [ "$choice" == "n" ]; then
    echo "Exiting..."
    break
  else
    echo "Invalid input. Please enter 'y' or 'n'."
  fi
done



