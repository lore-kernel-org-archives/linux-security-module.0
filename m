From: sargun@sargun.me (Sargun Dhillon)
Date: Wed, 25 Apr 2018 08:59:07 +0000
Subject: [PATCH v7 2/6] security: Make security_hook_heads private
In-Reply-To: <cover.1524645853.git.sargun@sargun.me>
References: <cover.1524645853.git.sargun@sargun.me>
Message-ID: <fca9f1bcd6d0284844c65221de07bc4335595b9a.1524645853.git.sargun@sargun.me>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This is in preparation for future patches. The pointer to the hook
head is no longer embedded in the security_hook_list structure,
and instead, now there is an offset.

In addition, since struct security_hook_heads is a static defined
in security.c, and it's full of hlist_heads, who's initialization
involves setting them to null, there's no more reason for explicit
initialization.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/linux/lsm_hooks.h                     | 10 +++++---
 scripts/gcc-plugins/randomize_layout_plugin.c |  2 --
 security/security.c                           | 34 +++++++++++++++++----------
 security/security.h                           |  3 ++-
 4 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 65f346cb6639..93bb0f8a597f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2014,7 +2014,7 @@ struct lsm_info {
 
 struct security_hook_list {
 	struct hlist_node		list;
-	struct hlist_head		*head;
+	const unsigned int		offset;
 	union security_list_options	hook;
 	/* This field is not currently in use */
 	struct lsm_info			*info;
@@ -2026,8 +2026,13 @@ struct security_hook_list {
  * care of the common case and reduces the amount of
  * text involved.
  */
+#define HOOK_OFFSET(HEAD)	offsetof(struct security_hook_heads, HEAD)
+
 #define LSM_HOOK_INIT(HEAD, HOOK) \
-	{ .head = &security_hook_heads.HEAD, .hook = { .HEAD = HOOK } }
+	{					\
+		.offset	= HOOK_OFFSET(HEAD),	\
+		.hook	= { .HEAD = HOOK }	\
+	}
 
 #define LSM_MODULE_INIT(NAME, HOOKS)		\
 	{					\
@@ -2036,7 +2041,6 @@ struct security_hook_list {
 		.count	= ARRAY_SIZE(HOOKS),	\
 	}
 
-extern struct security_hook_heads security_hook_heads;
 extern void security_add_hooks(struct lsm_info *lsm);
 
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 6d5bbd31db7f..d94138999427 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -52,8 +52,6 @@ static const struct whitelist_entry whitelist[] = {
 	{ "net/unix/af_unix.c", "unix_skb_parms", "char" },
 	/* big_key payload.data struct splashing */
 	{ "security/keys/big_key.c", "path", "void *" },
-	/* walk struct security_hook_heads as an array of struct hlist_head */
-	{ "security/security.c", "hlist_head", "security_hook_heads" },
 	{ }
 };
 
diff --git a/security/security.c b/security/security.c
index 36b9d2b0a135..acdbf65bd752 100644
--- a/security/security.c
+++ b/security/security.c
@@ -41,9 +41,13 @@
 
 DEFINE_MUTEX(lsm_info_lock);
 struct hlist_head lsm_info_head __lsm_ro_after_init = HLIST_HEAD_INIT;
-struct security_hook_heads security_hook_heads __lsm_ro_after_init;
+static struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
+struct security_hook_heads *get_security_hook_heads(void)
+{
+	return &security_hook_heads;
+}
 
 /* Boot-time LSM user choice */
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
@@ -70,12 +74,6 @@ static void __init do_security_initcalls(void)
  */
 int __init security_init(void)
 {
-	int i;
-	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
-
-	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
-	     i++)
-		INIT_HLIST_HEAD(&list[i]);
 	pr_info("Security Framework initialized\n");
 
 	/*
@@ -152,6 +150,20 @@ void security_delete_hooks(struct lsm_info *info)
 	mutex_unlock(&lsm_info_lock);
 }
 #endif /* CONFIG_SECURITY_SELINUX_DISABLE */
+
+static void __init security_add_hook(struct security_hook_list *hook,
+					struct lsm_info *info)
+{
+	const unsigned int offset = hook->offset;
+	const unsigned int idx = offset / sizeof(struct hlist_head);
+	struct hlist_head *head;
+
+	WARN_ON(offset % sizeof(struct hlist_head));
+
+	hook->info = info;
+	head = (struct hlist_head *)(&security_hook_heads) + idx;
+	hlist_add_tail_rcu(&hook->list, head);
+}
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @lsm_info: The lsm_info struct for this security module
@@ -160,14 +172,10 @@ void security_delete_hooks(struct lsm_info *info)
  */
 void __init security_add_hooks(struct lsm_info *info)
 {
-	struct security_hook_list *hook;
 	int i;
 
-	for (i = 0; i < info->count; i++) {
-		hook = &info->hooks[i];
-		hook->info = info;
-		hlist_add_tail_rcu(&hook->list, hook->head);
-	}
+	for (i = 0; i < info->count; i++)
+		security_add_hook(&info->hooks[i], info);
 
 	mutex_lock(&lsm_info_lock);
 	hlist_add_tail_rcu(&info->list, &lsm_info_head);
diff --git a/security/security.h b/security/security.h
index 79d1388fb038..b4d1a60862c3 100644
--- a/security/security.h
+++ b/security/security.h
@@ -5,6 +5,7 @@
 
 #ifndef __SECURITY_SECURITY_H
 #define __SECURITY_SECURITY_H
-extern struct hlist_head lsm_info_head;
 extern struct mutex lsm_info_lock;
+extern struct hlist_head lsm_info_head;
+extern struct security_hook_heads *get_security_hook_heads(void);
 #endif
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
