# Shortcuts
alias copyssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
alias reloadshell="omz reload"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias ll="/opt/homebrew/opt/coreutils/libexec/gnubin/ls -AhlFo --color --group-directories-first"
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias compile="commit 'compile'"
alias timestamp="date +%s"
alias version="commit 'version'"

# Directories
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"
alias projects="cd $HOME/git-sources"

# Kubernetes
alias k=kubectl
alias ktx=kubectx
alias kns=kubens
alias ctx=kubens

# Okta AWS CLI
alias gimme-aws-creds="okta-aws-cli -s 43200 --org-domain mydomain.okta.com --oidc-client-id <oidc-client-id> --aws-acct-fed-app-id <aws-app-id> --profile <aws-profile-name> --write-aws-credentials -b --aws-iam-role arn:aws:iam::<aws-account-id>:role/<role-name> --aws-iam-idp arn:aws:iam::<aws-account-id>:saml-provider/OKTA"

alias diff-side="diff --side-by-side"

# Git
alias gs="git status"
alias gb="git branch"
alias gc="git checkout"
alias gl="git log --oneline --decorate --color"
alias amend="git add . && git commit --amend --no-edit"
alias commit="git add . && git commit -m"
alias diff="git diff"
alias force="git push --force-with-lease"
alias nuke="git clean -df && git reset --hard"
alias pop="git stash pop"
alias prune="git fetch --prune"
alias pull="git pull"
alias push="git push"
alias resolve="git add . && git commit --no-edit"
alias stash="git stash -u"
alias unstage="git restore --staged ."
alias wip="commit wip"
