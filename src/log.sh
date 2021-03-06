alias vpt-log-clear="vpt::log::clear"
alias vpt-log-cat="vpt::log::cat"
alias vpt-log-info="vpt::log::info"
alias vpt-log-fit="vpt::log::fit"

vpt::log::fit() {
    while read -r; do
        echo "${REPLY:0:$COLUMNS}"
    done
}

vpt::log::clear() {
    if ! [[ -f "${VPT_LOG}" ]]; then
        return
    fi
    
    rm "${VPT_LOG}"
}

vpt::log::cat() {
    if ! [[ -f "${VPT_LOG}" ]]; then
        return
    fi
    
    cat "${VPT_LOG}"
}

vpt::log::exec() {
    exec 1> >(vpt::log "${FUNCNAME[1]}" '-')
    exec 2> >(exec 1>&2; vpt::log "${FUNCNAME[1]}" '!')
}

vpt::log() {
    while read -r; do
        echo "$@" "${REPLY}"
    done
}

vpt::log::ts() {
    printf '%s %s\n' \
        "$(date '+%y/%m/%d %H:%m:%s')" \
        "$*"
}

vpt::log::out() {
    vpt::log::echo '0' "$@"
}

vpt::log::err() {
    vpt::log::echo '1' "$@"
}

vpt::log::stdout() {
    while read -r; do
        vpt::log::out "$@" "${REPLY}"
    done
}

vpt::log::stderr() {
    while read -r; do
        vpt::log::err "$@" "${REPLY}"
    done
}

vpt::log::info() {
    vpt::log::out 'info' "$@"
}

vpt::log::stream() {
    local NAME="$1"
    shift

    vpt::log::out "stream-start" "${NAME}" "$@"

    "$@" \
        1> >(vpt::log::stdout "stream" "${NAME}" ) \
        2> >(vpt::log::stderr "stream" "${NAME}" )
}
