#!/usr/bin/env bash

printf "\e[33;1m%s\e[m\n" "Running pre-commit hook"

# Undo the stash of the files
pop_stash_files () {
    if [ -n "$hasChanges" ]; then
        printf "\e[33;1m%s\e[0m\n" '=== Applying git stash changes ==='
        git stash pop
    fi
}

# Stash any unstaged changes
hasChanges=$(git diff)
if [ -n "$hasChanges" ]; then
  printf "\e[33;1m%s\e[m\n" "Stashing unstaged changes"
  git stash -q --keep-index
fi

# Run tests
printf "\e[33;1m%s\e[m\n" "Running tests"
flutter test --coverage

if [ $? -ne 0 ]; then
    printf "\e[31;1m%s\e[m\n" "Tests failed, please fix before commiting"
    pop_stash_files
    exit 1
fi

genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html

slep 5
git checkout -- .

printf "\e[32;1m%s\e[m\n" "Finished running Unit tests"
printf '%s\n' "${avar}"

pop_stash_files