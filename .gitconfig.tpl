[user]
  name = GIT_USER_NAME
  email = GIT_USER_EMAIL
[init]
  defaultBranch = main
[grep]
  lineNumber = true
  extendedRegexp = true
  threads = 4
[color]
  ui = auto
[diff]
  renames = true
  tool = vimdiff
  compactionHeuristic = true
[difftool]
  prompt = false
[difftool "dyff"]
  cmd = dyff --color=on between --omit-header "$LOCAL" "$REMOTE"
[core]
  excludesfile = ~/.gitignore
  ignorecase = false
  quotepath = false
  autocrlf = input
  safecrlf = false
  commentChar = ";"
[log]
  abbrevCommit = true
[fetch]
  prune = true
[pull]
  ff = only
[http]
  postBuffer = 104857600
[alias]
  a = add
  aliases = !git config --list | grep -E '^alias' | cut -d '.' -f 2- | sort
  b = branch
  c = checkout
  clone-shallow = clone --depth 1
  cm = commit
  count-obj = count-objects --human-readable
  d = diff
  dt = difftool
  dw = diff --color-words
  ds = diff --name-status
  merged = branch --merged
  delete-merged = !git branch --merged | grep -vE '(\\*|main|master)' | xargs git branch -d
  force-push = push --force-with-lease --force-if-includes
  g = grep --heading
  l = log
  ll = log --pretty=oneline
  logs = log --graph --all --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative
  search-commit = log -G
  search-commit-patch = log --patch -G
  search-commit-patch-first = log --pickaxe-regex --patch -S
  search-commit-message = log --grep
  search-branch = name-rev --refs="refs/heads/*"
  ls = ls-files
  rl = reflog
  root = rev-parse --show-toplevel
  s = status --short --branch
  undo-commit = reset --soft @^
  undo-add = reset @
  recent = for-each-ref refs/heads/ --sort=-committerdate --format='%(committerdate:iso) %(color:green)%(refname:short)%(color:reset) %(color:red)%(authoremail) %(authorname)%(color:reset) %(subject)'
  redo-commit = revert @
  hash = show --format='%H' --no-patch
  log-num = log --numstat
  log-name = log --name-status
  ps = push origin HEAD
  p = pull
  w = worktree
  rename-branch = branch -m
  fix-comment = commit --amend
  which-branch = branch --contains
  force-remove-untracked = clean -d -f
  clone-latest-only = clone --depth 1
  tag-push = !"f(){ if [ -z \"$1\" ]; then echo 'Usage: git tag-push TAG'; return 1; fi; git tag \"$1\" && git push origin \"$1\"; }; f"
  tag-delete = !"f(){ if [ -z \"$1\" ]; then echo 'Usage: git tag-delete TAG'; return 1; fi; git tag -d \"$1\" && git push -d origin \"$1\"; }; f"
  tag-latest = describe --abbrev=0 --tags
  tag-list = tag -l --sort=creatordate --format='%(creatordate:unix) %(creatordate:iso-strict) %(refname)'
  tag-neighbor = !"f(){ if [ -z \"$1\" ]; then echo 'Usage: git tag-next TAG'; return 1; fi; git tag-list | grep -E \"refs/tags/${1}$\" -C 1; }; f"
  current-branch = "!git branch --contains | awk '$1==\"*\"{print $2}'"
  default-branch = !"f(){ basename \"$(git symbolic-ref refs/remotes/origin/HEAD)\"; }; f"
  reset-to-origin = !"f(){ target=\"${1:-$(git rev-parse --abbrev-ref HEAD)}\"; if [ -n \"$1\" ]; then git checkout \"$1\" || return 1; fi; git fetch origin && git reset --hard \"origin/${target}\"; }; f"
  rebase-upstream-push = !"f(){ target=\"${1:-$(git rev-parse --abbrev-ref HEAD)}\"; default_b=\"$(git default-branch 2>/dev/null || echo 'main')\"; if [ -n \"$1\" ]; then git checkout \"$1\" || return 1; fi; git fetch origin && git rebase --autostash \"origin/${default_b}\" && git push origin \"${target}\" --force-with-lease --force-if-includes; }; f"
  is-merged = !"f(){ branch=\"${1:-$(git rev-parse --abbrev-ref HEAD)}\"; target=\"${2:-$(git default-branch 2>/dev/null || echo 'main')}\"; git merge-base --is-ancestor \"$branch\" \"$target\" 2>/dev/null && return 0; target_tree=\"$(git rev-parse \"${target}^{tree}\" 2>/dev/null)\" || return 1; merged_tree=\"$(git merge-tree --write-tree \"$target\" \"$branch\" 2>/dev/null)\" || return 1; [ \"$target_tree\" = \"$merged_tree\" ]; }; f"
  default-pull = !"f(){ current=\"$(git current-branch)\"; db=\"$(git default-branch)\"; if [ \"$db\" != \"$current\" ]; then git switch \"$db\" -q && git branch -D \"$current\"; fi && git pull; }; f"
  delete-merged = !"f(){ current=\"$(git current-branch)\"; db=\"$(git default-branch)\"; if [ \"$db\" != \"$current\" ]; then git switch \"$db\" -q || return 1; fi && git pull && git branch --format='%(refname:short)' --merged \"$db\" | while read -r b; do if [ -n \"$b\" ] && [ \"$b\" != \"$db\" ]; then echo \"Delete branch: $b\"; git branch -d \"$b\"; fi; done; }; f"
  dyff = difftool --tool=dyff
