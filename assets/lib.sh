

uscan_report() {
	local tmp=/tmp
	local payload="${tmp}/input"
	local watchfile="${tmp}/watchfile"

	cat > $payload <&0

	jq -r '.source.watchfile' < $payload > $watchfile

	version="$( jq -r '.version.ref' )"

	uscan \
	    --report \
	    --dehs \
	    --upstream-version "$version" \
	    --no-download \
	    --package dummy \
	    --watchfile "$watchfile" \
	    2>/dev/null 
}

get_version() {
	xmllint --xpath '//dehs/upstream-version/text()' /dev/stdin
}

get_url() {
	xmllint --xpath '//dehs/upstream-url/text()' /dev/stdin
}
