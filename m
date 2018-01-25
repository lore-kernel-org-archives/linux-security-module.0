From: takondra@cisco.com (Taras Kondratiuk)
Date: Thu, 25 Jan 2018 03:27:49 +0000
Subject: [PATCH v2 09/15] initramfs: set extended attributes
In-Reply-To: <1516850875-25066-1-git-send-email-takondra@cisco.com>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
Message-ID: <1516850875-25066-10-git-send-email-takondra@cisco.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Mimi Zohar <zohar@linux.vnet.ibm.com>

This patch writes out the extended attributes included in the cpio file.
As the "security.ima" xattr needs to be written after the file data.
this patch separates extracting and setting the xattrs by defining new
do_setxattrs state.

[kamensky: fixed restoring of xattrs for symbolic links by using
           sys_lsetxattr() instead of sys_setxattr()]

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Victor Kamensky <kamensky@cisco.com>
Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
---
 init/initramfs.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 3d0f46c28459..040e26cf451a 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -310,6 +310,7 @@ static int __init do_xattrs(void);
 static int __init do_create(void);
 static int __init do_copy(void);
 static int __init do_symlink(void);
+static int __init do_setxattrs(void);
 static int __init do_reset(void);
 
 typedef int (*fsm_state_t)(void);
@@ -472,7 +473,7 @@ static int __init do_name(void)
 
 static int __init do_xattrs(void)
 {
-	/* Do nothing for now */
+	memcpy_optional(xattr_buf, collected, xattr_len);
 	state = do_create;
 	return 0;
 }
@@ -481,8 +482,7 @@ static __initdata int wfd;
 
 static int __init do_create(void)
 {
-	state = do_skip;
-	next_state = do_reset;
+	state = do_setxattrs;
 	clean_path(name_buf, mode);
 	if (S_ISREG(mode)) {
 		int ml = maybe_link(name_buf);
@@ -515,8 +515,11 @@ static int __init do_create(void)
 			do_utime(name_buf, mtime);
 		}
 	} else if (S_ISLNK(mode)) {
-		if (body_len > PATH_MAX)
+		if (body_len > PATH_MAX) {
+			state = do_skip;
+			next_state = do_reset;
 			return 0;
+		}
 		read_into(symlink_buf, body_len, do_symlink);
 	}
 	return 0;
@@ -530,7 +533,7 @@ static int __init do_copy(void)
 		sys_close(wfd);
 		do_utime(name_buf, mtime);
 		eat(body_len);
-		state = do_skip;
+		state = do_setxattrs;
 		return 0;
 	} else {
 		if (xwrite(wfd, victim, byte_count) != byte_count)
@@ -549,8 +552,52 @@ static int __init do_symlink(void)
 	sys_symlink(symlink_buf, name_buf);
 	sys_lchown(name_buf, uid, gid);
 	do_utime(name_buf, mtime);
+	state = do_setxattrs;
+	return 0;
+}
+
+struct xattr_hdr {
+	char c_size[8]; /* total size including c_size field */
+	char c_data[];  /* <name>\0<value> */
+};
+
+static int __init do_setxattrs(void)
+{
+	char *buf = xattr_buf;
+	char *bufend = buf + xattr_len;
+	struct xattr_hdr *hdr;
+	char str[sizeof(hdr->c_size) + 1];
+
 	state = do_skip;
 	next_state = do_reset;
+	if (!xattr_len)
+		return 0;
+
+	str[sizeof(hdr->c_size)] = 0;
+
+	while (buf < bufend) {
+		char *xattr_name, *xattr_value;
+		unsigned long xattr_entry_size, xattr_value_size;
+		int ret;
+
+		hdr = (struct xattr_hdr *)buf;
+		memcpy(str, hdr->c_size, sizeof(hdr->c_size));
+		ret = kstrtoul(str, 16, &xattr_entry_size);
+		buf += xattr_entry_size;
+		if (ret || buf > bufend) {
+			error("malformed xattrs");
+			break;
+		}
+
+		xattr_name = hdr->c_data;
+		xattr_value = xattr_name + strlen(xattr_name) + 1;
+		xattr_value_size = buf - xattr_value;
+
+		ret = sys_lsetxattr(name_buf, xattr_name, xattr_value,
+				xattr_value_size, 0);
+		pr_debug("%s: %s size: %lu val: %s (ret: %d)\n", name_buf,
+				xattr_name, xattr_value_size, xattr_value, ret);
+	}
 	return 0;
 }
 
-- 
2.10.3.dirty

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
