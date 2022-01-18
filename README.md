# restic-backup

## Doing Backups with [restic](https://restic.net/ "restic - backup done right").

## Requirements

*restic-backup* provides a set of shell scripts to simplify the usage of restic
 using the following basic **requirements**:

* (1) Data to be backed up MUST be stored in at least 2 geographical different
  locations. This ensures that the damage of one location  does not lead to loss
  of all data. We dispense to strictly follow the commonly used 3-2-1 rule which
  requires 3 differnt storage media.
  
* (2) Relevant data MUST be saved on a *Local Server* independently from any
  cloud service. This is for sake of independence and performance.

* (3) Data saved in the cloud MUST be saved encrypted. Encryption MUST occur in
  the clients. Server side encryption is not accepted.

Restic fullfils all those requirements in a perfect way.


## Backup Strategy

The following Backup **strategy** is used: 

* The *Local Server* is a RaspberrypiPi computer with a built-in 512 MB SSD. It 
  runs a SAMBA file service and exports any users home directory via the named
  export *pi2home*.


### *Windows Computer* backup to *Local Server*

The windows internal backup mechamisms are used. Backup storage is a network
drive to be mounted using the path `//raspberrypi2/pi2home`. Windows backup
is configured for a 

Only user files like documents or pictures are selected for the backup. 
Operating system directories and files are excluded.



### *Linux and MacOS Computer*  Backup to *Local Server*

Under Linux and MacOS a daily backup is done into the host's repository located
on the local server.  We do a back to the cloud every week once for every host.

The corresponding restic commands are

> `restic-backup lan daily`

for the daily backups and 

> `restic-backup onedrive weekly`.

vor the weekly backups.

The cronjob executing the script must be scheduled accordingly:

> `# Database dump and filebBackup every day at 4:00`  
> `00 4 * * * /usr/local/bin/backup-mysql; /usr/local/bin/restic-backup lan daily`  
> `# File backup every week friday at 12:00`  
> `00 12 * * 5 /usr/local/bin/restic-backup onedrive weekly

### *Local Server* backup to *cloud*

The local server's user data backup to a server private repository to the 
Onedrive storage happens every week:

> `restic-backup onedrive weekly`.


## Pruning of repositories

The repositories grow over time. it is therefore meaningful to remove snapshots
which don't contain unique data from time to time.

Restic provides a command to *forget* selected snapshots and then remove data
associated with the removed snapshot. It supports user definable policies 
which allow to keep certain sets of snapshots and forget outdated snapshots.

Restic calls the whole process *pruning*.

Here is my pruning policy implemented in `restic-prune`:

* Keep 2 hourly backups

* Keep 7 daily backups

* Keep 4 weekly backups

The values are hard coded in `restic-prune`.

> `restic-prune lan [hostname|`






