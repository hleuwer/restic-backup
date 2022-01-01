PROGRAM=restic-backup restic-clone restic-prune restic-snapshots restic-check
SETUP=restic-setup
INSTALL_DIR=/usr/local/bin
PLIST=com.hebbie.backup
PLIST_INSTALL=/Library/LaunchDaemons
PLIST2=com.hebbie.prune
CONFIG_INCL=restic-backup-include.conf
CONFIG_EXCL=restic-backup-exclude.conf
.PHONY: install uninstall install-plist

install::
	mkdir -p /usr/local/bin && cp $(PROGRAM) $(SETUP) $(INSTALL_DIR)
	@echo "Make sure to call /usr/local/bin/$(SETUP) in your shell startup script"
	@echo "Create/edit files '$(CONFIG_INCL)' and '$(CONFIG_EXCL)' to define directories/files to backup."

uninstall:
	sudo cd $(INSTALL_DIR) && rm -rf $(PROGRAM) $(SETUP)

install-daemon:
	sudo cp $(PLIST).plist $(PLIST_INSTALL)
	sudo cp $(PLIST2).plist $(PLIST_INSTALL)

uninstall-daemon:
	sudo rm $(PLIST_INSTALL)/$(PLIST).plist
	sudo rm $(PLIST_INSTALL)/$(PLIST2).plist

load-daemon:
	sudo /bin/launchctl load $(PLIST_INSTALL)/$(PLIST).plist
	sudo /bin/launchctl load $(PLIST_INSTALL)/$(PLIST2).plist

unload-daemon:
	sudo /bin/launchctl unload $(PLIST_INSTALL)/$(PLIST).plist
	sudo /bin/launchctl unload $(PLIST_INSTALL)/$(PLIST2).plist

test-daemon: $(PLIST_INSTALL)/$(PLIST).plist
	sudo /bin/launchctl start $(PLIST)
