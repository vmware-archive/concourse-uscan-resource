#!/usr/bin/env bash

set -eu
set -o pipefail

. "$( dirname "$0" )/../assets/lib.sh"

run_tests() {
	local input='
{
	"source": {
		"watchfile": "version=4\nhttps://golang.org/dl/ https://storage.googleapis.com/golang/go(1\\.8\\.3).linux-amd64.tar.gz"
	},
	"version": { "ref" : "0.0.1" }
}
'

	local version="$( echo "$input" | uscan_report | get_version )"
	local expected_version="1.8.3"

	[ "$version" = "$expected_version" ] || {
		echo "report not as expected"
		exit 1
	}
}

run_tests && {
	echo 'all tests passed'
}
