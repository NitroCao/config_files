OS_MAC="Darwin"
OS_LINUX="Linux"

get_os() {
    uname
}

# general environment variables
export PATH=$HOME/.local/bin:$HOME/go/bin:$PATH
export LANG=en_US.UTF-8
export LC_ALL=$LANG
export TERM=xterm-256color
export HTTP_PROXY=http://127.0.0.1:1080
export HTTPS_PROXY=http://127.0.0.1:1080
export NO_PROXY=127.0.0.1,localhost
if command -v nvim >/dev/null; then
    export EDITOR=nvim
elif command -v vim >/dev/null; then
    export EDITOR=vim
elif command -v vi >/dev/null; then
    export EDITOR=vi
fi


######################################################
# initialize zsh related configuration
if [ "$(get_os)" = "${OS_MAC}" ]; then
    ZSH="${HOME}/.oh-my-zsh"
else
    ZSH="/usr/share/oh-my-zsh"
fi

plugins=(git z)

source $ZSH/oh-my-zsh.sh

# load extra zsh completions on macOS
# install zsh-completions first
if [ "$(get_os)" = "${OS_MAC}" ]; then
    if type brew &>/dev/null; then
        FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    fi
fi


# initialize spaceship theme
autoload -Uz promptinit; promptinit
prompt spaceship
compinit

SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_FORMAT="%D %T"
SPACESHIP_DOCKER_SHOW=false

if [ "$(get_os)" = "${OS_MAC}" ]; then
    zsh_autosuggestions=/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    zsh_syntax_highhightling=/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
    zsh_autosuggestions=/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    zsh_syntax_highhightling=/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
if [ -f "${zsh_autosuggestions}" ]; then
    source "${zsh_autosuggestions}"
fi
if [ -f "${zsh_syntax_highhightling}" ]; then
    source "${zsh_syntax_highhightling}"
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
    fzf_key_bindings=/usr/local/opt/fzf/key-bindings.zsh
    fzf_completion=/usr/local/opt/fzf/completion.zsh
fi

source "${fzf_key_bindings}"
source "${fzf_completion}"
######################################################


######################################################
# initialize vcpkg
if [ "$(get_os)" = "${OS_MAC}" ]; then
    export VCPKG_ROOT="${HOME}/.vcpkg/vcpkg"
else
    source /opt/vcpkg/scripts/vcpkg_completion.zsh
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
