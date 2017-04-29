From: mic@digikod.net (=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=)
Date: Sat, 29 Apr 2017 21:02:57 +0200
Subject: [PATCH v1] LSM: Enable multiple calls to security_add_hooks() for the
	same LSM
Message-ID: <20170429190257.27137-1-mic@digikod.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Check if the registering LSM already registered hooks just before. This
enable to split hook declarations into multiple files without
registering multiple time the same LSM name, starting from commit
d69dece5f5b6 ("LSM: Add /sys/kernel/security/lsm").

Signed-off-by: Micka?l Sala?n <mic@digikod.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <james.l.morris@oracle.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Link: https://lkml.kernel.org/r/ccad825b-7a58-e499-e51b-bd7c98581afe at schaufler-ca.com
---
 security/security.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/security/security.c b/security/security.c
index 549bddcc2116..6be65050b268 100644
--- a/security/security.c
+++ b/security/security.c
@@ -25,6 +25,7 @@
 #include <linux/mount.h>
 #include <linux/personality.h>
 #include <linux/backing-dev.h>
+#include <linux/string.h>
 #include <net/flow.h>
 
 #define MAX_LSM_EVM_XATTR	2
@@ -86,6 +87,32 @@ static int __init choose_lsm(char *str)
 }
 __setup("security=", choose_lsm);
 
+static bool match_last_lsm(const char *list, const char *last)
+{
+	size_t list_len, last_len, i;
+
+	if (!list || !last)
+		return false;
+	list_len = strlen(list);
+	last_len = strlen(last);
+	if (!last_len || !list_len)
+		return false;
+	if (last_len > list_len)
+		return false;
+
+	for (i = 0; i < last_len; i++) {
+		if (list[list_len - 1 - i] != last[last_len - 1 - i])
+			return false;
+	}
+	/* Check if last_len == list_len */
+	if (i == list_len)
+		return true;
+	/* Check if it is a full name */
+	if (list[list_len - 1 - i] == ',')
+		return true;
+	return false;
+}
+
 static int lsm_append(char *new, char **result)
 {
 	char *cp;
@@ -93,6 +120,9 @@ static int lsm_append(char *new, char **result)
 	if (*result == NULL) {
 		*result = kstrdup(new, GFP_KERNEL);
 	} else {
+		/* Check if it is the last registered name */
+		if (match_last_lsm(*result, new))
+			return 0;
 		cp = kasprintf(GFP_KERNEL, "%s,%s", *result, new);
 		if (cp == NULL)
 			return -ENOMEM;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
