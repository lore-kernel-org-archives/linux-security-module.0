From: takondra@cisco.com (Taras Kondratiuk)
Date: Thu, 25 Jan 2018 03:27:51 +0000
Subject: [PATCH v2 11/15] gen_init_cpio: add newcx format
In-Reply-To: <1516850875-25066-1-git-send-email-takondra@cisco.com>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
Message-ID: <1516850875-25066-12-git-send-email-takondra@cisco.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Add "newcx" format that supports extended attributes and has increased
size of c_mtime and c_filesize fields.

Added -x option to select "newcx" format. Default is "newc".

Refer to Documentation/early-userspace/buffer-format.txt for detailed
format description.

Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
---
 usr/gen_init_cpio.c | 70 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 21 deletions(-)

diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index 7a2a6d85345d..78a47a5bdcb1 100644
--- a/usr/gen_init_cpio.c
+++ b/usr/gen_init_cpio.c
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <ctype.h>
 #include <limits.h>
+#include <assert.h>
 
 /*
  * Original work by Jeff Garzik
@@ -21,6 +22,8 @@
 #define xstr(s) #s
 #define str(s) xstr(s)
 
+static int newcx;
+static unsigned int cpio_hdr_size;
 static unsigned int offset;
 static unsigned int ino = 721;
 static time_t default_mtime;
@@ -56,7 +59,7 @@ static void push_rest(const char *name)
 	putchar(0);
 	offset += name_len;
 
-	tmp_ofs = name_len + 110;
+	tmp_ofs = name_len + cpio_hdr_size;
 	while (tmp_ofs & 3) {
 		putchar(0);
 		offset++;
@@ -77,6 +80,7 @@ struct cpio_header {
 	int rdevmajor;
 	int rdevminor;
 	size_t namesize;
+	size_t xattrsize;
 	unsigned int check;
 };
 
@@ -84,24 +88,44 @@ static void push_hdr(const struct cpio_header *hdr)
 {
 	char s[256];
 
-	sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX"
-		   "%08X%08X%08X%08X%08X%08X%08X",
-		"070701",
-		hdr->ino,
-		hdr->mode,
-		(long)hdr->uid,
-		(long)hdr->gid,
-		hdr->nlink,
-		(long)hdr->mtime,
-		(unsigned int)hdr->filesize,
-		hdr->devmajor,
-		hdr->devminor,
-		hdr->rdevmajor,
-		hdr->rdevminor,
-		(unsigned int)hdr->namesize,
-		hdr->check);
+	if (newcx) {
+		sprintf(s, "%s%08X%08X%08lX%08lX%08X%016llX"
+			   "%016llX%08X%08X%08X%08X%08X%08X",
+			"070703",
+			hdr->ino,
+			hdr->mode,
+			(long)hdr->uid,
+			(long)hdr->gid,
+			hdr->nlink,
+			hdr->mtime * 1000000ULL,
+			(long long)hdr->filesize,
+			hdr->devmajor,
+			hdr->devminor,
+			hdr->rdevmajor,
+			hdr->rdevminor,
+			(unsigned int)hdr->namesize,
+			(unsigned int)hdr->xattrsize);
+	} else {
+		sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX"
+			   "%08X%08X%08X%08X%08X%08X%08X",
+			"070701",
+			hdr->ino,
+			hdr->mode,
+			(long)hdr->uid,
+			(long)hdr->gid,
+			hdr->nlink,
+			(long)hdr->mtime,
+			(unsigned int)hdr->filesize,
+			hdr->devmajor,
+			hdr->devminor,
+			hdr->rdevmajor,
+			hdr->rdevminor,
+			(unsigned int)hdr->namesize,
+			hdr->check);
+	}
 	fputs(s, stdout);
-	offset += 110;
+	assert((offset & 3) == 0);
+	offset += cpio_hdr_size;
 }
 
 static void cpio_trailer(void)
@@ -301,7 +325,7 @@ static int cpio_mkfile(const char *name, const char *location,
 {
 	char *filebuf = NULL;
 	struct stat buf;
-	long size;
+	size_t size;
 	int file = -1;
 	int retval;
 	int rc = -1;
@@ -450,7 +474,7 @@ static int cpio_mkfile_line(const char *line)
 static void usage(const char *prog)
 {
 	fprintf(stderr, "Usage:\n"
-		"\t%s [-t <timestamp>] <cpio_list>\n"
+		"\t%s [-t <timestamp>] [-x] <cpio_list>\n"
 		"\n"
 		"<cpio_list> is a file containing newline separated entries that\n"
 		"describe the files to be included in the initramfs archive:\n"
@@ -527,7 +551,7 @@ int main (int argc, char *argv[])
 
 	default_mtime = time(NULL);
 	while (1) {
-		int opt = getopt(argc, argv, "t:h");
+		int opt = getopt(argc, argv, "t:h:x");
 		char *invalid;
 
 		if (opt == -1)
@@ -542,12 +566,16 @@ int main (int argc, char *argv[])
 				exit(1);
 			}
 			break;
+		case 'x':
+			newcx = 1;
+			break;
 		case 'h':
 		case '?':
 			usage(argv[0]);
 			exit(opt == 'h' ? 0 : 1);
 		}
 	}
+	cpio_hdr_size = newcx ? 134 : 110;
 
 	if (argc - optind != 1) {
 		usage(argv[0]);
-- 
2.10.3.dirty

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
