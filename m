From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 28 Jul 2018 10:24:42 +0800
Subject: [RFC PATCH] ima: arch_policy_rules can be static
In-Reply-To: <20180725233200.761-2-erichte@linux.vnet.ibm.com>
References: <20180725233200.761-2-erichte@linux.vnet.ibm.com>
Message-ID: <20180728022442.GA100797@lkp-g5>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


Fixes: b4c0791e0fac ("ima: add support for arch specific policies")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 ima_policy.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index b47db4d..e1f2ffd 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -195,8 +195,8 @@ static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {
 };
 
 /* An array of architecture specific rules */
-struct ima_rule_entry **arch_policy_rules __ro_after_init;
-struct ima_rule_entry *arch_policy_entry __ro_after_init;
+static struct ima_rule_entry **arch_policy_rules __ro_after_init;
+static struct ima_rule_entry *arch_policy_entry __ro_after_init;
 
 static LIST_HEAD(ima_default_rules);
 static LIST_HEAD(ima_policy_rules);
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
