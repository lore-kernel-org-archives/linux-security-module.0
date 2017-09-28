From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 28 Sep 2017 08:39:30 -0400
Subject: [RFC PATCH 0/3] define new read_iter file operation rwf flag
Message-ID: <1506602373-4799-1-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch set replaces the "integrity_read" file operation method,
as defined in the "ima: use fs method to read integrity data" patch,
with a new read_iter file operation "rwf" flag.  (The other patches
are the same.*)

The main difference between these approaches is whether IMA must be
explicitly enabled (opt-in), by defining the "integrity_read" file
operation method for each file system, or enabled by default, with
modifications as needed to the read_iter.

*The entire patch sets can be found in
git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
next-integrity-read and next-read-iter.

Mimi

Mimi Zohar (3):
  fs: define new read_iter rwf flag
  integrity: use call_read_iter to calculate the file hash
  fs: detect that the i_rwsem has already been taken exclusively

 arch/s390/hypfs/inode.c                      |  3 ++-
 drivers/block/loop.c                         |  2 +-
 drivers/char/mem.c                           |  6 ++++--
 drivers/gpu/drm/drm_dp_aux_dev.c             |  3 ++-
 drivers/net/tap.c                            |  3 ++-
 drivers/net/tun.c                            |  3 ++-
 drivers/staging/android/ashmem.c             |  3 ++-
 drivers/staging/lustre/lustre/llite/file.c   |  3 ++-
 drivers/staging/lustre/lustre/llite/vvp_io.c |  2 +-
 drivers/usb/gadget/function/f_fs.c           |  3 ++-
 drivers/usb/gadget/legacy/inode.c            |  2 +-
 drivers/vhost/net.c                          |  3 ++-
 fs/9p/vfs_file.c                             |  8 +++++---
 fs/aio.c                                     |  2 +-
 fs/block_dev.c                               |  4 ++--
 fs/ceph/file.c                               |  5 +++--
 fs/cifs/cifsfs.c                             |  6 +++---
 fs/cifs/cifsfs.h                             |  4 ++--
 fs/cifs/file.c                               | 10 +++++-----
 fs/coda/file.c                               |  2 +-
 fs/ecryptfs/file.c                           |  4 ++--
 fs/efivarfs/file.c                           |  2 +-
 fs/ext2/file.c                               | 16 +++++++++------
 fs/ext4/file.c                               | 20 +++++++++++--------
 fs/fuse/cuse.c                               |  3 ++-
 fs/fuse/dev.c                                |  3 ++-
 fs/fuse/file.c                               |  8 +++++---
 fs/hugetlbfs/inode.c                         |  3 ++-
 fs/ncpfs/file.c                              |  2 +-
 fs/nfs/file.c                                |  4 ++--
 fs/nfs/internal.h                            |  2 +-
 fs/ocfs2/file.c                              |  5 +++--
 fs/orangefs/file.c                           |  3 ++-
 fs/pipe.c                                    |  2 +-
 fs/read_write.c                              |  4 ++--
 fs/splice.c                                  |  2 +-
 fs/xfs/xfs_file.c                            | 30 +++++++++++++++++-----------
 include/linux/fs.h                           | 10 +++++-----
 mm/filemap.c                                 |  3 ++-
 mm/shmem.c                                   |  3 ++-
 net/socket.c                                 |  4 ++--
 security/integrity/iint.c                    | 21 +++++++++++++------
 sound/core/pcm_native.c                      |  2 +-
 43 files changed, 139 insertions(+), 94 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
