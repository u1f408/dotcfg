#!/usr/bin/env sh
# meow :)

if [ -f "/etc/NIXOS" ]; then
	echo >&2 "error: you're running this on NixOS. don't do that!"
	exit 1
fi

_mode="dry"
if [ "$#" -ge 1 ]; then
	_mode="$1"; shift
fi

_modestr=""
case "${_mode}" in
	dry)
		_modestr="[DRY RUN] "
		break
		;;
	real)
		break
		;;
	*)
		echo >&2 "error: unknown mode: ${_mode}"
		exit 1
		;;
esac

_base="$(dirname "$(readlink -f $0)")"
_dst="${PREFIX:-$HOME}"
printf "==> %sDeploying to %s\n" "${_modestr}" "${_dst}"

cat "${_base}/pathmap" | while IFS=" " read -r fsrc dst perm; do
	fdst="${_dst}/${dst}"
	printf "%s --> %s\n" "${fsrc}" "${fdst}"
	if [ "${_mode}" = "real" ]; then
		mkdir -p "$(dirname "${fdst}")"
		cp "${_base}/${fsrc}" "${fdst}"
        chmod "${perm}" "${fdst}"
	fi
done
