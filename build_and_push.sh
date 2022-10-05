#!/usr/bin/env bash

set -eu
set -o pipefail

test -z "${DEBUG:-}" || set -x

if [ -z "${1:-}" ]
then
    DIR="$( dirname "$(readlink -f "$0")" )"
else
    DIR="$1"
fi

trap "cd '${PWD}'" EXIT
cd "$DIR"

: "${NAME="$(basename "$DIR")"}"
: "${VER:=latest}"
: "${REPO:=cflondonservices}"

GIT_REV="$( git rev-parse HEAD )"
CUR_DATE="$( date -u '+%Y-%m-%dT%H:%M:%SZ' )"
DIRTY="$(
    [ "$(git status --porcelain | wc -l)" = 0 ] || {
        echo '-dirty'
    }
)"

TAG_DATE="${REPO}/${NAME}:${CUR_DATE//:/.}"  # tags with : are not allowed
TAG_VER="${REPO}/${NAME}:${VER}"

docker build \
    --label org.label-schema.vcs-rev="${GIT_REV}${DIRTY}" \
    --label org.label-schema.build-date="${CUR_DATE}" \
    --tag "$TAG_VER" \
    --tag "$TAG_DATE" \
    .

if [ -n "${PUSH_WHEN_DIRTY:-}" -o -z "$DIRTY" ]
then
    docker push "${REPO}/${NAME}"
else
    echo 'Not pushing, working dir is dirty' >&2
fi
