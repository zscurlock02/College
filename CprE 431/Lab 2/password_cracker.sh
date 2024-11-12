#!/bin/bash

salt="xgLS35S6"
target_hash="\$6\$xgLS35S6\$2UjEq.dUhICPw9zgDVJXcQYQp/9ilLPQt/8Zgu0uwngI5mVvB1eKQG9SnVLjmOOfkB4Jjb5VSAXGXjY4Cf5k90"
password_list="100k-most-used-passwords-NIST.txt"
counter=0
echo "Target hash: $target_hash"

# Loop through the password list
while read -r password; do

	# Increment counter and print progress
	((counter++))
	if (( counter % 100 == 0 )); then
		echo "$counter passwords checked"
	fi
	
    # Generate hash for the current password using OpenSSL
    generated_hash=$(openssl passwd -6 -salt "$salt" "$password")
		
    # Check if the generated hash matches the target hash
    if [[ "$generated_hash" == "$target_hash" ]]; then
        echo "Password found: $password"
        exit 0
    fi

done < "$password_list"

echo "Password not found in the list."
exit 1
