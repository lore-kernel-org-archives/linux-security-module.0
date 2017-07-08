From: chris.gekas@gmail.com (Christos Gkekas)
Date: Sat,  8 Jul 2017 20:50:21 +0100
Subject: [PATCH] apparmor: Fix logical error in verify_header()
Message-ID: <1499543421-5544-1-git-send-email-chris.gekas@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

verify_header() is currently checking whether interface version is less
than 5 *and* greater than 7, which always evaluates to false. Instead it
should check whether it is less than 5 *or* greater than 7.

Signed-off-by: Christos Gkekas <chris.gekas@gmail.com>
---
 security/apparmor/policy_unpack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index c600f4d..f273c61 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -832,7 +832,7 @@ static int verify_header(struct aa_ext *e, int required, const char **ns)
 	 * if not specified use previous version
 	 * Mask off everything that is not kernel abi version
 	 */
-	if (VERSION_LT(e->version, v5) && VERSION_GT(e->version, v7)) {
+	if (VERSION_LT(e->version, v5) || VERSION_GT(e->version, v7)) {
 		audit_iface(NULL, NULL, NULL, "unsupported interface version",
 			    e, error);
 		return error;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
