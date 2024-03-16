CONFIG="${HOME}/.config"
SHARE="${HOME}/.local/share"

.PHONY: install uninstall

install:
	ln --symbolic "${PWD}" "${CONFIG}/nvim"

uninstall:
	rm "${CONFIG}/nvim"
	rm --recursive --force "${SHARE}/nvim"
