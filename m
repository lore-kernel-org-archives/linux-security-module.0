From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 10 Aug 2017 19:41:43 -0400
Subject: [PATCH v5 0/4] define new fs integrity_read method 
Message-ID: <1502408507-4257-1-git-send-email-zohar@linux.vnet.ibm.com>
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

Version 2 of this patch set, introduced measurement entries and
IMA-audit messages containing file hash values of 0's, instead
of the actual file hash, to indicate that the file hash could not
be calculated.  Like for any other file signature verification
error, file access/execute permission is denied.

To override the IMA policy, allowing unverified code to be
accessed/executed on filesystems not supported by IMA, version 2 of
this patch set defined a new policy "action" named "dont_failsafe"
and a new builtin policy named "fs_unsafe", which can be specified
on the boot command line.

Direct Access:
Although the new integrity_read method works for files opened with
the "O_DIRECT" flag on block devices that support DAX, for consistency
instead of failing just the buffered read, this patch set fails both
buffered read and DAX.  (Refer to commit f9b2a735bddd "ima: audit log
files opened with O_DIRECT flag" for an explanation of the buffered
read locking issues.)


Change log v5:
- fail files opened O_DIRECT, but include access attempt in measurement
list.
- removed ocf2 and gfs2 integrity_read support.

Change log v4:
- define ext2/4 specific ->integrity_read functions based Jan Kara's
review.
- properly fail file open with O_DIRECT on filesystems not mounted
with "-o dax".
- remove the "permit_directio" IMA policy option.

Change log v3:
- define simple_read_iter_from_buffer
- replace the existing efivarfs ->read method with ->read_iter method.
- squashed other fs definitions of ->integrity_read with this patch.
- include dont_failsafe rule when displaying policy.
- fail attempt to add dont_failsafe rule when appending to the policy.
- moved '---' divider before change log, as requested in review.

Mimi

Christoph Hellwig (1):
  ima: use fs method to read integrity data

Mimi Zohar (3):
  ima: always measure and audit files in policy
  ima: define "dont_failsafe" policy action rule
  ima: define "fs_unsafe" builtin policy

 Documentation/ABI/testing/ima_policy            |  3 +-
 Documentation/admin-guide/kernel-parameters.txt |  8 +++-
 fs/btrfs/file.c                                 |  1 +
 fs/efivarfs/file.c                              | 12 ++---
 fs/ext2/file.c                                  | 17 +++++++
 fs/ext4/file.c                                  | 20 +++++++++
 fs/f2fs/file.c                                  |  1 +
 fs/jffs2/file.c                                 |  1 +
 fs/jfs/file.c                                   |  1 +
 fs/libfs.c                                      | 32 +++++++++++++
 fs/nilfs2/file.c                                |  1 +
 fs/ramfs/file-mmu.c                             |  1 +
 fs/ramfs/file-nommu.c                           |  1 +
 fs/ubifs/file.c                                 |  1 +
 fs/xfs/xfs_file.c                               | 21 +++++++++
 include/linux/fs.h                              |  3 ++
 mm/shmem.c                                      |  1 +
 security/integrity/iint.c                       | 20 ++++++---
 security/integrity/ima/ima.h                    |  1 +
 security/integrity/ima/ima_api.c                | 60 ++++++++++++++-----------
 security/integrity/ima/ima_crypto.c             | 10 +++++
 security/integrity/ima/ima_main.c               | 19 +++++---
 security/integrity/ima/ima_policy.c             | 41 ++++++++++++++++-
 23 files changed, 231 insertions(+), 45 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
