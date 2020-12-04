#!/bin/bash -e
# Downloaded from https://gist.githubusercontent.com/magnetikonline/dd5837d597722c9c2d5dfa16d8efe5b9/raw/e5e5d703f4d3efbf9f361a7a2e2273cd6ff12ace/gitlistobjectbysize.sh

function main {
	local tempFile=$(mktemp)

	# work over each commit and append all files in tree to $tempFile
	local IFS=$'\n'
	for commitSHA1 in $(git rev-list --all); do
		git ls-tree -r --long "$commitSHA1" >>"$tempFile"
	done

	# sort files by SHA1, de-dupe list and finally re-sort by filesize
	sort --key 3 "$tempFile" | \
		uniq | \
		sort --key 4 --numeric-sort --reverse

	# remove temp file
	rm "$tempFile"
}


main
