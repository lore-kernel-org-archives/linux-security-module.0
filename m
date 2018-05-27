From: colin.king@canonical.com (Colin King)
Date: Sun, 27 May 2018 23:55:10 +0100
Subject: [PATCH] EVM: Fix null dereference on xattr when xattr fails to
	allocate
Message-ID: <20180527225510.25612-1-colin.king@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case where the allocation of xattr fails and xattr is NULL, the
error exit return path via label 'out' will dereference xattr when
kfree'ing xattr-name.  Fix this by only kfree'ing xattr->name and xattr
when xattr is non-null.

Detected by CoverityScan, CID#1469366 ("Dereference after null check")

Fixes: fa516b66a1bf ("EVM: Allow runtime modification of the set of verified xattrs")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/integrity/evm/evm_secfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index fb8bc950aceb..cf5cd303d7c0 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -253,8 +253,10 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
 out:
 	audit_log_format(ab, " res=%d", err);
 	audit_log_end(ab);
-	kfree(xattr->name);
-	kfree(xattr);
+	if (xattr) {
+		kfree(xattr->name);
+		kfree(xattr);
+	}
 	return err;
 }
 
-- 
2.17.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
