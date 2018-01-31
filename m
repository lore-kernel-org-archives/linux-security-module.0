From: rob@landley.net (Rob Landley)
Date: Wed, 31 Jan 2018 13:32:58 -0600
Subject: [RFC PATCH] rootfs: force mounting rootfs as tmpfs
In-Reply-To: <1517348777.3469.5.camel@linux.vnet.ibm.com>
References: <1517348777.3469.5.camel@linux.vnet.ibm.com>
Message-ID: <1814af5c-170d-39c0-58fd-02eb7216e008@landley.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 01/30/2018 03:46 PM, Mimi Zohar wrote:
> Commit 16203a7a9422 ("initmpfs: make rootfs use tmpfs when CONFIG_TMPFS
> enabled") introduced using tmpfs as the rootfs filesystem.  The use of
> tmpfs is limited to systems that do not specify "root=" on the boot
> command line.
> 
> Without the check "!saved_root_name[0]", rootfs uses tmpfs.  As there
> must be a valid reason for this check, this patch introduces a new boot
> command line option named "noramfs" to force rootfs to use tmpfs.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

How about just:

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 7cf4f6d..af66ede 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -632,8 +632,8 @@ int __init init_rootfs(void)
 	if (err)
 		return err;
 
-	if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
-		(!root_fs_names || strstr(root_fs_names, "tmpfs"))) {
+	if (IS_ENABLED(CONFIG_TMPFS) && (!saved_root_name[0] ||
+		!strcmp(saved_root_name, "tmpfs"))) {
 		err = shmem_init();
 		is_tmpfs = true;
 	} else {

(Obviously-signed-off-by: Rob Landley <rob@landley.net>)

I.E. if you somehow just can't stop yourself from specifying root= when
using rootfs, have "root=tmpfs" do what you want.

(The old "I configured in tmpfs and am using rootfs but I want that rootfs
to be ramfs, not tmpfs" code doesn't seem to be a real-world concern, does
it?)

> ---
>  Documentation/admin-guide/kernel-parameters.txt |  2 ++
>  init/do_mounts.c                                | 15 +++++++++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)

I suppose I should do a documentation update too. Lemme send a proper one
after work...

Rob

P.S. While I'm at it, I've meant to wire up rootflags= so you can specify
a memory limit other than 50% forever, I should do that too. And resend
my "make DEVTMPFS_MOUNT apply to initramfs" patch (with the debian bug
workaround)...
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
