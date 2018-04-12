From: sargun@sargun.me (Sargun Dhillon)
Date: Thu, 12 Apr 2018 02:25:39 +0000
Subject: [PATCH] security: Remove unused field from security_hook_list
Message-ID: <20180412022536.GA8919@ircssh-2.c.rugged-nimbus-611.internal>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

It appears like char * lsm on struct security_hook_list is unused. Even
since its inception: https://patchwork.kernel.org/patch/9525051/
it hasn't been read, only written to. This removes that.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/linux/lsm_hooks.h | 1 -
 security/security.c       | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ac491137b10a..ea07e9cdfee0 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1966,7 +1966,6 @@ struct security_hook_list {
 	struct hlist_node		list;
 	struct hlist_head		*head;
 	union security_list_options	hook;
-	char				*lsm;
 } __randomize_layout;
 
 /*
diff --git a/security/security.c b/security/security.c
index dd246a38b3f0..b0a34961d0a3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -161,10 +161,8 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 {
 	int i;
 
-	for (i = 0; i < count; i++) {
-		hooks[i].lsm = lsm;
+	for (i = 0; i < count; i++)
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
-	}
 	if (lsm_append(lsm, &lsm_names) < 0)
 		panic("%s - Cannot get early memory.\n", __func__);
 }
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
