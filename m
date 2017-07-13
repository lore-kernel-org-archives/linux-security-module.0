From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 13 Jul 2017 09:54:50 -0400
Subject: [PATCH v3 4/4] ima: define "fs_unsafe" builtin policy
In-Reply-To: <1499954090-30054-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1499954090-30054-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1499954090-30054-5-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Permit normally denied access/execute permission for files in policy
on IMA unsupported filesystems.  This patch defines "fs_unsafe", a
builtin policy.

Mimi Zohar <zohar@linux.vnet.ibm.com>

Changelog v3:
- include dont_failsafe rule when displaying policy
---
 Documentation/admin-guide/kernel-parameters.txt |  8 +++++++-
 security/integrity/ima/ima_policy.c             | 12 ++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e438a1fca554..0aed01aabc16 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1478,7 +1478,7 @@
 
 	ima_policy=	[IMA]
 			The builtin policies to load during IMA setup.
-			Format: "tcb | appraise_tcb | secure_boot"
+			Format: "tcb | appraise_tcb | secure_boot | fs_unsafe"
 
 			The "tcb" policy measures all programs exec'd, files
 			mmap'd for exec, and all files opened with the read
@@ -1493,6 +1493,12 @@
 			of files (eg. kexec kernel image, kernel modules,
 			firmware, policy, etc) based on file signatures.
 
+			The "fs_unsafe" policy permits normally denied
+			access/execute permission for files in policy on IMA
+			unsupported filesystems.  Note this option, as the
+			name implies, is not safe and not recommended for
+			any environments other than testing.
+
 	ima_tcb		[IMA] Deprecated.  Use ima_policy= instead.
 			Load a policy which meets the needs of the Trusted
 			Computing Base.  This means IMA will measure all
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 3c29aa4e7980..6b77b890ff96 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -169,6 +169,10 @@ static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {
 	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
 };
 
+static struct ima_rule_entry dont_failsafe_rules[] __ro_after_init = {
+	{.action = DONT_FAILSAFE}
+};
+
 static LIST_HEAD(ima_default_rules);
 static LIST_HEAD(ima_policy_rules);
 static LIST_HEAD(ima_temp_rules);
@@ -188,6 +192,7 @@ __setup("ima_tcb", default_measure_policy_setup);
 
 static bool ima_use_appraise_tcb __initdata;
 static bool ima_use_secure_boot __initdata;
+static bool ima_use_dont_failsafe __initdata;
 static int __init policy_setup(char *str)
 {
 	char *p;
@@ -201,6 +206,10 @@ static int __init policy_setup(char *str)
 			ima_use_appraise_tcb = 1;
 		else if (strcmp(p, "secure_boot") == 0)
 			ima_use_secure_boot = 1;
+		else if (strcmp(p, "fs_unsafe") == 0) {
+			ima_use_dont_failsafe = 1;
+			set_failsafe(0);
+		}
 	}
 
 	return 1;
@@ -470,6 +479,9 @@ void __init ima_init_policy(void)
 			temp_ima_appraise |= IMA_APPRAISE_POLICY;
 	}
 
+	if (ima_use_dont_failsafe)
+		list_add_tail(&dont_failsafe_rules[0].list, &ima_default_rules);
+
 	ima_rules = &ima_default_rules;
 	ima_update_policy_flag();
 }
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
