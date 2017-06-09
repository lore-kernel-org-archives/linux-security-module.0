From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri,  9 Jun 2017 14:02:40 -0400
Subject: [PATCH 0/4] define new fs integrity_read method
Message-ID: <1497031364-19949-1-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

With the introduction of IMA-appraisal and the need to write file
hashes as security xattrs, IMA needed to take the global i_mutex
lock.  process_measurement() took the iint->mutex first and then
the i_mutex, while setxattr, chmod and chown took the locks in
reverse order.  To resolve this potential deadlock, the iint->mutex
was removed.

Some filesystems have recently replaced their filesystem dependent
lock with the global i_rwsem (formerly the i_mutex) to read a file.
As a result, when IMA attempts to calculate the file hash, reading
the file attempts to take the i_rwsem again.

To resolve this locking problem, this patch set introduces a new
->integrity_read file operation method.  Originally, the presence
of the integrity_read file operation method, as seen in Christoph's
patch, was intended to signify that the file system supports IMA.

Other than fixing this locking problem, the filesystem should be
able to detect when a file changes and re-measure/re-appraise the
file afterwards.  IMA makes the determination of when a file
changes based on the file system being mounted with i_version, but
even without i_version, files would still be measured/appraised
initially.  Detecting and notifying when a file system is mounted
without i_version should be considered a separate issue and
posted as a separate patch set, independently of this one. (A very
preliminary version is available from
https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ 
next-log-iversion-experimental.)

The large majority of filesystems in the fs directory call
generic_file_read_iter() directly (eg. reiserfs, 9p, adfs, affs,
afs, bfs, btrfs, exofs, f2fs, fat, gf2, hfs, hfsplus, hpfs, jfs, minix,
nifs2, omfs, ramfs, romfs, sysv, ubifs, udf, ufs).  Only
filesystems that define their own ->read_iter method, whether it
takes the i_rwsem or not, should be required to define their own
->integrity_read method.

This patch set defines the ->integrity_read file operation method
for xfs, ext4, and tpmfs.  Ceph, cifs, ecryptfs, ext2, fuse, ocfs2
have their own read_iter, but eventually call generic_file_read_iter(),
still need to be converted.  Coda and hugetlbfs have their own
read_iter functions, which do not call generic_file_read_iter().

Although this patch set addresses the locking issue, until the remaining
filesystem define their own ->integrity_read, it introduces the
situation where files that were previously measured, might now not be
measured and files that were previously appraised, might fail to be
appraised properly, even when properly signed/hashed.

Mimi


Christoph Hellwig (1):
  ima: use fs method to read integrity data

Mimi Zohar (5):
  tmpfs: define integrity_read file operation method
  ima: use existing read file operation method to calculate file hash
  ima: use read_iter (generic_file_read_iter) to calculate file hash
  security: define new LSM sb_post_new_mount hook
  ima: indicate possibly missing file measurements or verification

 fs/btrfs/file.c                   |  1 +
 fs/ext4/file.c                    |  1 +
 fs/namespace.c                    |  2 ++
 fs/xfs/xfs_file.c                 | 21 +++++++++++++++++++++
 include/linux/fs.h                |  1 +
 include/linux/ima.h               |  7 +++++++
 include/linux/lsm_hooks.h         |  9 +++++++++
 include/linux/security.h          |  3 +++
 mm/shmem.c                        |  1 +
 security/integrity/iint.c         | 34 +++++++++++++++++++++++++++-------
 security/integrity/ima/ima_main.c | 31 +++++++++++++++++++++++++++++++
 security/security.c               |  7 +++++++
 12 files changed, 111 insertions(+), 7 deletions(-)

-- 
2.7.4




====
*** BLURB HERE ***

Christoph Hellwig (1):
  ima: use fs method to read integrity data

Mimi Zohar (3):
  tmpfs: define integrity_read file operation method
  ima: use existing read file operation method to calculate file hash
  ima: use read_iter (generic_file_read_iter) to calculate file hash

 fs/btrfs/file.c           |  1 +
 fs/ext4/file.c            |  1 +
 fs/xfs/xfs_file.c         | 21 +++++++++++++++++++++
 include/linux/fs.h        |  1 +
 mm/shmem.c                |  1 +
 security/integrity/iint.c | 34 +++++++++++++++++++++++++++-------
 6 files changed, 52 insertions(+), 7 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
