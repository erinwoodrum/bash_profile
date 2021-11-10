export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completionexport DB_HOST="10.16.36.52"

export PORT="5432"
export DB_USERNAME="emc4jq2"
export DB_PASSWORD="OrangeMethod"
export DB_NAME="emc4jq2_tool_rental"
export SSL_MODE="disable"

export PG_USER="root"
export PG_PASSWORD="om"
export PG_HOST="ld19136.homedepot.com"

alias pg_start="launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"
alias pg_stop="launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"

alias gotesting='cd ~/go/src/github.homedepot.com/om-labs/go-testing'
alias gowebapp='cd ~/go/src/github.homedepot.com/EMC4JQ2/gowebapp'
alias gobin='cd ~/go/bin'

alias ll='ls -al'
alias cam='git commit -am'
alias get='curl -OL'

#PS1='[\W]$ '

export GOPATH="${HOME}/go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:/usr/local/opt/python/libexec/bin"
export PATH="$PATH:/usr/local/bin/apache-maven-3.8.1/bin"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"
export GOBIN="${HOME}/go/bin/"
export GOPRIVATE="github.com/cookiemonster5"
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
#export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"


#Regular Colors
Black="\[\033[0;30m\]"        # Black
Grey="\[\033[1;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
lRed="\[\033[1;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
lGreen="\[\033[1;32m\]"        # Green
dGreen="\[\033[2;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
lBlue="\[\033[1;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
lCyan="\[\033[1;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White
Brown="\[\033[1;33m\]"    # Brown

parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

parse_git_status() {
    #if_we_are_in_git_work_tree
    if $(git rev-parse --is-inside-work-tree &> /dev/null)
    then
        local status=$(git status --short 2> /dev/null)
	local unstaged=$(git status | egrep "not staged|Untracked|Unmerged")
        if [ -n "${unstaged}" ]  # if unstaged changes exist, color red
        then
        	PS1+=${Red}
        elif [ -n "${status}" ]  # else if changes exist but are all staged, yello
	then
		PS1+=${Yellow}
	else                     # no uncommitted changes, green
        	PS1+=${Green}
        fi
        PS1+=$(parse_git_branch)
    fi
}

build_prompt() {
 if $(git rev-parse --is-inside-work-tree &> /dev/null)
    then
        PS1="${Cyan}[\t] ${White}$(pwd | sed s:$(git rev-parse --show-toplevel | egrep -o '/.*/')::g)"
    else
        PS1="${Cyan}[\t] ${White}\w"
    fi
    parse_git_status
    PS1+=" ${Cyan}$ ${White}"
}
	#stores function calls and executes prior to PS1 being set, allows you to cheat
PROMPT_COMMAND=build_prompt

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-12.0.1.jdk/Contents/Home

function docker-artifactory() {
  echo -n Artifactory User:
  read ARTIFACTORY_USER
  echo -n Artifactory Password:
  read -s ARTIFACTORY_PASSWORD
  echo
  echo $(curl -s -X POST -d username="$ARTIFACTORY_USER" -d password="$ARTIFACTORY_PASSWORD" "https://token-generator.artifactory.homedepot.com/api/docker/generateToken" | jq -r .access_token) | docker login --username $ARTIFACTORY_USER --password-stdin https://docker.artifactory.homedepot.com
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/EMC4JQ2/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/EMC4JQ2/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/EMC4JQ2/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/EMC4JQ2/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/EMC4JQ2/google-cloud-sdk/path.bash.inc' ]; then . '/Users/EMC4JQ2/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/EMC4JQ2/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/EMC4JQ2/google-cloud-sdk/completion.bash.inc'; fi
