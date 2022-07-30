#!/usr/bin/env bash
set -eu

TARGET_BRANCH="main"
DEVELOP_BRANCH="feature/update-nodejs-package"

gen_commit_message(){
	echo "chore: Update Node.js packages"
}
git checkout ${TARGET_BRANCH}
git pull origin ${TARGET_BRANCH}
git fetch --prune
if git branch | grep ${DEVELOP_BRANCH}; then 
	echo "The '${DEVELOP_BRANCH}' branch already exists."
	read -p "Delete?(y/N): " yn
	case "$yn" in [yY]*) ;; *) echo "ERROR" >&2 ; exit 1 ;; esac
	git branch -D ${DEVELOP_BRANCH}
fi
git checkout -b ${DEVELOP_BRANCH}
npm install
npm update
git add package-lock.json
if [[ "$(git symbolic-ref --short HEAD)" != "${TARGET_BRANCH}" ]]; then
	git commit -F <(gen_commit_message)
	echo ""
	curl -Ss https://api.github.com/repos/Tiryoh/viewer.ambient.ty0.jp/pulls?state=open | jq .[].number | xargs -I{} echo -n "#{}, " | sed "s/, $/\n/g"
fi
