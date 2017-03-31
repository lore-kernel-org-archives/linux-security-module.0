From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 31 Mar 2017 18:21:18 +0300
Subject: [PATCH] selinux: Fix an uninitialized variable bug
Message-ID: <20170331152118.GA8141@mwanda>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

We removed this initialization as a cleanup but it is probably required.

The concern is that "nel" can be zero.  I'm not an expert on SELinux
code but I think it looks possible to write an SELinux policy which
triggers this bug.  GCC doesn't catch this, but my static checker does.

Fixes: 9c312e79d6af ("selinux: Delete an unnecessary variable initialisation in range_read()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 658247f98dc1..0080122760ad 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1832,7 +1832,7 @@ u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name)
 
 static int range_read(struct policydb *p, void *fp)
 {
-	struct range_trans *rt;
+	struct range_trans *rt = NULL;
 	struct mls_range *r = NULL;
 	int i, rc;
 	__le32 buf[2];
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
