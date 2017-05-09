From: labbott@redhat.com (Laura Abbott)
Date: Tue,  9 May 2017 11:25:27 -0700
Subject: [PATCH] ima: Add cgroups2 to the defaults list
Message-ID: <20170509182527.20492-1-labbott@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

cgroups2 is beginning to show up in wider usage. Add it to the default
nomeasure/noappraise list like other filesystems.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 security/integrity/ima/ima_policy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 3ab1067db624..d60889352dda 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -96,6 +96,8 @@ static struct ima_rule_entry dont_measure_rules[] __ro_after_init = {
 	{.action = DONT_MEASURE, .fsmagic = SELINUX_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_MEASURE, .fsmagic = CGROUP_SUPER_MAGIC,
 	 .flags = IMA_FSMAGIC},
+	{.action = DONT_MEASURE, .fsmagic = CGROUP2_SUPER_MAGIC,
+	 .flags = IMA_FSMAGIC},
 	{.action = DONT_MEASURE, .fsmagic = NSFS_MAGIC, .flags = IMA_FSMAGIC}
 };
 
@@ -139,6 +141,7 @@ static struct ima_rule_entry default_appraise_rules[] __ro_after_init = {
 	{.action = DONT_APPRAISE, .fsmagic = SELINUX_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_APPRAISE, .fsmagic = NSFS_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_APPRAISE, .fsmagic = CGROUP_SUPER_MAGIC, .flags = IMA_FSMAGIC},
+	{.action = DONT_APPRAISE, .fsmagic = CGROUP2_SUPER_MAGIC, .flags = IMA_FSMAGIC},
 #ifdef CONFIG_IMA_WRITE_POLICY
 	{.action = APPRAISE, .func = POLICY_CHECK,
 	.flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
-- 
2.12.2

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
