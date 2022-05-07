#!/bin/bash


SCRIPT_DIR="$(realpath -e "$(dirname "${BASH_SOURCE[0]}")")"


install_nvim() {
    local source_nvim_dir=$(realpath -m "${SCRIPT_DIR}/nvim")
    local dest_base_dir=$(realpath -m "${HOME}/.config")
    local dest_nvim_dir=$(realpath -m "${dest_base_dir}/nvim")

    if ! mkdir -p "${dest_base_dir}"; then
        >&2 echo "Failed to create config dir for nvim."
        return 1
    fi

    if [ -L "${dest_nvim_dir}" ]; then
        if [ "$(realpath ${dest_nvim_dir})" == "${source_nvim_dir}" ]; then
            >&2 echo "Symbolic link for nvim dir ${dest_nvim_dir} already exists, skipped."
            return 0
        else
            >&2 echo "Symbolic link for nvim dir ${dest_nvim_dir} already exists, but doesn't link to ${source_nvim_dir}."
            return 1
        fi
    fi
    if ! ln -sf "${source_nvim_dir}" "${dest_nvim_dir}"; then
        >&2 echo "Failed to create symbolic link for nvim dir at ${dest_nvim_dir}."
        return 1
    fi
}

install_zsh() {
    local source_file=$(realpath "${SCRIPT_DIR}/zshrc")
    local dest_file=$(realpath -m "${HOME}/.zshrc")

    if ! ln -sf "${source_file}" "${dest_file}"; then
        2>&2 echo "Failed to create symbolic link for zshrc at ${dest_file}."
        return 1
    fi
}

main() {
    echo "Start installing..."

    echo "Setup nvim..."
    install_nvim || exit 1

    echo "Setup zsh..."
    install_zsh || exit 1
}

main
