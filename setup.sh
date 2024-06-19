#!/bin/bash
echo $MAIN_DEPLOY_KEY | awk '{start_count = 0;end_count = 0;  
    for (i=1; i<=length($0); i++) {
        if (substr($0, i, 1) == " ") {
            end_count++;
        }
    }
    for (i=1; i<=length($0); i++) {
        char = substr($0, i, 1);
        if (char == " ") {
            start_count++;
            if (start_count > 3 && end_count > 3) {
                print "";
            } else {
                printf "%s", char;
            }
            end_count--;
        } else {
            printf "%s", char;
        }
    }
    print "";
}' > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
ssh-keyscan -t ecdsa github.com >> ~/.ssh/known_hosts
repo_name=$(echo $MAIN_URL | grep -oP '([^:/]+)/[^/]+\.git$' | cut -d '/' -f 2 | sed 's/\.git$//')
rm -rf $repo_name
git clone $MAIN_URL
cd $repo_name
