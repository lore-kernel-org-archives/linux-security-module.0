From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 7 Nov 2017 11:37:05 +0100
Subject: [PATCH v2 10/15] ima: disable digest lookup if digest lists are not
	checked
In-Reply-To: <20171107103710.10883-1-roberto.sassu@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
Message-ID: <20171107103710.10883-11-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch introduces two new hooks DIGEST_LIST_METADATA_CHECK and
DIGEST_LIST_CHECK, which are called respectively when parsing digest list
metadata and digest lists.

It also checks that rules for these two hooks are always specified in the
current policy. Without them, digest lists could be uploaded to IMA without
adding a new entry to the measurement list, without verifying the
signature, or without auditing the operation. Digest lookup is disabled for
each missing policy action (measure, appraise, audit).

Digest lookup is also disabled if CONFIG_IMA_DIGEST_LIST is not defined.

Changelog

v1:
- clear IMA_MEASURE action flag only if it was in the policy
- check if at least one action is allowed before searching the file digest
- retrieve ima_digest structure
- set IMA action flags in ima_disable_digest_lookup
- added DIGEST_LIST_METADATA_CHECK hook
- update MEASURE/APPRAISE policies

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h        |  2 ++
 security/integrity/ima/ima_main.c   | 38 +++++++++++++++++++++++++++++++++++--
 security/integrity/ima/ima_policy.c | 16 ++++++++++++++++
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 1f43284788eb..4b3b1ca5c09a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -204,6 +204,8 @@ static inline unsigned long ima_hash_key(u8 *digest)
 	hook(KEXEC_KERNEL_CHECK)	\
 	hook(KEXEC_INITRAMFS_CHECK)	\
 	hook(POLICY_CHECK)		\
+	hook(DIGEST_LIST_METADATA_CHECK)		\
+	hook(DIGEST_LIST_CHECK)		\
 	hook(MAX_CHECK)
 #define __ima_hook_enumify(ENUM)	ENUM,
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 766fe2e77419..840362734f91 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -29,6 +29,12 @@
 
 int ima_initialized;
 
+#ifdef CONFIG_IMA_DIGEST_LIST
+static int ima_disable_digest_lookup;
+#else
+static int ima_disable_digest_lookup = IMA_DO_MASK & ~IMA_APPRAISE_SUBMASK;
+#endif
+
 #ifdef CONFIG_IMA_APPRAISE
 int ima_appraise = IMA_APPRAISE_ENFORCE;
 #else
@@ -168,12 +174,20 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 	char *pathbuf = NULL;
 	char filename[NAME_MAX];
 	const char *pathname = NULL;
-	int rc = -ENOMEM, action, must_appraise;
+	int rc = -ENOMEM, action, action_done, must_appraise, digest_lookup;
 	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
+	struct ima_digest *found_digest = NULL;
 	struct evm_ima_xattr_data *xattr_value = NULL;
 	int xattr_len = 0;
 	bool violation_check;
 	enum hash_algo hash_algo;
+	int disable_mask = (func == DIGEST_LIST_CHECK) ?
+			   IMA_DO_MASK & ~IMA_APPRAISE_SUBMASK :
+			   IMA_DO_MASK & ~(IMA_APPRAISE | IMA_APPRAISE_SUBMASK);
+
+	if ((func == DIGEST_LIST_METADATA_CHECK || func == DIGEST_LIST_CHECK) &&
+	    !ima_policy_flag)
+		ima_disable_digest_lookup = disable_mask;
 
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return 0;
@@ -185,6 +199,9 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 	action = ima_get_action(inode, mask, func, &pcr);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
+	if (func == DIGEST_LIST_METADATA_CHECK || func == DIGEST_LIST_CHECK)
+		ima_disable_digest_lookup |= (~action & disable_mask);
+
 	if (!action && !violation_check)
 		return 0;
 
@@ -242,6 +259,21 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 	if (rc != 0 && rc != -EBADF && rc != -EINVAL)
 		goto out_digsig;
 
+	digest_lookup = action & ~ima_disable_digest_lookup;
+	if (digest_lookup) {
+		found_digest = ima_lookup_loaded_digest(iint->ima_hash->digest);
+		if (found_digest) {
+			action_done = digest_lookup & (IMA_MEASURE | IMA_AUDIT);
+			action &= ~action_done;
+			iint->flags |= (action_done << 1);
+
+			if (!(digest_lookup & IMA_APPRAISE))
+				found_digest = NULL;
+			if (digest_lookup & IMA_MEASURE)
+				iint->measured_pcrs |= (0x1 << pcr);
+		}
+	}
+
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
@@ -378,7 +410,9 @@ static int read_idmap[READING_MAX_ID] = {
 	[READING_MODULE] = MODULE_CHECK,
 	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
 	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
-	[READING_POLICY] = POLICY_CHECK
+	[READING_POLICY] = POLICY_CHECK,
+	[READING_DIGEST_LIST_METADATA] = DIGEST_LIST_METADATA_CHECK,
+	[READING_DIGEST_LIST] = DIGEST_LIST_CHECK
 };
 
 /**
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index ee4613fa5840..2767f7901f94 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -127,9 +127,20 @@ static struct ima_rule_entry default_measurement_rules[] __ro_after_init = {
 	{.action = MEASURE, .func = MODULE_CHECK, .flags = IMA_FUNC},
 	{.action = MEASURE, .func = FIRMWARE_CHECK, .flags = IMA_FUNC},
 	{.action = MEASURE, .func = POLICY_CHECK, .flags = IMA_FUNC},
+#ifdef CONFIG_IMA_DIGEST_LIST
+	{.action = MEASURE, .func = DIGEST_LIST_METADATA_CHECK,
+	 .flags = IMA_FUNC},
+	{.action = MEASURE, .func = DIGEST_LIST_CHECK, .flags = IMA_FUNC},
+#endif
 };
 
 static struct ima_rule_entry default_appraise_rules[] __ro_after_init = {
+#ifdef CONFIG_IMA_DIGEST_LIST
+	{.action = APPRAISE, .func = DIGEST_LIST_METADATA_CHECK,
+	 .flags = IMA_FUNC},
+	{.action = APPRAISE, .func = DIGEST_LIST_CHECK,
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+#endif
 	{.action = DONT_APPRAISE, .fsmagic = PROC_SUPER_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_APPRAISE, .fsmagic = SYSFS_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_APPRAISE, .fsmagic = DEBUGFS_MAGIC, .flags = IMA_FSMAGIC},
@@ -699,6 +710,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->func = KEXEC_INITRAMFS_CHECK;
 			else if (strcmp(args[0].from, "POLICY_CHECK") == 0)
 				entry->func = POLICY_CHECK;
+			else if (strcmp(args[0].from, "DIGEST_LIST_CHECK") == 0)
+				entry->func = DIGEST_LIST_CHECK;
+			else if (strcmp(args[0].from,
+				 "DIGEST_LIST_METADATA_CHECK") == 0)
+				entry->func = DIGEST_LIST_METADATA_CHECK;
 			else
 				result = -EINVAL;
 			if (!result)
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
