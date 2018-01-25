From: takondra@cisco.com (Taras Kondratiuk)
Date: Thu, 25 Jan 2018 03:27:41 +0000
Subject: [PATCH v2 01/15] Documentation: add newcx initramfs format description
In-Reply-To: <1516850875-25066-1-git-send-email-takondra@cisco.com>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
Message-ID: <1516850875-25066-2-git-send-email-takondra@cisco.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Many of the Linux security/integrity features are dependent on file
metadata, stored as extended attributes (xattrs), for making decisions.
These features need to be initialized during initcall and enabled as
early as possible for complete security coverage.

Initramfs (tmpfs) supports xattrs, but newc CPIO archive format does not
support including them into the archive.

This patch describes "extended" newc format (newcx) that is based on
newc and has following changes:
- extended attributes support
- increased size of filesize to support files >4GB.
- increased mtime field size to have usec precision and more than
  32-bit of seconds.
- removed unused checksum field.

Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Victor Kamensky <kamensky@cisco.com>
---
 Documentation/early-userspace/buffer-format.txt | 46 ++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/Documentation/early-userspace/buffer-format.txt b/Documentation/early-userspace/buffer-format.txt
index e1fd7f9dad16..d818df4f72dc 100644
--- a/Documentation/early-userspace/buffer-format.txt
+++ b/Documentation/early-userspace/buffer-format.txt
@@ -24,6 +24,7 @@ grammar, where:
 	+	indicates concatenation
 	GZIP()	indicates the gzip(1) of the operand
 	ALGN(n)	means padding with null bytes to an n-byte boundary
+	[n]	means size of field is n bytes
 
 	initramfs  := ("\0" | cpio_archive | cpio_gzip_archive)*
 
@@ -31,20 +32,29 @@ grammar, where:
 
 	cpio_archive := cpio_file* + (<nothing> | cpio_trailer)
 
-	cpio_file := ALGN(4) + cpio_header + filename + "\0" + ALGN(4) + data
+	cpio_file := (cpio_newc_file | cpio_newcx_file)
+
+	cpio_newc_file := ALGN(4) + cpio_newc_header + filename + "\0" + \
+			  ALGN(4) + data
+
+	cpio_newcx_file := ALGN(4) + cpio_newcx_header + filename + "\0" + \
+			   ALGN(4) + xattrs + ALGN(4) + data
+
+	xattrs := xattr_entry*
+
+	xattr_entry := xattr_size[8] + xattr_name + "\0" + xattr_value
 
 	cpio_trailer := ALGN(4) + cpio_header + "TRAILER!!!\0" + ALGN(4)
 
 
 In human terms, the initramfs buffer contains a collection of
-compressed and/or uncompressed cpio archives (in the "newc" or "crc"
-formats); arbitrary amounts zero bytes (for padding) can be added
-between members.
+compressed and/or uncompressed cpio archives; arbitrary amounts
+zero bytes (for padding) can be added between members.
 
 The cpio "TRAILER!!!" entry (cpio end-of-archive) is optional, but is
 not ignored; see "handling of hard links" below.
 
-The structure of the cpio_header is as follows (all fields contain
+The structure of the cpio_newc_header is as follows (all fields contain
 hexadecimal ASCII numbers fully padded with '0' on the left to the
 full width of the field, for example, the integer 4780 is represented
 by the ASCII string "000012ac"):
@@ -81,6 +91,32 @@ algorithm used.
 If the filename is "TRAILER!!!" this is actually an end-of-archive
 marker; the c_filesize for an end-of-archive marker must be zero.
 
+"Extended" newc format (newcx)
+"newcx" cpio format extends "newc" by increasing size of some fields
+and adding extended attributes support. cpio_newcx_header structure:
+
+Field name    Field size	 Meaning
+c_magic	       6 bytes		 The string "070703"
+c_ino	       8 bytes		 File inode number
+c_mode	       8 bytes		 File mode and permissions
+c_uid	       8 bytes		 File uid
+c_gid	       8 bytes		 File gid
+c_nlink	       8 bytes		 Number of links
+c_mtime	      16 bytes		 Modification time (microseconds)
+c_filesize    16 bytes		 Size of data field
+c_maj	       8 bytes		 Major part of file device number
+c_min	       8 bytes		 Minor part of file device number
+c_rmaj	       8 bytes		 Major part of device node reference
+c_rmin	       8 bytes		 Minor part of device node reference
+c_namesize     8 bytes		 Length of filename, including final \0
+c_xattrs_size  8 bytes		 Size of xattrs field
+
+Most of the fields match cpio_newc_header except c_mtime that contains
+microseconds. c_chksum field is dropped.
+
+xattr_size is a total size of xattr_entry including 8 bytes of
+xattr_size. xattr_size has the same hexadecimal ASCII encoding as other
+fields of cpio header.
 
 *** Handling of hard links
 
-- 
2.10.3.dirty

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
