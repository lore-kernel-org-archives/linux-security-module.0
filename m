From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Wed, 22 Mar 2017 19:46:20 +0900
Subject: [PATCH 2/2] LSM: Make security_hook_heads a local variable.
Message-ID: <1490179580-7065-2-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

We might introduce different "struct security_hook_heads" for built-in
LSM modules and dynamically loadable LSM modules when we start allowing
dynamically loadable LSM modules. But even if we decide to use different
lists, there is no need to export "struct security_hook_heads" for
dynamically loadable LSM modules and define different LSM_HOOK_INIT() for
built-in LSM modules and dynamically loadable LSM modules only for
switching list_head's address. Let's use index number within
"struct security_hook_heads" so that we can switch list_head's address
inside the registration function.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Kees Cook <keescook@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <james.l.morris@oracle.com>
---
 include/linux/lsm_hooks.h | 6 +++---
 security/security.c       | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 1aa6333..54191cf 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1877,8 +1877,8 @@ struct security_hook_heads {
  */
 struct security_hook_list {
 	struct list_head		list;
-	struct list_head		*head;
 	union security_list_options	hook;
+	const unsigned int		idx;
 	char				*lsm;
 };
 
@@ -1889,9 +1889,9 @@ struct security_hook_list {
  * text involved.
  */
 #define LSM_HOOK_INIT(HEAD, HOOK) \
-	{ .head = &security_hook_heads.HEAD, .hook = { .HEAD = HOOK } }
+	{ .idx = offsetof(struct security_hook_heads, HEAD) / \
+		sizeof(struct list_head), .hook = { .HEAD = HOOK } }
 
-extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
diff --git a/security/security.c b/security/security.c
index 2f15488..a5868ed 100644
--- a/security/security.c
+++ b/security/security.c
@@ -32,7 +32,7 @@
 /* Maximum number of letters for an LSM name string */
 #define SECURITY_NAME_MAX	10
 
-struct security_hook_heads security_hook_heads __lsm_ro_after_init;
+static struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 char *lsm_names;
 /* Boot-time LSM user choice */
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
@@ -133,10 +133,11 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm)
 {
 	int i;
+	struct list_head *list = (struct list_head *) &security_hook_heads;
 
 	for (i = 0; i < count; i++) {
 		hooks[i].lsm = lsm;
-		list_add_tail_rcu(&hooks[i].list, hooks[i].head);
+		list_add_tail_rcu(&hooks[i].list, &list[hooks[i].idx]);
 	}
 	if (lsm_append(lsm, &lsm_names) < 0)
 		panic("%s - Cannot get early memory.\n", __func__);
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
