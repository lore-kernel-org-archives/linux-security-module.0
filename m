From: takondra@cisco.com (Taras Kondratiuk)
Date: Thu, 25 Jan 2018 03:27:44 +0000
Subject: [PATCH v2 04/15] initramfs: remove unnecessary symlinks processing
	shortcut
In-Reply-To: <1516850875-25066-1-git-send-email-takondra@cisco.com>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
Message-ID: <1516850875-25066-5-git-send-email-takondra@cisco.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Special handling of symlinks in do_header() assumes that name and body
entries are sequential and reads them together. This shortcut has no
real performance benefits, but it complicates changes to the state
machine.

Make handling of symlinks more similar to a regular files. Store name
in name_buf and destination in symlink_buf.

Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
---
 init/initramfs.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index b6ee675e5cdb..d0ab7ad6ac05 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -266,16 +266,7 @@ static int __init do_header(void)
 	state = do_skip;
 	if (name_len <= 0 || name_len > PATH_MAX)
 		return 0;
-	if (S_ISLNK(mode)) {
-		if (body_len > PATH_MAX)
-			return 0;
-		collect = collected = symlink_buf;
-		remains = N_ALIGN(name_len) + body_len;
-		next_state = do_symlink;
-		state = do_collect;
-		return 0;
-	}
-	if (S_ISREG(mode) || !body_len)
+	if (S_ISREG(mode) || S_ISLNK(mode) || !body_len)
 		read_into(name_buf, N_ALIGN(name_len), do_name);
 	return 0;
 }
@@ -372,6 +363,11 @@ static int __init do_name(void)
 			sys_chmod(collected, mode);
 			do_utime(collected, mtime);
 		}
+	} else if (S_ISLNK(mode)) {
+		if (body_len > PATH_MAX)
+			return 0;
+		memcpy_optional(name_buf, collected, N_ALIGN(name_len));
+		read_into(symlink_buf, body_len, do_symlink);
 	}
 	return 0;
 }
@@ -397,11 +393,12 @@ static int __init do_copy(void)
 
 static int __init do_symlink(void)
 {
-	collected[N_ALIGN(name_len) + body_len] = '\0';
-	clean_path(collected, 0);
-	sys_symlink(collected + N_ALIGN(name_len), collected);
-	sys_lchown(collected, uid, gid);
-	do_utime(collected, mtime);
+	memcpy_optional(symlink_buf, collected, body_len);
+	symlink_buf[body_len] = '\0';
+	clean_path(name_buf, 0);
+	sys_symlink(symlink_buf, name_buf);
+	sys_lchown(name_buf, uid, gid);
+	do_utime(name_buf, mtime);
 	state = do_skip;
 	next_state = do_reset;
 	return 0;
@@ -453,7 +450,7 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	static __initdata char msg_buf[64];
 
 	header_buf = kmalloc(110, GFP_KERNEL);
-	symlink_buf = kmalloc(PATH_MAX + N_ALIGN(PATH_MAX) + 1, GFP_KERNEL);
+	symlink_buf = kmalloc(PATH_MAX + 1, GFP_KERNEL);
 	name_buf = kmalloc(N_ALIGN(PATH_MAX), GFP_KERNEL);
 
 	if (!header_buf || !symlink_buf || !name_buf)
-- 
2.10.3.dirty

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
