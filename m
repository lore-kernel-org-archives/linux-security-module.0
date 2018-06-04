From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon,  4 Jun 2018 15:05:21 +0100
Subject: [PATCH] integrity: silence warning when CONFIG_SECURITYFS is not
	enabled
Message-ID: <1528121121-3959-1-git-send-email-sudeep.holla@arm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

When CONFIG_SECURITYFS is not enabled, securityfs_create_dir returns
-ENODEV which throws the following error:
	"Unable to create integrity sysfs dir: -19"

However, if the feature is disabled, it can't be warning and hence
we need to silence the error.

Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Matthew Garrett <mjg59@google.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 security/integrity/iint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 149faa81f6f0..8082491876f9 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -218,7 +218,7 @@ void __init integrity_load_keys(void)
 static int __init integrity_fs_init(void)
 {
 	integrity_dir = securityfs_create_dir("integrity", NULL);
-	if (IS_ERR(integrity_dir)) {
+	if (IS_ENABLED(CONFIG_SECURITYFS) && IS_ERR(integrity_dir)) {
 		pr_err("Unable to create integrity sysfs dir: %ld\n",
 		       PTR_ERR(integrity_dir));
 		integrity_dir = NULL;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
