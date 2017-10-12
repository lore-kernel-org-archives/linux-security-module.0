From: rgb@redhat.com (Richard Guy Briggs)
Date: Wed, 11 Oct 2017 20:57:13 -0400
Subject: [PATCH GHAK16 V5 09/10] capabilities: fix logic for effective root or
	real root
In-Reply-To: <cover.1507769413.git.rgb@redhat.com>
References: <cover.1507769413.git.rgb@redhat.com>
Message-ID: <84e457662ed6918af35f5678c3cdd0250d693fa7.1507769413.git.rgb@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Now that the logic is inverted, it is much easier to see that both real
root and effective root conditions had to be met to avoid printing the
BPRM_FCAPS record with audit syscalls.  This meant that any setuid root
applications would print a full BPRM_FCAPS record when it wasn't
necessary, cluttering the event output, since the SYSCALL and PATH
records indicated the presence of the setuid bit and effective root user
id.

Require only one of effective root or real root to avoid printing the
unnecessary record.

Ref: commit 3fc689e96c0c ("Add audit_log_bprm_fcaps/AUDIT_BPRM_FCAPS")
See: https://github.com/linux-audit/audit-kernel/issues/16

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Acked-by: James Morris <james.l.morris@oracle.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Paul Moore <paul@paul-moore.com>
---
 security/commoncap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 0bd94d3..ad7536d 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -770,7 +770,7 @@ static inline bool __is_setgid(struct cred *new, const struct cred *old)
  *
  * We do not bother to audit if 3 things are true:
  *   1) cap_effective has all caps
- *   2) we are root
+ *   2) we became root *OR* are were already root
  *   3) root is supposed to have all caps (SECURE_NOROOT)
  * Since this is just a normal root execing a process.
  *
@@ -783,8 +783,7 @@ static inline bool nonroot_raised_pE(struct cred *cred, kuid_t root)
 
 	if (__cap_grew(effective, ambient, cred) &&
 	    !(__cap_full(effective, cred) &&
-	      __is_eff(root, cred) &&
-	      __is_real(root, cred) &&
+	      (__is_eff(root, cred) || __is_real(root, cred)) &&
 	      root_privileged()))
 		ret = true;
 	return ret;
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
