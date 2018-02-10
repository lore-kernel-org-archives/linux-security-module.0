From: jmorris@namei.org (James Morris)
Date: Sat, 10 Feb 2018 17:26:55 +1100 (AEDT)
Subject: [GIT PULL] Integrity: IMA FUSE fixes
Message-ID: <alpine.LRH.2.21.1802101718330.4382@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

These patches ensure that IMA works correctly on FUSE filesystems, so that 
cached integrity data is not used.  FUSE filesystems can change this data 
at any time without notifying the kernel and we now verify it for each 
use.

This work is late in the kernel cycle, but they have had good review, 
testing, and acks.  They only impact FUSE and IMA.

Please consider pulling for v4.16.

---

The following changes since commit 9a61df9e5f7471fe5be3e02bd0bed726b2761a54:

  Merge tag 'kbuild-v4.16-2' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild (2018-02-09 19:32:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git for-v4.16

for you to fetch changes up to 8f7765f67642424650e22c1077b149c2820e7d18:

  fuse: introduce new fs_type flag FS_IMA_NO_CACHE (2018-02-10 15:10:09 +1100)

----------------------------------------------------------------
Alban Crequy (2):
      ima: force re-appraisal on filesystems with FS_IMA_NO_CACHE
      fuse: introduce new fs_type flag FS_IMA_NO_CACHE

 fs/fuse/inode.c                   |  2 +-
 include/linux/fs.h                |  1 +
 security/integrity/ima/ima_main.c | 15 +++++++++++++--
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 624f18b..0a9e516 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1205,7 +1205,7 @@ static void fuse_kill_sb_anon(struct super_block *sb)
 static struct file_system_type fuse_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "fuse",
-	.fs_flags	= FS_HAS_SUBTYPE,
+	.fs_flags	= FS_HAS_SUBTYPE | FS_IMA_NO_CACHE,
 	.mount		= fuse_mount,
 	.kill_sb	= fuse_kill_sb_anon,
 };
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2a81556..8d3f97d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2069,6 +2069,7 @@ struct file_system_type {
 #define FS_BINARY_MOUNTDATA	2
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
+#define FS_IMA_NO_CACHE		16	/* Force IMA to re-measure, re-appraise, re-audit files */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	struct dentry *(*mount) (struct file_system_type *, int,
 		       const char *, void *);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2cfb0c7..55d9149 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -25,6 +25,7 @@
 #include <linux/xattr.h>
 #include <linux/ima.h>
 #include <linux/iversion.h>
+#include <linux/fs.h>
 
 #include "ima.h"
 
@@ -229,9 +230,19 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 				 IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
 				 IMA_ACTION_FLAGS);
 
-	if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags))
-		/* reset all flags if ima_inode_setxattr was called */
+	/*
+	 * Reset the measure, appraise and audit cached flags either if:
+	 * - ima_inode_setxattr was called, or
+	 * - based on filesystem feature flag
+	 * forcing the file to be re-evaluated.
+	 */
+	if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags)) {
+		iint->flags &= ~IMA_DONE_MASK;
+	} else if (inode->i_sb->s_type->fs_flags & FS_IMA_NO_CACHE) {
 		iint->flags &= ~IMA_DONE_MASK;
+		if (action & IMA_MEASURE)
+			iint->measured_pcrs = 0;
+	}
 
 	/* Determine if already appraised/measured based on bitmask
 	 * (IMA_MEASURE, IMA_MEASURED, IMA_XXXX_APPRAISE, IMA_XXXX_APPRAISED,
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
