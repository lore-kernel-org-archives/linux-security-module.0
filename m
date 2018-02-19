From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 19 Feb 2018 10:18:01 -0500
Subject: [PATCH v1 0/2] ima: untrusted filesystems 
Message-ID: <1519053483-18396-1-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Based on the mailing list discussions, it is clear that separating the
non-init unpriviliged, mounted untrusted filesystem from setuid
unprivileged or privileged mounted untrusted filesystems patches was
confusing.  I've combined the patches, commenting the code with an
explanation for the differentiation.

Instad of expliciting modifying the IMA policy to fail file signature
verfication for the setuid unprivileged or privileged mounted untrusted
filesystems cases, this patch set defines a builtin IMA policy named
"untrusted-fs".  No other IMA policy changes are required.

Mimi


Changelog v1:
- Merged the unprivileged and privileged patches.
- Dropped IMA fsname support.
- Introduced a new IMA builtin policy named "untrusted_fs".
- Replaced fs_type flag with sb->s_iflags flag.

Mimi Zohar (2):
  ima: fail signature verification on untrusted filesystems
  fuse: define the filesystem as untrusted

 Documentation/admin-guide/kernel-parameters.txt |  6 +++++-
 fs/fuse/inode.c                                 |  1 +
 include/linux/fs.h                              |  1 +
 security/integrity/ima/ima_appraise.c           | 16 +++++++++++++++-
 security/integrity/ima/ima_policy.c             |  5 +++++
 security/integrity/integrity.h                  |  1 +
 6 files changed, 28 insertions(+), 2 deletions(-)

-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
