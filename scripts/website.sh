#!/bin/bash -e

./scripts/build.sh

webpack=node_modules/.bin/webpack

demo=demo
website=website

echo "Deploying website..."

rm -rf $website
mkdir -p $website
sed "s/<!-- styles -->/<link rel=\"stylesheet\" href=\"bundle.css\">/" $demo/index.html > $website/index.html

NODE_ENV=production $webpack -p --config demo/webpack.config.js
git add -A $website
git commit -m 'built website'
git subtree push --prefix $website origin gh-pages

echo "Deployed website: http://whoisandie.github.io/react-blocks"
