From: rgb@redhat.com (Richard Guy Briggs)
Date: Thu, 11 May 2017 16:42:43 -0400
Subject: [RFC PATCH V2 4/4] capabilities: auit log other surprising conditions
In-Reply-To: <cover.1494527628.git.rgb@redhat.com>
References: <cover.1494527628.git.rgb@redhat.com>
Message-ID: <1779aa46278bf6b03052c2d4a59d68a996fd61a0.1494527628.git.rgb@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The existing condition tested for process effective capabilities set by file
attributes but intended to ignore the change if the result was unsurprisingly an
effective full set in the case root is special with a setuid root executable
file and we are root.

Stated again:
- When you execute a setuid root application, it is no surprise and expected
that it got all capabilities, so we do not want capabilities recorded.
        if (pESET && !(pEALL && (EROOT || RROOT) && SROOT) )

Now make sure we cover other cases:
- If something prevented a setuid root app getting all capabilities and it
wound up with one capability only, then it is a surprise and should be logged.
When it is a setuid root file, we only want capabilities when the process does
not get full capabilities..
        SROOT && SETUIDROOT && !pEALL

- Similarly if a non-setuid program does pick up capabilities due to file system
based capabilities, then we want to know what capabilities were picked up.
When it has file system based capabilities we want the capabilities.
        !SUID && FILECAP && pPADD

- If it is a non-setuid file and it gets ambient capabilities, we want the
capabilities.
        !SUID && pAADD

Related: https://github.com/linux-audit/audit-kernel/issues/16

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 security/commoncap.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index c0adee6..6309e81 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -608,7 +608,9 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
 	 * Number 1 above might fail if you don't have a full bset, but I think
 	 * that is interesting information to audit.
 	 */
-	if (pESET && !(pEALL && (EROOT || RROOT) && SROOT) ) {
+	if ( (pESET && !(pEALL && (EROOT || RROOT) && SROOT) )
+	    || (SROOT && SETUIDROOT && !pEALL)
+	    ||  (!SUID && ( (has_cap && pPADD) || pAADD) )) {
 		ret = audit_log_bprm_fcaps(bprm, new, old);
 		if (ret < 0)
 			return ret;
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
