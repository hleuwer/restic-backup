PROGRAM=restic-backup
SETUP=restic-setup
INSTALL_DIR=/usr/local/bin
CONFIG_INCL=restic-backup-include.conf
CONFIG_EXCL=restic-backup-exclude.conf

install::
	mkdir -p /usr/local/bin && cp $(PROGRAM) $(SETUP) $(INSTALL_DIR)
	@echo "Make sure to call /usr/local/bin/$(SETUP) in your shell startup script"
	@echo "Create/edit files '$(CONFIG_INCL)' and '$(CONFIG_EXCL)' to define directories/files to backup."
uninstall:
	sudo cd $(INSTALL_DIR) && rm -rf $(PROGRAM) $(SETUP)


