Return-Path: <SRS0=MkZ/=TD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918F4C43219
	for <linux-security-module@archiver.kernel.org>; Fri,  3 May 2019 11:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5671E2070B
	for <linux-security-module@archiver.kernel.org>; Fri,  3 May 2019 11:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfECLvu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 May 2019 07:51:50 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57459 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfECLvu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 May 2019 07:51:50 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hMWjB-0003El-Og; Fri, 03 May 2019 13:51:45 +0200
Date:   Fri, 3 May 2019 13:51:45 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     John Johansen <john.johansen@canonical.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, tglx@linutronix.de
Subject: [PATCH v3] apparmor: Use a memory pool instead per-CPU caches
Message-ID: <20190503115145.anv7z4kk7okydthm@linutronix.de>
References: <20190405133458.4809-1-bigeasy@linutronix.de>
 <ae17e2a3-7d08-5863-4fba-66ddeac11541@canonical.com>
 <20190430144725.gd6r3aketxuqdyir@linutronix.de>
 <02d7772b-5d06-1c32-b089-454547fbe08b@canonical.com>
 <20190502105158.2hluemukrdz5hbus@linutronix.de>
 <7b41609f-2592-93c1-55f7-6026ff6dba26@I-love.SAKURA.ne.jp>
 <20190502134730.d3ya46ave6a7bvom@linutronix.de>
 <001f651f-c544-c3fa-c0c2-f2a2b1ed565a@i-love.sakura.ne.jp>
 <20190503114827.yky7r2cjq7zy4dfm@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190503114827.yky7r2cjq7zy4dfm@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The get_buffers() macro may provide one or two buffers to the caller.
Those buffers are pre-allocated on init for each CPU. By default it
allocates
	2* 2 * MAX_PATH * POSSIBLE_CPU

which equals 64KiB on a system with 4 CPUs or 1MiB with 64 CPUs and so
on.

Replace the per-CPU buffers with a common memory pool which is shared
across all CPUs. The pool grows on demand and never shrinks. The pool
starts with two (UP) or four (SMP) elements. By using this pool it is
possible to request a buffer and keeping preemption enabled which avoids
the hack in profile_transition().

It has been pointed out by Tetsuo Handa that GFP_KERNEL allocations for
small amount of memory do not fail. In order not to have an endless
retry, __GFP_RETRY_MAYFAIL is passed (so the memory allocation is not
repeated until success) and retried once hoping that in the meantime a
buffer has been returned to the pool. Since now NULL is possible all
allocation paths check the buffer pointer and return -ENOMEM on failure.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v2…v3:
   - remove an unused flags variable.

v1…v2:
   - Use max_t instead min_t for a minimal buffer.
   - Pre-allocate 2 buffers on UP and 4 buffers on SMP systems.
   - Use __GFP_RETRY_MAYFAIL | __GFP_NOWARN on memory allocation. The
     allocation may fail under pressure and we will retry once.
   - Add an error path to each caller of aa_get_buffer() if the memory
     allocation fails.

 security/apparmor/domain.c       |  24 +++----
 security/apparmor/file.c         |  24 ++++---
 security/apparmor/include/path.h |  49 +--------------
 security/apparmor/lsm.c          | 105 +++++++++++++++++++++++--------
 security/apparmor/mount.c        |  65 ++++++++++++++-----
 5 files changed, 159 insertions(+), 108 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index ca2dccf5b445e..cae0e619ff4fe 100644
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
@@ -907,7 +896,12 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
 		ctx->nnp = aa_get_label(label);
 
 	/* buffer freed below, name is pointer into buffer */
-	get_buffers(buffer);
+	buffer = aa_get_buffer();
+	if (!buffer) {
+		error = -ENOMEM;
+		goto done;
+	}
+
 	/* Test for onexec first as onexec override other x transitions. */
 	if (ctx->onexec)
 		new = handle_onexec(label, ctx->onexec, ctx->token,
@@ -979,7 +973,7 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
 
 done:
 	aa_put_label(label);
-	put_buffers(buffer);
+	aa_put_buffer(buffer);
 
 	return error;
 
diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index d0afed9ebd0ed..7b424e73a8c74 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -336,12 +336,14 @@ int aa_path_perm(const char *op, struct aa_label *label,
 
 	flags |= PATH_DELEGATE_DELETED | (S_ISDIR(cond->mode) ? PATH_IS_DIR :
 								0);
-	get_buffers(buffer);
+	buffer = aa_get_buffer();
+	if (!buffer)
+		return -ENOMEM;
 	error = fn_for_each_confined(label, profile,
 			profile_path_perm(op, profile, path, buffer, request,
 					  cond, flags, &perms));
 
-	put_buffers(buffer);
+	aa_put_buffer(buffer);
 
 	return error;
 }
@@ -479,12 +481,18 @@ int aa_path_link(struct aa_label *label, struct dentry *old_dentry,
 	int error;
 
 	/* buffer freed below, lname is pointer in buffer */
-	get_buffers(buffer, buffer2);
+	buffer = aa_get_buffer();
+	buffer2 = aa_get_buffer();
+	error = -ENOMEM;
+	if (!buffer || !buffer2)
+		goto out;
+
 	error = fn_for_each_confined(label, profile,
 			profile_path_link(profile, &link, buffer, &target,
 					  buffer2, &cond));
-	put_buffers(buffer, buffer2);
-
+out:
+	aa_put_buffer(buffer);
+	aa_put_buffer(buffer2);
 	return error;
 }
 
@@ -528,7 +536,9 @@ static int __file_path_perm(const char *op, struct aa_label *label,
 		return 0;
 
 	flags = PATH_DELEGATE_DELETED | (S_ISDIR(cond.mode) ? PATH_IS_DIR : 0);
-	get_buffers(buffer);
+	buffer = aa_get_buffer();
+	if (!buffer)
+		return -ENOMEM;
 
 	/* check every profile in task label not in current cache */
 	error = fn_for_each_not_in_set(flabel, label, profile,
@@ -557,7 +567,7 @@ static int __file_path_perm(const char *op, struct aa_label *label,
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
index 87500bde5a92d..d8a3b8fe4de00 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -47,8 +47,13 @@
 /* Flag indicating whether initialization completed */
 int apparmor_initialized;
 
-DEFINE_PER_CPU(struct aa_buffers, aa_buffers);
+union aa_buffer {
+	struct list_head list;
+	char buffer[1];
+};
 
+static LIST_HEAD(aa_global_buffers);
+static DEFINE_SPINLOCK(aa_buffers_lock);
 
 /*
  * LSM hook functions
@@ -1406,6 +1411,7 @@ static int param_set_aauint(const char *val, const struct kernel_param *kp)
 		return -EPERM;
 
 	error = param_set_uint(val, kp);
+	aa_g_path_max = max_t(uint32_t, aa_g_path_max, sizeof(union aa_buffer));
 	pr_info("AppArmor: buffer size set to %d bytes\n", aa_g_path_max);
 
 	return error;
@@ -1518,6 +1524,46 @@ static int param_set_mode(const char *val, const struct kernel_param *kp)
 	return 0;
 }
 
+char *aa_get_buffer(void)
+{
+	union aa_buffer *aa_buf;
+	bool try_again = true;
+
+retry:
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
+	aa_buf = kmalloc(aa_g_path_max, GFP_KERNEL | __GFP_RETRY_MAYFAIL |
+			 __GFP_NOWARN);
+	if (!aa_buf) {
+		if (try_again) {
+			try_again = false;
+			goto retry;
+		}
+		pr_warn_once("AppArmor: Failed to allocate a memory buffer.\n");
+		return NULL;
+	}
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
@@ -1538,38 +1584,48 @@ static int __init set_init_ctx(void)
 
 static void destroy_buffers(void)
 {
-	u32 i, j;
+	union aa_buffer *aa_buf;
 
-	for_each_possible_cpu(i) {
-		for_each_cpu_buffer(j) {
-			kfree(per_cpu(aa_buffers, i).buf[j]);
-			per_cpu(aa_buffers, i).buf[j] = NULL;
-		}
+	spin_lock(&aa_buffers_lock);
+	while (!list_empty(&aa_global_buffers)) {
+		aa_buf = list_first_entry(&aa_global_buffers, union aa_buffer,
+					 list);
+		list_del(&aa_buf->list);
+		spin_unlock(&aa_buffers_lock);
+		kfree(aa_buf);
+		spin_lock(&aa_buffers_lock);
 	}
+	spin_unlock(&aa_buffers_lock);
 }
 
 static int __init alloc_buffers(void)
 {
-	u32 i, j;
+	union aa_buffer *aa_buf;
+	int i, num;
 
-	for_each_possible_cpu(i) {
-		for_each_cpu_buffer(j) {
-			char *buffer;
+	/*
+	 * A function may require two buffers at once. Usually the buffers are
+	 * used for a short period of time and are shared. On UP kernel buffers
+	 * two should be enough, with more CPUs it is possible that more
+	 * buffers will be used simultaneously. The preallocated pool may grow.
+	 * This preallocation has also the side-effect that AppArmor will be
+	 * disabled early at boot if aa_g_path_max is extremly high.
+	 */
+	if (num_online_cpus() > 1)
+		num = 4;
+	else
+		num = 2;
 
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
+	for (i = 0; i < num; i++) {
+
+		aa_buf = kmalloc(aa_g_path_max, GFP_KERNEL |
+				 __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
+		if (!aa_buf) {
+			destroy_buffers();
+			return -ENOMEM;
 		}
+		aa_put_buffer(&aa_buf->buffer[0]);
 	}
-
 	return 0;
 }
 
@@ -1734,7 +1790,7 @@ static int __init apparmor_init(void)
 	error = alloc_buffers();
 	if (error) {
 		AA_ERROR("Unable to allocate work buffers\n");
-		goto buffers_out;
+		goto alloc_out;
 	}
 
 	error = set_init_ctx();
@@ -1759,7 +1815,6 @@ static int __init apparmor_init(void)
 
 buffers_out:
 	destroy_buffers();
-
 alloc_out:
 	aa_destroy_aafs();
 	aa_teardown_dfa_engine();
diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
index 8c3787399356b..267a26fba14e1 100644
--- a/security/apparmor/mount.c
+++ b/security/apparmor/mount.c
@@ -412,11 +412,13 @@ int aa_remount(struct aa_label *label, const struct path *path,
 
 	binary = path->dentry->d_sb->s_type->fs_flags & FS_BINARY_MOUNTDATA;
 
-	get_buffers(buffer);
+	buffer = aa_get_buffer();
+	if (!buffer)
+		return -ENOMEM;
 	error = fn_for_each_confined(label, profile,
 			match_mnt(profile, path, buffer, NULL, NULL, NULL,
 				  flags, data, binary));
-	put_buffers(buffer);
+	aa_put_buffer(buffer);
 
 	return error;
 }
@@ -441,11 +443,18 @@ int aa_bind_mount(struct aa_label *label, const struct path *path,
 	if (error)
 		return error;
 
-	get_buffers(buffer, old_buffer);
+	buffer = aa_get_buffer();
+	old_buffer = aa_get_buffer();
+	error = -ENOMEM;
+	if (!buffer || old_buffer)
+		goto out;
+
 	error = fn_for_each_confined(label, profile,
 			match_mnt(profile, path, buffer, &old_path, old_buffer,
 				  NULL, flags, NULL, false));
-	put_buffers(buffer, old_buffer);
+out:
+	aa_put_buffer(buffer);
+	aa_put_buffer(old_buffer);
 	path_put(&old_path);
 
 	return error;
@@ -465,11 +474,13 @@ int aa_mount_change_type(struct aa_label *label, const struct path *path,
 	flags &= (MS_REC | MS_SILENT | MS_SHARED | MS_PRIVATE | MS_SLAVE |
 		  MS_UNBINDABLE);
 
-	get_buffers(buffer);
+	buffer = aa_get_buffer();
+	if (!buffer)
+		return -ENOMEM;
 	error = fn_for_each_confined(label, profile,
 			match_mnt(profile, path, buffer, NULL, NULL, NULL,
 				  flags, NULL, false));
-	put_buffers(buffer);
+	aa_put_buffer(buffer);
 
 	return error;
 }
@@ -492,11 +503,17 @@ int aa_move_mount(struct aa_label *label, const struct path *path,
 	if (error)
 		return error;
 
-	get_buffers(buffer, old_buffer);
+	buffer = aa_get_buffer();
+	old_buffer = aa_get_buffer();
+	error = -ENOMEM;
+	if (!buffer || !old_buffer)
+		goto out;
 	error = fn_for_each_confined(label, profile,
 			match_mnt(profile, path, buffer, &old_path, old_buffer,
 				  NULL, MS_MOVE, NULL, false));
-	put_buffers(buffer, old_buffer);
+out:
+	aa_put_buffer(buffer);
+	aa_put_buffer(old_buffer);
 	path_put(&old_path);
 
 	return error;
@@ -537,17 +554,29 @@ int aa_new_mount(struct aa_label *label, const char *dev_name,
 		}
 	}
 
-	get_buffers(buffer, dev_buffer);
+	buffer = aa_get_buffer();
+	if (!buffer) {
+		error = -ENOMEM;
+		goto out;
+	}
 	if (dev_path) {
 		error = fn_for_each_confined(label, profile,
 			match_mnt(profile, path, buffer, dev_path, dev_buffer,
 				  type, flags, data, binary));
 	} else {
+		dev_buffer = aa_get_buffer();
+		if (!dev_buffer) {
+			error = -ENOMEM;
+			goto out;
+		}
 		error = fn_for_each_confined(label, profile,
 			match_mnt_path_str(profile, path, buffer, dev_name,
 					   type, flags, data, binary, NULL));
 	}
-	put_buffers(buffer, dev_buffer);
+
+out:
+	aa_put_buffer(buffer);
+	aa_put_buffer(dev_buffer);
 	if (dev_path)
 		path_put(dev_path);
 
@@ -595,10 +624,13 @@ int aa_umount(struct aa_label *label, struct vfsmount *mnt, int flags)
 	AA_BUG(!label);
 	AA_BUG(!mnt);
 
-	get_buffers(buffer);
+	buffer = aa_get_buffer();
+	if (!buffer)
+		return -ENOMEM;
+
 	error = fn_for_each_confined(label, profile,
 			profile_umount(profile, &path, buffer));
-	put_buffers(buffer);
+	aa_put_buffer(buffer);
 
 	return error;
 }
@@ -671,7 +703,11 @@ int aa_pivotroot(struct aa_label *label, const struct path *old_path,
 	AA_BUG(!old_path);
 	AA_BUG(!new_path);
 
-	get_buffers(old_buffer, new_buffer);
+	old_buffer = aa_get_buffer();
+	new_buffer = aa_get_buffer();
+	error = -ENOMEM;
+	if (!old_buffer || !new_buffer)
+		goto out;
 	target = fn_label_build(label, profile, GFP_ATOMIC,
 			build_pivotroot(profile, new_path, new_buffer,
 					old_path, old_buffer));
@@ -690,7 +726,8 @@ int aa_pivotroot(struct aa_label *label, const struct path *old_path,
 		/* already audited error */
 		error = PTR_ERR(target);
 out:
-	put_buffers(old_buffer, new_buffer);
+	aa_put_buffer(old_buffer);
+	aa_put_buffer(new_buffer);
 
 	return error;
 
-- 
2.20.1

