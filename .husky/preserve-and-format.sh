#!/bin/sh

error_occurred=0

echo "committing staged changes to preserve them for the real commit"
git commit -m 'husky - Save index' --no-verify --quiet || error_occurred=1
echo "creating temp file so there is always something to stash"
touch huskytemp || error_occurred=1
echo "stashing changes not already added for the commit" 
git stash --include-untracked -m "husky - unstaged changes" --quiet || error_occurred=1
echo "restoring staged changes from the temp commit" 
git reset --soft HEAD^ --quiet || error_occurred=1

# in git versions 2.25 and later, the following commands can be used instead of the above commands
# echo "stashing staged changes to preserve them for the commit"
# git stash push --staged -m "husky - staged changes"    
# echo "stashing changes not already added for the commit" 
# git stash --include-untracked -m "husky - unstaged changes"
# echo "restoring staged changes from the stash" 
# git stash pop stash@{1}

echo "backing up docker-compose.yml to docker-compose.yml.huskybackup" 
cp docker-compose.yml docker-compose.yml.huskybackup || error_occurred=1
echo "ensuring default .env is maintained in repo" 
cp docker-compose.yml.default docker-compose.yml || error_occurred=1

echo "backing up .env to .env.huskybackup" 
cp .env .env.huskybackup || error_occurred=1
echo "ensuring default .env is maintained in repo" 
cp .env.default .env || error_occurred=1

echo "running format..." 
npm run --silent format || error_occurred=1

echo "adding all files to the commit that were changed by formatting" 
git add .  || error_occurred=1

echo "restoring the stashed changes" 
git stash pop --quiet || error_occurred=1
echo "deleting temp file" 
rm huskytemp || error_occurred=1

echo "restoring backed up docker-compose.yml" 
cp docker-compose.yml.huskybackup docker-compose.yml || error_occurred=1
echo "restoring backed up .env" 
cp .env.huskybackup .env || error_occurred=1

if [ $error_occurred -ne 0 ]; then
  echo "failed to run pre-commit checks"
  exit 1
fi