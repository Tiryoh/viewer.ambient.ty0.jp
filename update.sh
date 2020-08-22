#!/usr/bin/env bash
set -eu

gen_commit_message(){
	echo "chore: Update yarn packages"
}
git checkout master
git pull origin master
git fetch --prune
if git branch | grep yarn/update ; then 
	echo "The 'yarn/update' branch already exists."
	read -p "Delete?(y/N): " yn
	case "$yn" in [yY]*) ;; *) echo "ERROR" >&2 ; exit 1 ;; esac
	git branch -D yarn/update
fi
git checkout -b yarn/update
yarn
yarn upgrade
git add yarn.lock
if [[ "$(git symbolic-ref --short HEAD)" != "master" ]]; then
	git commit -F <(gen_commit_message)
	echo ""
	curl -Ss https://api.github.com/repos/Tiryoh/viewer.ambient.ty0.jp/pulls?state=open | jq .[].number | xargs -I{} echo -n "#{}, " | sed "s/, $/\n/g"
fi
