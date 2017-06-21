From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 21 Jun 2017 14:18:20 -0400
Subject: [PATCH v2 00/10] define new fs integrity_read method
Message-ID: <1498069110-10009-1-git-send-email-zohar@linux.vnet.ibm.com>
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
->integrity_read file operation method.  Until all filesystems
define the new ->integrity_read method, files that were previously
measured might not be currently measured and files that were
previously appraised might fail to be appraised properly.

Version 2 of this patch set, introduces measurement entries and
IMA-audit messages containing file hash values containing 0's,
instead of the actual file hash, for files which the file hash
could not be calculated.  Like for any other file signature
verification error, file access/execute permission will be denied,
for files in policy that the file hash could not be calculated.

To override the IMA policy, allowing unverified code to be
accessed/executed on filesystems not supported by IMA, version 2 of
this patch set defines a new pseudo policy "action" named
"dont_failsafe" and a new builtin policy named "fs_unsafe", which
can be specified on the boot command line.

Mimi

Changelog v1:
- Don't silently drop file measurements on failure to "collect" the
file hash, add an entry in the measurement list and IMA-audit log
the file.
- Define a pseudo policy action named "dont_failsafe".
- Define a new builtin IMA policy named "fs_unsafe".
- Instead of calling the existing read_iter method, when defined
as generic_file_read_iter(), define an ->integrity_read method
for each file system.
- Expanded/clarified motivation in the patch description for using
the ->read method.
- Use kvec, not iovec. (Reported by zero day testing)

Christoph Hellwig (1):
  ima: use fs method to read integrity data

Mimi Zohar (9):
  ima: always measure and audit files in policy
  ima: define "dont_failsafe" policy action rule
  ima: define "fs_unsafe" builtin policy
  tmpfs: define integrity_read method
  fs: define integrity_read method for ext2, gfs2, f2fs, jfs, ramfs
  ocfs2: define integrity_read method
  jffs2: define integrity_read method
  ubifs: define integrity_read method
  ima: use existing read file operation method to calculate file hash

 Documentation/ABI/testing/ima_policy            |  3 ++-
 Documentation/admin-guide/kernel-parameters.txt |  8 ++++++-
 fs/btrfs/file.c                                 |  1 +
 fs/ext2/file.c                                  |  1 +
 fs/ext4/file.c                                  |  1 +
 fs/f2fs/file.c                                  |  1 +
 fs/gfs2/file.c                                  |  2 ++
 fs/jffs2/file.c                                 |  1 +
 fs/jfs/file.c                                   |  1 +
 fs/ocfs2/file.c                                 |  1 +
 fs/ramfs/file-mmu.c                             |  1 +
 fs/ramfs/file-nommu.c                           |  1 +
 fs/ubifs/file.c                                 |  1 +
 fs/xfs/xfs_file.c                               | 21 +++++++++++++++++
 include/linux/fs.h                              |  1 +
 mm/shmem.c                                      |  1 +
 security/integrity/iint.c                       | 31 +++++++++++++++++++------
 security/integrity/ima/ima.h                    |  1 +
 security/integrity/ima/ima_api.c                |  7 ++++--
 security/integrity/ima/ima_main.c               | 15 +++++++++---
 security/integrity/ima/ima_policy.c             | 16 ++++++++++++-
 21 files changed, 101 insertions(+), 15 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
