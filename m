From: rgb@redhat.com (Richard Guy Briggs)
Date: Wed, 11 Oct 2017 20:57:08 -0400
Subject: [PATCH GHAK16 V5 04/10] capabilities: use root_priveleged inline to
	clarify logic
In-Reply-To: <cover.1507769413.git.rgb@redhat.com>
References: <cover.1507769413.git.rgb@redhat.com>
Message-ID: <5854c1e5862925f3f9ca9614c42fb4a9c5330556.1507769413.git.rgb@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Introduce inline root_privileged() to make use of SECURE_NONROOT
easier to read.

Suggested-by: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Acked-by: James Morris <james.l.morris@oracle.com>
Acked-by: Kees Cook <keescook@chromium.org>
Okay-ished-by: Paul Moore <paul@paul-moore.com>
---
 security/commoncap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 13661d3..9b8a6e7 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -695,6 +695,8 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_f
 	return rc;
 }
 
+static inline bool root_privileged(void) { return !issecure(SECURE_NOROOT); }
+
 /*
  * handle_privileged_root - Handle case of privileged root
  * @bprm: The execution parameters, including the proposed creds
@@ -713,7 +715,7 @@ static void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap,
 	const struct cred *old = current_cred();
 	struct cred *new = bprm->cred;
 
-	if (issecure(SECURE_NOROOT))
+	if (!root_privileged())
 		return;
 	/*
 	 * If the legacy file capability is set, then don't set privs
@@ -838,7 +840,7 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
 	if (__cap_grew(effective, ambient, new)) {
 		if (!__cap_full(effective, new) ||
 		    !uid_eq(new->euid, root_uid) || !uid_eq(new->uid, root_uid) ||
-		    issecure(SECURE_NOROOT)) {
+		    !root_privileged()) {
 			ret = audit_log_bprm_fcaps(bprm, new, old);
 			if (ret < 0)
 				return ret;
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
