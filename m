From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 22 Feb 2018 16:33:02 -0500
Subject: [PATCH v2 2/4] ima: re-evaluate files on privileged mounted
	filesystems
In-Reply-To: <1519335184-17808-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1519335184-17808-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1519335184-17808-3-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch addresses the fuse privileged mounted filesystems in a "secure"
environment, with a correctly enforced security policy, which is willing
to assume the inherent risk of specific fuse filesystems that are well
defined and properly implemented.

As there is no way for the kernel to detect file changes, the kernel
ignores the cached file integrity results and re-measures, re-appraises,
and re-audits the file.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Seth Forshee <seth.forshee@canonical.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Dongsu Park <dongsu@kinvolk.io>
Cc: Alban Crequy <alban@kinvolk.io>
Cc: Serge E. Hallyn <serge@hallyn.com>
---
 security/integrity/ima/ima_main.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index a5d225ffc388..f550f25294a3 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -25,6 +25,7 @@
 #include <linux/xattr.h>
 #include <linux/ima.h>
 #include <linux/iversion.h>
+#include <linux/fs.h>
 
 #include "ima.h"
 
@@ -230,9 +231,17 @@ static int process_measurement(struct file *file, const struct cred *cred,
 				 IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
 				 IMA_ACTION_FLAGS);
 
-	if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags))
-		/* reset all flags if ima_inode_setxattr was called */
+	/*
+	 * Re-evaulate the file if either the xattr has changed or the
+	 * kernel has no way of detecting file change on the filesystem.
+	 * (Limited to privileged mounted filesystems.)
+	 */
+	if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags) ||
+	    ((inode->i_sb->s_iflags & SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
+	     !(inode->i_sb->s_iflags & SB_I_UNTRUSTED_MOUNTER))) {
 		iint->flags &= ~IMA_DONE_MASK;
+		iint->measured_pcrs = 0;
+	}
 
 	/* Determine if already appraised/measured based on bitmask
 	 * (IMA_MEASURE, IMA_MEASURED, IMA_XXXX_APPRAISE, IMA_XXXX_APPRAISED,
-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
