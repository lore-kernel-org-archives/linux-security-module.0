From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Fri, 27 Apr 2018 22:25:26 +0900
Subject: [PATCH v7 0/6] Safe LSM (un)loading, and immutable hooks
In-Reply-To: <CAMp4zn-Y333bSX2EX-5M+-Mu1m9EeeAP203v=HJOFLPVmoUpNA@mail.gmail.com>
References: <201804260715.w3Q7FOlb036047@www262.sakura.ne.jp>
	<CAMp4zn9ojWn5oNMgZ6OKQR4=JhSnsrCzO443a8A71xfo_eLzHA@mail.gmail.com>
	<201804262107.HGG56259.OFOtHSOFQLVFJM@I-love.SAKURA.ne.jp>
	<CAMp4zn85hvdT2b0qsKWqxyC-5m=Y414akM1wjVH5qrZpgLE-bw@mail.gmail.com>
	<CAMp4zn-Y333bSX2EX-5M+-Mu1m9EeeAP203v=HJOFLPVmoUpNA@mail.gmail.com>
Message-ID: <201804272225.DAC82348.OFtSVOJOHLFMQF@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Sargun Dhillon wrote:
> > inode_free_security is called on all LSM callbacks -- so, it should
> > be, as long as people don't load unloadable major LSMs. If we want to
> > be super conservative here, we can do a try_module_get, and a
> > module_put if RC != 0 on RW hooks. So, we could have something like
> > call_int_hook_major, and call_void_hook_major.

I don't think we want to play with module usage count.

> >
> >>         }
> >>         /*** End of changes made by this series ***/
> >>         return 0;
> >> }
> >>
> >> and what Casey's series is doing is
> >>
> >> int security_inode_alloc(struct inode *inode)
> >> {
> >>         struct security_hook_list *P;
> >>         inode->i_security = NULL;
> >>         hlist_for_each_entry(P, &security_hook_heads.inode_alloc_security, list) {
> >>                 int RC = P->hook.inode_alloc_security(inode);
> >>                 if (RC != 0) {
> >>                         /*** Start of changes made by Casey's series ***/
> >>                         hlist_for_each_entry(P, &security_hook_heads.inode_free_security, list) {
> >>                                 P->hook.inode_free_security(inode); // <= Might call inode_free_security() without corresponding successful inode_alloc_security().
> >>                         }
> >>                         /*** End of changes made by Casey's series ***/
> >>                         return RC;
> >>                 }
> >>         }
> >>         return 0;
> >> }
> > Right, but this could be taken care of by just ensuring that nobody
> > allocates blobs (major LSM), and only one LSM returns a non-zero to
> > the *alloc* callbacks? Right now, we have this because one has to be a
> > "major" LSM in order to use these callbacks, and we ensure only one
> > major LSM is active at a time.

What Casey is trying to do is allow multiple major modules to use their
own blob. Thus,

> >
> > I suggest that either in the short term we:
> > 1) Trust people not to load a second major LSM,

this is not an option.

> > 2) See below.
> >
> > What about something as stupid as:

I don't think we want to do this.

> One other aspect that may not be obvious is on the *_alloc_*,
> callbacks, we wouldn't want to call callback's of LSMs which are
> non-major.

What both your series and Casey's series are missing will be as simple as below.
Apart from whether memory for security blobs should be managed by infrastructure or
by individual module, we will need to do something like below.

PATCH 1/2: Baseline for allowing safe runtime registration.

This patch allows multiple major LSM modules to safely manage their blobs
(though memory for security blobs need to be managed by individual module),
by calling only release hooks where corresponding alloc hook succeeded when
one of alloc hook returned an error. And thereby this patch makes it possible
to load LKM-based LSM modules.
---
 include/linux/lsm_hooks.h                     |  21 +--
 scripts/gcc-plugins/randomize_layout_plugin.c |   2 -
 security/Kconfig                              |  14 +-
 security/security.c                           | 184 +++++++++++++++++---------
 4 files changed, 148 insertions(+), 73 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9d0b286..083dea6 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2005,10 +2005,10 @@ struct security_hook_heads {
  * For use with generic list macros for common operations.
  */
 struct security_hook_list {
-	struct hlist_node		list;
-	struct hlist_head		*head;
-	union security_list_options	hook;
-	char				*lsm;
+	struct hlist_node			list;
+	const unsigned int			offset;
+	const union security_list_options	hook;
+	const char				*lsm;
 } __randomize_layout;
 
 /*
@@ -2017,14 +2017,16 @@ struct security_hook_list {
  * care of the common case and reduces the amount of
  * text involved.
  */
-#define LSM_HOOK_INIT(HEAD, HOOK) \
-	{ .head = &security_hook_heads.HEAD, .hook = { .HEAD = HOOK } }
+#define LSM_HOOK_INIT(HEAD, HOOK)				\
+	{							\
+		.offset = offsetof(struct security_hook_heads, HEAD),	\
+		.hook = { .HEAD = HOOK }				\
+	}
 
-extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
-extern void security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm);
+extern int security_add_hooks(struct security_hook_list *hooks, int count,
+			      const char *lsm);
 
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 /*
@@ -2049,7 +2051,6 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 }
 #endif /* CONFIG_SECURITY_SELINUX_DISABLE */
 
-/* Currently required to handle SELinux runtime hook disable. */
 #ifdef CONFIG_SECURITY_WRITABLE_HOOKS
 #define __lsm_ro_after_init
 #else
diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 6d5bbd3..d941389 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -52,8 +52,6 @@ struct whitelist_entry {
 	{ "net/unix/af_unix.c", "unix_skb_parms", "char" },
 	/* big_key payload.data struct splashing */
 	{ "security/keys/big_key.c", "path", "void *" },
-	/* walk struct security_hook_heads as an array of struct hlist_head */
-	{ "security/security.c", "hlist_head", "security_hook_heads" },
 	{ }
 };
 
diff --git a/security/Kconfig b/security/Kconfig
index c430206..84342d1 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -277,5 +277,17 @@ config DEFAULT_SECURITY
 	default "apparmor" if DEFAULT_SECURITY_APPARMOR
 	default "" if DEFAULT_SECURITY_DAC
 
-endmenu
+config SECURITY_RUNTIME_LOADING
+	bool "Allow adding security modules after boot"
+	depends on SECURITY
+	select SECURITY_WRITABLE_HOOKS
+	default n
+	help
+	  This option allows adding security modules which are implemented as
+	  loadable kernel modules after boot.
+
+	  NOTE: selecting this option will disable the '__ro_after_init'
+	  kernel hardening feature for security hooks. If you are unsure
+	  how to answer this question, answer N.
 
+endmenu
diff --git a/security/security.c b/security/security.c
index 7bc2fde..048da2a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -37,7 +37,7 @@
 /* Maximum number of letters for an LSM name string */
 #define SECURITY_NAME_MAX	10
 
-struct security_hook_heads security_hook_heads __lsm_ro_after_init;
+static struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
 char *lsm_names;
@@ -66,12 +66,6 @@ static void __init do_security_initcalls(void)
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
@@ -112,7 +106,7 @@ static bool match_last_lsm(const char *list, const char *lsm)
 	return !strcmp(last, lsm);
 }
 
-static int lsm_append(char *new, char **result)
+static int lsm_append(const char *new, char **result)
 {
 	char *cp;
 
@@ -162,17 +156,37 @@ int __init security_module_enable(const char *module)
  *
  * Each LSM has to register its hooks with the infrastructure.
  */
-void __init security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm)
+#ifdef SECURITY_RUNTIME_LOADING
+EXPORT_SYMBOL_GPL(security_add_hooks);
+#else
+__init
+#endif
+int security_add_hooks(struct security_hook_list *hooks, int count,
+		       const char *lsm)
 {
 	int i;
 
+	/*
+	 * If OOM occurs from __init function, panic() is already called before
+	 * failing the memory allocation. Thus, only LKM-based LSMs will get
+	 * -ENOMEM error.
+	 */
+	if (lsm_append(lsm, &lsm_names) < 0)
+		return -ENOMEM;
 	for (i = 0; i < count; i++) {
+		const unsigned int offset = hooks[i].offset;
+		struct hlist_head *head;
+
+		if (offset % sizeof(struct hlist_head) ||
+		    offset + sizeof(struct hlist_head) >
+		    sizeof(struct security_hook_heads))
+			panic("Invalid offset when adding %s module", lsm);
 		hooks[i].lsm = lsm;
-		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
+		head = (struct hlist_head *) (((char *) &security_hook_heads)
+					      + offset);
+		hlist_add_tail_rcu(&hooks[i].list, head);
 	}
-	if (lsm_append(lsm, &lsm_names) < 0)
-		panic("%s - Cannot get early memory.\n", __func__);
+	return 0;
 }
 
 int call_lsm_notifier(enum lsm_event event, void *data)
@@ -213,16 +227,62 @@ int unregister_lsm_notifier(struct notifier_block *nb)
 
 #define call_int_hook(FUNC, IRC, ...) ({			\
 	int RC = IRC;						\
+	struct security_hook_list *P;				\
+								\
+	hlist_for_each_entry(P, &security_hook_heads.FUNC, list) {	\
+		RC = P->hook.FUNC(__VA_ARGS__);				\
+		if (RC != 0)						\
+			break;						\
+	}								\
+	RC;								\
+})
+
+#define call_transactional_int_hook(UNDO_FUNC, UNDO_ARG, FUNC, ...) ({	\
+	int RC = 0;							\
+	struct security_hook_list *P1;					\
+	struct security_hook_list *P2;					\
+									\
+	hlist_for_each_entry(P1, &security_hook_heads.FUNC, list) {	\
+		RC = P1->hook.FUNC(__VA_ARGS__);			\
+		if (!RC)						\
+			continue;					\
+		hlist_for_each_entry(P2, &security_hook_heads.FUNC,	\
+				     list) {				\
+			if (P1 == P2)					\
+				break;					\
+			if (P2->hook.UNDO_FUNC)				\
+				P2->hook.UNDO_FUNC(UNDO_ARG);		\
+		}							\
+		break;							\
+	}								\
+	RC;								\
+})
+
+/*
+ * Since CONFIG_SECURITY_NETWORK_XFRM is not ready to handle multiple LSM
+ * hooks, and fortunately currently only SELinux uses it, use macros for
+ * calling only first LSM hook. This implies that LKM-based LSMs won't be
+ * able to use hooks for CONFIG_SECURITY_NETWORK_XFRM if SELinux is in use.
+ */
+#define call_first_void_hook(FUNC, ...)			\
 	do {							\
 		struct security_hook_list *P;			\
 								\
 		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
-			RC = P->hook.FUNC(__VA_ARGS__);		\
-			if (RC != 0)				\
-				break;				\
+			P->hook.FUNC(__VA_ARGS__);		\
+			break;					\
 		}						\
-	} while (0);						\
-	RC;							\
+	} while (0)
+
+#define call_first_int_hook(FUNC, IRC, ...) ({			\
+	int RC = IRC;						\
+	struct security_hook_list *P;				\
+								\
+	hlist_for_each_entry(P, &security_hook_heads.FUNC, list) {	\
+		RC = P->hook.FUNC(__VA_ARGS__);				\
+		break;							\
+	}								\
+	RC;								\
 })
 
 /* Security operations */
@@ -360,7 +420,8 @@ void security_bprm_committed_creds(struct linux_binprm *bprm)
 
 int security_sb_alloc(struct super_block *sb)
 {
-	return call_int_hook(sb_alloc_security, 0, sb);
+	return call_transactional_int_hook(sb_free_security, sb,
+					   sb_alloc_security, sb);
 }
 
 void security_sb_free(struct super_block *sb)
@@ -439,8 +500,13 @@ int security_sb_parse_opts_str(char *options, struct security_mnt_opts *opts)
 
 int security_inode_alloc(struct inode *inode)
 {
+	int ret;
 	inode->i_security = NULL;
-	return call_int_hook(inode_alloc_security, 0, inode);
+	ret = call_transactional_int_hook(inode_free_security, inode,
+					  inode_alloc_security, inode);
+	if (ret)
+		inode->i_security = NULL;
+	return ret;
 }
 
 void security_inode_free(struct inode *inode)
@@ -876,7 +942,8 @@ int security_file_permission(struct file *file, int mask)
 
 int security_file_alloc(struct file *file)
 {
-	return call_int_hook(file_alloc_security, 0, file);
+	return call_transactional_int_hook(file_free_security, file,
+					   file_alloc_security, file);
 }
 
 void security_file_free(struct file *file)
@@ -983,7 +1050,8 @@ int security_file_open(struct file *file, const struct cred *cred)
 
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 {
-	return call_int_hook(task_alloc, 0, task, clone_flags);
+	return call_transactional_int_hook(task_free, task, task_alloc, task,
+					   clone_flags);
 }
 
 void security_task_free(struct task_struct *task)
@@ -1168,7 +1236,8 @@ void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
 
 int security_msg_msg_alloc(struct msg_msg *msg)
 {
-	return call_int_hook(msg_msg_alloc_security, 0, msg);
+	return call_transactional_int_hook(msg_msg_free_security, msg,
+					   msg_msg_alloc_security, msg);
 }
 
 void security_msg_msg_free(struct msg_msg *msg)
@@ -1178,7 +1247,8 @@ void security_msg_msg_free(struct msg_msg *msg)
 
 int security_msg_queue_alloc(struct kern_ipc_perm *msq)
 {
-	return call_int_hook(msg_queue_alloc_security, 0, msq);
+	return call_transactional_int_hook(msg_queue_free_security, msq,
+					   msg_queue_alloc_security, msq);
 }
 
 void security_msg_queue_free(struct kern_ipc_perm *msq)
@@ -1210,7 +1280,8 @@ int security_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *msg,
 
 int security_shm_alloc(struct kern_ipc_perm *shp)
 {
-	return call_int_hook(shm_alloc_security, 0, shp);
+	return call_transactional_int_hook(shm_free_security, shp,
+					   shm_alloc_security, shp);
 }
 
 void security_shm_free(struct kern_ipc_perm *shp)
@@ -1235,7 +1306,8 @@ int security_shm_shmat(struct kern_ipc_perm *shp, char __user *shmaddr, int shmf
 
 int security_sem_alloc(struct kern_ipc_perm *sma)
 {
-	return call_int_hook(sem_alloc_security, 0, sma);
+	return call_transactional_int_hook(sem_free_security, sma,
+					   sem_alloc_security, sma);
 }
 
 void security_sem_free(struct kern_ipc_perm *sma)
@@ -1436,7 +1508,9 @@ int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u
 
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority)
 {
-	return call_int_hook(sk_alloc_security, 0, sk, family, priority);
+	return call_transactional_int_hook(sk_free_security, sk,
+					   sk_alloc_security, sk, family,
+					   priority);
 }
 
 void security_sk_free(struct sock *sk)
@@ -1598,89 +1672,76 @@ int security_xfrm_policy_alloc(struct xfrm_sec_ctx **ctxp,
 			       struct xfrm_user_sec_ctx *sec_ctx,
 			       gfp_t gfp)
 {
-	return call_int_hook(xfrm_policy_alloc_security, 0, ctxp, sec_ctx, gfp);
+	return call_first_int_hook(xfrm_policy_alloc_security, 0, ctxp,
+				   sec_ctx, gfp);
 }
 EXPORT_SYMBOL(security_xfrm_policy_alloc);
 
 int security_xfrm_policy_clone(struct xfrm_sec_ctx *old_ctx,
 			      struct xfrm_sec_ctx **new_ctxp)
 {
-	return call_int_hook(xfrm_policy_clone_security, 0, old_ctx, new_ctxp);
+	return call_first_int_hook(xfrm_policy_clone_security, 0, old_ctx,
+				   new_ctxp);
 }
 
 void security_xfrm_policy_free(struct xfrm_sec_ctx *ctx)
 {
-	call_void_hook(xfrm_policy_free_security, ctx);
+	call_first_void_hook(xfrm_policy_free_security, ctx);
 }
 EXPORT_SYMBOL(security_xfrm_policy_free);
 
 int security_xfrm_policy_delete(struct xfrm_sec_ctx *ctx)
 {
-	return call_int_hook(xfrm_policy_delete_security, 0, ctx);
+	return call_first_int_hook(xfrm_policy_delete_security, 0, ctx);
 }
 
 int security_xfrm_state_alloc(struct xfrm_state *x,
 			      struct xfrm_user_sec_ctx *sec_ctx)
 {
-	return call_int_hook(xfrm_state_alloc, 0, x, sec_ctx);
+	return call_first_int_hook(xfrm_state_alloc, 0, x, sec_ctx);
 }
 EXPORT_SYMBOL(security_xfrm_state_alloc);
 
 int security_xfrm_state_alloc_acquire(struct xfrm_state *x,
 				      struct xfrm_sec_ctx *polsec, u32 secid)
 {
-	return call_int_hook(xfrm_state_alloc_acquire, 0, x, polsec, secid);
+	return call_first_int_hook(xfrm_state_alloc_acquire, 0, x, polsec,
+				   secid);
 }
 
 int security_xfrm_state_delete(struct xfrm_state *x)
 {
-	return call_int_hook(xfrm_state_delete_security, 0, x);
+	return call_first_int_hook(xfrm_state_delete_security, 0, x);
 }
 EXPORT_SYMBOL(security_xfrm_state_delete);
 
 void security_xfrm_state_free(struct xfrm_state *x)
 {
-	call_void_hook(xfrm_state_free_security, x);
+	call_first_void_hook(xfrm_state_free_security, x);
 }
 
 int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir)
 {
-	return call_int_hook(xfrm_policy_lookup, 0, ctx, fl_secid, dir);
+	return call_first_int_hook(xfrm_policy_lookup, 0, ctx, fl_secid, dir);
 }
 
 int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 				       struct xfrm_policy *xp,
 				       const struct flowi *fl)
 {
-	struct security_hook_list *hp;
-	int rc = 1;
-
-	/*
-	 * Since this function is expected to return 0 or 1, the judgment
-	 * becomes difficult if multiple LSMs supply this call. Fortunately,
-	 * we can use the first LSM's judgment because currently only SELinux
-	 * supplies this call.
-	 *
-	 * For speed optimization, we explicitly break the loop rather than
-	 * using the macro
-	 */
-	hlist_for_each_entry(hp, &security_hook_heads.xfrm_state_pol_flow_match,
-				list) {
-		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
-		break;
-	}
-	return rc;
+	/* This function is expected to return 0 or 1. */
+	return call_first_int_hook(xfrm_state_pol_flow_match, 1, x, xp, fl);
 }
 
 int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
 {
-	return call_int_hook(xfrm_decode_session, 0, skb, secid, 1);
+	return call_first_int_hook(xfrm_decode_session, 0, skb, secid, 1);
 }
 
 void security_skb_classify_flow(struct sk_buff *skb, struct flowi *fl)
 {
-	int rc = call_int_hook(xfrm_decode_session, 0, skb, &fl->flowi_secid,
-				0);
+	int rc = call_first_int_hook(xfrm_decode_session, 0, skb,
+				     &fl->flowi_secid, 0);
 
 	BUG_ON(rc);
 }
@@ -1693,7 +1754,8 @@ void security_skb_classify_flow(struct sk_buff *skb, struct flowi *fl)
 int security_key_alloc(struct key *key, const struct cred *cred,
 		       unsigned long flags)
 {
-	return call_int_hook(key_alloc, 0, key, cred, flags);
+	return call_transactional_int_hook(key_free, key, key_alloc, key, cred,
+					   flags);
 }
 
 void security_key_free(struct key *key)
@@ -1755,11 +1817,13 @@ int security_bpf_prog(struct bpf_prog *prog)
 }
 int security_bpf_map_alloc(struct bpf_map *map)
 {
-	return call_int_hook(bpf_map_alloc_security, 0, map);
+	return call_transactional_int_hook(bpf_map_free_security, map,
+					   bpf_map_alloc_security, map);
 }
 int security_bpf_prog_alloc(struct bpf_prog_aux *aux)
 {
-	return call_int_hook(bpf_prog_alloc_security, 0, aux);
+	return call_transactional_int_hook(bpf_prog_free_security, aux,
+					   bpf_prog_alloc_security, aux);
 }
 void security_bpf_map_free(struct bpf_map *map)
 {
-- 
1.8.3.1


PATCH 2/2: Baseline for allowing safe runtime unregistration.

This patch makes it possible to unload LKM-based LSM modules, by using
another list for closing possible race window that release hooks are
by error called without corresponding successful alloc hook calls.

Though, it is questionable whether we want to support it at infrastructure
level. We can use a stacking LSM module which allows stacked LSM modules to
register/unregister. In that way, we can avoid lock_lsm()/unlock_lsm() at
infrastructure level. The stacking approach could also be applied for
separating mutable and immutable hooks. That is, the stacking LSM module
itself is chained to immutable (__ro_after_init) hook, and LKM-based LSMs
are chained to mutable (!__ro_after_init) hook.
---
 include/linux/lsm_hooks.h | 27 +++-----------
 security/Kconfig          |  8 +++++
 security/security.c       | 89 +++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 94 insertions(+), 30 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 083dea6..548e00b 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2006,6 +2006,9 @@ struct security_hook_heads {
  */
 struct security_hook_list {
 	struct hlist_node			list;
+#if defined(CONFIG_SECURITY_SELINUX_DISABLE) || defined(CONFIG_SECURITY_RUNTIME_UNLOADING)
+	struct hlist_node			undo_list;
+#endif
 	const unsigned int			offset;
 	const union security_list_options	hook;
 	const char				*lsm;
@@ -2027,29 +2030,7 @@ struct security_hook_list {
 
 extern int security_add_hooks(struct security_hook_list *hooks, int count,
 			      const char *lsm);
-
-#ifdef CONFIG_SECURITY_SELINUX_DISABLE
-/*
- * Assuring the safety of deleting a security module is up to
- * the security module involved. This may entail ordering the
- * module's hook list in a particular way, refusing to disable
- * the module once a policy is loaded or any number of other
- * actions better imagined than described.
- *
- * The name of the configuration option reflects the only module
- * that currently uses the mechanism. Any developer who thinks
- * disabling their module is a good idea needs to be at least as
- * careful as the SELinux team.
- */
-static inline void security_delete_hooks(struct security_hook_list *hooks,
-						int count)
-{
-	int i;
-
-	for (i = 0; i < count; i++)
-		hlist_del_rcu(&hooks[i].list);
-}
-#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
+extern void security_delete_hooks(struct security_hook_list *hooks, int count);
 
 #ifdef CONFIG_SECURITY_WRITABLE_HOOKS
 #define __lsm_ro_after_init
diff --git a/security/Kconfig b/security/Kconfig
index 84342d1..9be8788 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -290,4 +290,12 @@ config SECURITY_RUNTIME_LOADING
 	  kernel hardening feature for security hooks. If you are unsure
 	  how to answer this question, answer N.
 
+config SECURITY_RUNTIME_UNLOADING
+	bool "Allow removing security modules after boot"
+	depends on SECURITY_RUNTIME_LOADING && SRCU
+	default n
+	help
+	  This option allows removing security modules which are implemented as
+	  loadable kernel modules after boot.
+
 endmenu
diff --git a/security/security.c b/security/security.c
index 048da2a..40892a7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -29,6 +29,7 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <net/flow.h>
+#include <linux/srcu.h>
 
 #include <trace/events/initcall.h>
 
@@ -38,8 +39,29 @@
 #define SECURITY_NAME_MAX	10
 
 static struct security_hook_heads security_hook_heads __lsm_ro_after_init;
+#if defined(CONFIG_SECURITY_SELINUX_DISABLE) || defined(CONFIG_SECURITY_RUNTIME_UNLOADING)
+static struct security_hook_heads security_undo_heads __lsm_ro_after_init;
+#else
+#define security_undo_heads security_hook_heads
+#endif
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
+#if defined(CONFIG_SECURITY_SELINUX_DISABLE) || defined(CONFIG_SECURITY_RUNTIME_UNLOADING)
+DEFINE_STATIC_SRCU(security_hook_srcu);
+static inline int lock_lsm(void)
+{
+	return srcu_read_lock(&security_hook_srcu);
+}
+
+static inline void unlock_lsm(int idx)
+{
+	srcu_read_unlock(&security_hook_srcu, idx);
+}
+#else
+static inline int lock_lsm(void) { return 0; }
+static inline void unlock_lsm(int idx) { }
+#endif
+
 char *lsm_names;
 /* Boot-time LSM user choice */
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
@@ -182,6 +204,11 @@ int security_add_hooks(struct security_hook_list *hooks, int count,
 		    sizeof(struct security_hook_heads))
 			panic("Invalid offset when adding %s module", lsm);
 		hooks[i].lsm = lsm;
+#if defined(CONFIG_SECURITY_SELINUX_DISABLE) || defined(CONFIG_SECURITY_RUNTIME_UNLOADING)
+		head = (struct hlist_head *) (((char *) &security_undo_heads)
+					      + offset);
+		hlist_add_tail_rcu(&hooks[i].undo_list, head);
+#endif
 		head = (struct hlist_head *) (((char *) &security_hook_heads)
 					      + offset);
 		hlist_add_tail_rcu(&hooks[i].list, head);
@@ -189,6 +216,34 @@ int security_add_hooks(struct security_hook_list *hooks, int count,
 	return 0;
 }
 
+#if defined(CONFIG_SECURITY_SELINUX_DISABLE) || defined(CONFIG_SECURITY_RUNTIME_UNLOADING)
+/*
+ * Assuring the safety of deleting a security module is up to
+ * the security module involved. This may entail ordering the
+ * module's hook list in a particular way, refusing to disable
+ * the module once a policy is loaded or any number of other
+ * actions better imagined than described.
+ *
+ * The name of the configuration option reflects the only module
+ * that currently uses the mechanism. Any developer who thinks
+ * disabling their module is a good idea needs to be at least as
+ * careful as the SELinux team.
+ */
+void security_delete_hooks(struct security_hook_list *hooks, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		hlist_del_rcu(&hooks[i].list);
+	synchronize_srcu(&security_hook_srcu);
+	for (i = 0; i < count; i++)
+		hlist_del(&hooks[i].undo_list);
+}
+#if defined(CONFIG_SECURITY_RUNTIME_UNLOADING)
+EXPORT_SYMBOL_GPL(security_delete_hooks);
+#endif
+#endif /* CONFIG_SECURITY_SELINUX_DISABLE || CONFIG_SECURITY_RUNTIME_UNLOADING */
+
 int call_lsm_notifier(enum lsm_event event, void *data)
 {
 	return atomic_notifier_call_chain(&lsm_notifier_chain, event, data);
@@ -221,19 +276,23 @@ int unregister_lsm_notifier(struct notifier_block *nb)
 	do {							\
 		struct security_hook_list *P;			\
 								\
+		int srcu = lock_lsm();					\
 		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
 			P->hook.FUNC(__VA_ARGS__);		\
+		unlock_lsm(srcu);				\
 	} while (0)
 
 #define call_int_hook(FUNC, IRC, ...) ({			\
 	int RC = IRC;						\
 	struct security_hook_list *P;				\
+	int srcu = lock_lsm();					\
 								\
 	hlist_for_each_entry(P, &security_hook_heads.FUNC, list) {	\
 		RC = P->hook.FUNC(__VA_ARGS__);				\
 		if (RC != 0)						\
 			break;						\
 	}								\
+	unlock_lsm(srcu);						\
 	RC;								\
 })
 
@@ -241,12 +300,13 @@ int unregister_lsm_notifier(struct notifier_block *nb)
 	int RC = 0;							\
 	struct security_hook_list *P1;					\
 	struct security_hook_list *P2;					\
+	int srcu = lock_lsm();						\
 									\
 	hlist_for_each_entry(P1, &security_hook_heads.FUNC, list) {	\
 		RC = P1->hook.FUNC(__VA_ARGS__);			\
 		if (!RC)						\
 			continue;					\
-		hlist_for_each_entry(P2, &security_hook_heads.FUNC,	\
+		hlist_for_each_entry(P2, &security_undo_heads.FUNC,	\
 				     list) {				\
 			if (P1 == P2)					\
 				break;					\
@@ -255,6 +315,7 @@ int unregister_lsm_notifier(struct notifier_block *nb)
 		}							\
 		break;							\
 	}								\
+	unlock_lsm(srcu);						\
 	RC;								\
 })
 
@@ -267,21 +328,25 @@ int unregister_lsm_notifier(struct notifier_block *nb)
 #define call_first_void_hook(FUNC, ...)			\
 	do {							\
 		struct security_hook_list *P;			\
+		int srcu = lock_lsm();				\
 								\
 		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
 			P->hook.FUNC(__VA_ARGS__);		\
 			break;					\
 		}						\
+		unlock_lsm(srcu);				\
 	} while (0)
 
 #define call_first_int_hook(FUNC, IRC, ...) ({			\
 	int RC = IRC;						\
 	struct security_hook_list *P;				\
+	int srcu = lock_lsm();					\
 								\
 	hlist_for_each_entry(P, &security_hook_heads.FUNC, list) {	\
 		RC = P->hook.FUNC(__VA_ARGS__);				\
 		break;							\
 	}								\
+	unlock_lsm(srcu);						\
 	RC;								\
 })
 
@@ -375,6 +440,7 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 	struct security_hook_list *hp;
 	int cap_sys_admin = 1;
 	int rc;
+	int srcu = lock_lsm();
 
 	/*
 	 * The module will respond with a positive value if
@@ -390,6 +456,7 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 			break;
 		}
 	}
+	unlock_lsm(srcu);
 	return __vm_enough_memory(mm, pages, cap_sys_admin);
 }
 
@@ -870,38 +937,44 @@ int security_inode_killpriv(struct dentry *dentry)
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int rc = -EOPNOTSUPP;
+	int srcu;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
 	/*
 	 * Only one module will provide an attribute with a given name.
 	 */
+	srcu = lock_lsm();
 	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecurity, list) {
 		rc = hp->hook.inode_getsecurity(inode, name, buffer, alloc);
 		if (rc != -EOPNOTSUPP)
-			return rc;
+			break;
 	}
-	return -EOPNOTSUPP;
+	unlock_lsm(srcu);
+	return rc;
 }
 
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int rc = -EOPNOTSUPP;
+	int srcu;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
 	/*
 	 * Only one module will provide an attribute with a given name.
 	 */
+	srcu = lock_lsm();
 	hlist_for_each_entry(hp, &security_hook_heads.inode_setsecurity, list) {
 		rc = hp->hook.inode_setsecurity(inode, name, value, size,
 								flags);
 		if (rc != -EOPNOTSUPP)
-			return rc;
+			break;
 	}
-	return -EOPNOTSUPP;
+	unlock_lsm(srcu);
+	return rc;
 }
 
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
@@ -1206,6 +1279,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 	int thisrc;
 	int rc = -ENOSYS;
 	struct security_hook_list *hp;
+	int srcu = lock_lsm();
 
 	hlist_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
 		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
@@ -1215,6 +1289,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 				break;
 		}
 	}
+	unlock_lsm(srcu);
 	return rc;
 }
 
-- 
1.8.3.1
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
