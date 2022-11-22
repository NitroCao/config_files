OS_MAC="Darwin"
OS_LINUX="Linux"
OS_CENTOS="CentOS Linux"

get_os() {
    if [ -f /etc/os-release ]; then
        source /etc/os-release
    fi
    if [ -n "${NAME}" ]; then
        echo "${NAME}"
    else
        uname
    fi
}

test -d /home/linuxbrew/.linuxbrew && \
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
if command -v brew >/dev/null; then
    eval "$(brew shellenv)"
fi
if [ -z "${HOMEBREW_PREFIX}" ]; then
    HOMEBREW_PREFIX=/usr
fi

# general environment variables
export PATH=$HOME/.local/bin:$HOME/go/bin:$PATH
export LANG=en_US.UTF-8
export LC_ALL=$LANG
export TERM=xterm-256color
# export HTTP_PROXY=http://127.0.0.1:1080
# export HTTPS_PROXY=http://127.0.0.1:1080
# export NO_PROXY=127.0.0.1,localhost
if command -v nvim >/dev/null; then
    export EDITOR=nvim
elif command -v vim >/dev/null; then
    export EDITOR=vim
elif command -v vi >/dev/null; then
    export EDITOR=vi
fi


######################################################
# initialize zsh related configuration
if [ "$(get_os)" = "${OS_MAC}" ] || [ "$(get_os)" = "${OS_CENTOS}" ]; then
    ZSH="${HOME}/.oh-my-zsh"
else
    ZSH="/usr/share/oh-my-zsh"
fi

plugins=(git z)

source $ZSH/oh-my-zsh.sh

# load extra zsh completions on macOS
# install zsh-completions first
if type brew &>/dev/null; then
    FPATH="${HOMEBREW_PREFIX}"/share/zsh-completions:$FPATH
fi


# initialize spaceship theme
autoload -Uz promptinit; promptinit
prompt spaceship
compinit

SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_FORMAT="%D %T"
SPACESHIP_DOCKER_SHOW=false

ZSH_AUTOSUGGESTIONS="${HOMEBREW_PREFIX}"/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_SYNTAX_HIGHHIGHTLING="${HOMEBREW_PREFIX}"/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
if [ -f "${ZSH_AUTOSUGGESTIONS}" ]; then
    source "${ZSH_AUTOSUGGESTIONS}"
fi
if [ -f "${ZSH_SYNTAX_HIGHHIGHTLING}" ]; then
    source "${ZSH_SYNTAX_HIGHHIGHTLING}"
fi
######################################################


######################################################
# initialize bat command
if command -v bat >/dev/null; then
    alias cat=bat
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    export BAT_PAGER="less -RF"
fi
######################################################


######################################################
# initialize k8s-related commands
if command -v kubectl >/dev/null; then
    alias k=kubectl
    source <(kubectl completion zsh)
fi
if command -v minikube >/dev/null; then
    alias m=minikube
    source <(minikube completion zsh)
fi
######################################################


######################################################
# initialize pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if [ -z "${VIRTUAL_ENV}" ]; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"

    if which virtualenv >/dev/null; then
        eval "$(pyenv virtualenv-init -)"
    fi
fi
######################################################


######################################################
# initialize jenv on macOS
if command -v jenv >/dev/null; then
    eval "$(jenv init -)"
fi
######################################################


######################################################
# initialize fzf
if [ "$(get_os)" = "${OS_LINUX}" ]; then
    fzf_key_bindings=/usr/share/fzf/key-bindings.zsh
    fzf_completion=/usr/share/fzf/completion.zsh
else
    fzf_key_bindings="${HOMEBREW_PREFIX}"/opt/fzf/shell/key-bindings.zsh
    fzf_completion="${HOMEBREW_PREFIX}"/opt/fzf/shell/completion.zsh
fi

source "${fzf_key_bindings}"
source "${fzf_completion}"
######################################################


######################################################
# initialize vcpkg
if [ "$(get_os)" = "${OS_LINUX}" ]; then
    source /opt/vcpkg/scripts/vcpkg_completion.zsh
else
    export VCPKG_ROOT="${HOME}/.vcpkg/vcpkg"
fi
######################################################


######################################################
# initialize Yubico SSH on macOS
if command -v gpg-connect-agent >/dev/null; then
    gpg-connect-agent /bye >/dev/null 2>&1
    if [ "$(get_os)" = "${OS_MAC}" ]; then
        export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh
    else
        export SSH_AUTH_SOCK=${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh
    fi
fi
######################################################
