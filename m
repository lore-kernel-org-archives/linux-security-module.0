From: takondra@cisco.com (Taras Kondratiuk)
Date: Thu, 25 Jan 2018 03:27:53 +0000
Subject: [PATCH v2 13/15] gen_initramfs_list.sh: add -x option to enable newcx
	format
In-Reply-To: <1516850875-25066-1-git-send-email-takondra@cisco.com>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
Message-ID: <1516850875-25066-14-git-send-email-takondra@cisco.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Mimi Zohar <zohar@linux.vnet.ibm.com>

-x option populates extended attributes in cpio_list file passed to
get_init_cpio and selects newcx CPIO format.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
---
 scripts/gen_initramfs_list.sh | 13 ++++++++++++-
 usr/Kconfig                   | 11 +++++++++++
 usr/Makefile                  |  3 ++-
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/scripts/gen_initramfs_list.sh b/scripts/gen_initramfs_list.sh
index 86a3c0e5cfbc..cddb82f093d9 100755
--- a/scripts/gen_initramfs_list.sh
+++ b/scripts/gen_initramfs_list.sh
@@ -24,6 +24,7 @@ $0 [-o <file>] [-u <uid>] [-g <gid>] {-d | <cpio_source>} ...
 	-g <gid>       Group ID to map to group ID 0 (root).
 		       <gid> is only meaningful if <cpio_source> is a
 		       directory.  "squash" forces all files to gid 0.
+	-x             include file extended attributes in cpio archive.
 	<cpio_source>  File list or directory for cpio archive.
 		       If <cpio_source> is a .cpio file it will be used
 		       as direct input to initramfs.
@@ -146,6 +147,9 @@ parse() {
 			;;
 	esac
 
+	$include_xattrs && \
+		getfattr -h -d -m - -e hex --absolute-names ${location} | \
+		sed -e '/^#/d' -e '/^$/d' -e 's/^/xattr /' >> ${output}
 	echo "${str}" >> ${output}
 
 	return 0
@@ -226,6 +230,8 @@ root_gid=0
 dep_list=
 cpio_file=
 cpio_list=
+cpio_opts=
+include_xattrs=false
 output="/dev/stdout"
 output_file=""
 is_cpio_compressed=
@@ -283,6 +289,10 @@ while [ $# -gt 0 ]; do
 			default_list="$arg"
 			${dep_list}default_initramfs
 			;;
+		"-x")   # include extended attributers
+			cpio_opts="-x"
+			include_xattrs=true
+			;;
 		"-h")
 			usage
 			exit 0
@@ -312,7 +322,8 @@ if [ ! -z ${output_file} ]; then
 			fi
 		fi
 		cpio_tfile="$(mktemp ${TMPDIR:-/tmp}/cpiofile.XXXXXX)"
-		usr/gen_init_cpio $timestamp ${cpio_list} > ${cpio_tfile}
+		usr/gen_init_cpio $timestamp ${cpio_opts} ${cpio_list} \
+			> ${cpio_tfile}
 	else
 		cpio_tfile=${cpio_file}
 	fi
diff --git a/usr/Kconfig b/usr/Kconfig
index 43658b8a975e..0cc03bc4614c 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -52,6 +52,17 @@ config INITRAMFS_ROOT_GID
 
 	  If you are not sure, leave it set to "0".
 
+config INITRAMFS_NEWCX
+	bool "Use newcx CPIO format for initramfs"
+	depends on INITRAMFS_SOURCE!=""
+	default n
+	help
+	  If selected "usr/gen_init_cpio" will generate newcx CPIO archive
+	  format that supports extended attributes.
+
+	  See <file:Documentation/early-userspace/buffer-format.txt> for
+	  more details.
+
 config RD_GZIP
 	bool "Support initial ramdisk/ramfs compressed using gzip"
 	depends on BLK_DEV_INITRD
diff --git a/usr/Makefile b/usr/Makefile
index 237a028693ce..1106bfd61475 100644
--- a/usr/Makefile
+++ b/usr/Makefile
@@ -29,7 +29,8 @@ ramfs-input := $(if $(filter-out "",$(CONFIG_INITRAMFS_SOURCE)), \
 			$(shell echo $(CONFIG_INITRAMFS_SOURCE)),-d)
 ramfs-args  := \
         $(if $(CONFIG_INITRAMFS_ROOT_UID), -u $(CONFIG_INITRAMFS_ROOT_UID)) \
-        $(if $(CONFIG_INITRAMFS_ROOT_GID), -g $(CONFIG_INITRAMFS_ROOT_GID))
+        $(if $(CONFIG_INITRAMFS_ROOT_GID), -g $(CONFIG_INITRAMFS_ROOT_GID)) \
+        $(if $(CONFIG_INITRAMFS_NEWCX), -x)
 
 # $(datafile_d_y) is used to identify all files included
 # in initramfs and to detect if any files are added/removed.
-- 
2.10.3.dirty

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
