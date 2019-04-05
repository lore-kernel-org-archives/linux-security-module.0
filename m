Return-Path: <SRS0=2koH=SH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8E5C10F00
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Apr 2019 13:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0D32184B
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Apr 2019 13:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfDENfJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:35:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48241 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDENfI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 Apr 2019 09:35:08 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hCOzj-0002tV-3C; Fri, 05 Apr 2019 15:34:59 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-security-module@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] apparmor: Use a memory pool instead per-CPU caches
Date:   Fri,  5 Apr 2019 15:34:57 +0200
Message-Id: <20190405133458.4809-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The get_buffers() macro may provide one or two buffers to the caller.
Those buffers are preallocated on init for each CPU. By default it
allocates
	2* 2 * MAX_PATH * POSSIBLE_CPU

which equals 64KiB on a system with 4 CPUs or 1MiB with 64 CPUs and so
on.

Replace the per-CPU buffers with a common memory pool which is shared
across all CPUs. The pool grows on demand and never shrinks.
By using this pool it is possible to request a buffer and keeping
preemption enabled which avoids the hack in profile_transition().

During light testing I didn't get more than two buffers in total with
this patch. So it seems to make sense to allocate the buffers on demand
and keep them for further use for a quick access.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 security/apparmor/domain.c       | 19 ++-----
 security/apparmor/file.c         | 15 +++---
 security/apparmor/include/path.h | 49 +----------------
 security/apparmor/lsm.c          | 90 +++++++++++++++-----------------
 security/apparmor/mount.c        | 36 ++++++++-----
 5 files changed, 77 insertions(+), 132 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index ca2dccf5b445e..1f4a6e420b6d3 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -689,20 +689,9 @@ static struct aa_label *profile_transition(struct aa_profile *profile,
 	} else if (COMPLAIN_MODE(profile)) {
 		/* no exec permission - learning mode */
 		struct aa_profile *new_profile = NULL;
-		char *n = kstrdup(name, GFP_ATOMIC);
 
-		if (n) {
-			/* name is ptr into buffer */
-			long pos = name - buffer;
-			/* break per cpu buffer hold */
-			put_buffers(buffer);
-			new_profile = aa_new_null_profile(profile, false, n,
-							  GFP_KERNEL);
-			get_buffers(buffer);
-			name = buffer + pos;
-			strcpy((char *)name, n);
-			kfree(n);
-		}
+		new_profile = aa_new_null_profile(profile, false, name,
+						  GFP_KERNEL);
 		if (!new_profile) {
 			error = -ENOMEM;
 			info = "could not create null profile";
@@ -907,7 +896,7 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
 		ctx->nnp = aa_get_label(label);
 
 	/* buffer freed below, name is pointer into buffer */
-	get_buffers(buffer);
+	buffer = aa_get_buffer();
 	/* Test for onexec first as onexec override other x transitions. */
 	if (ctx->onexec)
 		new = handle_onexec(label, ctx->onexec, ctx->token,
@@ -979,7 +968,7 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
 
 done:
 	aa_put_label(label);
-	put_buffers(buffer);
+	aa_put_buffer(buffer);
 
 	return error;
 
diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index d0afed9ebd0ed..e422a3f59e80c 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -336,12 +336,12 @@ int aa_path_perm(const char *op, struct aa_label *label,
 
 	flags |= PATH_DELEGATE_DELETED | (S_ISDIR(cond->mode) ? PATH_IS_DIR :
 								0);
-	get_buffers(buffer);
+	buffer = aa_get_buffer();
 	error = fn_for_each_confined(label, profile,
 			profile_path_perm(op, profile, path, buffer, request,
 					  cond, flags, &perms));
 
-	put_buffers(buffer);
+	aa_put_buffer(buffer);
 
 	return error;
 }
@@ -479,12 +479,13 @@ int aa_path_link(struct aa_label *label, struct dentry *old_dentry,
 	int error;
 
 	/* buffer freed below, lname is pointer in buffer */
-	get_buffers(buffer, buffer2);
+	buffer = aa_get_buffer();
+	buffer2 = aa_get_buffer();
 	error = fn_for_each_confined(label, profile,
 			profile_path_link(profile, &link, buffer, &target,
 					  buffer2, &cond));
-	put_buffers(buffer, buffer2);
-
+	aa_put_buffer(buffer);
+	aa_put_buffer(buffer2);
 	return error;
 }
 
@@ -528,7 +529,7 @@ static int __file_path_perm(const char *op, struct aa_label *label,
 		return 0;
 
 	flags = PATH_DELEGATE_DELETED | (S_ISDIR(cond.mode) ? PATH_IS_DIR : 0);
-	get_buffers(buffer);
+	buffer = aa_get_buffer();
 
 	/* check every profile in task label not in current cache */
 	error = fn_for_each_not_in_set(flabel, label, profile,
@@ -557,7 +558,7 @@ static int __file_path_perm(const char *op, struct aa_label *label,
 	if (!error)
 		update_file_ctx(file_ctx(file), label, request);
 
-	put_buffers(buffer);
+	aa_put_buffer(buffer);
 
 	return error;
 }
diff --git a/security/apparmor/include/path.h b/security/apparmor/include/path.h
index b6380c5f00972..b0b2ab85e42d8 100644
--- a/security/apparmor/include/path.h
+++ b/security/apparmor/include/path.h
@@ -15,7 +15,6 @@
 #ifndef __AA_PATH_H
 #define __AA_PATH_H
 
-
 enum path_flags {
 	PATH_IS_DIR = 0x1,		/* path is a directory */
 	PATH_CONNECT_PATH = 0x4,	/* connect disconnected paths to / */
@@ -30,51 +29,7 @@ int aa_path_name(const struct path *path, int flags, char *buffer,
 		 const char **name, const char **info,
 		 const char *disconnected);
 
-#define MAX_PATH_BUFFERS 2
-
-/* Per cpu buffers used during mediation */
-/* preallocated buffers to use during path lookups */
-struct aa_buffers {
-	char *buf[MAX_PATH_BUFFERS];
-};
-
-#include <linux/percpu.h>
-#include <linux/preempt.h>
-
-DECLARE_PER_CPU(struct aa_buffers, aa_buffers);
-
-#define ASSIGN(FN, A, X, N) ((X) = FN(A, N))
-#define EVAL1(FN, A, X) ASSIGN(FN, A, X, 0) /*X = FN(0)*/
-#define EVAL2(FN, A, X, Y...)	\
-	do { ASSIGN(FN, A, X, 1);  EVAL1(FN, A, Y); } while (0)
-#define EVAL(FN, A, X...) CONCATENATE(EVAL, COUNT_ARGS(X))(FN, A, X)
-
-#define for_each_cpu_buffer(I) for ((I) = 0; (I) < MAX_PATH_BUFFERS; (I)++)
-
-#ifdef CONFIG_DEBUG_PREEMPT
-#define AA_BUG_PREEMPT_ENABLED(X) AA_BUG(preempt_count() <= 0, X)
-#else
-#define AA_BUG_PREEMPT_ENABLED(X) /* nop */
-#endif
-
-#define __get_buffer(C, N) ({						\
-	AA_BUG_PREEMPT_ENABLED("__get_buffer without preempt disabled");  \
-	(C)->buf[(N)]; })
-
-#define __get_buffers(C, X...)    EVAL(__get_buffer, C, X)
-
-#define __put_buffers(X, Y...) ((void)&(X))
-
-#define get_buffers(X...)						\
-do {									\
-	struct aa_buffers *__cpu_var = get_cpu_ptr(&aa_buffers);	\
-	__get_buffers(__cpu_var, X);					\
-} while (0)
-
-#define put_buffers(X, Y...)		\
-do {					\
-	__put_buffers(X, Y);		\
-	put_cpu_ptr(&aa_buffers);	\
-} while (0)
+char *aa_get_buffer(void);
+void aa_put_buffer(char *buf);
 
 #endif /* __AA_PATH_H */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 49d664ddff444..224a99b12bc54 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -47,8 +47,13 @@
 /* Flag indicating whether initialization completed */
 int apparmor_initialized;
 
-DEFINE_PER_CPU(struct aa_buffers, aa_buffers);
-
+/* aa_g_path_max */
+union aa_buffer {
+	struct list_head list;
+	char buffer[1];
+};
+static LIST_HEAD(aa_global_buffers);
+static DEFINE_SPINLOCK(aa_buffers_lock);
 
 /*
  * LSM hook functions
@@ -1399,6 +1404,7 @@ static int param_set_aauint(const char *val, const struct kernel_param *kp)
 		return -EPERM;
 
 	error = param_set_uint(val, kp);
+	aa_g_path_max = min_t(uint32_t, aa_g_path_max, sizeof(union aa_buffer));
 	pr_info("AppArmor: buffer size set to %d bytes\n", aa_g_path_max);
 
 	return error;
@@ -1471,6 +1477,38 @@ static int param_set_mode(const char *val, const struct kernel_param *kp)
 	return 0;
 }
 
+char *aa_get_buffer(void)
+{
+	union aa_buffer *aa_buf;
+
+try_again:
+	spin_lock(&aa_buffers_lock);
+	if (!list_empty(&aa_global_buffers)) {
+		aa_buf = list_first_entry(&aa_global_buffers, union aa_buffer,
+					  list);
+		list_del(&aa_buf->list);
+		spin_unlock(&aa_buffers_lock);
+		return &aa_buf->buffer[0];
+	}
+	spin_unlock(&aa_buffers_lock);
+
+	aa_buf = kmalloc(aa_g_path_max, GFP_KERNEL);
+	if (WARN_ON_ONCE(!aa_buf))
+		goto try_again;
+	return &aa_buf->buffer[0];
+}
+
+void aa_put_buffer(char *buf)
+{
+	union aa_buffer *aa_buf;
+
+	aa_buf = container_of(buf, union aa_buffer, buffer[0]);
+
+	spin_lock(&aa_buffers_lock);
+	list_add(&aa_buf->list, &aa_global_buffers);
+	spin_unlock(&aa_buffers_lock);
+}
+
 /*
  * AppArmor init functions
  */
@@ -1489,43 +1527,6 @@ static int __init set_init_ctx(void)
 	return 0;
 }
 
-static void destroy_buffers(void)
-{
-	u32 i, j;
-
-	for_each_possible_cpu(i) {
-		for_each_cpu_buffer(j) {
-			kfree(per_cpu(aa_buffers, i).buf[j]);
-			per_cpu(aa_buffers, i).buf[j] = NULL;
-		}
-	}
-}
-
-static int __init alloc_buffers(void)
-{
-	u32 i, j;
-
-	for_each_possible_cpu(i) {
-		for_each_cpu_buffer(j) {
-			char *buffer;
-
-			if (cpu_to_node(i) > num_online_nodes())
-				/* fallback to kmalloc for offline nodes */
-				buffer = kmalloc(aa_g_path_max, GFP_KERNEL);
-			else
-				buffer = kmalloc_node(aa_g_path_max, GFP_KERNEL,
-						      cpu_to_node(i));
-			if (!buffer) {
-				destroy_buffers();
-				return -ENOMEM;
-			}
-			per_cpu(aa_buffers, i).buf[j] = buffer;
-		}
-	}
-
-	return 0;
-}
-
 #ifdef CONFIG_SYSCTL
 static int apparmor_dointvec(struct ctl_table *table, int write,
 			     void __user *buffer, size_t *lenp, loff_t *ppos)
@@ -1684,17 +1685,11 @@ static int __init apparmor_init(void)
 
 	}
 
-	error = alloc_buffers();
-	if (error) {
-		AA_ERROR("Unable to allocate work buffers\n");
-		goto buffers_out;
-	}
-
 	error = set_init_ctx();
 	if (error) {
 		AA_ERROR("Failed to set context on init task\n");
 		aa_free_root_ns();
-		goto buffers_out;
+		goto alloc_out;
 	}
 	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
 				"apparmor");
@@ -1710,9 +1705,6 @@ static int __init apparmor_init(void)
 
 	return error;
 
-buffers_out:
-	destroy_buffers();
-
 alloc_out:
 	aa_destroy_aafs();
 	aa_teardown_dfa_engine();
diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
index 8c3787399356b..8a6cf1c14e82a 100644
--- a/security/apparmor/mount.c
+++ b/security/apparmor/mount.c
@@ -412,11 +412,11 @@ int aa_remount(struct aa_label *label, const struct path *path,
 
 	binary = path->dentry->d_sb->s_type->fs_flags & FS_BINARY_MOUNTDATA;
 
-	get_buffers(buffer);
+	buffer = aa_get_buffer();
 	error = fn_for_each_confined(label, profile,
 			match_mnt(profile, path, buffer, NULL, NULL, NULL,
 				  flags, data, binary));
-	put_buffers(buffer);
+	aa_put_buffer(buffer);
 
 	return error;
 }
@@ -441,11 +441,13 @@ int aa_bind_mount(struct aa_label *label, const struct path *path,
 	if (error)
 		return error;
 
-	get_buffers(buffer, old_buffer);
+	buffer = aa_get_buffer();
+	old_buffer = aa_get_buffer();
 	error = fn_for_each_confined(label, profile,
 			match_mnt(profile, path, buffer, &old_path, old_buffer,
 				  NULL, flags, NULL, false));
-	put_buffers(buffer, old_buffer);
+	aa_put_buffer(buffer);
+	aa_put_buffer(old_buffer);
 	path_put(&old_path);
 
 	return error;
@@ -465,11 +467,11 @@ int aa_mount_change_type(struct aa_label *label, const struct path *path,
 	flags &= (MS_REC | MS_SILENT | MS_SHARED | MS_PRIVATE | MS_SLAVE |
 		  MS_UNBINDABLE);
 
-	get_buffers(buffer);
+	buffer = aa_get_buffer();
 	error = fn_for_each_confined(label, profile,
 			match_mnt(profile, path, buffer, NULL, NULL, NULL,
 				  flags, NULL, false));
-	put_buffers(buffer);
+	aa_put_buffer(buffer);
 
 	return error;
 }
@@ -492,11 +494,13 @@ int aa_move_mount(struct aa_label *label, const struct path *path,
 	if (error)
 		return error;
 
-	get_buffers(buffer, old_buffer);
+	buffer = aa_get_buffer();
+	old_buffer = aa_get_buffer();
 	error = fn_for_each_confined(label, profile,
 			match_mnt(profile, path, buffer, &old_path, old_buffer,
 				  NULL, MS_MOVE, NULL, false));
-	put_buffers(buffer, old_buffer);
+	aa_put_buffer(buffer);
+	aa_put_buffer(old_buffer);
 	path_put(&old_path);
 
 	return error;
@@ -537,17 +541,19 @@ int aa_new_mount(struct aa_label *label, const char *dev_name,
 		}
 	}
 
-	get_buffers(buffer, dev_buffer);
+	buffer = aa_get_buffer();
 	if (dev_path) {
 		error = fn_for_each_confined(label, profile,
 			match_mnt(profile, path, buffer, dev_path, dev_buffer,
 				  type, flags, data, binary));
 	} else {
+		dev_buffer = aa_get_buffer();
 		error = fn_for_each_confined(label, profile,
 			match_mnt_path_str(profile, path, buffer, dev_name,
 					   type, flags, data, binary, NULL));
+		aa_put_buffer(dev_buffer);
 	}
-	put_buffers(buffer, dev_buffer);
+	aa_put_buffer(buffer);
 	if (dev_path)
 		path_put(dev_path);
 
@@ -595,10 +601,10 @@ int aa_umount(struct aa_label *label, struct vfsmount *mnt, int flags)
 	AA_BUG(!label);
 	AA_BUG(!mnt);
 
-	get_buffers(buffer);
+	buffer = aa_get_buffer();
 	error = fn_for_each_confined(label, profile,
 			profile_umount(profile, &path, buffer));
-	put_buffers(buffer);
+	aa_put_buffer(buffer);
 
 	return error;
 }
@@ -671,7 +677,8 @@ int aa_pivotroot(struct aa_label *label, const struct path *old_path,
 	AA_BUG(!old_path);
 	AA_BUG(!new_path);
 
-	get_buffers(old_buffer, new_buffer);
+	old_buffer = aa_get_buffer();
+	new_buffer = aa_get_buffer();
 	target = fn_label_build(label, profile, GFP_ATOMIC,
 			build_pivotroot(profile, new_path, new_buffer,
 					old_path, old_buffer));
@@ -690,7 +697,8 @@ int aa_pivotroot(struct aa_label *label, const struct path *old_path,
 		/* already audited error */
 		error = PTR_ERR(target);
 out:
-	put_buffers(old_buffer, new_buffer);
+	aa_put_buffer(old_buffer);
+	aa_put_buffer(new_buffer);
 
 	return error;
 
-- 
2.20.1

