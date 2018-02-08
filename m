From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 08 Feb 2018 13:35:01 -0500
Subject: [GIT PULL] IMA bug fixes for 4.16-rc1
Message-ID: <1518114901.3445.3.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

Here are the remaining 2 FUSE patches.

thanks,

Mimi

The following changes since commit e2598077dc6a26c9644393e5c21f22a90dbdccdb:

  ima: re-initialize iint->atomic_flags (2018-02-02 21:03:08 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git fixes-v4.16-rc1

for you to fetch changes up to f132f946073b19687a2d52888e4a4f9b2d46478e:

  fuse: introduce new fs_type flag FS_IMA_NO_CACHE (2018-02-08 10:59:03 -0500)

----------------------------------------------------------------
Alban Crequy (2):
      ima: force re-appraisal on filesystems with FS_IMA_NO_CACHE
      fuse: introduce new fs_type flag FS_IMA_NO_CACHE

 fs/fuse/inode.c                   |  2 +-
 include/linux/fs.h                |  1 +
 security/integrity/ima/ima_main.c | 15 +++++++++++++--
 3 files changed, 15 insertions(+), 3 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
