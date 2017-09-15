From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 15 Sep 2017 00:58:11 -0400
Subject: [PATCH 0/3] ima: only call integrity_kernel_read to calc file hash
Message-ID: <1505451494-30228-1-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The integrity_kernel_read() function was originally introduced to
read a file and calculate the file hash by-passing any security
checks.  Support subsequently was added allowing the kernel to read
a file containing a signed x509 certificate and load it onto either
the IMA or EVM keyring.

This patch set replaces the call to integrity_kernel_read() with the
common kernel_read_file_from_path() function, for reading and
loading an x509 certificate onto either the IMA or EVM keyring.  The
remaining calls to integrity_kernel_read() calculate a file hash, by
calling the new integrity_read file operation method.

Mimi


Christoph Hellwig (2):
  integrity: replace call to integrity_read_file with kernel version
  ima: use fs method to read integrity data

Mimi Zohar (1):
  vfs: constify path argument to kernel_read_file_from_path

 fs/btrfs/file.c                   |  1 +
 fs/efivarfs/file.c                |  1 +
 fs/exec.c                         |  2 +-
 fs/ext2/file.c                    | 17 ++++++++++
 fs/ext4/file.c                    | 20 ++++++++++++
 fs/f2fs/file.c                    |  1 +
 fs/jffs2/file.c                   |  1 +
 fs/jfs/file.c                     |  1 +
 fs/nilfs2/file.c                  |  1 +
 fs/ramfs/file-mmu.c               |  1 +
 fs/ramfs/file-nommu.c             |  1 +
 fs/ubifs/file.c                   |  1 +
 fs/xfs/xfs_file.c                 | 21 ++++++++++++
 include/linux/fs.h                |  4 ++-
 mm/shmem.c                        |  1 +
 security/integrity/digsig.c       | 14 +++++---
 security/integrity/iint.c         | 69 ++++++++-------------------------------
 security/integrity/ima/ima_main.c |  4 +++
 security/integrity/integrity.h    |  2 --
 sound/oss/sound_firmware.h        |  2 +-
 20 files changed, 100 insertions(+), 65 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
