From: takondra@cisco.com (Taras Kondratiuk)
Date: Thu, 25 Jan 2018 03:27:50 +0000
Subject: [PATCH v2 10/15] gen_init_cpio: move header formatting into function
In-Reply-To: <1516850875-25066-1-git-send-email-takondra@cisco.com>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
Message-ID: <1516850875-25066-11-git-send-email-takondra@cisco.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

CPIO header is generated in multiple places with the same sprintf()
format string. Move formatting into a single function in preparation
to adding a new cpio format.

Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
---
 usr/gen_init_cpio.c | 186 ++++++++++++++++++++++++++--------------------------
 1 file changed, 92 insertions(+), 94 deletions(-)

diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index 03b21189d58b..7a2a6d85345d 100644
--- a/usr/gen_init_cpio.c
+++ b/usr/gen_init_cpio.c
@@ -64,34 +64,55 @@ static void push_rest(const char *name)
 	}
 }
 
-static void push_hdr(const char *s)
+struct cpio_header {
+	unsigned int ino;
+	unsigned int mode;
+	uid_t uid;
+	gid_t gid;
+	unsigned int nlink;
+	time_t mtime;
+	size_t filesize;
+	int devmajor;
+	int devminor;
+	int rdevmajor;
+	int rdevminor;
+	size_t namesize;
+	unsigned int check;
+};
+
+static void push_hdr(const struct cpio_header *hdr)
 {
+	char s[256];
+
+	sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX"
+		   "%08X%08X%08X%08X%08X%08X%08X",
+		"070701",
+		hdr->ino,
+		hdr->mode,
+		(long)hdr->uid,
+		(long)hdr->gid,
+		hdr->nlink,
+		(long)hdr->mtime,
+		(unsigned int)hdr->filesize,
+		hdr->devmajor,
+		hdr->devminor,
+		hdr->rdevmajor,
+		hdr->rdevminor,
+		(unsigned int)hdr->namesize,
+		hdr->check);
 	fputs(s, stdout);
 	offset += 110;
 }
 
 static void cpio_trailer(void)
 {
-	char s[256];
 	const char name[] = "TRAILER!!!";
+	struct cpio_header hdr = {
+		.nlink = 1,
+		.namesize = strlen(name)+1,
+	};
 
-	sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08X%08X",
-		"070701",		/* magic */
-		0,			/* ino */
-		0,			/* mode */
-		(long) 0,		/* uid */
-		(long) 0,		/* gid */
-		1,			/* nlink */
-		(long) 0,		/* mtime */
-		0,			/* filesize */
-		0,			/* major */
-		0,			/* minor */
-		0,			/* rmajor */
-		0,			/* rminor */
-		(unsigned)strlen(name)+1, /* namesize */
-		0);			/* chksum */
-	push_hdr(s);
+	push_hdr(&hdr);
 	push_rest(name);
 
 	while (offset % 512) {
@@ -103,27 +124,21 @@ static void cpio_trailer(void)
 static int cpio_mkslink(const char *name, const char *target,
 			 unsigned int mode, uid_t uid, gid_t gid)
 {
-	char s[256];
-
 	if (name[0] == '/')
 		name++;
-	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08X%08X",
-		"070701",		/* magic */
-		ino++,			/* ino */
-		S_IFLNK | mode,		/* mode */
-		(long) uid,		/* uid */
-		(long) gid,		/* gid */
-		1,			/* nlink */
-		(long) default_mtime,	/* mtime */
-		(unsigned)strlen(target)+1, /* filesize */
-		3,			/* major */
-		1,			/* minor */
-		0,			/* rmajor */
-		0,			/* rminor */
-		(unsigned)strlen(name) + 1,/* namesize */
-		0);			/* chksum */
-	push_hdr(s);
+	struct cpio_header hdr = {
+		.ino = ino++,
+		.mode = S_IFLNK | mode,
+		.uid = uid,
+		.gid = gid,
+		.nlink = 1,
+		.mtime = default_mtime,
+		.filesize = strlen(target)+1,
+		.devmajor = 3,
+		.devminor = 1,
+		.namesize = strlen(name)+1,
+	};
+	push_hdr(&hdr);
 	push_string(name);
 	push_pad();
 	push_string(target);
@@ -152,27 +167,20 @@ static int cpio_mkslink_line(const char *line)
 static int cpio_mkgeneric(const char *name, unsigned int mode,
 		       uid_t uid, gid_t gid)
 {
-	char s[256];
-
 	if (name[0] == '/')
 		name++;
-	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08X%08X",
-		"070701",		/* magic */
-		ino++,			/* ino */
-		mode,			/* mode */
-		(long) uid,		/* uid */
-		(long) gid,		/* gid */
-		2,			/* nlink */
-		(long) default_mtime,	/* mtime */
-		0,			/* filesize */
-		3,			/* major */
-		1,			/* minor */
-		0,			/* rmajor */
-		0,			/* rminor */
-		(unsigned)strlen(name) + 1,/* namesize */
-		0);			/* chksum */
-	push_hdr(s);
+	struct cpio_header hdr = {
+		.ino = ino++,
+		.mode = mode,
+		.uid = uid,
+		.gid = gid,
+		.nlink = 2,
+		.mtime = default_mtime,
+		.devmajor = 3,
+		.devminor = 1,
+		.namesize = strlen(name)+1,
+	};
+	push_hdr(&hdr);
 	push_rest(name);
 	return 0;
 }
@@ -241,8 +249,6 @@ static int cpio_mknod(const char *name, unsigned int mode,
 		       uid_t uid, gid_t gid, char dev_type,
 		       unsigned int maj, unsigned int min)
 {
-	char s[256];
-
 	if (dev_type == 'b')
 		mode |= S_IFBLK;
 	else
@@ -250,23 +256,20 @@ static int cpio_mknod(const char *name, unsigned int mode,
 
 	if (name[0] == '/')
 		name++;
-	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08X%08X",
-		"070701",		/* magic */
-		ino++,			/* ino */
-		mode,			/* mode */
-		(long) uid,		/* uid */
-		(long) gid,		/* gid */
-		1,			/* nlink */
-		(long) default_mtime,	/* mtime */
-		0,			/* filesize */
-		3,			/* major */
-		1,			/* minor */
-		maj,			/* rmajor */
-		min,			/* rminor */
-		(unsigned)strlen(name) + 1,/* namesize */
-		0);			/* chksum */
-	push_hdr(s);
+	struct cpio_header hdr = {
+		.ino = ino++,
+		.mode = mode,
+		.uid = uid,
+		.gid = gid,
+		.nlink = 1,
+		.mtime = default_mtime,
+		.devmajor = 3,
+		.devminor = 1,
+		.rdevmajor = maj,
+		.rdevminor = min,
+		.namesize = strlen(name)+1,
+	};
+	push_hdr(&hdr);
 	push_rest(name);
 	return 0;
 }
@@ -296,7 +299,6 @@ static int cpio_mkfile(const char *name, const char *location,
 			unsigned int mode, uid_t uid, gid_t gid,
 			unsigned int nlinks)
 {
-	char s[256];
 	char *filebuf = NULL;
 	struct stat buf;
 	long size;
@@ -340,23 +342,19 @@ static int cpio_mkfile(const char *name, const char *location,
 		if (name[0] == '/')
 			name++;
 		namesize = strlen(name) + 1;
-		sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
-		       "%08lX%08X%08X%08X%08X%08X%08X",
-			"070701",		/* magic */
-			ino,			/* ino */
-			mode,			/* mode */
-			(long) uid,		/* uid */
-			(long) gid,		/* gid */
-			nlinks,			/* nlink */
-			(long) buf.st_mtime,	/* mtime */
-			size,			/* filesize */
-			3,			/* major */
-			1,			/* minor */
-			0,			/* rmajor */
-			0,			/* rminor */
-			namesize,		/* namesize */
-			0);			/* chksum */
-		push_hdr(s);
+		struct cpio_header hdr = {
+			.ino = ino,
+			.mode = mode,
+			.uid = uid,
+			.gid = gid,
+			.nlink = nlinks,
+			.mtime = buf.st_mtime,
+			.filesize = size,
+			.devmajor = 3,
+			.devminor = 1,
+			.namesize = namesize,
+		};
+		push_hdr(&hdr);
 		push_string(name);
 		push_pad();
 
-- 
2.10.3.dirty

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
