From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 25 Jul 2017 17:44:21 +0200
Subject: [PATCH 10/12] ima: disable digest lookup if digest lists are not
	measured
In-Reply-To: <20170725154423.24845-1-roberto.sassu@huawei.com>
References: <20170725154423.24845-1-roberto.sassu@huawei.com>
Message-ID: <20170725154423.24845-11-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Loading digest lists affects the behavior of IMA, as files whose digest
has been uploaded will not be displayed in the measurement list.
If the digest lists loading event is not reported, verifiers would believe
that the files with uploaded digests have not been accessed.

To prevent this, the DIGEST_CHECK hook has been defined and a new rule
to measure files accessed by the new hook has been added to the default
policy. If the currently loaded policy does not contain that rule,
digest lookup is disabled.

Digest lookup is also disabled if CONFIG_IMA_DIGEST_LIST is not defined.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_main.c   | 15 ++++++++++++++-
 security/integrity/ima/ima_policy.c |  1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 77dd4d0..2a558ee 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -199,6 +199,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
 	hook(KEXEC_KERNEL_CHECK)	\
 	hook(KEXEC_INITRAMFS_CHECK)	\
 	hook(POLICY_CHECK)		\
+	hook(DIGEST_LIST_CHECK)		\
 	hook(MAX_CHECK)
 #define __ima_hook_enumify(ENUM)	ENUM,
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2aebb79..c329549 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -29,6 +29,12 @@
 
 int ima_initialized;
 
+#ifdef CONFIG_IMA_DIGEST_LIST
+static int ima_disable_digest_check;
+#else
+static int ima_disable_digest_check = 1;
+#endif
+
 #ifdef CONFIG_IMA_APPRAISE
 int ima_appraise = IMA_APPRAISE_ENFORCE;
 #else
@@ -171,6 +177,9 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 	bool violation_check;
 	enum hash_algo hash_algo;
 
+	if (func == DIGEST_LIST_CHECK && !ima_policy_flag)
+		ima_disable_digest_check = 1;
+
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return 0;
 
@@ -181,6 +190,9 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 	action = ima_get_action(inode, mask, func, &pcr);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
+	if (func == DIGEST_LIST_CHECK && !(action & IMA_MEASURE))
+		ima_disable_digest_check = 1;
+
 	if (!action && !violation_check)
 		return 0;
 
@@ -375,7 +387,8 @@ static int read_idmap[READING_MAX_ID] = {
 	[READING_MODULE] = MODULE_CHECK,
 	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
 	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
-	[READING_POLICY] = POLICY_CHECK
+	[READING_POLICY] = POLICY_CHECK,
+	[READING_DIGEST_LIST] = DIGEST_LIST_CHECK
 };
 
 /**
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 95209a5..b5c004d 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -127,6 +127,7 @@ static struct ima_rule_entry default_measurement_rules[] __ro_after_init = {
 	{.action = MEASURE, .func = MODULE_CHECK, .flags = IMA_FUNC},
 	{.action = MEASURE, .func = FIRMWARE_CHECK, .flags = IMA_FUNC},
 	{.action = MEASURE, .func = POLICY_CHECK, .flags = IMA_FUNC},
+	{.action = MEASURE, .func = DIGEST_LIST_CHECK, .flags = IMA_FUNC},
 };
 
 static struct ima_rule_entry default_appraise_rules[] __ro_after_init = {
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
