#!/bin/bash

printf "old branch: "
read old_branch
printf "new branch: "
read new_branch

save_path="Tune/build/Localization-Diff"
res_path="Tune/src/main/res"

# Create directory with full access if they are not already exist
mkdir -p $save_path

string_values=("" "-in" "-ja" "-ko" "-th" "-zh" "-zh-rTW")
languages=("en" "in" "ja" "ko" "th" "zh" "zh-rTW")

for ((i = 0; i < ${#string_values[@]}; i++)); do
    string_value=${string_values[$i]}
    language=${languages[$i]}

    # outputs git diff as a temp file
    git diff --color $old_branch $new_branch -- $res_path/values$string_value/strings.xml > $save_path/temp.strings.$language.diff

    # outputs temp file as a html file
    ansi-to-html -n -x $save_path/temp.strings.$language.diff > $save_path/strings.$language.html

    # remove the temp file
    rm $save_path/temp.strings.$language.diff
done

# Allow read/write permissions
chmod -R 777 $save_path

echo "Done! Check $save_path"
