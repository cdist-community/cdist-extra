#!/usr/bin/awk -f
#
# 2020 Dennis Camera (dennis.camera@ssrq-sds-fds.ch)
#
# This file is part of cdist.
#
# cdist is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# cdist is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with cdist. If not, see <http://www.gnu.org/licenses/>.
#

function getvalue(path) {
	# Reads the first line of the file located at path and returns it.
	getline < path
	close(path)
	return $0
}

function sepafter(f, def,    _) {
	# finds the separator between field $f and $(f+1)
	_ = substr($0, length($f)+1, index(substr($0, length($f)+1), $(f+1))-1)
	return _ ? _ : def
}

function write_aliases() {
	if (aliases_written) return

	# print aliases line
	printf "%s%s", ENVIRON["__object_id"], sepafter(1, ": ")
	while ((getline < aliases_should_file) > 0) {
		if (aliases_written) printf ", "
		printf "%s", $0
		aliases_written = 1
	}
	printf "\n"
	close(aliases_should_file)
}

BEGIN {
	FS = ":[ \t]*"

	parameter_dir = ENVIRON["__object"] "/parameter/"

	mode = (getvalue(parameter_dir "state") != "absent")
	aliases_should_file = (parameter_dir "/alias")
}

/^[ \t]*\#/ {
	# comment line (leave alone)
	select = 0; cont = 0  # comments terminate alias lists and continuations
	print
	next
}

{
	# is this line a continuation line?
	# (the prev. line ended in a backslash or the line starts with whitespace)
	is_cont = /^[ \t]/ || cont

	# detect if the line is a line to be continued (ends with a backslash)
	cont = ($0 ~ /\\$/)
	# if it is, we drop the backslash from the line.
	if (cont) sub(/[ \t]*\\$/, "", $0)
}

is_cont {
	# we ignore the line as it has been rewritten previously or is not
	# interesting
	next
}

$1 == ENVIRON["__object_id"] {
	# "target" user -> rewrite aliases list
	select = 1
	if (mode) write_aliases()
	next
}

{
	# other user
	select = 0
	print
}

END {
	# if the last line was an alias, the separator will be reused (looks better)
	if (mode && !aliases_written)
		write_aliases()
}
