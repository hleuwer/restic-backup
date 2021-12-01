PROGRAM=restic-backup
CONFIG=restic-backup-include.conf restic-backup-exclude.conf
install::
	cp $(CONFIG) /etc
	cp $(PROGRAM) /usr/local/bin
uninstall:
	cd /etc && rm -rf $(CONFIG)
	cd /usr/local/bin && rm -rf $(PROGRAM)
