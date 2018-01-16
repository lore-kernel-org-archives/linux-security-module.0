From: alban.crequy@gmail.com (Alban Crequy)
Date: Tue, 16 Jan 2018 11:41:21 +0100
Subject: [PATCH] ima,fuse: introduce new fs flag FS_NO_IMA_CACHE
In-Reply-To: <20180115144804.GA28856@infradead.org>
References: <20180115144804.GA28856@infradead.org>
Message-ID: <20180116104121.4231-1-alban@kinvolk.io>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Alban Crequy <alban@kinvolk.io>

This patch forces files to be re-measured, re-appraised and re-audited
on file systems with the feature flag FS_NO_IMA_CACHE. In that way,
cached integrity results won't be used.

For now, only FUSE filesystems use this flag. This is because the
userspace FUSE process can change the underlying files at any times.

This patch is based on the patch "ima: define a new policy option
named force" by Mimi. [1]

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

The test was done using the branch "alban/fuse-flag-ima-nocache" [4].

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
$ sudo cat /sys/kernel/security/ima/ascii_runtime_measurements|grep
/mnt/memfs/prog
10 7ac5aed52061cb09120e977c6d04ee5c7b11c371 ima-ng
sha1:ac14c9268cd2811f7a5adea17b27d84f50e1122c /mnt/memfs/prog1
10 9acc17a9a32aec4a676b8f6558e17a3d6c9a78e6 ima-ng
sha1:799cb5d1e06d5c37ae7a76ba25ecd1bd01476383 /mnt/memfs/prog2

6. Use the backdoor command in my patched memfs to redirect file
operations on file handle 3 to file handle 2:
rm -f  /tmp/memfs-switch* ; touch /tmp/memfs-switch-3-2

7. Check how the FUSE driver serves different content for the files:
$ /mnt/memfs/prog1
hello world: 2
$ /mnt/memfs/prog2
hello world: 2

8. Check the measurements:
sudo cat /sys/kernel/security/ima/ascii_runtime_measurements|grep
/mnt/memfs/prog

Without the patch, there are no new measurements, despite the FUSE
driver having served different executables.

With the patch, I can see additional measurements for prog1 and prog2
with the hashes reversed when the FUSE driver served the alternative
content.

====

[1] https://www.spinics.net/lists/linux-integrity/msg00948.html
[2] https://github.com/bbengfort/memfs
[3] https://github.com/kinvolk/memfs/commits/alban/switch-files
[4] https://github.com/kinvolk/linux/commits/alban/fuse-flag-ima-nocache
[5] https://github.com/kinvolk/fuse-userns-patches/commit/cf1f5750cab0

Cc: linux-integrity at vger.kernel.org
Cc: linux-security-module at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Seth Forshee <seth.forshee@canonical.com>
Cc: Christoph Hellwig <hch@infradead.org>
Tested-by: Dongsu Park <dongsu@kinvolk.io>
Signed-off-by: Alban Crequy <alban@kinvolk.io>
---
 fs/fuse/inode.c                   |  2 +-
 include/linux/fs.h                |  1 +
 security/integrity/ima/ima_main.c | 11 +++++++----
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8c98edee3628..b511e6469b0a 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1212,7 +1212,7 @@ static void fuse_kill_sb_anon(struct super_block *sb)
 static struct file_system_type fuse_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "fuse",
-	.fs_flags	= FS_HAS_SUBTYPE | FS_USERNS_MOUNT,
+	.fs_flags	= FS_HAS_SUBTYPE | FS_USERNS_MOUNT | FS_NO_IMA_CACHE,
 	.mount		= fuse_mount,
 	.kill_sb	= fuse_kill_sb_anon,
 };
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fce19c491970..88da6908a2b2 100644
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
index 88af481502f7..e6e45ab15dfc 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/xattr.h>
 #include <linux/ima.h>
+#include <linux/fs.h>
 
 #include "ima.h"
 
@@ -229,13 +230,15 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 				 IMA_ACTION_FLAGS);
 
 	/*
-	 * Reset the measure, appraise and audit cached flags either if
-	 * ima_inode_setxattr was called or based on policy, forcing
-	 * the file to be re-evaluated.
+	 * Reset the measure, appraise and audit cached flags either if:
+	 * - ima_inode_setxattr was called, or
+	 * - based on policy ("force"), or
+	 * - based on filesystem feature flag
+	 * forcing the file to be re-evaluated.
 	 */
 	if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags)) {
 		iint->flags &= ~IMA_DONE_MASK;
-	} else if (action & IMA_FORCE) {
+	} else if (action & IMA_FORCE || inode->i_sb->s_type->fs_flags & FS_NO_IMA_CACHE) {
 		if (action & IMA_MEASURE) {
 			iint->measured_pcrs = 0;
 			iint->flags &=
-- 
2.13.6

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
