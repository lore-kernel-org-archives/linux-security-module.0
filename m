From: takondra@cisco.com (Taras Kondratiuk)
Date: Thu, 25 Jan 2018 03:27:48 +0000
Subject: [PATCH v2 08/15] initramfs: add newcx format
In-Reply-To: <1516850875-25066-1-git-send-email-takondra@cisco.com>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
Message-ID: <1516850875-25066-9-git-send-email-takondra@cisco.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Add 'newcx' format that adds extended attributes and increased size of
c_mtime and c_filesize fields.

Refer to Documentation/early-userspace/buffer-format.txt for detailed
format description.

Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
---
 init/initramfs.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 85 insertions(+), 10 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 7f0bbfde94e3..3d0f46c28459 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -54,6 +54,7 @@ static void __init error(char *x)
 /* link hash */
 
 #define N_ALIGN(len) ((((len) + 1) & ~3) + 2)
+#define X_ALIGN(len) ((len + 3) & ~3)
 
 static __initdata struct hash {
 	int ino, minor, major;
@@ -154,7 +155,8 @@ static void __init dir_utime(void)
 static __initdata time64_t mtime;
 static __initdata u32 ino, major, minor, nlink, rmajor, rminor;
 static __initdata umode_t mode;
-static __initdata u32 body_len, name_len;
+static __initdata u32 name_len, xattr_len;
+static __initdata u64 body_len, mtime_u64;
 static __initdata uid_t uid;
 static __initdata gid_t gid;
 static __initdata u32 mode_u32;
@@ -167,6 +169,12 @@ struct cpio_hdr_field {
 	const char *name;
 };
 
+static __initdata enum cpio_format {
+	CPIO_NO_MAGIC,
+	CPIO_NEWC,
+	CPIO_NEWCX,
+} cpio_format;
+
 #define HDR_FIELD(type, field, variable) \
 	{ .offset = offsetof(type, field) + \
 	  BUILD_BUG_ON_ZERO(sizeof(*(variable))*2 < FIELD_SIZEOF(type, field)),\
@@ -177,9 +185,11 @@ struct cpio_hdr_field {
 
 #define NEWC_FIELD(field, variable) \
 		HDR_FIELD(struct cpio_newc_header, field, variable)
+#define NEWCX_FIELD(field, variable) \
+		HDR_FIELD(struct cpio_newcx_header, field, variable)
 
-#define CPIO_MAX_HEADER_SIZE sizeof(struct cpio_newc_header)
-#define CPIO_MAX_FIELD_SIZE 8
+#define CPIO_MAX_HEADER_SIZE sizeof(struct cpio_newcx_header)
+#define CPIO_MAX_FIELD_SIZE 16
 #define CPIO_MAGIC_SIZE 6
 
 struct cpio_newc_header {
@@ -214,10 +224,44 @@ static struct cpio_hdr_field cpio_newc_header_info[] __initdata = {
 	{ 0 },
 };
 
+struct cpio_newcx_header {
+	char    c_ino[8];
+	char    c_mode[8];
+	char    c_uid[8];
+	char    c_gid[8];
+	char    c_nlink[8];
+	char    c_mtime[16];
+	char    c_filesize[16];
+	char    c_devmajor[8];
+	char    c_devminor[8];
+	char    c_rdevmajor[8];
+	char    c_rdevminor[8];
+	char    c_namesize[8];
+	char    c_xattrsize[8];
+};
+
+static struct cpio_hdr_field cpio_newcx_header_info[] __initdata = {
+	NEWCX_FIELD(c_ino, &ino),
+	NEWCX_FIELD(c_mode, &mode_u32),
+	NEWCX_FIELD(c_uid, &uid),
+	NEWCX_FIELD(c_gid, &gid),
+	NEWCX_FIELD(c_nlink, &nlink),
+	NEWCX_FIELD(c_mtime, &mtime_u64),
+	NEWCX_FIELD(c_filesize, &body_len),
+	NEWCX_FIELD(c_devmajor, &major),
+	NEWCX_FIELD(c_devminor, &minor),
+	NEWCX_FIELD(c_rdevmajor, &rmajor),
+	NEWCX_FIELD(c_rdevminor, &rminor),
+	NEWCX_FIELD(c_namesize, &name_len),
+	NEWCX_FIELD(c_xattrsize, &xattr_len),
+	{ 0 },
+};
+
 static void __init parse_header(char *s)
 {
 	char buf[CPIO_MAX_FIELD_SIZE + 1];
-	struct cpio_hdr_field *field = cpio_newc_header_info;
+	struct cpio_hdr_field *field = (cpio_format == CPIO_NEWC) ?
+		cpio_newc_header_info : cpio_newcx_header_info;
 
 	while (field->size) {
 		int ret = 0;
@@ -243,7 +287,15 @@ static void __init parse_header(char *s)
 			pr_err("invalid cpio header field (%d)", ret);
 		field++;
 	}
+
 	mode = mode_u32;
+	if (cpio_format == CPIO_NEWCX) {
+		/* Microseconds are ignored for now */
+		do_div(mtime_u64, USEC_PER_SEC);
+		mtime = mtime_u64;
+	} else {
+		xattr_len = 0;
+	}
 }
 
 /* FSM */
@@ -254,6 +306,7 @@ static int __init do_format(void);
 static int __init do_header(void);
 static int __init do_skip(void);
 static int __init do_name(void);
+static int __init do_xattrs(void);
 static int __init do_create(void);
 static int __init do_copy(void);
 static int __init do_symlink(void);
@@ -291,7 +344,7 @@ static void __init read_into(char *buf, unsigned size, fsm_state_t next)
 	}
 }
 
-static __initdata char *header_buf, *symlink_buf, *name_buf;
+static __initdata char *header_buf, *symlink_buf, *name_buf, *xattr_buf;
 
 static int __init do_start(void)
 {
@@ -315,22 +368,34 @@ static int __init do_collect(void)
 
 static int __init do_format(void)
 {
-	if (memcmp(collected, "070707", CPIO_MAGIC_SIZE) == 0) {
+	int header_size = 0;
+
+	cpio_format = CPIO_NO_MAGIC;
+
+	if (!memcmp(collected, "070707", CPIO_MAGIC_SIZE)) {
 		error("incorrect cpio method used: use -H newc option");
 		return 1;
+	} else if (!memcmp(collected, "070701", CPIO_MAGIC_SIZE)) {
+		cpio_format = CPIO_NEWC;
+		header_size = sizeof(struct cpio_newc_header);
+	} else if (!memcmp(collected, "070703", CPIO_MAGIC_SIZE)) {
+		cpio_format = CPIO_NEWCX;
+		header_size = sizeof(struct cpio_newcx_header);
 	}
-	if (memcmp(collected, "070701", CPIO_MAGIC_SIZE)) {
+
+	if (cpio_format == CPIO_NO_MAGIC) {
 		error("no cpio magic");
 		return 1;
 	}
-	read_into(header_buf, sizeof(struct cpio_newc_header), do_header);
+	read_into(header_buf, header_size, do_header);
 	return 0;
 }
 
 static int __init do_header(void)
 {
 	parse_header(collected);
-	next_header = this_header + N_ALIGN(name_len) + body_len;
+	next_header = this_header + N_ALIGN(name_len) + X_ALIGN(xattr_len) +
+		      body_len;
 	next_header = (next_header + 3) & ~3;
 	state = do_skip;
 	if (name_len <= 0 || name_len > PATH_MAX)
@@ -400,9 +465,17 @@ static int __init do_name(void)
 	}
 	memcpy_optional(name_buf, collected, N_ALIGN(name_len));
 	state = do_create;
+	if (xattr_len > 0)
+		read_into(xattr_buf, X_ALIGN(xattr_len), do_xattrs);
 	return 0;
 }
 
+static int __init do_xattrs(void)
+{
+	/* Do nothing for now */
+	state = do_create;
+	return 0;
+}
 
 static __initdata int wfd;
 
@@ -529,8 +602,9 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	header_buf = kmalloc(CPIO_MAX_HEADER_SIZE, GFP_KERNEL);
 	symlink_buf = kmalloc(PATH_MAX + 1, GFP_KERNEL);
 	name_buf = kmalloc(N_ALIGN(PATH_MAX), GFP_KERNEL);
+	xattr_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 
-	if (!header_buf || !symlink_buf || !name_buf)
+	if (!header_buf || !symlink_buf || !name_buf || !xattr_buf)
 		panic("can't allocate buffers");
 
 	state = do_start;
@@ -575,6 +649,7 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 		len -= my_inptr;
 	}
 	dir_utime();
+	kfree(xattr_buf);
 	kfree(name_buf);
 	kfree(symlink_buf);
 	kfree(header_buf);
-- 
2.10.3.dirty

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
