# Deletes all remote branches 3 weeks or older

delbr() {

  echo "Continue? (y/n)"
  read shouldContinue
  if [ $shouldContinue = "n" ]; then
    echo "Aborting"
    return 0
  fi

  echo Running remote branch clean up...
  echo Deleting all branches 3 weeks and older
  prefix="origin/"
  for k in $(git branch -r | sed /\*/d); do
    if [ $k = "->" ] || [ $k = "origin/master" ] || [ $k = "origin/HEAD" ]; then
      continue
    fi
    if [ -z "$(git log -1 --since='3 weeks ago' -s $k)" ]; then
      echo Deleting "$(git log -1 --pretty=format:"%ct" $k) $k";
      git push origin :${k#$prefix}
    fi
  done
}

delbr
