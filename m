From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Thu, 30 Nov 2017 11:56:03 +0100
Subject: [RFC][PATCH v2 2/9] ima: preserve flags in ima_inode_post_setattr()
	if file must be appraised
In-Reply-To: <20171130105610.15761-1-roberto.sassu@huawei.com>
References: <20171130105610.15761-1-roberto.sassu@huawei.com>
Message-ID: <20171130105610.15761-3-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Before commit d79d72e02485 ("ima: per hook cache integrity appraisal
status"), ima_inode_post_setattr() clears the iint flags only if the file
does not match policy rules after attributes changed. After the commit
above, it clears the flags in any case. This patch restores the original
behavior.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_appraise.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 1b56ee949315..a54ad18affb1 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -360,11 +360,13 @@ void ima_inode_post_setattr(struct dentry *dentry)
 	must_appraise = ima_must_appraise(inode, MAY_ACCESS, POST_SETATTR);
 	iint = integrity_iint_find(inode);
 	if (iint) {
-		iint->flags &= ~(IMA_APPRAISE | IMA_APPRAISED |
-				 IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
-				 IMA_ACTION_RULE_FLAGS);
 		if (must_appraise)
 			iint->flags |= IMA_APPRAISE;
+		else
+			iint->flags &= ~(IMA_APPRAISE | IMA_APPRAISED |
+					 IMA_APPRAISE_SUBMASK |
+					 IMA_APPRAISED_SUBMASK |
+					 IMA_ACTION_RULE_FLAGS);
 	}
 	if (!must_appraise)
 		__vfs_removexattr(dentry, XATTR_NAME_IMA);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
