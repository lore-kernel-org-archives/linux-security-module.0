From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 01 Feb 2018 13:38:02 -0500
Subject: [GIT PULL] IMA bug fixes for 4.16
Message-ID: <1517510282.6675.13.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

Included in this pull request are three bug fixes, assuming the 2 FUSE
patches are considered bugs and not new features, and a maintainer update.
I'd appreciate your sending them to Linus for 4.16.

thanks,

Mimi

The following changes since commit 36447456e1cca853188505f2a964dbbeacfc7a7a:

  ima/policy: fix parsing of fsuuid (2018-01-18 16:52:49 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity

for you to fetch changes up to d56f30ac85c067d0d3a6c4f293f655dc298cb5ce:

  ima: force re-appraisal on filesystems with FS_IMA_NO_CACHE (2018-02-01 12:38:31 -0500)

----------------------------------------------------------------
Alban Crequy (2):
      fuse: introduce new fs_type flag FS_IMA_NO_CACHE
      ima: force re-appraisal on filesystems with FS_IMA_NO_CACHE

Mimi Zohar (2):
      ima: re-initialize iint->atomic_flags
      maintainers: update trusted keys

 MAINTAINERS                       |  1 +
 fs/fuse/inode.c                   |  2 +-
 include/linux/fs.h                |  1 +
 security/integrity/iint.c         |  1 +
 security/integrity/ima/ima_main.c | 15 +++++++++++++--
 5 files changed, 17 insertions(+), 3 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
