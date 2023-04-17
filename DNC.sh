#!/bin/bash

# -----------------------------------------------------------------------------------------------
# This software or should I say program or a bash script is intended only for personal use only.
# I created this program to encrypt or decrypt texts that I want to. This software is free.
# -----------------------------------------------------------------------------------------------

if ! command -v openssl &> /dev/null || ! command -v xxd &> /dev/null
    then
        text="Either OpenSSL or xxd is not installed on your system.
        To install OpenSSL, you can use the following command:
        [ sudo apt-get install openssl ]
        To install xxd, you can use the following command:
        [ sudo apt-get install xxd     ]"
        for (( i=0; i<${#text}; i++ )); do
        echo -n "${text:$i:1}"
        sleep 1
    done    
fi

echo "CHECKING..." 
echo "OpenSSL and xxd are already installed on your system, proceeding..."
sleep 1 

# Function to encrypt a string
encrypt() {
  echo "$1" | openssl enc -aes-256-ctr -pass pass:"$2" -nosalt | xxd -p
}

# Function to decrypt an encrypted string
decrypt() {
  echo "$1" | xxd -r -p | openssl enc -aes-256-ctr -d -pass pass:"$2" -nosalt
}

while true; do
  clear
  tput bold
echo '██████╗░███████╗███╗░░██╗░█████╗░██████╗░██╗░░░██╗██████╗░████████╗'
sleep 0.2
echo '██╔══██╗██╔════╝████╗░██║██╔══██╗██╔══██╗╚██╗░██╔╝██╔══██╗╚══██╔══╝'
sleep 0.2
echo '██║░░██║█████╗░░██╔██╗██║██║░░╚═╝██████╔╝░╚████╔╝░██████╔╝░░░██║░░░'
sleep 0.3
echo '██║░░██║██╔══╝░░██║╚████║██║░░██╗██╔══██╗░░╚██╔╝░░██╔═══╝░░░░██║░░░'
sleep 0.3
echo '██████╔╝███████╗██║░╚███║╚█████╔╝██║░░██║░░░██║░░░██║░░░░░░░░██║░░░'
sleep 0.4
echo '╚═════╝░╚══════╝╚═╝░░╚══╝░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░░░░░░░╚═╝░░░'
sleep 0.4
echo '    By: DALE RAFAEL                                                '

  tput setaf 5
  sleep 0.1
  echo "+====================[ WELCOME to DENCRYPTER]=====================+"
  tput sgr0
  tput setaf 4
  sleep 0.1
  echo "+ If you always/somehow want to exit, just press CTRL + C or here +"
  sleep 0.1
  echo "+ type 'ext'. 'enc' for Encrypt 'dnc' for Decrypt.                +"
  sleep 0.1
  echo "+=================================================================+"
  tput sgr0
  tput setaf 2
  echo ''
  sleep 0.1
  echo "Do you want to Encrypt or Decrypt? [enc/dnc/ext]"
  read -rp ": " action
  tput sgr0
  if [[ "$action" == "enc" ]]; then
    clear
    mode="encrypt"
  elif [[ "$action" == "dnc" ]]; then
    clear
    mode="decrypt"
  elif [[ "$action" == "ext" ]]; then
    clear
    exit
  else
    tput setaf 1
    sleep 0.1
    echo "+== [! ERROR !] ======================================+"
    sleep 0.1
    echo "+ Invalid Choice. Please enter either 'enc' or 'dnc'. +"
    sleep 0.1
    echo "+=====================================================+"
    tput sgr0
    clear
    continue
  fi

  # Ask for the passphrase
  clear
  tput setaf 2
  echo      "+==[PASSPHRASE]==================+"
  sleep 0.5
  echo      "+  The passphrase is the code    +"
  echo      "+ used to encrypt ALPHANUM input +"
  echo      "+================================+"
  tput sgr0
  read -rsp ": " passphrase
  tput sgr0
  
  # Ask for the text or ALPHANUM input
  clear
  tput setaf 5
  echo     "+==[ALPHANUM INPUT]=============+"
  sleep 0.5
  echo     "+ The text you want to encrypt, +"
  echo     "+ press CTRL+SHIFT+V to paste   +"
  echo     "+===============================+"
  tput sgr0
  read -rp ": " text
  tput sgr0
  # Perform action
  echo "Note: To copy the text, highlight then press CTRL+SHIFT+C"
  echo ""
  if [[ "$mode" == "encrypt" ]]; then
    encrypted=$(encrypt "$text" "$passphrase")
    clear
    echo "Encrypted Text:
    $encrypted"
    sleep 2
  else
    decrypted=$(decrypt "$text" "$passphrase")
    clear
    echo "Decrypted Text:
    $decrypted"
    sleep 2
  fi

  # Prompt to continue or exit
  echo ""
  echo ""
  echo "DONE!, submit any feedback to: bumanglagdale@gmail.com"
  read -rp "+== [ DO YOU WANT TO GO BACK TO THE MAIN MENU? ] ==+ (y/n): " choice
  if [[ "$choice" == "n" ]]; then
    exit 0
  fi
  trap EXIT
done
