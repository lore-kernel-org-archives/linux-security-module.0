From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 13 Jun 2018 16:00:03 +0100
Subject: [PATCH v3] integrity: silence warning when CONFIG_SECURITYFS is not
	enabled
In-Reply-To: <1528194345-9956-1-git-send-email-sudeep.holla@arm.com>
References: <1528194345-9956-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1528902003-863-1-git-send-email-sudeep.holla@arm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

When CONFIG_SECURITYFS is not enabled, securityfs_create_dir returns
-ENODEV which throws the following error:
	"Unable to create integrity sysfs dir: -19"

However, if the feature is disabled, it can't be warning and hence
we need to silence the error. This patch checks for the error -ENODEV
which is returned when CONFIG_SECURITYFS is disabled to stop the error
being thrown.

Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Matthew Garrett <mjg59@google.com>
Acked-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 security/integrity/iint.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Hi Mimi Zohar,

Extremely sorry for the silly mistake. Somehow my aarch64 toolchain
doesn't complain about this and I failed to notice though it's so
obvious.

Regards,
Sudeep

v2->v3:
	- Fix the format specifier for pr_err(%d instead of %ld)
	- Replace "sysfs" to "securityfs" in the dmesg as suggested by
	  Mimi Zohar
v1->v2:
	- Check for -ENODEV rather than IS_ENABLED(..) as suggested by
	  Matthew Garrett

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 149faa81f6f0..ba605714aac4 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -219,10 +219,13 @@ static int __init integrity_fs_init(void)
 {
 	integrity_dir = securityfs_create_dir("integrity", NULL);
 	if (IS_ERR(integrity_dir)) {
-		pr_err("Unable to create integrity sysfs dir: %ld\n",
-		       PTR_ERR(integrity_dir));
+		int ret = PTR_ERR(integrity_dir);
+
+		if (ret != -ENODEV)
+			pr_err("Unable to create integrity securityfs dir: %d\n",
+			       ret);
 		integrity_dir = NULL;
-		return PTR_ERR(integrity_dir);
+		return ret;
 	}
 
 	return 0;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
