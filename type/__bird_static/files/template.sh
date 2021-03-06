#!/bin/sh
# Template to generate a static protocol configuration file for bird(1).
# Required non-empty variables:
# __object_id, object
#
# Required defined variables:
# description

# Header
printf "protocol static %s {\n" "${__object_id:?}"

# Optional description
[ -n "${description?}" ] && printf "\tdescription \"%s\";\n" "${description:?}"

# Channel choice
printf "\t%s;\n" "$(cat "${__object:?}/parameter/channel")"

# Routes
while read -r route
do
	printf "\troute %s;\n" "${route?}"
done < "${__object:?}/parameter/route"

# Header close
printf "}\n"
