From: rgb@redhat.com (Richard Guy Briggs)
Date: Thu, 11 May 2017 16:42:42 -0400
Subject: [RFC PATCH V2 3/4] capabilities: fix logic for effective root or real
	root
In-Reply-To: <cover.1494527628.git.rgb@redhat.com>
References: <cover.1494527628.git.rgb@redhat.com>
Message-ID: <771a50ef3c8263ed77a2bcb84f5e75b95ead0495.1494527628.git.rgb@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Now that the logic is inverted, it is much easier to see that both real root
and effective root conditions had to be met to avoid printing the BPRM_FCAPS
record with audit syscalls.  This meant that any setuid root applications would
print a full BPRM_FCAPS record when it wasn't necessary, cluttering the event
output, since the SYSCALL and PATH records indicated the presence of the setuid
bit and effective root user id.

Require only one of effective root or real root to avoid printing the
unnecessary record.

Ref: 3fc689e96c0c (Add audit_log_bprm_fcaps/AUDIT_BPRM_FCAPS)
See: https://github.com/linux-audit/audit-kernel/issues/16

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 security/commoncap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 664d6a5..c0adee6 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -608,7 +608,7 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
 	 * Number 1 above might fail if you don't have a full bset, but I think
 	 * that is interesting information to audit.
 	 */
-	if (pESET && !(pEALL && EROOT && RROOT && SROOT) ) {
+	if (pESET && !(pEALL && (EROOT || RROOT) && SROOT) ) {
 		ret = audit_log_bprm_fcaps(bprm, new, old);
 		if (ret < 0)
 			return ret;
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
