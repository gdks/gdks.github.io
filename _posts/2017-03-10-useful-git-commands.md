---
title: Useful but rarely used git commands
description: List of git useful git commands that I only need occasionally
header: Useful but rarely used git commands
---


This is a list of git commands I've found really useful but have only needed rarely so I'm recording these here for future reference.

&nbsp;

Remove untracked git files

> git clean -df

View differences in a specific file between commits

> git diff start_commit..end_commit -- path/to/file

Undo last commit

> git reset --soft HEAD^

Temporarily ignore a file from the index or start tracking again

> git update-index --assume-unchanged path/to/file

> git update-index --no-assume-unchanged path/to/file

Revert local repository to same state as remote

> git fetch [remote]
git reset --hard [remote]/[branch]

Search commit messages in log history

> git log --grep=searchterm

Search contents of commits in history

> git log -Ssearchterm

Search all commit history for file contents

> git grep <regexp> $(git rev-list --all)

&nbsp;
