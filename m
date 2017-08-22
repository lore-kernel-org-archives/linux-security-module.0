From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 22 Aug 2017 16:02:52 -0400
Subject: [GIT PULL]  IMA patches for 4.14
Message-ID: <1503432172.2971.6.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

Here is the integrity pull request for 4.14. ?The major change is
support for a new ->integrity_read file operation method, called for
calculating the file hash.
?
thanks,

Mimi

---

The following changes since commit 08f49ffce0522ae4738308f400795ee4d92f6e3d:

  tpm: ibmvtpm: simplify crq initialization and document crq format (2017-08-19 20:23:44 +0300)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next

for you to fetch changes up to ed301d2614d2658b1d54115501cc9295de79a819:

  ima: define "fs_unsafe" builtin policy (2017-08-22 12:27:05 -0400)

----------------------------------------------------------------
Christoph Hellwig (1):
      ima: use fs method to read integrity data

Mimi Zohar (6):
      ima: don't remove the securityfs policy file
      libfs: define simple_read_iter_from_buffer
      efivarfs: replaces the read file operation with read_iter
      ima: always measure and audit files in policy
      ima: define "dont_failsafe" policy action rule
      ima: define "fs_unsafe" builtin policy

 Documentation/ABI/testing/ima_policy            |  3 +-
 Documentation/admin-guide/kernel-parameters.txt |  8 ++-
 fs/btrfs/file.c                                 |  1 +
 fs/efivarfs/file.c                              | 12 +++--
 fs/ext2/file.c                                  | 17 +++++++
 fs/ext4/file.c                                  | 20 ++++++++
 fs/f2fs/file.c                                  |  1 +
 fs/jffs2/file.c                                 |  1 +
 fs/jfs/file.c                                   |  1 +
 fs/libfs.c                                      | 32 ++++++++++++
 fs/nilfs2/file.c                                |  1 +
 fs/ramfs/file-mmu.c                             |  1 +
 fs/ramfs/file-nommu.c                           |  1 +
 fs/ubifs/file.c                                 |  1 +
 fs/xfs/xfs_file.c                               | 21 ++++++++
 include/linux/fs.h                              |  3 ++
 mm/shmem.c                                      |  1 +
 security/integrity/iint.c                       | 20 +++++---
 security/integrity/ima/ima.h                    |  1 +
 security/integrity/ima/ima_api.c                | 67 ++++++++++++++++---------
 security/integrity/ima/ima_crypto.c             | 10 ++++
 security/integrity/ima/ima_fs.c                 |  4 +-
 security/integrity/ima/ima_main.c               | 19 ++++---
 security/integrity/ima/ima_policy.c             | 41 ++++++++++++++-
 24 files changed, 240 insertions(+), 47 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
