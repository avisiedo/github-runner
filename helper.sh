#!/bin/bash



function yield
{
    echo "$*" >&2
}


function info_message
{
    yield "INFO:$*"
}


function warning_message
{
    yield "WARNING:$*"
}


function error_message
{
    yield "ERROR:$*"
}


function debug_message
{
    yield "DEBUG:$*"
}


function die
{
    local _err=$?
    [ $_err -eq 0 ] && _err=127
    error_message "$*"
    exit $_err
}


function try
{
    "$@" || die "Trying '$*'"
}


function cmd-help
{
cat << EOB
Usage: ./helper <subcommand> ...
    help
    build  --url https://github.com/username/projectname.git  --token \$TOKEN  [--label mylabel1{,mylabel2}]
    lint   Check linters for the list of files specified.

Review your "https://github.com/username/projectname/settings/actions" site to get your token.
EOB
    return 0
}


function cmd-build
{
    local token
    local url
    local labels
    local build_args
    while [ $# -gt 1 ]
    do
        case "$1" in
            "--token" )
                token="$2"
                shift 2
                ;;
            "--url" )
                url="$2"
                shift 2
                ;;
            "--labels" )
                labels="$2"
                ;;
            * )
                echo "$1"
                shift 1
                ;;
        esac
    done

    [ "$token" == "" ] && die "Argument --token is required"
    [ "$url" == "" ] && die "Argument --url is required"

    build_args=""
    build_args="${build_args} --build-arg TOKEN=$token"
    build_args="${build_args} --build-arg URL=$url"
    [ "$labels" != "" ] && build_args="${build_args} --build-arg LABELS=$labels"

    # shellcheck disable=SC2086
    try podman image build ${build_args} -t github-runner:latest .
}


function cmd-lint
{
    return 0
}


CMD="$1"
shift 1

case "$CMD" in
    "help" | "build" )
        "cmd-$CMD" "$@"
        ;;
    * )
        die "Subcommand '$CMD' "
        ;;
esac



