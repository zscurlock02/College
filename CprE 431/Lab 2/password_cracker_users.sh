#!/bin/bash

salt1="2Ff.cblr"
salt2="zZKc4nOX"
salt3="dCPTizMy"
salt4="0Ptm7uW6"
salt5="QpU0v3n/"
target_hash1="\$6\$2Ff.cblr\$QwoNFOAme5xy5/anjAsZVIDrZdBKZ.hZ6UIIdLU9D4DDEs3O.CbRsICaVxxdQOTG2TOHYSHDwfdsrG0WGsXVB/"
target_hash2="\$6\$zZKc4nOX\$Rac9mB17TLeFgE/TOH0gTgRnAmaNk67ezuZo4fQAOSkulEKrrW6sum0uElLvmAeBqhf0k/jCYn2dddJCC0QzI1"
target_hash3="\$6\$dCPTizMy\$b8Fiueet0w08JR66mI3UPg.U7ertejWDHTDCAyqbVSjhhLgTu8N2/51R496408q356m.gmJSjG.u89L.3K8HH."
target_hash4="\$6\$0Ptm7uW6\$9cYOHvx3S6dJBgK4ZhVq.bPHJlaMH.KV/59bsX2UYVSBp6RUit6KKFLnuoKz5L5yHMH75YZymLcil9uBhV4XW."
target_hash5="\$6\$QpU0v3n/\$Z5BKWAKu6SsZMI4KStZmlR/IZuhE9Ts.cezqBca3iApKmbT/GSBC1GUHf0I0mmytOdmqzclHkT47idGnpmHoe0"
password_list="100k-most-used-passwords-NIST.txt"
counter=0
passwords_found=0
echo "User 1 Salt: $salt1"
echo "User 1 Target Hash: $target_hash1"
echo "User 2 Salt: $salt2"
echo "User 2 Target Hash: $target_hash2"
echo "User 3 Salt: $salt3"
echo "User 3 Target Hash: $target_hash3"
echo "User 4 Salt: $salt4"
echo "User 4 Target Hash: $target_hash4"
echo "User 5 Salt: $salt5"
echo "User 5 Target Hash: $target_hash5"
# Loop through the password list
while read -r password; do

	# Increment counter and print progress
	((counter++))
	if (( counter % 100 == 0 )); then
		echo "$counter passwords checked"
	fi
	
    # Generate hash for the current password using OpenSSL
    generated_hash1=$(openssl passwd -6 -salt "$salt1" "$password")
	generated_hash2=$(openssl passwd -6 -salt "$salt2" "$password")
	generated_hash3=$(openssl passwd -6 -salt "$salt3" "$password")
	generated_hash4=$(openssl passwd -6 -salt "$salt4" "$password")
	generated_hash5=$(openssl passwd -6 -salt "$salt5" "$password")
		
    # Check if the generated hash matches the target hash
    if [[ "$generated_hash1" == "$target_hash1" ]]; then
        echo "Password 1 found: $password"
		((passwords_found++))
    fi
	
	if [[ "$generated_hash2" == "$target_hash2" ]]; then
        echo "Password 2 found: $password"
		((passwords_found++))
    fi
	
    if [[ "$generated_hash3" == "$target_hash3" ]]; then
        echo "Password 3 found: $password"
		((passwords_found++))
    fi
	
    if [[ "$generated_hash4" == "$target_hash4" ]]; then
        echo "Password 4 found: $password"
		((passwords_found++))
    fi
	
    if [[ "$generated_hash5" == "$target_hash5" ]]; then
        echo "Password 5 found: $password"
		exit 0
		((passwords_found++))
    fi
	
	if (( passwords_found == 5 )); then
		echo "All passwords found"
		exit 0
	fi

done < "$password_list"

echo "Password not found in the list."
exit 1