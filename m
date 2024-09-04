Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03B71465B4;
	Wed,  4 Sep 2024 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433818; cv=none; b=cIJxida9MeUAeygry45vgodMmfwD1Ikrl826aE0AdostG1sccujXYS5eOVhZS7gCsc3k01VHLXnTBJ8Ov1QkJDCgvBpH7B/VPnR3o0TrCslHnY2Bn9BMB3ZkFSuzE5w+vPUib5LK7203EwCWoLnbmaOTShe3nY6KYXnzuT4+/sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433818; c=relaxed/simple;
	bh=QkfiDhNRI/jOE7+dep8lo0MoPE4+l9UksHSgYqmO3K0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NPRs/5xYDMLJZuN5DwyPME/0Sc7D/Fu6gOw29cDgkcl0sMXO+8zCLRUjNAL+OTpGj9uZmDwcp17BftqVIAV1tRTpPEOF0utXpTapTWyVNza9asGUJy7iPJO7m5BeTi6HOmMmzfLOQiySD9sTubE2PdfKcv1gQV0BFt+xX0HXG5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4847A5lO001031;
	Wed, 4 Sep 2024 16:10:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Wed, 04 Sep 2024 16:10:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4847A4RD001027
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 4 Sep 2024 16:10:04 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <caafb609-8bef-4840-a080-81537356fc60@I-love.SAKURA.ne.jp>
Date: Wed, 4 Sep 2024 16:10:05 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: tomoyo-dev-en@lists.osdn.me, tomoyo-users-en@lists.osdn.me
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] LSM: allow loadable kernel module based LSM modules
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Until 2.6.23, it was officially possible to register/unregister LSM modules
that are implemented as loadable kernel modules. But from 2.6.24 to 6.11,
it is not officially possible to do so due to commit 20510f2f4e2d
("security: Convert LSM into a static interface"). When that commit was
discussed, effectively SELinux was the only in-tree LSM user, and therefore
out-of-tree LSM users were not able to express opinions.

But that commit missed realities that

  how difficult/unrealistic for Linux users who are using prebuilt kernel
  packages provided by Linux distributors to replace their kernels

  how difficult for Linux distributors to allow their users to use in-tree
  LSM modules which that distributor is not familiar with [1] because Linux
  distributors are supposed to support kernel packages they built and
  shipped

  Linux distributors do not want to enable out-of-tree code due to upstream
  first policy, while Linux kernel development community can not afford
  accepting whatever proposed code due to limited resources

. These realities keep away out-of-tree LSMs (or even in-tree LSMs) which
are not built into vmlinux, and caused unhappy times for Linux users who
want to try a new LSM module. An approach that can survive is that LSM
modules that cannot be built into vmlinux is to provide as a loadable
kernel module.

Therefore, I had been providing a workaround called AKARI that allows Linux
users to use TOMOYO as a loadable kernel module [2] from 2.6.0 to 6.11. But
commit 417c5643cd67 ("lsm: replace indirect LSM hook calls with static
calls") made it difficult to use AKARI due to replacing the linked list
(which can allow registering more than number of built-in LSM modules) with
static call slots (which cannot allow registering more than number of
built-in LSM modules).

I considered trying Kprobes and BPF-LSM for reimplementing TOMOYO, but the
conclusion is that Kprobes and BPF-LSM are too restricted to reimplement
TOMOYO.

Paul Moore has commented

  I do not intentionally plan to make life difficult for the out-of-tree
  LSMs, but if that happens as a result of design decisions intended to
  benefit in-tree LSMs that is acceptable as far as I am concerned.

at [3]. But the static calls change suddenly jumped in, and that made life
difficult for the in-tree but not built-in LSMs as a result of design
decisions intended to benefit in-tree and built-in LSMs.

Now that the static calls change is going to be merged into Linux 6.12,
I propose this patch for recovering life for "in-tree but not built-in"
LSMs, by officially allowing loadable kernel module based LSM modules.

I'm not planning to propose a change for allowing unregistration of LSM
modules after boot, for I agree one of concerns

  the ability to unload a security module is not required by in-tree
  users and potentially complicates the overall security architecture

in "security: Convert LSM into a static interface" change. But I assert
that the ability to load a security module (i.e. loadable kernel module
based LSMs) is inevitable due to unsolvable realities.

The LSM hooks for loadable kernel module based LSMs are enabled only if
the kernel is booted with 'dynamic_lsm' kernel command line option added
in order to honer the administrator's decision and avoid overhead when
the administrator does not plan to use loadable kernel module based LSMs.

Of course, Linux distributors might revert this patch in their kernels if
their kernels are intended for very specific/dedicated purposes. But what
is important is that we again officially support LSM modules that are
implemented as loadable kernel modules in accordance with upstream first
policy.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=542986 [1]
Link: https://tomoyo.sourceforge.net/akari/comparison.html [2]
Link: https://lkml.kernel.org/r/CAHC9VhSG2UzE9N0-tAJc8B3Mj1PEuJ2b6wso_DUs_Y83yqwhjA@mail.gmail.com [3]
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
I'll start updating security/tomoyo after this change is accepted. For
those who want to try this change now, an example module is shown below.
-----
#include <linux/lsm_hooks.h>

static void test_bprm_committed_creds(const struct linux_binprm *bprm)
{
        pr_info_once("%s() is called\n", __func__);
}

static int test_file_open(struct file *f)
{
        pr_info_once("%s() is called\n", __func__);
        return 0;
}

static const struct lsm_id test_lsmid = {
        .name = "test",
};

static struct security_dynamic_hook_list test_hooks[] = {
        LSM_HOOK_INIT(file_open, test_file_open),
        LSM_HOOK_INIT(bprm_committed_creds, test_bprm_committed_creds),
};

static int __init test_init(void)
{
        return security_add_dynamic_hooks(test_hooks, ARRAY_SIZE(test_hooks),
                                          &test_lsmid);
}

module_init(test_init);
MODULE_LICENSE("GPL");
-----

 include/linux/lsm_hooks.h |  24 +++++
 security/security.c       | 200 +++++++++++++++++++++++++++++++++++---
 2 files changed, 210 insertions(+), 14 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 090d1d3e19fed..afe4eeeb7bd52 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -71,6 +71,12 @@ struct lsm_static_calls_table {
 	#undef LSM_HOOK
 } __packed __randomize_layout;
 
+struct security_dynamic_hook_heads {
+	#define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
+	#include "lsm_hook_defs.h"
+	#undef LSM_HOOK
+} __randomize_layout;
+
 /**
  * struct lsm_id - Identify a Linux Security Module.
  * @lsm: name of the LSM, must be approved by the LSM maintainers
@@ -98,6 +104,13 @@ struct security_hook_list {
 	const struct lsm_id *lsmid;
 } __randomize_layout;
 
+struct security_dynamic_hook_list {
+	struct hlist_node		list;
+	struct hlist_head		*head;
+	union security_list_options	hook;
+	const struct lsm_id		*lsmid;
+} __randomize_layout;
+
 /*
  * Security blob size or offset data.
  */
@@ -130,14 +143,24 @@ struct lsm_blob_sizes {
  * care of the common case and reduces the amount of
  * text involved.
  */
+#ifndef MODULE
 #define LSM_HOOK_INIT(NAME, HOOK)			\
 	{						\
 		.scalls = static_calls_table.NAME,	\
 		.hook = { .NAME = HOOK }		\
 	}
+#else
+#define LSM_HOOK_INIT(NAME, HOOK)			\
+	{						\
+		.head = &security_hook_heads.NAME,	\
+		.hook = { .NAME = HOOK }		\
+	}
+#endif
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
 			       const struct lsm_id *lsmid);
+extern int security_add_dynamic_hooks(struct security_dynamic_hook_list *hooks, int count,
+				      const struct lsm_id *lsmid);
 
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
 #define LSM_FLAG_EXCLUSIVE	BIT(1)
@@ -170,6 +193,7 @@ struct lsm_info {
 /* DO NOT tamper with these variables outside of the LSM framework */
 extern char *lsm_names;
 extern struct lsm_static_calls_table static_calls_table __ro_after_init;
+extern struct security_dynamic_hook_heads security_hook_heads;
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
 
diff --git a/security/security.c b/security/security.c
index 7272bbea05cb8..1b6c64c631ac0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -130,6 +130,10 @@ static __initdata struct lsm_info *exclusive;
 #undef LSM_HOOK
 #undef DEFINE_LSM_STATIC_CALL
 
+struct security_dynamic_hook_heads security_hook_heads;
+EXPORT_SYMBOL_GPL(security_hook_heads);
+static DEFINE_STATIC_KEY_FALSE_RO(security_dynamic_hook_key);
+
 /*
  * Initialise a table of static calls for each LSM hook.
  * DEFINE_STATIC_CALL_NULL invocation above generates a key (STATIC_CALL_KEY)
@@ -644,6 +648,32 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	}
 }
 
+static int __init enable_dynamic_hooks(char *str)
+{
+	static_branch_enable(&security_dynamic_hook_key);
+	pr_info("Dynamic LSM hook enabled.\n");
+	return 1;
+}
+__setup("dynamic_lsm", enable_dynamic_hooks);
+
+int security_add_dynamic_hooks(struct security_dynamic_hook_list *hooks, int count,
+			       const struct lsm_id *lsmid)
+{
+	int i;
+
+	if (!static_key_enabled(&security_dynamic_hook_key)) {
+		pr_info("Boot with 'dynamic_lsm' kernel command line option to enable dynamic LSM hook.\n");
+		return -EINVAL;
+	}
+	pr_info("Dynamic LSM hook: adding '%s' module.\n", lsmid->name);
+	for (i = 0; i < count; i++) {
+		hooks[i].lsmid = lsmid;
+		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(security_add_dynamic_hooks);
+
 int call_blocking_lsm_notifier(enum lsm_event event, void *data)
 {
 	return blocking_notifier_call_chain(&blocking_lsm_notifier_chain,
@@ -952,9 +982,15 @@ do {									     \
 	}								     \
 } while (0);
 
-#define call_void_hook(HOOK, ...)                                 \
-	do {                                                      \
+#define call_void_hook(HOOK, ...)					\
+	do {								\
 		LSM_LOOP_UNROLL(__CALL_STATIC_VOID, HOOK, __VA_ARGS__); \
+		if (static_key_enabled(&security_dynamic_hook_key)) { \
+			struct security_dynamic_hook_list *P;		\
+									\
+			hlist_for_each_entry(P, &security_hook_heads.HOOK, list) \
+				P->hook.HOOK(__VA_ARGS__);		\
+		}							\
 	} while (0)
 
 
@@ -973,6 +1009,15 @@ do {									     \
 	int RC = LSM_RET_DEFAULT(HOOK);					\
 									\
 	LSM_LOOP_UNROLL(__CALL_STATIC_INT, RC, HOOK, OUT, __VA_ARGS__);	\
+	if (static_key_enabled(&security_dynamic_hook_key)) {	\
+		struct security_dynamic_hook_list *P;			\
+									\
+		hlist_for_each_entry(P, &security_hook_heads.HOOK, list) { \
+			RC = P->hook.HOOK(__VA_ARGS__);			\
+			if (RC != LSM_RET_DEFAULT(HOOK))		\
+				goto OUT;				\
+		}							\
+	}								\
 OUT:									\
 	RC;								\
 })
@@ -1230,9 +1275,21 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 		rc = scall->hl->hook.vm_enough_memory(mm, pages);
 		if (rc < 0) {
 			cap_sys_admin = 0;
-			break;
+			goto done;
 		}
 	}
+	if (static_key_enabled(&security_dynamic_hook_key)) {
+		struct security_dynamic_hook_list *hp;
+
+		hlist_for_each_entry(hp, &security_hook_heads.vm_enough_memory, list) {
+			rc = hp->hook.vm_enough_memory(mm, pages);
+			if (rc <= 0) {
+				cap_sys_admin = 0;
+				break;
+			}
+		}
+	}
+ done:
 	return __vm_enough_memory(mm, pages, cap_sys_admin);
 }
 
@@ -1385,6 +1442,18 @@ int security_fs_context_parse_param(struct fs_context *fc,
 		else if (trc != -ENOPARAM)
 			return trc;
 	}
+	if (static_key_enabled(&security_dynamic_hook_key)) {
+		struct security_dynamic_hook_list *hp;
+
+		hlist_for_each_entry(hp, &security_hook_heads.fs_context_parse_param,
+				     list) {
+			trc = hp->hook.fs_context_parse_param(fc, param);
+			if (trc == 0)
+				rc = 0;
+			else if (trc != -ENOPARAM)
+				return trc;
+		}
+	}
 	return rc;
 }
 
@@ -1616,8 +1685,20 @@ int security_sb_set_mnt_opts(struct super_block *sb,
 		rc = scall->hl->hook.sb_set_mnt_opts(sb, mnt_opts, kern_flags,
 					      set_kern_flags);
 		if (rc != LSM_RET_DEFAULT(sb_set_mnt_opts))
-			break;
+			goto done;
+	}
+	if (static_key_enabled(&security_dynamic_hook_key)) {
+		struct security_dynamic_hook_list *hp;
+
+		hlist_for_each_entry(hp, &security_hook_heads.sb_set_mnt_opts,
+				     list) {
+			rc = hp->hook.sb_set_mnt_opts(sb, mnt_opts, kern_flags,
+						      set_kern_flags);
+			if (rc != LSM_RET_DEFAULT(sb_set_mnt_opts))
+				break;
+		}
 	}
+ done:
 	return rc;
 }
 EXPORT_SYMBOL(security_sb_set_mnt_opts);
@@ -1826,17 +1907,28 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 			return -ENOMEM;
 	}
 
+	/*
+	 * As documented in lsm_hooks.h, -EOPNOTSUPP in this context
+	 * means that the LSM is not willing to provide an xattr, not
+	 * that it wants to signal an error. Thus, continue to invoke
+	 * the remaining LSMs.
+	 */
 	lsm_for_each_hook(scall, inode_init_security) {
 		ret = scall->hl->hook.inode_init_security(inode, dir, qstr, new_xattrs,
 						  &xattr_count);
 		if (ret && ret != -EOPNOTSUPP)
 			goto out;
-		/*
-		 * As documented in lsm_hooks.h, -EOPNOTSUPP in this context
-		 * means that the LSM is not willing to provide an xattr, not
-		 * that it wants to signal an error. Thus, continue to invoke
-		 * the remaining LSMs.
-		 */
+	}
+	if (static_key_enabled(&security_dynamic_hook_key)) {
+		struct security_dynamic_hook_list *hp;
+
+		hlist_for_each_entry(hp, &security_hook_heads.inode_init_security,
+				     list) {
+			ret = hp->hook.inode_init_security(inode, dir, qstr, new_xattrs,
+							   &xattr_count);
+			if (ret && ret != -EOPNOTSUPP)
+				goto out;
+		}
 	}
 
 	/* If initxattrs() is NULL, xattr_count is zero, skip the call. */
@@ -3681,9 +3773,22 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 		if (thisrc != LSM_RET_DEFAULT(task_prctl)) {
 			rc = thisrc;
 			if (thisrc != 0)
-				break;
+				goto done;
 		}
 	}
+	if (static_key_enabled(&security_dynamic_hook_key)) {
+		struct security_dynamic_hook_list *hp;
+
+		hlist_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
+			thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
+			if (thisrc != LSM_RET_DEFAULT(task_prctl)) {
+				rc = thisrc;
+				if (thisrc != 0)
+					break;
+			}
+		}
+	}
+ done:
 	return rc;
 }
 
@@ -4144,8 +4249,38 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 		total += entrysize;
 		count += rc;
 		if (single)
-			break;
+			goto done;
 	}
+	if (static_key_enabled(&security_dynamic_hook_key)) {
+		struct security_dynamic_hook_list *hp;
+
+		hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
+			if (single && lctx.id != hp->lsmid->id)
+				continue;
+			entrysize = left;
+			if (base)
+				uctx = (struct lsm_ctx __user *)(base + total);
+			rc = hp->hook.getselfattr(attr, uctx, &entrysize, flags);
+			if (rc == -EOPNOTSUPP) {
+				rc = 0;
+				continue;
+			}
+			if (rc == -E2BIG) {
+				rc = 0;
+				left = 0;
+				toobig = true;
+			} else if (rc < 0)
+				return rc;
+			else
+				left -= entrysize;
+
+			total += entrysize;
+			count += rc;
+			if (single)
+				break;
+		}
+	}
+ done:
 	if (put_user(total, size))
 		return -EFAULT;
 	if (toobig)
@@ -4202,8 +4337,17 @@ int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 	lsm_for_each_hook(scall, setselfattr)
 		if ((scall->hl->lsmid->id) == lctx->id) {
 			rc = scall->hl->hook.setselfattr(attr, lctx, size, flags);
-			break;
+			goto free_out;
 		}
+	if (static_key_enabled(&security_dynamic_hook_key)) {
+		struct security_dynamic_hook_list *hp;
+
+		hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
+			if ((hp->lsmid->id) == lctx->id) {
+				rc = hp->hook.setselfattr(attr, lctx, size, flags);
+				break;
+			}
+	}
 
 free_out:
 	kfree(lctx);
@@ -4231,6 +4375,15 @@ int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
 			continue;
 		return scall->hl->hook.getprocattr(p, name, value);
 	}
+	if (static_key_enabled(&security_dynamic_hook_key)) {
+		struct security_dynamic_hook_list *hp;
+
+		hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
+			if (lsmid != 0 && lsmid != hp->lsmid->id)
+				continue;
+			return hp->hook.getprocattr(p, name, value);
+		}
+	}
 	return LSM_RET_DEFAULT(getprocattr);
 }
 
@@ -4255,6 +4408,15 @@ int security_setprocattr(int lsmid, const char *name, void *value, size_t size)
 			continue;
 		return scall->hl->hook.setprocattr(name, value, size);
 	}
+	if (static_key_enabled(&security_dynamic_hook_key)) {
+		struct security_dynamic_hook_list *hp;
+
+		hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
+			if (lsmid != 0 && lsmid != hp->lsmid->id)
+				continue;
+			return hp->hook.setprocattr(name, value, size);
+		}
+	}
 	return LSM_RET_DEFAULT(setprocattr);
 }
 
@@ -5399,8 +5561,18 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	 */
 	lsm_for_each_hook(scall, xfrm_state_pol_flow_match) {
 		rc = scall->hl->hook.xfrm_state_pol_flow_match(x, xp, flic);
-		break;
+		goto out;
+	}
+	if (static_key_enabled(&security_dynamic_hook_key)) {
+		struct security_dynamic_hook_list *hp;
+
+		hlist_for_each_entry(hp, &security_hook_heads.xfrm_state_pol_flow_match,
+				     list) {
+			rc = hp->hook.xfrm_state_pol_flow_match(x, xp, flic);
+			break;
+		}
 	}
+ out:
 	return rc;
 }
 
-- 
2.43.5

