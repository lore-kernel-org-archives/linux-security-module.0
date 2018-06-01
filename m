From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 1 Jun 2018 11:00:05 +0300
Subject: [PATCH] EVM: unlock on error path in evm_read_xattrs()
Message-ID: <20180601075946.wpyly2mgmaynfm4c@kili.mountain>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

We need to unlock before returning on this error path.

Fixes: fa516b66a1bf ("EVM: Allow runtime modification of the set of verified xattrs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index a7a0a1acae99..6d3b34ae8499 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -147,8 +147,10 @@ static ssize_t evm_read_xattrs(struct file *filp, char __user *buf,
 		size += strlen(xattr->name) + 1;
 
 	temp = kmalloc(size + 1, GFP_KERNEL);
-	if (!temp)
+	if (!temp) {
+		mutex_unlock(&xattr_list_mutex);
 		return -ENOMEM;
+	}
 
 	list_for_each_entry(xattr, &evm_config_xattrnames, list) {
 		sprintf(temp + offset, "%s\n", xattr->name);
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
