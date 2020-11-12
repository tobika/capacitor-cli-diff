#!/bin/bash

set -e

versions=$(npm view @capacitor/cli versions --json)

versions=${versions//\"/}
versions=${versions//\[/}
versions=${versions//\]/}
versions=${versions//\,/}

versions=(${versions})

blocklist=()
filterVersion1=(*0.0.*)
filterVersion2=(1.0.0-*)
filterVersion3=(2.*-beta.*)
filterVersion4=(3.*-alpha.*)

lastVersion="1.0.0"
rebaseNeeded=false

for version in "${versions[@]}"
do

  if [[ "${version}" == ${filterVersion1[@]} || "${version}" == ${filterVersion2[@]} || "${version}" == ${filterVersion3[@]} || "${version}" == ${filterVersion4[@]} ]]
  then
    echo "Skipping unwanted ${version}"
    continue
  fi

  if [[ " ${blocklist[@]} " =~ " ${version} " ]]
  then
    echo "Skipping blocklisted ${version}"
    continue
  fi

  if [ `git branch --list ${version}` ] || [ `git branch --list --remote origin/${version}` ]
  then
    echo "${version} already generated."
    git checkout ${version}
    if [ ${rebaseNeeded} = true ]
    then
      git rebase --onto ${lastVersion} HEAD~ ${version} -X theirs
      diffStat=`git --no-pager diff HEAD~ --shortstat`
      git push origin ${version} -f
      diffUrl="[${lastVersion}...${version}](https://github.com/tobika/capacitor-cli-diff/compare/${lastVersion}...${version})"
      git checkout master
      # rewrite stats in README after rebase
      sed -i.bak -e "/^${version}|/ d" README.md && rm README.md.bak
      sed -i.bak -e 's/----|----|----/----|----|----\
NEWLINE/g' README.md && rm README.md.bak
      sed -i.bak -e "s@NEWLINE@${version}|${diffUrl}|${diffStat}@" README.md && rm README.md.bak
      git commit -a --amend --no-edit
      git checkout ${version}
    fi
    lastVersion=${version}
    continue
  fi

  echo "Generate ${version}"
  rebaseNeeded=true
  git checkout -b ${version}
  # delete app
  rm -rf diff-app/node_modules
  rm -rf diff-app/android
  rm -rf diff-app/package-lock.json
  cd diff-app
  # generate app with new CLI version
  npm install @capacitor/cli@${version} @capacitor/core@${version} @capacitor/android@${version}
  npx cap init "diff-app" com.tobik.diffapp
  npx cap add android
  cd ..
  git add diff-app
  git commit -am "chore: version ${version}"
  diffStat=`git --no-pager diff HEAD~ --shortstat`
  git push origin ${version} -f
  git checkout master
  diffUrl="[${lastVersion}...${version}](https://github.com/tobika/capacitor-cli-diff/compare/${lastVersion}...${version})"
  # insert a row in the version table of the README
  sed -i.bak "/^${version}|/ d" README.md && rm README.md.bak
  sed -i.bak 's/----|----|----/----|----|----\
NEWLINE/g' README.md && rm README.md.bak
  sed -i.bak "s@NEWLINE@${version}|${diffUrl}|${diffStat}@" README.md && rm README.md.bak
  # commit
  git commit -a --amend --no-edit
  git checkout ${version}
  lastVersion=${version}

done

git checkout master
git push origin master -f
