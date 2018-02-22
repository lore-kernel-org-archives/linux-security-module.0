From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 22 Feb 2018 16:33:01 -0500
Subject: [PATCH v2 1/4] ima: fail file signature verification on non-init
	mounted filesystems
In-Reply-To: <1519335184-17808-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1519335184-17808-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1519335184-17808-2-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

FUSE can be mounted by unprivileged users either today with fusermount
installed with setuid, or soon with the upcoming patches to allow FUSE
mounts in a non-init user namespace.

This patch addresses the new unprivileged non-init mounted filesystems,
which are untrusted, by failing the signature verification.

This patch defines two new flags SB_I_IMA_UNVERIFIABLE_SIGNATURE and
SB_I_UNTRUSTED_MOUNTER.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Seth Forshee <seth.forshee@canonical.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Dongsu Park <dongsu@kinvolk.io>
Cc: Alban Crequy <alban@kinvolk.io>
Cc: Serge E. Hallyn <serge@hallyn.com>

Changelog v2:
- Limit patch to non-init mounted filesystems.
- Define 2 sb->s_iflags

Changelog v1:
- Merged the unprivileged and privileged patches.
- Dropped IMA fsname support.
- Introduced a new IMA builtin policy named "untrusted_fs".
- Replaced fs_type flag with sb->s_iflags flag.
---
 include/linux/fs.h                    |  2 ++
 security/integrity/ima/ima_appraise.c | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2a815560fda0..4e1c76af7b68 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1320,6 +1320,8 @@ extern int send_sigurg(struct fown_struct *fown);
 
 /* sb->s_iflags to limit user namespace mounts */
 #define SB_I_USERNS_VISIBLE		0x00000010 /* fstype already mounted */
+#define SB_I_IMA_UNVERIFIABLE_SIGNATURE	0x00000020
+#define SB_I_UNTRUSTED_MOUNTER		0x00000040
 
 /* Possible states of 'frozen' field */
 enum {
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 1b177461f20e..f34901069e78 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -302,7 +302,18 @@ int ima_appraise_measurement(enum ima_hooks func,
 	}
 
 out:
-	if (status != INTEGRITY_PASS) {
+	/*
+	 * File signatures on some filesystems can not be properly verified.
+	 * On these filesytems, that are mounted by an untrusted mounter,
+	 * fail the file signature verification.
+	 */
+	if (inode->i_sb->s_iflags &
+	    (SB_I_IMA_UNVERIFIABLE_SIGNATURE | SB_I_UNTRUSTED_MOUNTER)) {
+		status = INTEGRITY_FAIL;
+		cause = "unverifiable-signature";
+		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
+				    op, cause, rc, 0);
+	} else if (status != INTEGRITY_PASS) {
 		if ((ima_appraise & IMA_APPRAISE_FIX) &&
 		    (!xattr_value ||
 		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
@@ -319,6 +330,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 	} else {
 		ima_cache_flags(iint, func);
 	}
+
 	ima_set_cache_status(iint, func, status);
 	return status;
 }
-- 
2.7.5

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
