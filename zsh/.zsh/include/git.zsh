# shellcheck disable=all

# Heavily inspired from https://github.com/sorin-ionescu/prezto/blob/master/modules/git/alias.zsh
# Git aliases
# Log
zstyle -s ':prezto:module:git:log:medium' format '_git_log_medium_format' ||
    _git_log_medium_format='%C(bold)Commit:%C(reset) %C(green)%H%C(bold magenta)%d%n%C(bold)Author:%C(reset) %C(cyan)%an <%ae>%n%C(bold)Date:%C(reset)   %C(blue)%ai (%ar)%C(reset)%n%w(80,1,2)%+B'
zstyle -s ':prezto:module:git:log:oneline' format '_git_log_oneline_format' ||
    _git_log_oneline_format='%C(green)%h%C(reset) %><(55,trunc)%s%C(bold magenta)%d%C(reset) %C(blue)[%an]%C(reset) %C(yellow)%ad%C(reset)%n'
zstyle -s ':prezto:module:git:log:brief' format '_git_log_brief_format' ||
    _git_log_brief_format='%C(green)%h%C(reset) %s%n%C(blue)(%ar by %an)%C(bold magenta)%d%C(reset)%n'

# Status
zstyle -s ':prezto:module:git:status:ignore' submodules '_git_status_ignore_submodules' ||
    _git_status_ignore_submodules='none'

alias g='git'
alias gui='lazygit'
alias tig='gitui'

# Branch (b)
alias gb='git branch'
alias gbv='git branch --verbose --verbose'
alias gba='git branch --all'
alias gbav='git branch --all --verbose --verbose'
alias gbc='git checkout -b'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'
alias gbx='git branch --delete'
alias gbX='git branch --delete --force'
alias gbm='git branch --move'
alias gbM='git branch --move --force'
alias gbs='git show-branch'
alias gbsa='git show-branch --all'

# Commit (c)
alias gc='git commit --verbose'
alias gcS='git commit --verbose --gpg-sign'
alias gca='git commit --verbose --all'
alias gcaS='git commit --verbose --all --gpg-sign'
alias gcm='git commit --message'
alias gcmS='git commit --message --gpg-sign'
alias gcam='git commit --all --message'
alias gco='git checkout'
alias gcO='git checkout --patch'
alias gcf='git commit --amend --reuse-message HEAD'
alias gcfS='git commit --amend --reuse-message HEAD --gpg-sign'
alias gcF='git commit --verbose --amend'
alias gcFS='git commit --verbose --amend --gpg-sign'
alias gcp='git cherry-pick --ff'
alias gcP='git cherry-pick --no-commit'
alias gcr='git revert'
alias gcR='git reset "HEAD^"'
alias gcs='git show'
alias gcsS='git show --pretty=short --show-signature'
alias gcl='git-commit-lost'
alias gcy='git cherry --verbose --abbrev'
alias gcY='git cherry --verbose'

# Rev-parse (rp)
alias grpl="git rev-parse HEAD | tr -d '\n'"
alias grps="git rev-parse HEAD | cut -c1-7 | tr -d '\n'"

# Conflict (C)
alias gCl='git --no-pager diff --name-only --diff-filter=U'
alias gCa='git add $(gCl)'
alias gCe='git mergetool $(gCl)'
alias gCo='git checkout --ours --'
alias gCO='gCo $(gCl)'
alias gCt='git checkout --theirs --'
alias gCT='gCt $(gCl)'

# Data (d)
alias gd='git ls-files'
alias gdc='git ls-files --cached'
alias gdx='git ls-files --deleted'
alias gdm='git ls-files --modified'
alias gdu='git ls-files --other --exclude-standard'
alias gdk='git ls-files --killed'
alias gdi='git status --porcelain --short --ignored | sed -n "s/^!! //p"'

# Fetch (f)
alias gf='git fetch'
alias gfa='git fetch --all --prune --tags'
alias gfc='git clone'
alias gfcr='git clone --recurse-submodules'
alias gfm='git pull'
alias gfma='git pull --autostash'
alias gfr='git pull --rebase'
alias gfra='git pull --rebase --autostash'

# Grep (g)
alias gg='git grep'
alias ggi='git grep --ignore-case'
alias ggl='git grep --files-with-matches'
alias ggL='git grep --files-without-matches'
alias ggv='git grep --invert-match'
alias ggw='git grep --word-regexp'

# Index (i)
alias gia='git add'
alias giA='git add --patch'
alias giu='git add --update'
alias gid='git diff --no-ext-diff --cached'
alias giD='git diff --no-ext-diff --cached --word-diff'
alias gii='git update-index --assume-unchanged'
alias giI='git update-index --no-assume-unchanged'
alias gir='git reset'
alias giR='git reset --patch'
alias gix='git rm -r --cached'
alias giX='git rm -r --force --cached'

# Log (l)
alias gl='git log --topo-order --pretty=format:"$_git_log_medium_format"'
alias gls='git log --topo-order --stat --pretty=format:"$_git_log_medium_format"'
alias gld='git log --topo-order --stat --patch --full-diff --pretty=format:"$_git_log_medium_format"'
alias glo='git log --topo-order --pretty=format:"$_git_log_oneline_format"'
alias glg='git log --topo-order --graph --pretty=format:"$_git_log_oneline_format"'
alias glb='git log --topo-order --pretty=format:"$_git_log_brief_format"'
alias glc='git shortlog --summary --numbered'
alias glS='git log --show-signature'

# Merge (m)
alias gm='git merge'
alias gmC='git merge --no-commit'
alias gmF='git merge --no-ff'
alias gma='git merge --abort'
alias gmt='git mergetool'

# Push (p)
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpF='git push --force'
alias gpa='git push --all'
alias gpA='git push --all && git push --tags'
alias gpt='git push --tags'
alias gpc='git push --set-upstream origin "$(git-branch-current 2> /dev/null)"'
alias gpp='git pull origin "$(git-branch-current 2> /dev/null)" && git push origin "$(git-branch-current 2> /dev/null)"'

# Rebase (r)
alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gri='git rebase --interactive'
alias grs='git rebase --skip'

# Remote (R)
alias gR='git remote'
alias gRl='git remote --verbose'
alias gRa='git remote add'
alias gRx='git remote rm'
alias gRd='git remote rm'
alias gRm='git remote rename'
alias gRu='git remote update'
alias gRp='git remote prune'
alias gRs='git remote show'
alias gRb='git-hub-browse'

# Stash (s)
alias gs='git stash'
alias gsa='git stash apply'
alias gsx='git stash drop'
alias gsl='git stash list'
alias gsd='git stash show --patch --stat'
alias gsp='git stash pop'
alias gss='git stash save --include-untracked'
alias gsS='git stash save --patch --no-keep-index'
alias gsw='git stash save --include-untracked --keep-index'

# Submodule (S)
alias gS='git submodule'
alias gSa='git submodule add'
alias gSf='git submodule foreach'
alias gSi='git submodule init'
alias gSI='git submodule update --init --recursive'
alias gSl='git submodule status'
alias gSm='git-submodule-move'
alias gSs='git submodule sync'
alias gSu='git submodule update --remote --recursive'
alias gSx='git-submodule-remove'

# Tag (t)
alias gt='git tag'
alias gtl='git tag --list'
alias gts='git tag --sign'
alias gtv='git verify-tag'

# Working Copy (w)
alias gws='git status --ignore-submodules=$_git_status_ignore_submodules --short'
alias gwS='git status --ignore-submodules=$_git_status_ignore_submodules'
alias gwd='git diff --no-ext-diff'
alias gwD='git diff --no-ext-diff --word-diff'
alias gwr='git reset --soft'
alias gwR='git reset --hard'
alias gwc='git clean --dry-run'
alias gwC='git clean --force'
alias gwx='git rm -r'
alias gwX='git rm -r --force'
