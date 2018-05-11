From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 10 May 2018 17:56:10 -0700
Subject: [PATCH 22/23] LSM: Fix setting of the IMA data in inode init
In-Reply-To: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
Message-ID: <e5fb34e1-43ee-bee1-2751-065e8b2b083a@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Casey Schaufler <casey@schaufler-ca.com>
Date: Thu, 10 May 2018 16:23:47 -0700
Subject: [PATCH 22/23] LSM: Fix setting of the IMA data in inode init

Fix a missing assignment in the inode security initialization.
The EVM entry was not being set correctly.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index ef51783e967e..571643cc7256 100644
--- a/security/security.c
+++ b/security/security.c
@@ -941,6 +941,7 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 							&lsm_xattr->value_len);
 		if (rc == 0) {
 			lsm_xattr++;
+			evm_xattr = lsm_xattr;
 			if (ret == -EOPNOTSUPP)
 				ret = 0;
 		} else if (rc != -EOPNOTSUPP) {
@@ -950,7 +951,7 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 	}
 
 	if (ret == 0) {
-		rc = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
+		rc = evm_inode_init_security(inode, new_xattrs, evm_xattr);
 		if (rc == 0)
 			rc = initxattrs(inode, new_xattrs, fs_data);
 	}
-- 
2.14.3


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
