#/bin/bash
# Version : 1.0.0
# Date : 2019-01-25
# Usecase : Create the required files for training
# Author : Gopal V Patil
## $1 vocabulary.txt
## $2 word.arpa
## $3 lm.binary
## $4 alphabet.txt
## $5 trie
## $6 model
     
if [ $# -ne 6 ]; then
    echo "## vocabulary.txt (eg. model/vocabulary.txt)"
    echo "## word.arpa (eg. model/words.arpa)"
    echo "## lm.binary (eg. model/lm.binary)"
    echo "## alphabet.txt (eg. model/alphabet.txt)"
    echo "## trie (eg. model/trie)"
    echo '## model (eg. model)' 
    exit
fi
     
echo "Step 1. clean the vocabulary"
sed 's/\xc2\xa0/ /' $6/$1

echo "Step 2. Generate the arpa"
../../kenlm/build/bin/./lmplz --text $6/$1 --arpa $6/$2 --o 4 --discount_fallback --temp_prefi /tmp/

echo "Step 3. Generate the LM binary"
../../kenlm/build/bin/./build_binary -T -s trie $6/$2 $6/$3

echo "Step 4. Generate the trie"
../native_client/bin/generate_trie $4 $6/$3 $6/$5

echo "Done!"
