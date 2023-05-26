export PATH=$HOME/.local/bin:$HOME/go/bin:$PATH
export LANG=en_US.UTF-8
export LC_ALL=$LANG
export TERM=xterm-256color
# export HTTP_PROXY=http://127.0.0.1:1080
# export HTTPS_PROXY=http://127.0.0.1:1080
# export NO_PROXY=127.0.0.1,localhost

if test -d /home/linuxbrew/.linuxbrew; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif test -d /opt/homebrew; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

function brew_enabled() {
    [[ ! -z "${HOMEBREW_PREFIX+x}" ]]
}

function setup_editor() {
    if command -v nvim >/dev/null 2>&1; then
        export EDITOR=nvim
    elif command -v vim >/dev/null 2>&1; then
        export EDITOR=vim
    elif command -v vi >/dev/null 2>&1; then
        export EDITOR=vi
    fi
}

function setup_omz() {
    if test -d "${HOME}/.oh-my-zsh"; then
        ZSH="${HOME}/.oh-my-zsh"
    else
        ZSH="/usr/share/oh-my-zsh"
    fi

    plugins=(git z)
    source $ZSH/oh-my-zsh.sh

    # load extra zsh completions on macOS
    # install zsh-completions first
    if brew_enabled; then
        fpath+=("${HOMEBREW_PREFIX}/share/zsh/site-functions" "${HOMEBREW_PREFIX}/share/zsh-completions")
    fi

    autoload -U promptinit; promptinit
    prompt pure

    if brew_enabled; then
        zsh_autosuggestions="${HOMEBREW_PREFIX}/opt/zsh-autosuggestions/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
        zsh_syntax_highhightling="${HOMEBREW_PREFIX}/opt/zsh-syntax-highlighting/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    else
        zsh_autosuggestions=/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
        zsh_syntax_highhightling=/usr/share/zsh/plugins//zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    fi
    if [ -f "${zsh_autosuggestions}" ]; then
        source "${zsh_autosuggestions}"
    fi
    if [ -f "${zsh_syntax_highhightling}" ]; then
        source "${zsh_syntax_highhightling}"
    fi
}

function setup_bat() {
    if command -v bat >/dev/null 2>&1; then
        alias cat=bat
        export MANPAGER="sh -c 'col -bx | bat -l man -p'"
        export BAT_PAGER="less -RF"
    fi
}

function setup_kubectl() {
    if command -v kubectl >/dev/null 2>&1; then
        alias k=kubectl
        source <(kubectl completion zsh)
    fi
}

function setup_minikube() {
    if command -v minikube >/dev/null 2>&1; then
        alias m=minikube
        source <(minikube completion zsh)
    fi
}

function setup_pyenv() {
    if ! command -v pyenv >/dev/null 2>&1; then
        return
    fi

    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"

    if command -v pyenv-virtualenv-init >/dev/null 2>&1; then
        eval "$(pyenv virtualenv-init -)"
    fi
}

function setup_jenv() {
    if command -v jenv >/dev/null 2>&1; then
        eval "$(jenv init -)"
    fi
}

setup_fzf() {
    if ! command -v fzf >/dev/null 2>&1; then
        return
    fi

    fzf_key_bindings=/usr/share/fzf/key-bindings.zsh
    fzf_completion=/usr/share/fzf/completion.zsh
    if brew_enabled; then
        fzf_key_bindings="${HOMEBREW_PREFIX}"/opt/fzf/shell/key-bindings.zsh
        fzf_completion="${HOMEBREW_PREFIX}"/opt/fzf/shell/completion.zsh
    fi

    source "${fzf_key_bindings}"
    source "${fzf_completion}"
}

function setup_ssh_agent() {
    if command -v gpg-connect-agent >/dev/null 2>&1; then
        gpg-connect-agent /bye >/dev/null 2>&1
        if brew_enabled; then
            export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh
        else
            export SSH_AUTH_SOCK=${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh
        fi
    fi
}

tw() {
    [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
    if [ $1 ]; then
        echo "Please specify target window"
        return
    fi
    window=$(tmux select-pane -m && tmux list-windows -aF '#{window_id};#{window_name};#{session_name}' 2>/dev/null | fzf --exit-0 | cut -d';' -f1) && tmux $change -t "$window"
}

setup_editor
setup_omz
setup_bat
setup_kubectl
setup_minikube
setup_pyenv
setup_jenv
setup_fzf
setup_ssh_agent
