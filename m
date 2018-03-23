From: colin.king@canonical.com (Colin King)
Date: Fri, 23 Mar 2018 23:34:22 +0000
Subject: [PATCH][next] apparmor: fix error returns checks by making size a
	ssize_t
Message-ID: <20180323233422.7856-1-colin.king@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently variable size is a unsigned size_t, hence comparisons to
see if it is less than zero (for error checking) will always be
false.  Fix this by making size a ssize_t

Detected by CoverityScan, CID#1466080 ("Unsigned compared against 0")

Fixes: 8e51f9087f40 ("apparmor: Add support for attaching profiles via xattr, presence and value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/apparmor/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 57cc892e05a2..590b7e8cd21c 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -314,7 +314,7 @@ static int aa_xattrs_match(const struct linux_binprm *bprm,
 			   struct aa_profile *profile, unsigned int state)
 {
 	int i;
-	size_t size;
+	ssize_t size;
 	struct dentry *d;
 	char *value = NULL;
 	int value_size = 0, ret = profile->xattr_count;
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
