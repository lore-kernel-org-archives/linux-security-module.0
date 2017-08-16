From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 16 Aug 2017 13:30:16 -0400
Subject: [RFC PATCH 0/4] ima: filesystems not mounted with i_version 
Message-ID: <1502904620-20075-1-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

IMA measures a file, verifies a file's integrity, and caches the
results.  On filesystems with MS_I_VERSION enabled, IMA can detect
file changes and cause them to be re-measured and verified.  On
filesystems without MS_I_VERSION enabled, files are measured and
verified just once.

Currently users either have to look at the source code or test 
to determine if the file system supports i_version.  Even if the
file system supports i_version, there is no guarantee that the
filesystem was actually mounted with the i_version flag.

This patch set emits warning messages when filesystems are not
mounted with i_version support.  This patch set defines two new post
LSM hooks named security_sb_post_new_mount and
security_sb_post_remount, with their corresponding IMA functions.

Questions:
- IMA can call out directly to the IMA functions, without having to
  define these LSM hooks.  Is there a need for these LSM hooks?

- do_new_mount() creates a new vfsmount. If there is a way of accessing
  this new vfsmount from the caller do_mount(), we would only need one
  new LSM hook and corresponding IMA hook.

Mimi

Mimi Zohar (4):
  security: define new LSM sb_post_new_mount hook
  ima: define new ima_sb_post_new_mount hook
  security: define a new LSM sb_post_remount hook
  ima: define a new ima_sb_post_remount hook

 fs/namespace.c                    |  5 ++++
 include/linux/ima.h               | 14 +++++++++
 include/linux/lsm_hooks.h         | 16 ++++++++++
 include/linux/security.h          | 10 +++++++
 security/integrity/ima/ima_main.c | 62 +++++++++++++++++++++++++++++++++++++++
 security/security.c               | 15 ++++++++++
 6 files changed, 122 insertions(+)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
