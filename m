From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 21 Jun 2017 14:18:24 -0400
Subject: [PATCH v2 04/10] ima: define "fs_unsafe" builtin policy
In-Reply-To: <1498069110-10009-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1498069110-10009-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <1498069110-10009-5-git-send-email-zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Permit normally denied access/execute permission for files in policy
on IMA unsupported filesystems.  This patch defines "fs_unsafe", a
builtin policy.

Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 8 +++++++-
 security/integrity/ima/ima_policy.c             | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

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
index cb92c9c04e80..4ff5640522c7 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -200,6 +200,8 @@ static int __init policy_setup(char *str)
 			ima_use_appraise_tcb = 1;
 		else if (strcmp(p, "secure_boot") == 0)
 			ima_use_secure_boot = 1;
+		else if (strcmp(p, "fs_unsafe") == 0)
+			set_failsafe(0);
 	}
 
 	return 1;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
