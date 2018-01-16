From: alban.crequy@gmail.com (Alban Crequy)
Date: Tue, 16 Jan 2018 16:10:00 +0100
Subject: [RFC PATCH v2] ima,fuse: introduce new fs flag FS_NO_IMA_CACHE
Message-ID: <20180116151000.443-1-alban@kinvolk.io>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Alban Crequy <alban@kinvolk.io>

This patch forces files to be re-measured, re-appraised and re-audited
on file systems with the feature flag FS_NO_IMA_CACHE. In that way,
cached integrity results won't be used.

For now, this patch adds the new flag only FUSE filesystems. This is
needed because the userspace FUSE process can change the underlying
files at any time.

How to test this:

====

The test I did was using a patched version of the memfs FUSE driver
[2][3] and two very simple "hello-world" programs [5] (prog1 prints
"hello world: 1" and prog2 prints "hello world: 2").

I copy prog1 and prog2 in the fuse-memfs mount point, execute them and
check the sha1 hash in
"/sys/kernel/security/ima/ascii_runtime_measurements".

My patch on the memfs FUSE driver added a backdoor command to serve
prog1 when the kernel asks for prog2 or vice-versa. In this way, I can
exec prog1 and get it to print "hello world: 2" without ever replacing
the file via the VFS, so the kernel is not aware of the change.

The test was done using the branch "alban/fuse-flag-ima-nocache-v2" [4].

Step by step test procedure:

1. Mount the memfs FUSE using [3]:
rm -f  /tmp/memfs-switch* ; memfs -L DEBUG  /mnt/memfs

2. Copy prog1 and prog2 using [5]
cp prog1 /mnt/memfs/prog1
cp prog2 /mnt/memfs/prog2

3. Lookup the files and let the FUSE driver to keep the handles open:
dd if=/mnt/memfs/prog1 bs=1 | (read -n 1 x ; sleep 3600 ) &
dd if=/mnt/memfs/prog2 bs=1 | (read -n 1 x ; sleep 3600 ) &

4. Check the 2 programs work correctly:
$ /mnt/memfs/prog1
hello world: 1
$ /mnt/memfs/prog2
hello world: 2

5. Check the measurements for prog1 and prog2:
$ sudo cat /sys/kernel/security/ima/ascii_runtime_measurements \
                | grep /mnt/memfs/prog
10 [...] ima-ng sha1:ac14c9268cd2[...] /mnt/memfs/prog1
10 [...] ima-ng sha1:799cb5d1e06d[...] /mnt/memfs/prog2

6. Use the backdoor command in my patched memfs to redirect file
operations on file handle 3 to file handle 2:
rm -f  /tmp/memfs-switch* ; touch /tmp/memfs-switch-3-2

7. Check how the FUSE driver serves different content for the files:
$ /mnt/memfs/prog1
hello world: 2
$ /mnt/memfs/prog2
hello world: 2

8. Check the measurements:
sudo cat /sys/kernel/security/ima/ascii_runtime_measurements \
                | grep /mnt/memfs/prog

Without the patch, there are no new measurements, despite the FUSE
driver having served different executables.

With the patch, I can see additional measurements for prog1 and prog2
with the hashes reversed when the FUSE driver served the alternative
content.

====

[1] https://www.spinics.net/lists/linux-integrity/msg00948.html
[2] https://github.com/bbengfort/memfs
[3] https://github.com/kinvolk/memfs/commits/alban/switch-files
[4] https://github.com/kinvolk/linux/commits/alban/fuse-flag-ima-nocache-v2
[5] https://github.com/kinvolk/fuse-userns-patches/commit/cf1f5750cab0

Cc: linux-kernel at vger.kernel.org
Cc: linux-integrity at vger.kernel.org
Cc: linux-security-module at vger.kernel.org
Cc: linux-fsdevel at vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: James Morris <james.l.morris@oracle.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Seth Forshee <seth.forshee@canonical.com>
Cc: Christoph Hellwig <hch@infradead.org>
Tested-by: Dongsu Park <dongsu@kinvolk.io>
Signed-off-by: Alban Crequy <alban@kinvolk.io>

---

There was a previous attempt (unmerged) with a IMA option named "force" and using
that option for FUSE filesystems. This patch uses a different approach
so that the IMA subsystem does not need to know about FUSE.
- https://www.spinics.net/lists/linux-integrity/msg00948.html
- https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1584131.html

Changes since v1: https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1587390.html
- include linux-fsdevel mailing list in cc
- mark patch as RFC
- based on next-integrity, without other unmerged FUSE / IMA patches
---
 fs/fuse/inode.c                   |  2 +-
 include/linux/fs.h                |  1 +
 security/integrity/ima/ima_main.c | 24 ++++++++++++++++++++++--
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 624f18bbfd2b..5bf14289afba 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1205,7 +1205,7 @@ static void fuse_kill_sb_anon(struct super_block *sb)
 static struct file_system_type fuse_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "fuse",
-	.fs_flags	= FS_HAS_SUBTYPE,
+	.fs_flags	= FS_HAS_SUBTYPE | FS_NO_IMA_CACHE,
 	.mount		= fuse_mount,
 	.kill_sb	= fuse_kill_sb_anon,
 };
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 511fbaabf624..2bd7e73ebc2a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2075,6 +2075,7 @@ struct file_system_type {
 #define FS_BINARY_MOUNTDATA	2
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
+#define FS_NO_IMA_CACHE		16	/* Force IMA to re-measure, re-appraise, re-audit files */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	struct dentry *(*mount) (struct file_system_type *, int,
 		       const char *, void *);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 6d78cb26784d..2ce4d69068a8 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/xattr.h>
 #include <linux/ima.h>
+#include <linux/fs.h>
 
 #include "ima.h"
 
@@ -228,9 +229,28 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
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
 		iint->flags &= ~IMA_DONE_MASK;
+	} else if (inode->i_sb->s_type->fs_flags & FS_NO_IMA_CACHE) {
+		if (action & IMA_MEASURE) {
+			iint->measured_pcrs = 0;
+			iint->flags &=
+			    ~(IMA_COLLECTED | IMA_MEASURE | IMA_MEASURED);
+		}
+		if (action & IMA_APPRAISE)
+			iint->flags &=
+			    ~(IMA_COLLECTED | IMA_APPRAISE | IMA_APPRAISED |
+			      IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK);
+		if (action & IMA_AUDIT)
+			iint->flags &=
+			    ~(IMA_COLLECTED | IMA_AUDIT | IMA_AUDITED);
+	}
 
 	/* Determine if already appraised/measured based on bitmask
 	 * (IMA_MEASURE, IMA_MEASURED, IMA_XXXX_APPRAISE, IMA_XXXX_APPRAISED,
-- 
2.13.6

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
