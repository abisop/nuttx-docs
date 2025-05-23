#!/usr/bin/env bash

# abort on errors
set -e

# navigate into the build output directory
cd .vitepress/dist

# if you are deploying to a custom domain
# echo 'www.example.com' > CNAME

git init
git add -A
git commit -m 'deploy'


git push -f https://github.com/abisop/abisop.github.io.git

cd -

