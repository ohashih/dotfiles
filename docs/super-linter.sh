#!/bin/bash
# -- super-linter.sh -----------------------------------------------------------
#
# Run super-linter locally on changed/added file(s) only
#
# This program comes with no warranty. Use at your own risk.
#
# You have been warned. (That said, it works well for me :)
#
#
# include https://opensource.org/license/MIT \
#     | sed 's/<YEAR>/2025/; s/<COPYRIGHT HOLDER>/edo/'
#
# ------------------------------------------------------------------------------
# Exit immediately; report undefined variables; fail on pipe
set -euo pipefail

readonly ME=${0##*/}
readonly WORKDIR="./tmp/lint"

display_usage() {

    cat << EOE

    Super Linter による静的コード解析を実行するスクリプト

    構文: ./${ME}

EOE

    exit 0

}

check_sanity() {

    [[ $(command -v docker) ]] \
        || whoopsie "Please install Docker first."

    [[ $(docker ps) ]] \
        || whoopsie "Please run Docker daemon first."

}

copy_target_files() {

    rm -rf "${WORKDIR}"

    mkdir -p "${WORKDIR}"

    target_files=$(
        git status --porcelain --no-renames \
            | grep --invert-match '^ *D' \
            | awk '{print $2}'
    )

    if [[ -z "${target_files}" ]]; then
        echo "No files to lint. Exiting..."
        exit 0
    fi

    for file in ${target_files}; do
        mkdir -p "${WORKDIR}/$(dirname "${file}")"
        cp -R "${file}" "${WORKDIR}/${file}"
    done

    cp .editorconfig "${WORKDIR}/.editorconfig"

}

lint() {

    docker compose \
        --file docker-compose.super-linter.yml \
        up \
        --build \
        --exit-code-from linter \
        || whoopsie "Lint failed."

}

main() {

    while getopts h opt; do
        case $opt in
            h)
                display_usage
            ;;
            :)
                whoopsie "Option missing!"
            ;;
            \?)
                whoopsie "Invalid option!"
            ;;
        esac
    done

    check_sanity

    copy_target_files

    lint

}

whoopsie() {

    local message=$1

    echo "${message} Aborting..."
    exit 192

}

main "$@"

exit 0
