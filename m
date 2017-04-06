From: john.johansen@canonical.com (John Johansen)
Date: Thu,  6 Apr 2017 06:55:22 -0700
Subject: [PATCH 4/6] apparmor: fix invalid reference to index variable of
	iterator line 836
In-Reply-To: <20170406135524.25481-1-john.johansen@canonical.com>
References: <20170406135524.25481-1-john.johansen@canonical.com>
Message-ID: <20170406135524.25481-5-john.johansen@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Once the loop on lines 836-853 is complete and exits normally, ent is a
pointer to the dummy list head value.  The derefernces accessible from eg
the goto fail on line 860 or the various goto fail_lock's afterwards thus
seem incorrect.

Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: John Johansen <john.johansen@canonical.com>
---
 security/apparmor/policy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index f44312a..c0a4066 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -874,9 +874,11 @@ ssize_t aa_replace_profiles(struct aa_ns *view, struct aa_profile *profile,
 	if (ns_name) {
 		ns = aa_prepare_ns(view, ns_name);
 		if (IS_ERR(ns)) {
+			op = OP_PROF_LOAD;
 			info = "failed to prepare namespace";
 			error = PTR_ERR(ns);
 			ns = NULL;
+			ent = NULL;
 			goto fail;
 		}
 	} else
@@ -1011,7 +1013,7 @@ ssize_t aa_replace_profiles(struct aa_ns *view, struct aa_profile *profile,
 	/* audit cause of failure */
 	op = (!ent->old) ? OP_PROF_LOAD : OP_PROF_REPL;
 fail:
-	audit_policy(profile, op, ns_name, ent->new->base.hname,
+	audit_policy(profile, op, ns_name, ent ? ent->new->base.hname : NULL,
 		     info, error);
 	/* audit status that rest of profiles in the atomic set failed too */
 	info = "valid profile in failed atomic policy load";
@@ -1021,7 +1023,7 @@ ssize_t aa_replace_profiles(struct aa_ns *view, struct aa_profile *profile,
 			/* skip entry that caused failure */
 			continue;
 		}
-		op = (!ent->old) ? OP_PROF_LOAD : OP_PROF_REPL;
+		op = (!tmp->old) ? OP_PROF_LOAD : OP_PROF_REPL;
 		audit_policy(profile, op, ns_name,
 			     tmp->new->base.hname, info, error);
 	}
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
