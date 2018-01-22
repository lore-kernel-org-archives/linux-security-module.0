From: alban.crequy@gmail.com (Alban Crequy)
Date: Mon, 22 Jan 2018 17:24:50 +0100
Subject: [RFC PATCH v3 0/2] ima,fuse: introduce new fs flag FS_IMA_NO_CACHE
Message-ID: <20180122162452.8756-1-alban@kinvolk.io>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patchset v3 introduces a new fs flag FS_IMA_NO_CACHE and uses it in
FUSE. This forces files to be re-measured, re-appraised and re-audited
on file systems with the feature flag FS_IMA_NO_CACHE. In that way,
cached integrity results won't be used.

There was a previous attempt (unmerged) with a IMA option named "force" and using
that option for FUSE filesystems. These patches use a different approach
so that the IMA subsystem does not need to know about FUSE.
- https://www.spinics.net/lists/linux-integrity/msg00948.html
- https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1584131.html

Changes since v1: https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1587390.html
- include linux-fsdevel mailing list in cc
- mark patch as RFC
- based on next-integrity, without other unmerged FUSE / IMA patches

Changes since v2: https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1587678.html
- rename flag to FS_IMA_NO_CACHE
- split patch into 2

The patchset is also available in our github repo:
  https://github.com/kinvolk/linux/tree/alban/fuse-flag-ima-nocache-v3


Alban Crequy (2):
  fuse: introduce new fs_type flag FS_IMA_NO_CACHE
  ima: force re-appraisal on filesystems with FS_IMA_NO_CACHE

 fs/fuse/inode.c                   |  2 +-
 include/linux/fs.h                |  1 +
 security/integrity/ima/ima_main.c | 24 ++++++++++++++++++++++--
 3 files changed, 24 insertions(+), 3 deletions(-)

-- 
2.13.6

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
