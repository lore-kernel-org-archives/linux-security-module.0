From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 7 Nov 2017 11:37:06 +0100
Subject: [PATCH v2 11/15] ima: add policy action digest_list
In-Reply-To: <20171107103710.10883-1-roberto.sassu@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
Message-ID: <20171107103710.10883-12-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The new policy action 'digest_list' has been added to selectively search a
digest in the ima_digests_htable hash table only for specific rules.

The main use case would be to use digest lists to measure/appraise the TCB,
so that the PCR 10 value is predictable, and to extend a different PCR if
binaries and libraries are accessed by regular users. The policy should be:

measure func=BPRM_CHECK uid=0 digest_list
measure func=BPRM_CHECK pcr=11
measure func=MMAP_CHECK uid=0 digest_list
measure func=MMAP_CHECK pcr=11
measure func=FILE_CHECK uid=0 digest_list mask=^MAY_READ

appraise uid=0 digest_list

Digest lookup is enabled if the digest_list policy action is not specified
in the policy.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h          |  4 ++--
 security/integrity/ima/ima_api.c      |  7 +++++--
 security/integrity/ima/ima_appraise.c |  2 +-
 security/integrity/ima/ima_main.c     |  5 ++++-
 security/integrity/ima/ima_policy.c   | 17 ++++++++++++++---
 security/integrity/integrity.h        |  1 +
 6 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 4b3b1ca5c09a..ddd0e1e7e99b 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -215,7 +215,7 @@ enum ima_hooks {
 
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, int mask,
-		   enum ima_hooks func, int *pcr);
+		   enum ima_hooks func, int *pcr, int *digest_mask);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
@@ -236,7 +236,7 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
 /* IMA policy related functions */
 int ima_match_policy(struct inode *inode, enum ima_hooks func, int mask,
-		     int flags, int *pcr);
+		     int flags, int *pcr, int *digest_mask);
 void ima_init_policy(void);
 void ima_update_policy(void);
 void ima_update_policy_flag(void);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c7e8db0ea4c0..01dfab95b6ac 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -161,6 +161,8 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *        MAY_APPEND)
  * @func: caller identifier
  * @pcr: pointer filled in if matched measure policy sets pcr=
+ * @digest_mask: pointer filled with actions for which digest lookup
+ *               must be disabled
  *
  * The policy is defined in terms of keypairs:
  *		subj=, obj=, type=, func=, mask=, fsmagic=
@@ -172,13 +174,14 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * Returns IMA_MEASURE, IMA_APPRAISE mask.
  *
  */
-int ima_get_action(struct inode *inode, int mask, enum ima_hooks func, int *pcr)
+int ima_get_action(struct inode *inode, int mask, enum ima_hooks func, int *pcr,
+		   int *digest_mask)
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE;
 
 	flags &= ima_policy_flag;
 
-	return ima_match_policy(inode, func, mask, flags, pcr);
+	return ima_match_policy(inode, func, mask, flags, pcr, digest_mask);
 }
 
 /*
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index ec7dfa02c051..285a53452fb5 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -53,7 +53,7 @@ int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
 	if (!ima_appraise)
 		return 0;
 
-	return ima_match_policy(inode, func, mask, IMA_APPRAISE, NULL);
+	return ima_match_policy(inode, func, mask, IMA_APPRAISE, NULL, NULL);
 }
 
 static int ima_fix_xattr(struct dentry *dentry,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 840362734f91..d58199c8435c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -184,6 +184,8 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 	int disable_mask = (func == DIGEST_LIST_CHECK) ?
 			   IMA_DO_MASK & ~IMA_APPRAISE_SUBMASK :
 			   IMA_DO_MASK & ~(IMA_APPRAISE | IMA_APPRAISE_SUBMASK);
+	int disable_mask_policy = (ima_policy_flag & IMA_SEARCH_DIGEST_LIST) ?
+				  IMA_DO_MASK & ~IMA_APPRAISE_SUBMASK : 0;
 
 	if ((func == DIGEST_LIST_METADATA_CHECK || func == DIGEST_LIST_CHECK) &&
 	    !ima_policy_flag)
@@ -196,7 +198,7 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 	 * bitmask based on the appraise/audit/measurement policy.
 	 * Included is the appraise submask.
 	 */
-	action = ima_get_action(inode, mask, func, &pcr);
+	action = ima_get_action(inode, mask, func, &pcr, &disable_mask_policy);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
 	if (func == DIGEST_LIST_METADATA_CHECK || func == DIGEST_LIST_CHECK)
@@ -260,6 +262,7 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 		goto out_digsig;
 
 	digest_lookup = action & ~ima_disable_digest_lookup;
+	digest_lookup &= ~disable_mask_policy;
 	if (digest_lookup) {
 		found_digest = ima_lookup_loaded_digest(iint->ima_hash->digest);
 		if (found_digest) {
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 2767f7901f94..b9d38a0d45a6 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -365,6 +365,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @func: IMA hook identifier
  * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
  * @pcr: set the pcr to extend
+ * @digest_mask: unset actions for which digest lookup should be enabled
  *
  * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
  * conditions.
@@ -374,7 +375,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * than writes so ima_match_policy() is classical RCU candidate.
  */
 int ima_match_policy(struct inode *inode, enum ima_hooks func, int mask,
-		     int flags, int *pcr)
+		     int flags, int *pcr, int *digest_mask)
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
@@ -401,6 +402,8 @@ int ima_match_policy(struct inode *inode, enum ima_hooks func, int mask,
 
 		if ((pcr) && (entry->flags & IMA_PCR))
 			*pcr = entry->pcr;
+		if (digest_mask && (entry->flags & IMA_SEARCH_DIGEST_LIST))
+			*digest_mask &= (~entry->action & IMA_DO_MASK);
 
 		if (!actmask)
 			break;
@@ -421,8 +424,10 @@ void ima_update_policy_flag(void)
 	struct ima_rule_entry *entry;
 
 	list_for_each_entry(entry, ima_rules, list) {
+		int digest_list = entry->flags & IMA_SEARCH_DIGEST_LIST;
+
 		if (entry->action & IMA_DO_MASK)
-			ima_policy_flag |= entry->action;
+			ima_policy_flag |= (entry->action | digest_list);
 	}
 
 	ima_appraise |= temp_ima_appraise;
@@ -540,7 +545,7 @@ enum {
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_permit_directio,
-	Opt_pcr
+	Opt_pcr, Opt_digest_list
 };
 
 static match_table_t policy_tokens = {
@@ -571,6 +576,7 @@ static match_table_t policy_tokens = {
 	{Opt_appraise_type, "appraise_type=%s"},
 	{Opt_permit_directio, "permit_directio"},
 	{Opt_pcr, "pcr=%s"},
+	{Opt_digest_list, "digest_list"},
 	{Opt_err, NULL}
 };
 
@@ -889,6 +895,9 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->flags |= IMA_PCR;
 
 			break;
+		case Opt_digest_list:
+			entry->flags |= IMA_SEARCH_DIGEST_LIST;
+			break;
 		case Opt_err:
 			ima_log_string(ab, "UNKNOWN", p);
 			result = -EINVAL;
@@ -1158,6 +1167,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, "appraise_type=imasig ");
 	if (entry->flags & IMA_PERMIT_DIRECTIO)
 		seq_puts(m, "permit_directio ");
+	if (entry->flags & IMA_SEARCH_DIGEST_LIST)
+		seq_puts(m, "digest_list ");
 	rcu_read_unlock();
 	seq_puts(m, "\n");
 	return 0;
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index a5951879c15c..b46461a5f43f 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -33,6 +33,7 @@
 #define IMA_DIGSIG_REQUIRED	0x02000000
 #define IMA_PERMIT_DIRECTIO	0x04000000
 #define IMA_NEW_FILE		0x08000000
+#define IMA_SEARCH_DIGEST_LIST	0x10000000
 
 #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
 				 IMA_APPRAISE_SUBMASK)
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
