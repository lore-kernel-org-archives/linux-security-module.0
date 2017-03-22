From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Wed, 22 Mar 2017 21:13:01 +0900
Subject: out of tree lsm's
In-Reply-To: <9598189e-c807-bb5f-b6bc-cc90cd0b4ac0@schaufler-ca.com>
References: <04d6fd0a-bb59-b3c0-258c-b5826e7277a0@schaufler-ca.com>
	<CADc-OzFAiq4ccLgTYtx+jvkGxduoOC3J+C90UTQWDOB6+EoFfQ@mail.gmail.com>
	<864de292-248c-d6fe-c184-95f9964d8f65@schaufler-ca.com>
	<201703220653.EGI86908.VOFOFHOLJtQSMF@I-love.SAKURA.ne.jp>
	<9598189e-c807-bb5f-b6bc-cc90cd0b4ac0@schaufler-ca.com>
Message-ID: <201703222113.EFD39082.FFOHOQOLVJtFMS@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Casey Schaufler wrote:
> On 3/21/2017 2:53 PM, Tetsuo Handa wrote:
> > Casey Schaufler wrote:
> >> On 3/21/2017 9:06 AM, Peter Moody wrote:
> >>> On Tue, Mar 21, 2017 at 8:36 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>>> On 3/21/2017 3:41 AM, Tetsuo Handa wrote:
> >>>>> Tetsuo Handa wrote:
> >>>>>> Casey Schaufler wrote:
> >>>>>>>> right. sorry for the imprecise language; by site-specific I meant a "small" lsm.
> >>>>>>>>
> >>>>>>>> I would love to have the ability write a small lsm that I can build as
> >>>>>>>> a module and load at boot eg. via initrd.
> >>>>>>>>
> >>>>>>>> AIUI, adding even a new "small" lsm requires kconfig patches, building
> >>>>>>>> a new kernel, etc. I know there are objections to dynamically loadable
> >>>>>>>> lsms and I was trying to find a compromise that made them easier to
> >>>>>>>> work with.
> >>>>>>> The stacking design criteria I'm working with
> >>>>>>> include not doing anything that would prevent
> >>>>>>> dynamic module loading. I do not plan to implement
> >>>>>>> dynamic loading. Tetsuo has been a strong
> >>>>>>> advocate of loadable modules. I would expect to
> >>>>>>> see a proposal from him shortly after the
> >>>>>>> general stacking lands, assuming it does.
> >>>>>> But currently __lsm_ro_after_init which is planned to go to 4.12 is preventing
> >>>>>> dynamic modules from loading. We need a legitimate interface for loadable modules like
> >>>>>> http://lkml.kernel.org/r/201702152342.GBH04183.FOFJFHQOLMOtVS at I-love.SAKURA.ne.jp .
> >>>>>> Requiring rodata=0 kernel command line option to allow dynamic modules is silly.
> >>>>>>
> >>>>> I think we need something like below change when allowing loadable modules.
> >>>> I believe that a simpler approach would be to
> >>>> add a separate list of dynamic hooks to supliment
> >>>> the list of static hooks. If SELinux unloading is
> >>>> desired the SELinux hooks would be put on the
> >>>> dynamic list which would not be "hardened" with
> >>>> _ro_after_init, where the rest of the static modules
> >>>> would be.
> >>> FWIW, I don't know if that would solve the case I was initially asking
> >>> about since the out-of-tree lsm I was hoping to be able to access all
> >>> of the standard security hooks with an out-of-tree module.
> >> It would work fine. All I'm suggesting is that in addition
> >> to security_hook_heads there would be a
> >> security_hooks_heads_dynamic. The code in security.c would
> >> be stretched to loop through both lists. Any locking or
> >> other complexity associated with being dynamic would be
> >> limited to the dynamic list.
> >>
> > Yes, adding security_hooks_heads_dynamic would work about calling hooks.
> > But why not to protect security_hooks_heads_dynamic with mostly-read-only
> > protection when security_hooks_heads is protected with __ro_after_init?
> 
> I'd be fine with that. What I don't care for
> is adding the complexity of mostly-read-only
> to the complied-in-load-at-init case.
> 
> > I don't think SELinux wants to give up read-only protection only for
> > allowing runtime disable.
> 
> The read-only protection is very new, and wasn't missed
> greatly before it was added. I also understand that SELinux
> is looking to remove the runtime disable feature.
> 
> > And if protecting security_hooks_heads_dynamic, why to use separate lists?
> > Is keeping security_hooks_heads __ro_after_init a worthwhile protection
> > when we add a dynamic module to security_hooks_heads_dynamic? A malicious
> > dynamic module can after all tamper security_hooks_heads by making it
> > read-write.
> 
> This is where I always get a headache. You want
> the list of hooks to be mutable, but you don't want
> to loose the __ro_after_init protection. The two
> list approach allows the modules that are not dynamic
> to be protected, and those that want to change to
> change. It addresses the concern of those who want
> "static" module lists to be hard while allowing
> loadable modules.
> 
> I also assume that if we allow loadable modules at
> some point it will be optional.

So, roughly speaking, below patch is what you mean, isn't it?
Yes, it would work. 

I wonder whether the complication by splitting into security_hooks_heads
and security_hooks_heads_dynamic (because it is impossible to make only
security_hooks_heads[0] read-only when declared as security_hooks_heads[2]
and use security_hooks_heads[1] read-write instead of declaring
security_hooks_heads and security_hooks_heads_dynamic) is worthwhile
when we add mostly-read-only protection to security_hooks_heads_dynamic.


>From 08ac4ea012f91e640f895df2978b40f2feb89550 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 22 Mar 2017 20:50:47 +0900
Subject: [PATCH] LSM: Make dynamic module registration legitimate.

This patch applies on top of below two patches.

  [PATCH 1/2] LSM: Initialize security_hook_heads upon registration.
  [PATCH 2/2] LSM: Make security_hook_heads a local variable.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/lsm_hooks.h  | 12 +++---
 security/Kconfig           |  6 ++-
 security/apparmor/lsm.c    |  2 +-
 security/commoncap.c       |  2 +-
 security/loadpin/loadpin.c |  2 +-
 security/security.c        | 93 ++++++++++++++++++++++++++++++++++++++++++++--
 security/selinux/Kconfig   |  4 +-
 security/selinux/hooks.c   |  7 +++-
 security/smack/smack_lsm.c |  2 +-
 security/tomoyo/tomoyo.c   |  2 +-
 security/yama/yama_lsm.c   |  2 +-
 11 files changed, 113 insertions(+), 21 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 54191cf..712b2d3 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1897,6 +1897,11 @@ struct security_hook_list {
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
+#ifdef CONFIG_SECURITY_DYNAMIC_LOADING
+extern void security_add_hooks_dynamic(struct security_hook_list *hooks,
+				       int count, char *lsm);
+#endif
+
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 /*
  * Assuring the safety of deleting a security module is up to
@@ -1920,13 +1925,6 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 }
 #endif /* CONFIG_SECURITY_SELINUX_DISABLE */
 
-/* Currently required to handle SELinux runtime hook disable. */
-#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
-#define __lsm_ro_after_init
-#else
-#define __lsm_ro_after_init	__ro_after_init
-#endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
-
 extern int __init security_module_enable(const char *module);
 extern void __init capability_add_hooks(void);
 #ifdef CONFIG_SECURITY_YAMA
diff --git a/security/Kconfig b/security/Kconfig
index 3ff1bf9..e852cb0 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -31,10 +31,12 @@ config SECURITY
 
 	  If you are unsure how to answer this question, answer N.
 
-config SECURITY_WRITABLE_HOOKS
+config SECURITY_DYNAMIC_LOADING
 	depends on SECURITY
-	bool
+	bool "Allow dynamic registration of LSM modules"
 	default n
+	help
+	  This option allows loadable LSM modules.
 
 config SECURITYFS
 	bool "Enable the securityfs filesystem"
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index e287b69..73aad35 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -587,7 +587,7 @@ static int apparmor_task_setrlimit(struct task_struct *task,
 	return error;
 }
 
-static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
+static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
 	LSM_HOOK_INIT(capget, apparmor_capget),
diff --git a/security/commoncap.c b/security/commoncap.c
index 7abebd7..9704ed0 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1071,7 +1071,7 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
 
 #ifdef CONFIG_SECURITY
 
-struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
+struct security_hook_list capability_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(capable, cap_capable),
 	LSM_HOOK_INIT(settime, cap_settime),
 	LSM_HOOK_INIT(ptrace_access_check, cap_ptrace_access_check),
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index dbe6efd..aaef8d9 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -174,7 +174,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
 	return 0;
 }
 
-static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
+static struct security_hook_list loadpin_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
 	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
 };
diff --git a/security/security.c b/security/security.c
index a5868ed..493f260 100644
--- a/security/security.c
+++ b/security/security.c
@@ -32,7 +32,13 @@
 /* Maximum number of letters for an LSM name string */
 #define SECURITY_NAME_MAX	10
 
-static struct security_hook_heads security_hook_heads __lsm_ro_after_init;
+static struct security_hook_heads security_hook_heads __ro_after_init;
+#ifdef CONFIG_SECURITY_DYNAMIC_LOADING
+static struct security_hook_heads security_hook_heads_dynamic;
+#else
+/* Dummy for hiding build errors. */
+#define security_hook_heads_dynamic security_hook_heads
+#endif
 char *lsm_names;
 /* Boot-time LSM user choice */
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
@@ -61,6 +67,12 @@ int __init security_init(void)
 	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct list_head);
 	     i++)
 		INIT_LIST_HEAD(&list[i]);
+#ifdef CONFIG_SECURITY_DYNAMIC_LOADING
+	list = (struct list_head *) &security_hook_heads_dynamic;
+	for (i = 0; i < sizeof(security_hook_heads_dynamic) /
+		     sizeof(struct list_head); i++)
+		INIT_LIST_HEAD(&list[i]);
+#endif
 	pr_info("Security Framework initialized\n");
 
 	/*
@@ -143,6 +155,24 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 		panic("%s - Cannot get early memory.\n", __func__);
 }
 
+#ifdef CONFIG_SECURITY_DYNAMIC_LOADING
+void security_add_hooks_dynamic(struct security_hook_list *hooks, int count,
+				char *lsm)
+{
+	int i;
+	struct list_head *list =
+		(struct list_head *) &security_hook_heads_dynamic;
+
+	for (i = 0; i < count; i++) {
+		hooks[i].lsm = lsm;
+		list_add_tail_rcu(&hooks[i].list, &list[hooks[i].idx]);
+	}
+	if (lsm_append(lsm, &lsm_names) < 0)
+		panic("%s - Cannot get early memory.\n", __func__);
+}
+EXPORT_SYMBOL_GPL(security_add_hooks_dynamic);
+#endif
+
 /*
  * Hook list operation macros.
  *
@@ -159,6 +189,11 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 								\
 		list_for_each_entry(P, &security_hook_heads.FUNC, list)	\
 			P->hook.FUNC(__VA_ARGS__);		\
+		if (IS_ENABLED(CONFIG_SECURITY_DYNAMIC_LOADING))	\
+			list_for_each_entry(P,				\
+				    &security_hook_heads_dynamic.FUNC,  \
+					    list)			\
+				P->hook.FUNC(__VA_ARGS__);		\
 	} while (0)
 
 #define call_int_hook(FUNC, IRC, ...) ({			\
@@ -171,6 +206,14 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 			if (RC != 0)				\
 				break;				\
 		}						\
+		if (IS_ENABLED(CONFIG_SECURITY_DYNAMIC_LOADING))	\
+			list_for_each_entry(P,				\
+				    &security_hook_heads_dynamic.FUNC,  \
+					    list) {			\
+				RC = P->hook.FUNC(__VA_ARGS__);		\
+				if (RC != 0)				\
+					break;				\
+			}						\
 	} while (0);						\
 	RC;							\
 })
@@ -280,6 +323,16 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 			break;
 		}
 	}
+	if (IS_ENABLED(CONFIG_SECURITY_DYNAMIC_LOADING) && cap_sys_admin)
+		list_for_each_entry(hp,
+			    &security_hook_heads_dynamic.vm_enough_memory,
+				    list) {
+			rc = hp->hook.vm_enough_memory(mm, pages);
+			if (rc <= 0) {
+				cap_sys_admin = 0;
+				break;
+			}
+		}
 	return __vm_enough_memory(mm, pages, cap_sys_admin);
 }
 
@@ -768,6 +821,15 @@ int security_inode_getsecurity(struct inode *inode, const char *name, void **buf
 		if (rc != -EOPNOTSUPP)
 			return rc;
 	}
+	if (IS_ENABLED(CONFIG_SECURITY_DYNAMIC_LOADING))
+		list_for_each_entry(hp,
+			    &security_hook_heads_dynamic.inode_getsecurity,
+				    list) {
+			rc = hp->hook.inode_getsecurity(inode, name, buffer,
+							alloc);
+			if (rc != -EOPNOTSUPP)
+				return rc;
+		}
 	return -EOPNOTSUPP;
 }
 
@@ -787,6 +849,15 @@ int security_inode_setsecurity(struct inode *inode, const char *name, const void
 		if (rc != -EOPNOTSUPP)
 			return rc;
 	}
+	if (IS_ENABLED(CONFIG_SECURITY_DYNAMIC_LOADING))
+		list_for_each_entry(hp,
+			    &security_hook_heads_dynamic.inode_setsecurity,
+				    list) {
+			rc = hp->hook.inode_setsecurity(inode, name, value,
+							size, flags);
+			if (rc != -EOPNOTSUPP)
+				return rc;
+		}
 	return -EOPNOTSUPP;
 }
 
@@ -1092,6 +1163,17 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 				break;
 		}
 	}
+	if (IS_ENABLED(CONFIG_SECURITY_DYNAMIC_LOADING) && rc == -ENOSYS)
+		list_for_each_entry(hp, &security_hook_heads_dynamic.task_prctl,
+				    list) {
+			thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4,
+						     arg5);
+			if (thisrc != -ENOSYS) {
+				rc = thisrc;
+				if (thisrc != 0)
+					break;
+			}
+		}
 	return rc;
 }
 
@@ -1562,9 +1644,14 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	 */
 	list_for_each_entry(hp, &security_hook_heads.xfrm_state_pol_flow_match,
 				list) {
-		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
-		break;
+		return hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
 	}
+	if (IS_ENABLED(CONFIG_SECURITY_DYNAMIC_LOADING))
+		list_for_each_entry(hp,
+			&security_hook_heads_dynamic.xfrm_state_pol_flow_match,
+				    list) {
+			return hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
+		}
 	return rc;
 }
 
diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 8af7a69..3b9ce3d 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -40,7 +40,7 @@ config SECURITY_SELINUX_BOOTPARAM_VALUE
 config SECURITY_SELINUX_DISABLE
 	bool "NSA SELinux runtime disable"
 	depends on SECURITY_SELINUX
-	select SECURITY_WRITABLE_HOOKS
+	select SECURITY_DYNAMIC_LOADING
 	default n
 	help
 	  This option enables writing to a selinuxfs node 'disable', which
@@ -52,7 +52,7 @@ config SECURITY_SELINUX_DISABLE
 	  to employ.
 
 	  NOTE: selecting this option will disable the '__ro_after_init'
-	  kernel hardening feature for security hooks.   Please consider
+	  kernel hardening feature for SELinux hooks.   Please consider
 	  using the selinux=0 boot parameter instead of enabling this
 	  option.
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d37a723..f5f348e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6123,7 +6123,7 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
 
 #endif
 
-static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
+static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
 	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
 	LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
@@ -6366,7 +6366,12 @@ static __init int selinux_init(void)
 					    0, SLAB_PANIC, NULL);
 	avc_init();
 
+#ifndef CONFIG_SECURITY_SELINUX_DISABLE
 	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
+#else
+	security_add_hooks_dynamic(selinux_hooks, ARRAY_SIZE(selinux_hooks),
+				   "selinux");
+#endif
 
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 927e60e..cfaa78c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4633,7 +4633,7 @@ static int smack_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 	return 0;
 }
 
-static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
+static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
 	LSM_HOOK_INIT(syslog, smack_syslog),
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index b5fb930..2677427 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -496,7 +496,7 @@ static int tomoyo_socket_sendmsg(struct socket *sock, struct msghdr *msg,
  * tomoyo_security_ops is a "struct security_operations" which is used for
  * registering TOMOYO.
  */
-static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
+static struct security_hook_list tomoyo_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(cred_alloc_blank, tomoyo_cred_alloc_blank),
 	LSM_HOOK_INIT(cred_prepare, tomoyo_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, tomoyo_cred_transfer),
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 8298e09..fae3cd9 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -428,7 +428,7 @@ int yama_ptrace_traceme(struct task_struct *parent)
 	return rc;
 }
 
-static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
+static struct security_hook_list yama_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
 	LSM_HOOK_INIT(task_prctl, yama_task_prctl),
-- 
1.8.3.1
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
