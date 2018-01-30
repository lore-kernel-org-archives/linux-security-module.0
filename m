From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 30 Jan 2018 16:46:17 -0500
Subject: [RFC PATCH] rootfs: force mounting rootfs as tmpfs
Message-ID: <1517348777.3469.5.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Commit 16203a7a9422 ("initmpfs: make rootfs use tmpfs when CONFIG_TMPFS
enabled") introduced using tmpfs as the rootfs filesystem.  The use of
tmpfs is limited to systems that do not specify "root=" on the boot
command line.

Without the check "!saved_root_name[0]", rootfs uses tmpfs.  As there
must be a valid reason for this check, this patch introduces a new boot
command line option named "noramfs" to force rootfs to use tmpfs.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 init/do_mounts.c                                | 15 +++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6571fbfdb2a1..fd82df2ff150 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2733,6 +2733,8 @@
 
 	nopcid		[X86-64] Disable the PCID cpu feature.
 
+	noramfs		Don't use ramfs for rootfs, use tmpfs.
+
 	norandmaps	Don't use address space randomization.  Equivalent to
 			echo 0 > /proc/sys/kernel/randomize_va_space
 
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 7cf4f6dafd5f..74d8bfcd1294 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -315,6 +315,16 @@ static int __init root_data_setup(char *str)
 	return 1;
 }
 
+static bool force_tmpfs;
+static int __init force_tmpfs_setup(char *str)
+{
+	if (*str)
+		return 0;
+	force_tmpfs = true;
+	return 1;
+
+}
+
 static char * __initdata root_fs_names;
 static int __init fs_names_setup(char *str)
 {
@@ -332,6 +342,7 @@ static int __init root_delay_setup(char *str)
 __setup("rootflags=", root_data_setup);
 __setup("rootfstype=", fs_names_setup);
 __setup("rootdelay=", root_delay_setup);
+__setup("noramfs", force_tmpfs_setup);
 
 static void __init get_fs_names(char *page)
 {
@@ -632,8 +643,8 @@ int __init init_rootfs(void)
 	if (err)
 		return err;
 
-	if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
-		(!root_fs_names || strstr(root_fs_names, "tmpfs"))) {
+	if (IS_ENABLED(CONFIG_TMPFS) && (force_tmpfs || (!saved_root_name[0] &&
+		(!root_fs_names || strstr(root_fs_names, "tmpfs"))))) {
 		err = shmem_init();
 		is_tmpfs = true;
 	} else {
-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
