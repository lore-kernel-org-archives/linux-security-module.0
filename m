Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFF5C433F5
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Dec 2021 07:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbhLJHZF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:25:05 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4241 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbhLJHZF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Dec 2021 02:25:05 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J9Mk56Yn4z67MnZ;
        Fri, 10 Dec 2021 15:20:13 +0800 (CST)
Received: from mscphispre00059.huawei.com (10.123.71.64) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Fri, 10 Dec 2021 08:21:28 +0100
From:   Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
To:     <mic@digikod.net>
CC:     <linux-security-module@vger.kernel.org>, <yusongping@huawei.com>,
        <artem.kuzin@huawei.com>
Subject: [RFC PATCH 0/2] Landlock network PoC implementation
Date:   Fri, 10 Dec 2021 15:21:23 +0800
Message-ID: <20211210072123.386713-1-konstantin.meskhidze@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.123.71.64]
X-ClientProxiedBy: mscpeml500002.china.huawei.com (7.188.26.138) To
 fraeml704-chm.china.huawei.com (10.206.15.53)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

According the main idea of Landlock's author Mickaёl Salun the goal
of Landlock is to enable to restrict ambient rights
(e.g. global filesystem access) for a set of processes.
Landlock is stackable LSM. Landlock empowers any process,
including unprivileged ones, to securely restrict themselves.
This feature could be very helpful in containerized environment
and different sandboxed applications.

Now Landlock supports a number of filesytem access rights:
	- file execute
	- write to file
	- read file
	- make directory
 and etc.

So, this PoC patch provides the basic idea for Landlock network
access-control implementation.
eBPF-based sandboxes like BPFcontain and BPFbox sandboxes confine
network traffic at the socket level. Network rules grant access
to various socket operations on the IPv4 and IPv6 socket families.
Socket operations could be grouped by different use cases:
	• Client, server.
	• Send and receive categories.
BPFbox operation example:
	- connect
	- bind
	- accept
	- listen
	- send
 and etc.

Landlock network enhancement should follow similar logic
like in mentioned sandboxes!

Implementation related issues
=============================

1. Its needed to add a new type of rules:

enum landlock_rule_type {
	LANDLOCK_RULE_PATH_BENEATH = 1,
	LANDLOCK_RULE_NET = 2,
	LANDLOCK_RULE_TYPE_NUM
}

struct landlock_ruleset_attr {
	_u64 handled_access_fs;
	_u64 handled_actions_net;
}

struct landlock_net_beneath_attr {
	/**
	 * @allowed_actions: Bitmask of allowed network actions
	 * for a current process
	 */
	__u64 allowed_actions;
}


2. Added 2 defines for network allowed actions.
Now the current prototype patch support creating 2 types
of sockets - unix and inet:
	LANDLOCK_ACCESS_FS_MAKE_UNIX_SOCK	 (1ULL << 0)
	LANDLOCK_ACCESS_FS_MAKE_INET_SOCK	 (1ULL << 1)

Its needed to discuss what kind of sockets types and actions
should be supported in MINIMAL version!!!


3. Syscalls interfaces.
Current syscall interface look like enough for support different
rule types, but it’s needed to modify some internal functions
to support it.

As an example:
struct landlock_ruleset *landlock_create_ruleset(const u32 fs_access_mask,
						 const u32 net_access_mask)
{
	struct landlock_ruleset *new_ruleset;

	/* Informs about useless ruleset. */
	if (!access_mask && !net_access_mask )
		return ERR_PTR(-ENOMSG);
	new_ruleset = create_ruleset(1);
	if (!IS_ERR(new_ruleset) && access_mask)
		new_ruleset->access_masks[0][0] = access_mask;
	if (!IS_ERR(new_ruleset) && net_access_mask)
		new_ruleset->fs_access_masks[1][0] = net_access_mask;

	return new_ruleset;
}

In future, it's to use an array access_mask[LANDLOCK_RULE_TYPE_NUM - 1]
enum landlock_rule_type {
	LANDLOCK_RULE_PATH_BENEATH = 1
	LANDLOCK_RULE_NET = 2,

	LANDLOCK_RULE_TYPE_NUM
};


4. Kernel objects.
For filesystem restrictions inodes objects are used to tie landlock rules.
But for socket operations it's preferred to use task_struct object of
a process, cause sockets' inodes are created just after
security_socket_create() hook is called, and if its needed to have
some restriction rule for creating sockets, this rule can't be tied
to a socket inode cause there is no any has been created at the hook's
catching moment, see the sock_create_lite() function below:

int sock_create_lite(int family, int type, int protocol,
		     struct socket **res)
{
	int err;
	struct socket *sock = NULL;

	err = security_socket_create(family, type, protocol, 1);
	if (err)
		goto out;
	...

	sock = sock_alloc();
	if (!sock) {
		err = -ENOMEM;
		goto out;
	}
	...
}
And all other socket rules can be tied to a process object, cause
it would be easier to maintaint and control it.
For containerized application a user could create a bunch container with
individual network restriction rules tied to them.

This solution (what kernel object to use) must be established first,
cause the following design depends on it.


5. Landlock internal structures modifications.

 - In further patches its needed network_rules structure in landlock_layer
structure to support network rules:

	struct landlock_layer {
		/**
		* @level: Position of this layer in the layer stack.
		*/
		u16 level;
		/**
		* @access: Bitfield of allowed actions on the kernel object.  They are
		* relative to the object type (e.g. %LANDLOCK_ACTION_FS_READ).
		*/
		u16 access;

		struct network_rules;
	};

The architecture of struct network_rules has not been established yet,
and it could be like this :

	struct network_rules {
		Socket_domains = {AF_UNIX, AF_INET
		Socket_types = {SOCK_STREAM, ...
		Socket_protocols = {IP, TCP, ...
		Socket_actions = {"connect", "bind"
		IP_address_allowed[]
	}

 - Using pointer to FAM arrays of different types of access masks: fs,
network, ipc etc.

	struct landlock_ruleset {

		struct rb_root root;
		...
		...

		u16 *access_masks[];
	};


This is just the basic ideas for the open discussion.
Please give your opinion and suggestion.

Konstantin Meskhidze (2):
  landlock: base template for network hooks
  landlock: socket_create() hook implemented

 include/uapi/linux/landlock.h |  69 +++++++++++
 security/landlock/Makefile    |   2 +-
 security/landlock/fs.c        |   4 +-
 security/landlock/limits.h    |   3 +
 security/landlock/net.c       | 209 ++++++++++++++++++++++++++++++++++
 security/landlock/net.h       |  50 ++++++++
 security/landlock/ruleset.c   |  46 ++++++--
 security/landlock/ruleset.h   |  11 +-
 security/landlock/setup.c     |   3 +
 security/landlock/syscalls.c  | 140 ++++++++++++++++-------
 10 files changed, 479 insertions(+), 58 deletions(-)
 create mode 100644 security/landlock/net.c
 create mode 100644 security/landlock/net.h

--
2.25.1

From 8f1dff03a9722601334a31ee3c6680240a0e6e1c Mon Sep 17 00:00:00 2001
From: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Date: Fri, 19 Nov 2021 11:18:23 +0800
Subject: [RFC PATCH 1/2] landlock: base template for network hooks

Add a new rule type LANDLOCK_RULE_NET to
landlock_rule_type.
Add landlock_net_beneath_attr to support network
allowed actions.
Add two network flags for socket creation confinement:
LANDLOCK_ACCESS_FS_MAKE_UNIX_SOCK,
LANDLOCK_ACCESS_FS_MAKE_INET_SOCK.
Update Landlock syscalls to support network rules
injections.
Update landlock_ruleset structure to support network access mask.
Add net.c and net.h files with network template functions.
Add new blob size with lbs_task and landlock_add_net_hooks
into landlock_init().

Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
---
 include/uapi/linux/landlock.h |  69 +++++++++++++++++
 security/landlock/Makefile    |   2 +-
 security/landlock/fs.c        |   4 +-
 security/landlock/limits.h    |   3 +
 security/landlock/net.c       |  88 +++++++++++++++++++++
 security/landlock/net.h       |  51 +++++++++++++
 security/landlock/ruleset.c   |  46 ++++++++---
 security/landlock/ruleset.h   |   9 ++-
 security/landlock/setup.c     |   3 +
 security/landlock/syscalls.c  | 140 ++++++++++++++++++++++++----------
 10 files changed, 358 insertions(+), 57 deletions(-)
 create mode 100644 security/landlock/net.c
 create mode 100644 security/landlock/net.h

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index b3d952067f59..7d980b55d345 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -25,6 +25,14 @@ struct landlock_ruleset_attr {
 	 * compatibility reasons.
 	 */
 	__u64 handled_access_fs;
+
+	/**
+	 * @handled_actions_net: Bitmask of actions (cf. `Network flags`_)
+	 * that is handled by this ruleset and should then be forbidden if no
+	 * rule explicitly allow them.  This is needed for backward
+	 * compatibility reasons.
+	 */
+	__u64 handled_access_net;
 };

 /*
@@ -46,6 +54,18 @@ enum landlock_rule_type {
 	 * landlock_path_beneath_attr .
 	 */
 	LANDLOCK_RULE_PATH_BENEATH = 1,
+
+	/**
+	 * @LANDLOCK_RULE_NET: Type of a &struct
+	 * landlock_net_beneath_attr .
+	 */
+	LANDLOCK_RULE_NET = 2,
+
+	/**
+	 * @LANDLOCK_RULE_TYPE_NUM: Number of
+	 * Landlock	rules type: fs, network, ipc ect.
+	 */
+	LANDLOCK_RULE_TYPE_NUM
 };

 /**
@@ -70,6 +90,22 @@ struct landlock_path_beneath_attr {
 	 */
 } __attribute__((packed));

+/**
+ * struct landlock_path_beneath_attr - Network actions definition
+ *
+ * Argument of sys_landlock_add_rule().
+ */
+struct landlock_net_beneath_attr {
+	/**
+	 * @allowed_actions: Bitmask of allowed network actions for a current process
+	 */
+	__u64 allowed_actions;
+	/*
+	 * This struct is packed to avoid trailing reserved members.
+	 * Cf. security/landlock/syscalls.c:build_check_abi()
+	 */
+} __attribute__((packed));
+
 /**
  * DOC: fs_access
  *
@@ -134,4 +170,37 @@ struct landlock_path_beneath_attr {
 #define LANDLOCK_ACCESS_FS_MAKE_BLOCK			(1ULL << 11)
 #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)

+/**
+ * DOC: net_actions
+ *
+ * A set of actions on kernel objects may be defined by an attribute (e.g.
+ * &struct landlock_net_beneath_attr) including a bitmask of access.
+ *
+ * Network flags
+ * ~~~~~~~~~~~~~~~~
+ *
+ * These flags enable to restrict a sandboxed process to a set of actions on
+ * network actions.
+ *
+ * A process can only create these type sockets with allowed actions:
+ *
+ * - %LANDLOCK_ACCESS_NET_MAKE...: Create a unix/inet socket.
+ *
+ * - %LANDLOCK_ACCESS_NET_MAKE_UNIX_SOCK: Create (or rename or link) a UNIX domain
+ *   socket.
+ * - %LANDLOCK_ACCESS_NET_MAKE_INET_SOCK: Create (or rename or link) a IPv4 Internet
+ *   protocols domain socket.
+ *
+ * .. warning::
+ *
+ *   It is currently not possible to restrict some network-related actions
+ *   accessible through these syscall families:   accept(2), bind(2),
+ *   close(2), connect(2), fcntl(2),getpeername(2), getsockname(2),
+ *   getsockopt(2), listen(2), read(2), recv(2), select(2), send(2),
+ *   shutdown(2), socketpair(2),
+ *   Future Landlock evolutions will enable to restrict them.
+ */
+#define LANDLOCK_ACCESS_FS_MAKE_UNIX_SOCK	 (1ULL << 0)
+#define LANDLOCK_ACCESS_FS_MAKE_INET_SOCK	 (1ULL << 1)
+
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index 7bbd2f413b3e..afa44baaa83a 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -1,4 +1,4 @@
 obj-$(CONFIG_SECURITY_LANDLOCK) := landlock.o

 landlock-y := setup.o syscalls.o object.o ruleset.o \
-	cred.o ptrace.o fs.o
+	cred.o ptrace.o fs.o net.o
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 97b8e421f617..bb5967fc5dd4 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -163,7 +163,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 		return -EINVAL;

 	/* Transforms relative access rights to absolute ones. */
-	access_rights |= LANDLOCK_MASK_ACCESS_FS & ~ruleset->fs_access_masks[0];
+	access_rights |= LANDLOCK_MASK_ACCESS_FS & ~ruleset->access_masks[0][0];
 	object = get_inode_object(d_backing_inode(path->dentry));
 	if (IS_ERR(object))
 		return PTR_ERR(object);
@@ -252,7 +252,7 @@ static int check_access_path(const struct landlock_ruleset *const domain,
 	/* Saves all layers handling a subset of requested accesses. */
 	layer_mask = 0;
 	for (i = 0; i < domain->num_layers; i++) {
-		if (domain->fs_access_masks[i] & access_request)
+		if (domain->access_masks[0][i] & access_request)
 			layer_mask |= BIT_ULL(i);
 	}
 	/* An access request not handled by the domain is allowed. */
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 2a0a1095ee27..56f883530545 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -18,4 +18,7 @@
 #define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_MAKE_SYM
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)

+#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_FS_MAKE_INET_SOCK
+#define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
+
 #endif /* _SECURITY_LANDLOCK_LIMITS_H */
diff --git a/security/landlock/net.c b/security/landlock/net.c
new file mode 100644
index 000000000000..49af2c821f79
--- /dev/null
+++ b/security/landlock/net.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock LSM - Filesystem management and hooks
+ *
+ * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2020 ANSSI
+ */
+
+#include <linux/atomic.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/compiler_types.h>
+#include <linux/dcache.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/limits.h>
+#include <linux/list.h>
+#include <linux/lsm_hooks.h>
+#include <linux/mount.h>
+#include <linux/namei.h>
+#include <linux/path.h>
+#include <linux/rcupdate.h>
+#include <linux/spinlock.h>
+#include <linux/stat.h>
+#include <linux/types.h>
+#include <linux/wait_bit.h>
+#include <linux/workqueue.h>
+#include <uapi/linux/landlock.h>
+#include <linux/thread_info.h>
+#include <linux/sched.h>
+
+
+#include "common.h"
+#include "cred.h"
+#include "fs.h"
+#include "limits.h"
+#include "object.h"
+#include "ruleset.h"
+#include "setup.h"
+#include "net.h"
+
+/* Underlying object management */
+
+static void release_task_object(struct landlock_object *const object)
+{
+	struct task_struct *const task = object->underobj;
+
+	/* Untie landlock object from kernel object */
+	object->underobj = NULL;
+
+	/* Untie kernel object from landlock object */
+	rcu_assign_pointer(landlock_task(task)->object, NULL);
+
+}
+
+static const struct landlock_object_underops landlock_net_underops = {
+	.release = release_task_object
+};
+
+struct task_struct;
+
+static inline struct task_struct *get_current_task(void)
+{
+	return current;
+}
+
+int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
+						     u32 access_hierarchy)
+{
+	return 0;
+}
+
+static int hook_socket_create(int family, int type, int protocol, int kern)
+{
+	return 0;
+}
+
+static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(socket_create, hook_socket_create),
+};
+
+__init void landlock_add_net_hooks(void)
+{
+	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
+			LANDLOCK_NAME);
+}
diff --git a/security/landlock/net.h b/security/landlock/net.h
new file mode 100644
index 000000000000..094ac150ac3c
--- /dev/null
+++ b/security/landlock/net.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock LSM - Network management and hooks
+ *
+ * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2020 ANSSI
+ */
+
+#ifndef _SECURITY_LANDLOCK_NET_H
+#define _SECURITY_LANDLOCK_NET_H
+
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <asm/current.h>
+#include <linux/cred.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/lsm_hooks.h>
+#include <linux/rcupdate.h>
+#include <linux/sched.h>
+
+#include "common.h"
+#include "ruleset.h"
+#include "setup.h"
+
+
+/**
+ * struct landlock_task_security - Process task security blob
+ *
+ * Enable to reference a &struct landlock_object tied to a task (i.e.
+ * underlying object).
+ */
+struct landlock_task_security {
+	/**
+	 * @object: Weak pointer to an allocated object.
+	 */
+	struct landlock_object __rcu *object;
+};
+
+static inline struct landlock_task_security *landlock_task(
+		const struct task_struct *const task)
+{
+	return task->security + landlock_blob_sizes.lbs_task;
+}
+
+__init void landlock_add_net_hooks(void);
+
+int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
+						     u32 access_hierarchy);
+
+#endif /* _SECURITY_LANDLOCK_NET_H */
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index ec72b9262bf3..cec0fd1f83df 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
+#include <uapi/linux/landlock.h>

 #include "limits.h"
 #include "object.h"
@@ -27,9 +28,23 @@
 static struct landlock_ruleset *create_ruleset(const u32 num_layers)
 {
 	struct landlock_ruleset *new_ruleset;
+	u16 row, col, rules_types_num;
+
+	new_ruleset = kmalloc(sizeof(*new_ruleset) +
+			      sizeof *(new_ruleset->access_masks),
+			      GFP_KERNEL_ACCOUNT);
+
+	rules_types_num = LANDLOCK_RULE_TYPE_NUM - 1;
+	for (row = 0; row < rules_types_num; row++) {
+		new_ruleset->access_masks[row] = kmalloc(sizeof *(new_ruleset->access_masks[row]),
+							 GFP_KERNEL_ACCOUNT);
+		for (col = 0; col < num_layers; col++) {
+			static int count = 1;
+
+			new_ruleset->access_masks[row][col] = count++;
+		}
+	}

-	new_ruleset = kzalloc(struct_size(new_ruleset, fs_access_masks,
-				num_layers), GFP_KERNEL_ACCOUNT);
 	if (!new_ruleset)
 		return ERR_PTR(-ENOMEM);
 	refcount_set(&new_ruleset->usage, 1);
@@ -39,21 +54,25 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
 	/*
 	 * hierarchy = NULL
 	 * num_rules = 0
-	 * fs_access_masks[] = 0
+	 * access_masks[] = 0
 	 */
 	return new_ruleset;
 }

-struct landlock_ruleset *landlock_create_ruleset(const u32 fs_access_mask)
+struct landlock_ruleset *landlock_create_ruleset(const u32 fs_access_mask,
+						 const u32 net_access_mask)
 {
 	struct landlock_ruleset *new_ruleset;

 	/* Informs about useless ruleset. */
-	if (!fs_access_mask)
+	if (!fs_access_mask && !net_access_mask)
 		return ERR_PTR(-ENOMSG);
 	new_ruleset = create_ruleset(1);
-	if (!IS_ERR(new_ruleset))
-		new_ruleset->fs_access_masks[0] = fs_access_mask;
+	if (!IS_ERR(new_ruleset) && fs_access_mask)
+		new_ruleset->access_masks[0][0] = fs_access_mask;
+	if (!IS_ERR(new_ruleset) && net_access_mask)
+		new_ruleset->access_masks[1][0] = net_access_mask;
+
 	return new_ruleset;
 }

@@ -116,11 +135,13 @@ static void build_check_ruleset(void)
 		.num_rules = ~0,
 		.num_layers = ~0,
 	};
-	typeof(ruleset.fs_access_masks[0]) fs_access_mask = ~0;
+	typeof(ruleset.access_masks[0][0]) fs_access_mask = ~0;
+	typeof(ruleset.access_masks[1][0]) net_access_mask = ~0;

 	BUILD_BUG_ON(ruleset.num_rules < LANDLOCK_MAX_NUM_RULES);
 	BUILD_BUG_ON(ruleset.num_layers < LANDLOCK_MAX_NUM_LAYERS);
 	BUILD_BUG_ON(fs_access_mask < LANDLOCK_MASK_ACCESS_FS);
+	BUILD_BUG_ON(net_access_mask < LANDLOCK_MASK_ACCESS_NET);
 }

 /**
@@ -279,7 +300,10 @@ static int merge_ruleset(struct landlock_ruleset *const dst,
 		err = -EINVAL;
 		goto out_unlock;
 	}
-	dst->fs_access_masks[dst->num_layers - 1] = src->fs_access_masks[0];
+	/* Copy fs access masks. */
+	dst->access_masks[0][dst->num_layers - 1] = src->access_masks[0][0];
+	/* Copy network access masks. */
+	dst->access_masks[1][dst->num_layers - 1] = src->access_masks[1][0];

 	/* Merges the @src tree. */
 	rbtree_postorder_for_each_entry_safe(walker_rule, next_rule,
@@ -337,8 +361,8 @@ static int inherit_ruleset(struct landlock_ruleset *const parent,
 		goto out_unlock;
 	}
 	/* Copies the parent layer stack and leaves a space for the new layer. */
-	memcpy(child->fs_access_masks, parent->fs_access_masks,
-			flex_array_size(parent, fs_access_masks, parent->num_layers));
+	memcpy(child->access_masks, parent->access_masks,
+			flex_array_size(parent, access_masks, parent->num_layers));

 	if (WARN_ON_ONCE(!parent->hierarchy)) {
 		err = -EINVAL;
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 2d3ed7ec5a0a..8f4285fab372 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -97,7 +97,7 @@ struct landlock_ruleset {
 		 * section.  This is only used by
 		 * landlock_put_ruleset_deferred() when @usage reaches zero.
 		 * The fields @lock, @usage, @num_rules, @num_layers and
-		 * @fs_access_masks are then unused.
+		 * @access_masks are then unused.
 		 */
 		struct work_struct work_free;
 		struct {
@@ -124,7 +124,7 @@ struct landlock_ruleset {
 			 */
 			u32 num_layers;
 			/**
-			 * @fs_access_masks: Contains the subset of filesystem
+			 * @access_masks: Contains the subset of filesystem
 			 * actions that are restricted by a ruleset.  A domain
 			 * saves all layers of merged rulesets in a stack
 			 * (FAM), starting from the first layer to the last
@@ -135,12 +135,13 @@ struct landlock_ruleset {
 			 * layers are set once and never changed for the
 			 * lifetime of the ruleset.
 			 */
-			u16 fs_access_masks[];
+			u16 *access_masks[];
 		};
 	};
 };

-struct landlock_ruleset *landlock_create_ruleset(const u32 fs_access_mask);
+struct landlock_ruleset *landlock_create_ruleset(const u32 fs_access_mask,
+						 const u32 net_access_mask);

 void landlock_put_ruleset(struct landlock_ruleset *const ruleset);
 void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset);
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index f8e8e980454c..91ab06ec8ce0 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -14,6 +14,7 @@
 #include "fs.h"
 #include "ptrace.h"
 #include "setup.h"
+#include "net.h"

 bool landlock_initialized __lsm_ro_after_init = false;

@@ -21,6 +22,7 @@ struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
 	.lbs_cred = sizeof(struct landlock_cred_security),
 	.lbs_inode = sizeof(struct landlock_inode_security),
 	.lbs_superblock = sizeof(struct landlock_superblock_security),
+	.lbs_task = sizeof(struct landlock_task_security),
 };

 static int __init landlock_init(void)
@@ -28,6 +30,7 @@ static int __init landlock_init(void)
 	landlock_add_cred_hooks();
 	landlock_add_ptrace_hooks();
 	landlock_add_fs_hooks();
+	landlock_add_net_hooks();
 	landlock_initialized = true;
 	pr_info("Up and running.\n");
 	return 0;
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 32396962f04d..72cb1b0cb8a9 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -31,6 +31,7 @@
 #include "limits.h"
 #include "ruleset.h"
 #include "setup.h"
+#include "net.h"

 /**
  * copy_min_struct_from_user - Safe future-proof argument copying
@@ -73,7 +74,8 @@ static void build_check_abi(void)
 {
 	struct landlock_ruleset_attr ruleset_attr;
 	struct landlock_path_beneath_attr path_beneath_attr;
-	size_t ruleset_size, path_beneath_size;
+	struct landlock_net_beneath_attr net_beneath_attr;
+	size_t ruleset_size, path_beneath_size, net_beneath_size;

 	/*
 	 * For each user space ABI structures, first checks that there is no
@@ -81,13 +83,18 @@ static void build_check_abi(void)
 	 * struct size.
 	 */
 	ruleset_size = sizeof(ruleset_attr.handled_access_fs);
+	ruleset_size += sizeof(ruleset_attr.handled_access_net);
 	BUILD_BUG_ON(sizeof(ruleset_attr) != ruleset_size);
-	BUILD_BUG_ON(sizeof(ruleset_attr) != 8);
+	BUILD_BUG_ON(sizeof(ruleset_attr) != 16);

 	path_beneath_size = sizeof(path_beneath_attr.allowed_access);
 	path_beneath_size += sizeof(path_beneath_attr.parent_fd);
 	BUILD_BUG_ON(sizeof(path_beneath_attr) != path_beneath_size);
 	BUILD_BUG_ON(sizeof(path_beneath_attr) != 12);
+
+	net_beneath_size = sizeof(net_beneath_attr.allowed_actions);
+	BUILD_BUG_ON(sizeof(net_beneath_attr) != net_beneath_size);
+	BUILD_BUG_ON(sizeof(net_beneath_attr) != 8);
 }

 /* Ruleset handling */
@@ -174,20 +181,33 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 		return -EINVAL;
 	}

-	/* Copies raw user space buffer. */
+	/* Copies raw user space buffer for fs. */
 	err = copy_min_struct_from_user(&ruleset_attr, sizeof(ruleset_attr),
 			offsetofend(typeof(ruleset_attr), handled_access_fs),
 			attr, size);
 	if (err)
 		return err;

+	/* Copies raw user space buffer for network. */
+	err = copy_min_struct_from_user(&ruleset_attr, sizeof(ruleset_attr),
+			offsetofend(typeof(ruleset_attr), handled_access_net),
+			attr, size);
+	if (err)
+		return err;
+
 	/* Checks content (and 32-bits cast). */
 	if ((ruleset_attr.handled_access_fs | LANDLOCK_MASK_ACCESS_FS) !=
 			LANDLOCK_MASK_ACCESS_FS)
 		return -EINVAL;

+	/* Checks content (and 32-bits cast). */
+	if ((ruleset_attr.handled_access_net | LANDLOCK_MASK_ACCESS_NET) !=
+			LANDLOCK_MASK_ACCESS_NET)
+		return -EINVAL;
+
 	/* Checks arguments and transforms to kernel struct. */
-	ruleset = landlock_create_ruleset(ruleset_attr.handled_access_fs);
+	ruleset = landlock_create_ruleset(ruleset_attr.handled_access_fs,
+					  ruleset_attr.handled_access_net);
 	if (IS_ERR(ruleset))
 		return PTR_ERR(ruleset);

@@ -306,6 +326,7 @@ SYSCALL_DEFINE4(landlock_add_rule,
 		const void __user *const, rule_attr, const __u32, flags)
 {
 	struct landlock_path_beneath_attr path_beneath_attr;
+	struct landlock_net_beneath_attr  net_beneath_attr;
 	struct path path;
 	struct landlock_ruleset *ruleset;
 	int res, err;
@@ -317,47 +338,88 @@ SYSCALL_DEFINE4(landlock_add_rule,
 	if (flags)
 		return -EINVAL;

-	if (rule_type != LANDLOCK_RULE_PATH_BENEATH)
+	if ((rule_type != LANDLOCK_RULE_PATH_BENEATH) &&
+	    (rule_type != LANDLOCK_RULE_NET))
 		return -EINVAL;

-	/* Copies raw user space buffer, only one type for now. */
-	res = copy_from_user(&path_beneath_attr, rule_attr,
-			sizeof(path_beneath_attr));
-	if (res)
-		return -EFAULT;
-
-	/* Gets and checks the ruleset. */
-	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_WRITE);
-	if (IS_ERR(ruleset))
-		return PTR_ERR(ruleset);
-
-	/*
-	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
-	 * are ignored in path walks.
-	 */
-	if (!path_beneath_attr.allowed_access) {
-		err = -ENOMSG;
-		goto out_put_ruleset;
+	if (rule_type == LANDLOCK_RULE_PATH_BENEATH) {
+		/* Copies raw user space buffer, only one type for now. */
+		res = copy_from_user(&path_beneath_attr, rule_attr,
+				sizeof(path_beneath_attr));
+		if (res)
+			return -EFAULT;
 	}
-	/*
-	 * Checks that allowed_access matches the @ruleset constraints
-	 * (ruleset->fs_access_masks[0] is automatically upgraded to 64-bits).
-	 */
-	if ((path_beneath_attr.allowed_access | ruleset->fs_access_masks[0]) !=
-			ruleset->fs_access_masks[0]) {
-		err = -EINVAL;
-		goto out_put_ruleset;
+
+	if (rule_type == LANDLOCK_RULE_NET) {
+		/* Copies raw user space buffer, only one type for now. */
+		res = copy_from_user(&net_beneath_attr, rule_attr,
+				sizeof(net_beneath_attr));
+		if (res)
+			return -EFAULT;
 	}

-	/* Gets and checks the new rule. */
-	err = get_path_from_fd(path_beneath_attr.parent_fd, &path);
-	if (err)
-		goto out_put_ruleset;
+	if (rule_type == LANDLOCK_RULE_PATH_BENEATH) {
+		/* Gets and checks the ruleset. */
+		ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_WRITE);
+		if (IS_ERR(ruleset))
+			return PTR_ERR(ruleset);
+
+		/*
+		 * Informs about useless rule: empty allowed_access (i.e. deny rules)
+		 * are ignored in path walks.
+		 */
+		if (!path_beneath_attr.allowed_access) {
+			err = -ENOMSG;
+			goto out_put_ruleset;
+		}
+		/*
+		 * Checks that allowed_access matches the @ruleset constraints
+		 * (ruleset->access_masks[0][0] is automatically upgraded to 64-bits).
+		 */
+		if ((path_beneath_attr.allowed_access | ruleset->access_masks[0][0]) !=
+				ruleset->access_masks[0][0]) {
+			err = -EINVAL;
+			goto out_put_ruleset;
+		}
+
+		/* Gets and checks the new rule. */
+		err = get_path_from_fd(path_beneath_attr.parent_fd, &path);
+		if (err)
+			goto out_put_ruleset;
+
+		/* Imports the new rule. */
+		err = landlock_append_fs_rule(ruleset, &path,
+				path_beneath_attr.allowed_access);
+		path_put(&path);
+	}

-	/* Imports the new rule. */
-	err = landlock_append_fs_rule(ruleset, &path,
-			path_beneath_attr.allowed_access);
-	path_put(&path);
+	if (rule_type == LANDLOCK_RULE_NET) {
+		/* Gets and checks the ruleset. */
+		ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_WRITE);
+		if (IS_ERR(ruleset))
+			return PTR_ERR(ruleset);
+
+		/*
+		 * Informs about useless rule: empty allowed_access (i.e. deny rules)
+		 * are ignored in network actions
+		 */
+		if (!net_beneath_attr.allowed_actions) {
+			err = -ENOMSG;
+			goto out_put_ruleset;
+		}
+		/*
+		 * Checks that allowed_access matches the @ruleset constraints
+		 * (ruleset->access_masks[1][0] is automatically upgraded to 64-bits).
+		 */
+		if ((net_beneath_attr.allowed_actions | ruleset->access_masks[1][0]) !=
+				ruleset->access_masks[1][0]) {
+			err = -EINVAL;
+			goto out_put_ruleset;
+		}
+
+		/* Imports the new rule. */
+		err = landlock_append_net_rule(ruleset, net_beneath_attr.allowed_actions);
+	}

 out_put_ruleset:
 	landlock_put_ruleset(ruleset);
--
2.25.1


From 5216f8c21805879cd41d57f858817417669a7f40 Mon Sep 17 00:00:00 2001
From: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Date: Fri, 3 Dec 2021 12:04:11 +0800
Subject: [RFC PATCH 2/2] landlock: socket_create() hook implemented

Implement socket_create() hook.
Current prototype can restrict creating two
types of sockets: INET and UNIX. Its just basic idea
how Landlock could support network confinement.

Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
---
 security/landlock/net.c      | 141 ++++++++++++++++++++++++++++++++---
 security/landlock/net.h      |   5 +-
 security/landlock/ruleset.h  |   2 +-
 security/landlock/syscalls.c |   2 +-
 4 files changed, 135 insertions(+), 15 deletions(-)

diff --git a/security/landlock/net.c b/security/landlock/net.c
index 49af2c821f79..3c6b3a6da322 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -42,17 +42,10 @@
 #include "net.h"

 /* Underlying object management */
-
 static void release_task_object(struct landlock_object *const object)
 {
-	struct task_struct *const task = object->underobj;
-
 	/* Untie landlock object from kernel object */
 	object->underobj = NULL;
-
-	/* Untie kernel object from landlock object */
-	rcu_assign_pointer(landlock_task(task)->object, NULL);
-
 }

 static const struct landlock_object_underops landlock_net_underops = {
@@ -66,15 +59,143 @@ static inline struct task_struct *get_current_task(void)
 	return current;
 }

+static struct landlock_object *get_task_object(struct task_struct *const task)
+{
+	struct landlock_object *object, *new_object;
+	struct landlock_task_security *task_sec = landlock_task(task);
+
+	object = task_sec->object;
+	if (object)
+		if (likely(refcount_inc_not_zero(&object->usage)))
+			return object;
+
+	/*
+	 * If there is no object tied to task, then create a new one.
+	 */
+	new_object = landlock_create_object(&landlock_net_underops, task);
+	if (IS_ERR(new_object))
+		return new_object;
+
+	task_sec->object = new_object;
+	return new_object;
+}
+
+
 int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
-						     u32 access_hierarchy)
+						     u32 access_rights)
 {
-	return 0;
+	int err;
+	struct landlock_object *object;
+
+	/* Transforms relative access rights to absolute ones. */
+	access_rights |= LANDLOCK_MASK_ACCESS_NET & ~ruleset->access_masks[1][0];
+
+	object = get_task_object(get_current_task());
+	if (IS_ERR(object))
+		return PTR_ERR(object);
+	mutex_lock(&ruleset->lock);
+	err = landlock_insert_rule(ruleset, object, access_rights << 16);
+	mutex_unlock(&ruleset->lock);
+	/*
+	 * No need to check for an error because landlock_insert_rule()
+	 * increments the refcount for the new object if needed.
+	 */
+	landlock_put_object(object);
+	return err;
+}
+
+/* Access-control management */
+static inline bool unmask_layers(
+		const struct landlock_ruleset *const domain,
+		const u32 access_request, u64 layer_mask)
+{
+	const struct landlock_rule *rule;
+	const struct task_struct *task;
+	size_t i;
+	bool allowed = false;
+
+	task = get_current_task();
+
+	rule = landlock_find_rule(domain, landlock_task(task)->object);
+
+	/* Grant access if there is no rule for an oject */
+	if (!rule)
+		return allowed = true;
+
+	/*
+	 * An access is granted if, for each policy layer, at least one rule
+	 * encountered on network actions requested,
+	 * regardless of their position in the layer stack.  We must then check
+	 * the remaining layers, from the first added layer to
+	 * the last one.
+	 */
+	for (i = 0; i < rule->num_layers; i++) {
+		const struct landlock_layer *const layer = &rule->layers[i];
+		const u64 layer_level = BIT_ULL(layer->level - 1);
+
+		/* Checks that the layer grants access to the request. */
+		if ((layer->access & (access_request << 16)) == (access_request << 16)) {
+			layer_mask &= ~layer_level;
+			allowed = true;
+
+			if (layer_mask == 0)
+				return allowed;
+		} else {
+			layer_mask &= ~layer_level;
+
+			if (layer_mask == 0)
+				return allowed;
+		}
+	}
+	return allowed;
+}
+
+static int check_socket_access(const struct landlock_ruleset *const domain,
+							 int family)
+{
+	bool allowed = false;
+	u64 layer_mask;
+	size_t i;
+
+	/* Make sure all layers can be checked. */
+	BUILD_BUG_ON(BITS_PER_TYPE(layer_mask) < LANDLOCK_MAX_NUM_LAYERS);
+
+	if (!family)
+		return 0;
+	if (WARN_ON_ONCE(!domain))
+		return 0;
+	if (WARN_ON_ONCE(domain->num_layers < 1))
+		return -EACCES;
+
+	/* Saves all layers handling a subset of requested
+	 * socket family.
+	 */
+	layer_mask = 0;
+	for (i = 0; i < domain->num_layers; i++) {
+		if (domain->access_masks[1][i] & family)
+			layer_mask |= BIT_ULL(i);
+	}
+	/* An access request not handled by the domain is allowed. */
+	if (layer_mask == 0)
+		return 0;
+
+	/*
+	 * We need to walk through all the hierarchy to not miss any relevant
+	 * restriction.
+	 */
+	allowed = unmask_layers(domain, family, layer_mask);
+
+	return allowed ? 0 : -EACCES;
 }

 static int hook_socket_create(int family, int type, int protocol, int kern)
 {
-	return 0;
+	const struct landlock_ruleset *const dom = landlock_get_current_domain();
+
+	if (!dom)
+		return 0;
+
+	return check_socket_access(dom, family);
 }

 static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
diff --git a/security/landlock/net.h b/security/landlock/net.h
index 094ac150ac3c..2036272ff106 100644
--- a/security/landlock/net.h
+++ b/security/landlock/net.h
@@ -23,7 +23,6 @@
 #include "ruleset.h"
 #include "setup.h"

-
 /**
  * struct landlock_task_security - Process task security blob
  *
@@ -32,9 +31,9 @@
  */
 struct landlock_task_security {
 	/**
-	 * @object: Weak pointer to an allocated object.
+	 * @object: Pointer to an allocated object.
 	 */
-	struct landlock_object __rcu *object;
+	struct landlock_object *object;
 };

 static inline struct landlock_task_security *landlock_task(
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 8f4285fab372..cec3fc489531 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -28,7 +28,7 @@ struct landlock_layer {
 	 * @access: Bitfield of allowed actions on the kernel object.  They are
 	 * relative to the object type (e.g. %LANDLOCK_ACTION_FS_READ).
 	 */
-	u16 access;
+	u32 access;
 };

 /**
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 72cb1b0cb8a9..27653e7bf201 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -339,7 +339,7 @@ SYSCALL_DEFINE4(landlock_add_rule,
 		return -EINVAL;

 	if ((rule_type != LANDLOCK_RULE_PATH_BENEATH) &&
-	    (rule_type != LANDLOCK_RULE_NET))
+		(rule_type != LANDLOCK_RULE_NET))
 		return -EINVAL;

 	if (rule_type == LANDLOCK_RULE_PATH_BENEATH) {
--
2.25.1

