From: takondra@cisco.com (Taras Kondratiuk)
Date: Thu, 25 Jan 2018 03:27:52 +0000
Subject: [PATCH v2 12/15] gen_init_cpio: set extended attributes for newcx
	format
In-Reply-To: <1516850875-25066-1-git-send-email-takondra@cisco.com>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
Message-ID: <1516850875-25066-13-git-send-email-takondra@cisco.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

gen_init_cpio creates CPIO archive according to cpio_list manifest file
that contains list of archive entries (one per line). To be able to
store extended attributes in newcx CPIO format we need to pass them via
cpio_list file.

One way of doing it would be to append xattrs to each entry line, but
"file" lines have a variable number of elements because of hardlinks. It
is not obvious how to mark end of hardlinks and start of xattrs in this
case.

This patch introduces a new entry type: "xattr". Each "xattr" line
specify one name=value pair. xattr values are applied to the next
non-xattr line. There can be multiple "xattr" lines before non-xattr
line.

It may be more logical to have xattr lines after corresponding
file entry, but it makes parsing a bit more complex and needs more
intrusive changes.

Xattr value is hex-encoded (see getfattr(1)). Plain string variant would
be easier to read, but special symbols have to be escaped. Hex encoding
is much simpler.

Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
---
 usr/gen_init_cpio.c | 142 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 119 insertions(+), 23 deletions(-)

diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index 78a47a5bdcb1..e356f9e532a2 100644
--- a/usr/gen_init_cpio.c
+++ b/usr/gen_init_cpio.c
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <ctype.h>
 #include <limits.h>
+#include <sys/xattr.h>
 #include <assert.h>
 
 /*
@@ -50,21 +51,10 @@ static void push_pad (void)
 	}
 }
 
-static void push_rest(const char *name)
+static void push_string_padded(const char *name)
 {
-	unsigned int name_len = strlen(name) + 1;
-	unsigned int tmp_ofs;
-
-	fputs(name, stdout);
-	putchar(0);
-	offset += name_len;
-
-	tmp_ofs = name_len + cpio_hdr_size;
-	while (tmp_ofs & 3) {
-		putchar(0);
-		offset++;
-		tmp_ofs++;
-	}
+	push_string(name);
+	push_pad();
 }
 
 struct cpio_header {
@@ -137,7 +127,7 @@ static void cpio_trailer(void)
 	};
 
 	push_hdr(&hdr);
-	push_rest(name);
+	push_string_padded(name);
 
 	while (offset % 512) {
 		putchar(0);
@@ -145,6 +135,96 @@ static void cpio_trailer(void)
 	}
 }
 
+struct xattr_hdr {
+	char c_size[8]; /* total size including c_size field */
+	char c_data[];
+};
+static unsigned int xattr_buflen;
+static char xattr_buf[4096];
+
+static void push_xattrs(void)
+{
+	if (!newcx || !xattr_buflen)
+		return;
+
+	if (fwrite(xattr_buf, xattr_buflen, 1, stdout) != 1)
+		fprintf(stderr, "writing xattrs failed\n");
+	offset += xattr_buflen;
+	xattr_buflen = 0;
+
+	push_pad();
+}
+
+static int convert_hex_string(const char *hex_str, char *out, size_t out_size)
+{
+	char buf[3];
+	size_t str_len = strlen(hex_str);
+
+	if (str_len % 2 != 0 || str_len / 2 > out_size)
+		return 0;
+
+	buf[2] = '\0';
+	while (*hex_str != '\0') {
+		buf[0] = *hex_str++;
+		buf[1] = *hex_str++;
+		*out++ = (char)strtol(buf, NULL, 16);
+	}
+
+	return str_len / 2;
+}
+
+static int collect_xattr(const char *line)
+{
+	const char *name, *value;
+	size_t name_len, value_len;
+	char *buf = xattr_buf + xattr_buflen;
+	struct xattr_hdr *hdr = (struct xattr_hdr *)buf;
+	char *bufend = xattr_buf + sizeof(xattr_buf);
+	char *value_buf;
+	size_t xattr_entry_size;
+	char size_str[sizeof(hdr->c_size) + 1];
+
+	if (!newcx)
+		return 0;
+
+	name = line;
+	value = strchr(line, '=');
+	if (!value) {
+		fprintf(stderr, "Unrecognized xattr format '%s'", line);
+		return -1;
+	}
+	name_len = value - name;
+	value++;
+
+	/*
+	 * For now we support only hex encoded values.
+	 * String or base64 can be added later.
+	 */
+	if (strncmp(value, "0x", 2)) {
+		fprintf(stderr,
+			"Only hex encoded xattr value is supported '%s'",
+			value);
+		return -1;
+	}
+
+	value += 2;
+	value_buf = buf + sizeof(struct xattr_hdr) + name_len + 1;
+	value_len = convert_hex_string(value, value_buf, bufend - value_buf);
+	if (value_len == 0) {
+		fprintf(stderr, "Failed to parse xattr value '%s'", line);
+		return -1;
+	}
+	xattr_entry_size = sizeof(struct xattr_hdr) + name_len + 1 + value_len;
+
+	sprintf(size_str, "%08X", (unsigned int)xattr_entry_size);
+	memcpy(hdr->c_size, size_str, sizeof(hdr->c_size));
+	memcpy(hdr->c_data, name, name_len);
+	hdr->c_data[name_len] = '\0';
+	xattr_buflen += xattr_entry_size;
+
+	return 0;
+}
+
 static int cpio_mkslink(const char *name, const char *target,
 			 unsigned int mode, uid_t uid, gid_t gid)
 {
@@ -161,12 +241,12 @@ static int cpio_mkslink(const char *name, const char *target,
 		.devmajor = 3,
 		.devminor = 1,
 		.namesize = strlen(name)+1,
+		.xattrsize = xattr_buflen,
 	};
 	push_hdr(&hdr);
-	push_string(name);
-	push_pad();
-	push_string(target);
-	push_pad();
+	push_string_padded(name);
+	push_xattrs();
+	push_string_padded(target);
 	return 0;
 }
 
@@ -203,9 +283,11 @@ static int cpio_mkgeneric(const char *name, unsigned int mode,
 		.devmajor = 3,
 		.devminor = 1,
 		.namesize = strlen(name)+1,
+		.xattrsize = xattr_buflen,
 	};
 	push_hdr(&hdr);
-	push_rest(name);
+	push_string_padded(name);
+	push_xattrs();
 	return 0;
 }
 
@@ -292,9 +374,11 @@ static int cpio_mknod(const char *name, unsigned int mode,
 		.rdevmajor = maj,
 		.rdevminor = min,
 		.namesize = strlen(name)+1,
+		.xattrsize = xattr_buflen,
 	};
 	push_hdr(&hdr);
-	push_rest(name);
+	push_string_padded(name);
+	push_xattrs();
 	return 0;
 }
 
@@ -377,10 +461,13 @@ static int cpio_mkfile(const char *name, const char *location,
 			.devmajor = 3,
 			.devminor = 1,
 			.namesize = namesize,
+			/* xattrs go on last link */
+			.xattrsize = (i == nlinks) ? xattr_buflen : 0,
 		};
 		push_hdr(&hdr);
-		push_string(name);
-		push_pad();
+		push_string_padded(name);
+		if (hdr.xattrsize)
+			push_xattrs();
 
 		if (size) {
 			if (fwrite(filebuf, size, 1, stdout) != 1) {
@@ -486,6 +573,8 @@ static void usage(const char *prog)
 		"slink <name> <target> <mode> <uid> <gid>\n"
 		"pipe <name> <mode> <uid> <gid>\n"
 		"sock <name> <mode> <uid> <gid>\n"
+		"# xattr line is applied to the next non-xattr entry\n"
+		"xattr <xattr_name>=<xattr_val>\n"
 		"\n"
 		"<name>       name of the file/dir/nod/etc in the archive\n"
 		"<location>   location of the file in the current filesystem\n"
@@ -498,12 +587,16 @@ static void usage(const char *prog)
 		"<maj>        major number of nod\n"
 		"<min>        minor number of nod\n"
 		"<hard links> space separated list of other links to file\n"
+		"<xattr_name> extended attribute name\n"
+		"<xattr_val>  hex-encoded extended attribute value\n"
 		"\n"
 		"example:\n"
 		"# A simple initramfs\n"
 		"dir /dev 0755 0 0\n"
 		"nod /dev/console 0600 0 0 c 5 1\n"
 		"dir /root 0700 0 0\n"
+		"# set SELinux label 'system_u:object_r:bin_t:s0' for /sbin directory\n"
+		"xattr security.selinux=0x73797374656d5f753a6f626a6563745f723a62696e5f743a733000\n"
 		"dir /sbin 0755 0 0\n"
 		"file /sbin/kinit /usr/src/klibc/kinit/kinit 0755 0 0\n"
 		"\n"
@@ -533,6 +626,9 @@ struct file_handler file_handler_table[] = {
 		.type    = "sock",
 		.handler = cpio_mksock_line,
 	}, {
+		.type    = "xattr",
+		.handler = collect_xattr,
+	}, {
 		.type    = NULL,
 		.handler = NULL,
 	}
-- 
2.10.3.dirty

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
