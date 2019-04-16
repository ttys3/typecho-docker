# how to merge two git repo into one

```bash
mkdir lychee-one
cd lychee-one
git init .
touch .gitignore
git add -f .gitignore
git ci -m "init commit, add .gitignore" 
git remote add s6 git@bitbucket.org:8ox86/docker-lychee-alpine-s6.git
git fetch s6 
git merge --allow-unrelated-histories s6/master
git remote add lychee https://github.com/ttys3/Lychee-Laravel.git
git fetch lychee
git merge --allow-unrelated-histories lychee/nanodm
```