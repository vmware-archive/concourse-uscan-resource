#!/usr/bin/env bash

set -eu
set -o pipefail

. ./lib.sh

test_uscan_report() {
	local input='
{
	"source": {
		"watchfile": "version=4\nhttps://golang.org/dl/ https://storage.googleapis.com/golang/go(1\\.8\\.3).linux-amd64.tar.gz"
	},
	"version": { "ref" : "0.0.1" }
}
'

	local report="$( echo "$input" | uscan_report | get_version )"
	local expected="1.8.3"
	[ "$report" = "$expected" ] || {
		echo "report not as expected"
		exit 1
	}
}

test_uscan_report
