Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D29E37DEB5
	for <linux-security-module@vger.kernel.org>; Thu, 12 Mar 2026 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773311041; cv=none; b=s/dfpCgH7sUcPy3FGWniLuj1B+MLP7EmV+RbkEJbryO5lEzHlcyGqqmSwk4hDm2gTqNSGAgvRDynDwiaghOpq2xT4WZZ33YHTyP9IVhnZbdRX3jlUJpT5f62yzFxN9y0bVrGO3yZcqcmK4X50QE/n8rx+YxFMRCjSI5fbF2d+3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773311041; c=relaxed/simple;
	bh=Kuk5M65TLV2DqlBhfIIA4Tfd/b9WlaqiLZsMXaDZRQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWSewg1QRf1oNCBmL9zB4Ri783Co08wDTJeyAw/heIksYYDT1xwJ+utJ3vqkgdK0/ZIjotVQc9j+OFNHA8alYtbFa3ud7LaGM0H+Bs58LCwxE4YUCgX8Ut3indtmlf6JI6rTX0JIBI14pFCR/Iwy4924O8XCfvXXwC7GY2ZI+zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=jyIGR1tP; arc=none smtp.client-ip=83.166.143.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="jyIGR1tP"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fWjsh2pkqz18rZ;
	Thu, 12 Mar 2026 11:05:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773309912;
	bh=jw0yh2VxEdeafuAPsIR+ZYaijzn/nG0FVrH3u/L1ovk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jyIGR1tPRhv6TL7PsKJ1qo7f5c2QhfawtPZGigiLyY7aptF9vJvRxlAxhz1Vw5h5D
	 UBCIQcULB6C887sFgFjD07MFE57vSPHyh9KLc/85cAX3+n4jAazNCpBKNqco50M44u
	 oDWkJHyVKKHi+/+CJUNvfn7pJCwKafpYmB/tDD7g=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fWjsg6LPVzBpK;
	Thu, 12 Mar 2026 11:05:11 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Justin Suess <utilityemal77@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Shervin Oloumi <enlightened@google.com>,
	Tingmao Wang <m@maowtm.org>,
	kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH v1 03/11] nsproxy: Add FOR_EACH_NS_TYPE() X-macro and CLONE_NS_ALL
Date: Thu, 12 Mar 2026 11:04:36 +0100
Message-ID: <20260312100444.2609563-4-mic@digikod.net>
In-Reply-To: <20260312100444.2609563-1-mic@digikod.net>
References: <20260312100444.2609563-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Introduce the FOR_EACH_NS_TYPE(X) macro as the single source of truth
for the set of (struct type, CLONE_NEW* flag) pairs that define Linux
namespace types.

Currently, the list of CLONE_NEW* flags is duplicated inline in
multiple call sites and would need another copy in each new consumer.
This makes it easy to miss one when a new namespace type is added.

Derive two things from the X-macro:

- CLONE_NS_ALL: Bitmask of all known CLONE_NEW* flags, usable as a
  validity mask or iteration bound.

- ns_common_type(): Rewritten to use the X-macro via a leading-comma
  _Generic pattern, so the struct-to-flag mapping stays in sync with the
  flag set automatically.

Replace the inline flag enumerations in copy_namespaces(),
unshare_nsproxy_namespaces(), check_setns_flags(), and
ksys_unshare() with CLONE_NS_ALL.

When a new namespace type is added, only FOR_EACH_NS_TYPE needs to
be updated; CLONE_NS_ALL, ns_common_type(), and all the call sites
pick up the change automatically.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 include/linux/ns/ns_common_types.h | 44 +++++++++++++++++++++++-------
 kernel/fork.c                      |  7 ++---
 kernel/nsproxy.c                   | 13 +++------
 3 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/include/linux/ns/ns_common_types.h b/include/linux/ns/ns_common_types.h
index 170288e2e895..5cfe0ce3c881 100644
--- a/include/linux/ns/ns_common_types.h
+++ b/include/linux/ns/ns_common_types.h
@@ -7,6 +7,7 @@
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
 #include <linux/types.h>
+#include <uapi/linux/sched.h>
 
 struct cgroup_namespace;
 struct dentry;
@@ -187,15 +188,38 @@ struct ns_common {
 		struct user_namespace *:   (IS_ENABLED(CONFIG_USER_NS) ? &userns_operations   : NULL), \
 		struct uts_namespace *:    (IS_ENABLED(CONFIG_UTS_NS)  ? &utsns_operations    : NULL))
 
-#define ns_common_type(__ns)                                \
-	_Generic((__ns),                                    \
-		struct cgroup_namespace *: CLONE_NEWCGROUP, \
-		struct ipc_namespace *:    CLONE_NEWIPC,    \
-		struct mnt_namespace *:    CLONE_NEWNS,     \
-		struct net *:              CLONE_NEWNET,    \
-		struct pid_namespace *:    CLONE_NEWPID,    \
-		struct time_namespace *:   CLONE_NEWTIME,   \
-		struct user_namespace *:   CLONE_NEWUSER,   \
-		struct uts_namespace *:    CLONE_NEWUTS)
+/*
+ * FOR_EACH_NS_TYPE - Canonical list of namespace types
+ *
+ * Enumerates all (struct type, CLONE_NEW* flag) pairs.  This is the
+ * single source of truth used to derive ns_common_type() and
+ * CLONE_NS_ALL.  When adding a new namespace type, add a single entry
+ * here; all consumers update automatically.
+ *
+ * @X: Callback macro taking (struct_name, clone_flag) as arguments.
+ */
+#define FOR_EACH_NS_TYPE(X)                  \
+	X(cgroup_namespace, CLONE_NEWCGROUP) \
+	X(ipc_namespace, CLONE_NEWIPC)       \
+	X(mnt_namespace, CLONE_NEWNS)        \
+	X(net, CLONE_NEWNET)                 \
+	X(pid_namespace, CLONE_NEWPID)       \
+	X(time_namespace, CLONE_NEWTIME)     \
+	X(user_namespace, CLONE_NEWUSER)     \
+	X(uts_namespace, CLONE_NEWUTS)
+
+/* Bitmask of all known CLONE_NEW* flags. */
+#define _NS_TYPE_FLAG_OR(struct_name, flag) | (flag)
+#define CLONE_NS_ALL                        (0 FOR_EACH_NS_TYPE(_NS_TYPE_FLAG_OR))
+
+/*
+ * ns_common_type - Map a namespace struct pointer to its CLONE_NEW* flag
+ *
+ * Uses a leading-comma pattern so the FOR_EACH_NS_TYPE expansion
+ * produces ", struct foo *: FLAG" entries without a trailing comma.
+ */
+#define _NS_TYPE_ASSOC(struct_name, flag) , struct struct_name *: (flag)
+
+#define ns_common_type(__ns) _Generic((__ns)FOR_EACH_NS_TYPE(_NS_TYPE_ASSOC))
 
 #endif /* _LINUX_NS_COMMON_TYPES_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 65113a304518..767559acd060 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -46,6 +46,7 @@
 #include <linux/mm_inline.h>
 #include <linux/memblock.h>
 #include <linux/nsproxy.h>
+#include <linux/ns/ns_common_types.h>
 #include <linux/capability.h>
 #include <linux/cpu.h>
 #include <linux/cgroup.h>
@@ -3046,11 +3047,9 @@ void __init proc_caches_init(void)
  */
 static int check_unshare_flags(unsigned long unshare_flags)
 {
-	if (unshare_flags & ~(CLONE_THREAD|CLONE_FS|CLONE_NEWNS|CLONE_SIGHAND|
+	if (unshare_flags & ~(CLONE_THREAD|CLONE_FS|CLONE_SIGHAND|
 				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM|
-				CLONE_NEWUTS|CLONE_NEWIPC|CLONE_NEWNET|
-				CLONE_NEWUSER|CLONE_NEWPID|CLONE_NEWCGROUP|
-				CLONE_NEWTIME))
+				CLONE_NS_ALL))
 		return -EINVAL;
 	/*
 	 * Not implemented, but pretend it works if there is nothing
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index f0b30d1907e7..7181886331c8 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/nsproxy.h>
+#include <linux/ns/ns_common_types.h>
 #include <linux/init_task.h>
 #include <linux/mnt_namespace.h>
 #include <linux/utsname.h>
@@ -170,9 +171,7 @@ int copy_namespaces(u64 flags, struct task_struct *tsk)
 	struct user_namespace *user_ns = task_cred_xxx(tsk, user_ns);
 	struct nsproxy *new_ns;
 
-	if (likely(!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
-			      CLONE_NEWPID | CLONE_NEWNET |
-			      CLONE_NEWCGROUP | CLONE_NEWTIME)))) {
+	if (likely(!(flags & (CLONE_NS_ALL & ~CLONE_NEWUSER)))) {
 		if ((flags & CLONE_VM) ||
 		    likely(old_ns->time_ns_for_children == old_ns->time_ns)) {
 			get_nsproxy(old_ns);
@@ -214,9 +213,7 @@ int unshare_nsproxy_namespaces(unsigned long unshare_flags,
 	struct user_namespace *user_ns;
 	int err = 0;
 
-	if (!(unshare_flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
-			       CLONE_NEWNET | CLONE_NEWPID | CLONE_NEWCGROUP |
-			       CLONE_NEWTIME)))
+	if (!(unshare_flags & (CLONE_NS_ALL & ~CLONE_NEWUSER)))
 		return 0;
 
 	user_ns = new_cred ? new_cred->user_ns : current_user_ns();
@@ -292,9 +289,7 @@ int exec_task_namespaces(void)
 
 static int check_setns_flags(unsigned long flags)
 {
-	if (!flags || (flags & ~(CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
-				 CLONE_NEWNET | CLONE_NEWTIME | CLONE_NEWUSER |
-				 CLONE_NEWPID | CLONE_NEWCGROUP)))
+	if (!flags || (flags & ~CLONE_NS_ALL))
 		return -EINVAL;
 
 #ifndef CONFIG_USER_NS
-- 
2.53.0

