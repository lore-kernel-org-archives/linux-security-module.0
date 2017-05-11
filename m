From: rgb@redhat.com (Richard Guy Briggs)
Date: Thu, 11 May 2017 16:42:41 -0400
Subject: [RFC PATCH V2 2/4] capabilities: invert logic for clarity
In-Reply-To: <cover.1494527628.git.rgb@redhat.com>
References: <cover.1494527628.git.rgb@redhat.com>
Message-ID: <020580f9a2db5624019d4fd4687c286d04e63841.1494527628.git.rgb@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The way the logic was presented, it was awkward to read and verify.  Invert the
logic using DeMorgan's Law to be more easily able to read and understand.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 security/commoncap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 9520f0a..664d6a5 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -608,7 +608,7 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
 	 * Number 1 above might fail if you don't have a full bset, but I think
 	 * that is interesting information to audit.
 	 */
-	if (pESET && (!pEALL || !EROOT || !RROOT || !SROOT) ) {
+	if (pESET && !(pEALL && EROOT && RROOT && SROOT) ) {
 		ret = audit_log_bprm_fcaps(bprm, new, old);
 		if (ret < 0)
 			return ret;
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
