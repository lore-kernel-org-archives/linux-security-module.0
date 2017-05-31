From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 31 May 2017 13:23:41 -0700
Subject: [PATCH] Smack: Use cap_capable in privilege check
Message-ID: <21876921-ee24-450a-9d8f-fd7ef99b389b@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Subject: [PATCH] Smack: Use cap_capable in privilege check

Use cap_capable() rather than capable() in the Smack privilege
check as the former does not invoke other security module
privilege check, while the later does. This becomes important
when stacking. It may be a problem even with minor modules.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack.h        |  2 +-
 security/smack/smack_access.c | 19 +++++++++++--------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 612b810..6a71fc7 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -320,7 +320,7 @@ int smk_netlbl_mls(int, char *, struct netlbl_lsm_secattr *, int);
 struct smack_known *smk_import_entry(const char *, int);
 void smk_insert_entry(struct smack_known *skp);
 struct smack_known *smk_find_entry(const char *);
-int smack_privileged(int cap);
+bool smack_privileged(int cap);
 void smk_destroy_label_list(struct list_head *list);
 
 /*
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index a4b2e6b..1a30041 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -627,35 +627,38 @@ DEFINE_MUTEX(smack_onlycap_lock);
  * Is the task privileged and allowed to be privileged
  * by the onlycap rule.
  *
- * Returns 1 if the task is allowed to be privileged, 0 if it's not.
+ * Returns true if the task is allowed to be privileged, false if it's not.
  */
-int smack_privileged(int cap)
+bool smack_privileged(int cap)
 {
 	struct smack_known *skp = smk_of_current();
 	struct smack_known_list_elem *sklep;
+	int rc;
 
 	/*
 	 * All kernel tasks are privileged
 	 */
 	if (unlikely(current->flags & PF_KTHREAD))
-		return 1;
+		return true;
 
-	if (!capable(cap))
-		return 0;
+	rc = cap_capable(current_cred(), &init_user_ns, cap,
+				SECURITY_CAP_AUDIT);
+	if (rc)
+		return false;
 
 	rcu_read_lock();
 	if (list_empty(&smack_onlycap_list)) {
 		rcu_read_unlock();
-		return 1;
+		return true;
 	}
 
 	list_for_each_entry_rcu(sklep, &smack_onlycap_list, list) {
 		if (sklep->smk_label == skp) {
 			rcu_read_unlock();
-			return 1;
+			return true;
 		}
 	}
 	rcu_read_unlock();
 
-	return 0;
+	return false;
 }

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
