From: zenczykowski@gmail.com (=?UTF-8?q?Maciej=20=C5=BBenczykowski?=)
Date: Thu, 21 Dec 2017 13:06:05 -0800
Subject: [PATCH] userns: honour no_new_privs for cap_bset during user ns
	creation/switch
Message-ID: <20171221210605.181720-1-zenczykowski@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Maciej ?enczykowski <maze@google.com>

This allows locking down user namespaces tighter,
and it could even be considered a security fix.

Signed-off-by: Maciej ?enczykowski <maze@google.com>
---
 kernel/user_namespace.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 246d4d4ce5c7..2354f7ade78a 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -50,11 +50,12 @@ static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
 	 * anything as the capabilities are bound to the new user namespace.
 	 */
 	cred->securebits = SECUREBITS_DEFAULT;
+	cred->cap_bset = task_no_new_privs(current) ? current_cred()->cap_bset
+						    : CAP_FULL_SET;
 	cred->cap_inheritable = CAP_EMPTY_SET;
-	cred->cap_permitted = CAP_FULL_SET;
-	cred->cap_effective = CAP_FULL_SET;
+	cred->cap_permitted = cred->cap_bset;
+	cred->cap_effective = cred->cap_bset;
 	cred->cap_ambient = CAP_EMPTY_SET;
-	cred->cap_bset = CAP_FULL_SET;
 #ifdef CONFIG_KEYS
 	key_put(cred->request_key_auth);
 	cred->request_key_auth = NULL;
-- 
2.15.1.620.gb9897f4670-goog

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
