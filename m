From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 02 May 2018 16:49:16 -0500
Subject: [PATCH] evm: Don't update hmacs in user ns mounts
Message-ID: <87r2mtybhf.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Seth Forshee <seth.forshee@canonical.com>
Date: Fri, 22 Dec 2017 15:32:35 +0100

The kernel should not calculate new hmacs for mounts done by
non-root users. Update evm_calc_hmac_or_hash() to refuse to
calculate new hmacs for mounts for non-init user namespaces.

Cc: linux-integrity at vger.kernel.org
Cc: linux-security-module at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: James Morris <james.l.morris@oracle.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
Signed-off-by: Dongsu Park <dongsu@kinvolk.io>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

Mimi this patch has been floating around for a while and it appears to
be the only piece missing from the vfs to make unprivileged mounts safe
(at least semantically).  Do you want to merge this through your integrity
tree or should merge this through my userns tree?

 security/integrity/evm/evm_crypto.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index a46fba322340..facf9cdd577d 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -200,7 +200,8 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 	int size;
 	bool ima_present = false;
 
-	if (!(inode->i_opflags & IOP_XATTR))
+	if (!(inode->i_opflags & IOP_XATTR) ||
+	    inode->i_sb->s_user_ns != &init_user_ns)
 		return -EOPNOTSUPP;
 
 	desc = init_desc(type);
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
