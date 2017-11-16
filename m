From: joe@perches.com (Joe Perches)
Date: Thu, 16 Nov 2017 07:27:29 -0800
Subject: [PATCH 4/4] ima: Fix line continuation format
In-Reply-To: <cover.1510845910.git.joe@perches.com>
References: <cover.1510845910.git.joe@perches.com>
Message-ID: <ea357947f2cbac6cd7ace62c92831d0d6d403ea8.1510845910.git.joe@perches.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Line continuations with excess spacing causes unexpected output.

Signed-off-by: Joe Perches <joe@perches.com>
---
 security/integrity/ima/ima_template.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 7412d0291ab9..30db39b23804 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -377,8 +377,7 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 			break;
 
 		if (hdr[HDR_TEMPLATE_NAME].len >= MAX_TEMPLATE_NAME_LEN) {
-			pr_err("attempting to restore a template name \
-				that is too long\n");
+			pr_err("attempting to restore a template name that is too long\n");
 			ret = -EINVAL;
 			break;
 		}
@@ -389,8 +388,8 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 		template_name[hdr[HDR_TEMPLATE_NAME].len] = 0;
 
 		if (strcmp(template_name, "ima") == 0) {
-			pr_err("attempting to restore an unsupported \
-				template \"%s\" failed\n", template_name);
+			pr_err("attempting to restore an unsupported template \"%s\" failed\n",
+			       template_name);
 			ret = -EINVAL;
 			break;
 		}
@@ -410,8 +409,8 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 						&(template_desc->fields),
 						&(template_desc->num_fields));
 		if (ret < 0) {
-			pr_err("attempting to restore the template fmt \"%s\" \
-				failed\n", template_desc->fmt);
+			pr_err("attempting to restore the template fmt \"%s\" failed\n",
+			       template_desc->fmt);
 			ret = -EINVAL;
 			break;
 		}
-- 
2.15.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
