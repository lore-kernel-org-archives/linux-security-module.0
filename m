Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77B51DED68
	for <linux-security-module@vger.kernel.org>; Fri, 22 Nov 2024 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286065; cv=none; b=OQWJoGW3JAC/mdTORmN/Ob0otWTePh0M200/QLhuNyk/RnpoC6RrfVPDI4ZLcRrFNH1Qkd7FlxbDk9MKTJh3ynWiRQB19nUngrwgrXg0/OEHqXpG5zqR5sW3bLdr1kVQu9bqGivgkoltB/xvOLerAvojUL7kuoFLeXPZtAZh2AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286065; c=relaxed/simple;
	bh=NQLCs4tHDa6+sFnlPgeXPdf8gOFXJLhRqT9IMTeMugs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2V7lgPNdpsBLlYDMIVM8c/u40WLIG/qk2sj6aOpfpY+CEnfjFm5+dsLIjipFWR6U4YpgsLCXMMwELcav56HB676DVQXqnG5EEh0t7uvQvuLXnZviGkxfRxES9mXIoT8fZbF0iqq1g8HJM3AswtKCAkEukJ3SBoApGTc9KcVJrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=APOXg9cr; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="APOXg9cr"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XvyKK30ylzl0b;
	Fri, 22 Nov 2024 15:34:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1732286053;
	bh=G8oh/GUG4yJsFLSux1Fb2WJY5z3CF18h5oN/CFHEKmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=APOXg9crmyn5F9BvuKLR+f80pSFNw2n6Wlj674J0emAZ1BDFkMoi097ciog+hNFkk
	 bUJelNCxCpkdvuH6Sd1WE7sBKm1BxkSwbybTG1iv0WxzOcPIXO8G8R1pSWU578GeEC
	 As3rlHMW31b+nxHK4G713rjGEL9hiZZCAM6n88n8=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XvyKJ4Zz1zGw5;
	Fri, 22 Nov 2024 15:34:12 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 08/23] landlock: Log ptrace denials
Date: Fri, 22 Nov 2024 15:33:38 +0100
Message-ID: <20241122143353.59367-9-mic@digikod.net>
In-Reply-To: <20241122143353.59367-1-mic@digikod.net>
References: <20241122143353.59367-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add audit support to ptrace_access_check and ptrace_traceme hooks.

Add a new AUDIT_LANDLOCK_DENY record type dedicated to any Landlock
denials.

Log the domain ID restricting the action, the domain's blockers that are
missing to allow the requested access, and the target task.

The blockers are implicit restrictions (e.g. ptrace), or explicit access
rights (e.g. filesystem), or explicit scopes (e.g. signal).

For the ptrace_access_check case, we log the current/parent domain and
the child task.  For the ptrace_traceme case, we log the parent domain
and the parent task.  Indeed, the requester is the current task, but the
action would be performed by the parent task.

The quick return for non-landlocked tasks is moved from task_ptrace() to
each LSM hooks.

Audit event sample:

  type=LL_DENY msg=audit(1732186800.349:44): domain=195ba459b blockers=ptrace opid=1 ocomm="systemd"
  type=SYSCALL msg=audit(1732186800.349:44): arch=c000003e syscall=101 success=no [...] pid=300 auid=0

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241122143353.59367-9-mic@digikod.net
---

Changes since v2:
- Log domain IDs as hexadecimal number: this is a more compact notation
  (i.e. at least one less digit), it improves alignment in logs, and it
  makes most IDs start with 1 as leading digit (because of the 2^32
  minimal value).  Do not use the "0x" prefix that would add useless
  data to logs.
- Constify function arguments.

Changes since v1:
- Move most audit code to this patch.
- Rebase on the TCP patch series.
- Don't log missing access right: simplify and make it generic for rule
  types.
- Don't log errno and then don't wrap the error with
  landlock_log_request(), as suggested by Jeff.
- Add a WARN_ON_ONCE() check to never dereference null pointers.
- Only log when audit is enabled.
- Don't log task's PID/TID with log_task() because it would be redundant
  with the SYSCALL record.
- Move the "op" in front and rename "domain" to "denying_domain" to make
  it more consistent with other entries.
- Don't update the request with the domain ID but add an helper to get
  it from the layer masks (and in a following commit with a struct
  file).
- Revamp get_domain_id_from_layer_masks() into
  get_level_from_layer_masks().
- For ptrace_traceme, log the parent domain instead of the current one.
- Add documentation.
- Rename AUDIT_LANDLOCK_DENIAL to AUDIT_LANDLOCK_DENY.
- Only log the domain ID and the target task.
- Log "blockers", which are either implicit restrictions (e.g. ptrace)
  or explicit access rights (e.g. filesystem), or scopes (e.g. signal).
- Don't log LSM hook names/operations.
- Pick an audit event ID folling the IPE ones.
- Add KUnit tests.
---
 include/uapi/linux/audit.h  |   3 +-
 security/landlock/Makefile  |   2 +-
 security/landlock/audit.c   | 137 ++++++++++++++++++++++++++++++++++++
 security/landlock/audit.h   |  52 ++++++++++++++
 security/landlock/domain.c  |  21 ++++++
 security/landlock/domain.h  |  17 +++++
 security/landlock/ruleset.c |   3 +
 security/landlock/task.c    |  91 ++++++++++++++++++------
 8 files changed, 302 insertions(+), 24 deletions(-)
 create mode 100644 security/landlock/audit.c
 create mode 100644 security/landlock/audit.h
 create mode 100644 security/landlock/domain.c

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 75e21a135483..60c909c396c0 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -33,7 +33,7 @@
  * 1100 - 1199 user space trusted application messages
  * 1200 - 1299 messages internal to the audit daemon
  * 1300 - 1399 audit event messages
- * 1400 - 1499 SE Linux use
+ * 1400 - 1499 access control messages
  * 1500 - 1599 kernel LSPP events
  * 1600 - 1699 kernel crypto events
  * 1700 - 1799 kernel anomaly records
@@ -146,6 +146,7 @@
 #define AUDIT_IPE_ACCESS	1420	/* IPE denial or grant */
 #define AUDIT_IPE_CONFIG_CHANGE	1421	/* IPE config change */
 #define AUDIT_IPE_POLICY_LOAD	1422	/* IPE policy load */
+#define AUDIT_LANDLOCK_DENY	1423	/* Landlock denial */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index e1777abbc413..31512ee4b041 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -5,4 +5,4 @@ landlock-y := setup.o syscalls.o object.o ruleset.o \
 
 landlock-$(CONFIG_INET) += net.o
 
-landlock-$(CONFIG_AUDIT) += id.o
+landlock-$(CONFIG_AUDIT) += id.o domain.o audit.o
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
new file mode 100644
index 000000000000..eab6b3a8a231
--- /dev/null
+++ b/security/landlock/audit.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock LSM - Audit helpers
+ *
+ * Copyright © 2023-2024 Microsoft Corporation
+ */
+
+#include <kunit/test.h>
+#include <linux/audit.h>
+#include <linux/lsm_audit.h>
+
+#include "audit.h"
+#include "domain.h"
+#include "ruleset.h"
+
+static const char *get_blocker(const enum landlock_request_type type)
+{
+	switch (type) {
+	case LANDLOCK_REQUEST_PTRACE:
+		return "ptrace";
+	}
+
+	WARN_ON_ONCE(1);
+	return "unknown";
+}
+
+static void log_blockers(struct audit_buffer *const ab,
+			 const enum landlock_request_type type)
+{
+	audit_log_format(ab, "%s", get_blocker(type));
+}
+
+static struct landlock_hierarchy *
+get_hierarchy(const struct landlock_ruleset *const domain, const size_t layer)
+{
+	struct landlock_hierarchy *node = domain->hierarchy;
+	ssize_t i;
+
+	if (WARN_ON_ONCE(layer >= domain->num_layers))
+		return node;
+
+	for (i = domain->num_layers - 1; i > layer; i--) {
+		if (WARN_ON_ONCE(!node->parent))
+			break;
+
+		node = node->parent;
+	}
+
+	return node;
+}
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+static void test_get_hierarchy(struct kunit *const test)
+{
+	struct landlock_hierarchy dom0_node = {
+		.id = 10,
+	};
+	struct landlock_hierarchy dom1_node = {
+		.parent = &dom0_node,
+		.id = 20,
+	};
+	struct landlock_hierarchy dom2_node = {
+		.parent = &dom1_node,
+		.id = 30,
+	};
+	struct landlock_ruleset dom2 = {
+		.hierarchy = &dom2_node,
+		.num_layers = 3,
+	};
+
+	KUNIT_EXPECT_EQ(test, 10, get_hierarchy(&dom2, 0)->id);
+	KUNIT_EXPECT_EQ(test, 20, get_hierarchy(&dom2, 1)->id);
+	KUNIT_EXPECT_EQ(test, 30, get_hierarchy(&dom2, 2)->id);
+	KUNIT_EXPECT_EQ(test, 30, get_hierarchy(&dom2, -1)->id);
+}
+
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
+
+static bool is_valid_request(const struct landlock_request *const request)
+{
+	if (WARN_ON_ONCE(!request->layer_plus_one))
+		return false;
+
+	return true;
+}
+
+/**
+ * landlock_log_denial - Create audit records related to a denial
+ *
+ * @domain: The domain denying an action.
+ * @request: Detail of the user space request.
+ */
+void landlock_log_denial(const struct landlock_ruleset *const domain,
+			 const struct landlock_request *const request)
+{
+	struct audit_buffer *ab;
+	struct landlock_hierarchy *youngest_denied;
+
+	if (WARN_ON_ONCE(!domain || !domain->hierarchy || !request))
+		return;
+
+	if (!is_valid_request(request))
+		return;
+
+	if (!audit_enabled)
+		return;
+
+	ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
+			     AUDIT_LANDLOCK_DENY);
+	if (!ab)
+		return;
+
+	youngest_denied = get_hierarchy(domain, request->layer_plus_one - 1);
+	audit_log_format(ab, "domain=%llx blockers=", youngest_denied->id);
+	log_blockers(ab, request->type);
+	audit_log_lsm_data(ab, &request->audit);
+	audit_log_end(ab);
+}
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+static struct kunit_case test_cases[] = {
+	/* clang-format off */
+	KUNIT_CASE(test_get_hierarchy),
+	{}
+	/* clang-format on */
+};
+
+static struct kunit_suite test_suite = {
+	.name = "landlock_audit",
+	.test_cases = test_cases,
+};
+
+kunit_test_suite(test_suite);
+
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
new file mode 100644
index 000000000000..f33095afcd2f
--- /dev/null
+++ b/security/landlock/audit.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock LSM - Audit helpers
+ *
+ * Copyright © 2023-2024 Microsoft Corporation
+ */
+
+#ifndef _SECURITY_LANDLOCK_AUDIT_H
+#define _SECURITY_LANDLOCK_AUDIT_H
+
+#include <linux/audit.h>
+#include <linux/lsm_audit.h>
+
+#include "ruleset.h"
+
+enum landlock_request_type {
+	LANDLOCK_REQUEST_PTRACE = 1,
+};
+
+/*
+ * We should be careful to only use a variable of this type for
+ * landlock_log_denial().  This way, the compiler can remove it entirely if
+ * CONFIG_AUDIT is not set.
+ */
+struct landlock_request {
+	/* Mandatory fields. */
+	enum landlock_request_type type;
+	struct common_audit_data audit;
+
+	/**
+	 * layer_plus_one: First layer level that denies the request + 1.  The
+	 * extra one is useful to detect uninitialized field.
+	 */
+	size_t layer_plus_one;
+};
+
+#ifdef CONFIG_AUDIT
+
+void landlock_log_denial(const struct landlock_ruleset *const domain,
+			 const struct landlock_request *const request);
+
+#else /* CONFIG_AUDIT */
+
+static inline void
+landlock_log_denial(const struct landlock_ruleset *const domain,
+		    const struct landlock_request *const request)
+{
+}
+
+#endif /* CONFIG_AUDIT */
+
+#endif /* _SECURITY_LANDLOCK_AUDIT_H */
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
new file mode 100644
index 000000000000..965e4dc21975
--- /dev/null
+++ b/security/landlock/domain.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock LSM - Domain management
+ *
+ * Copyright © 2024 Microsoft Corporation
+ */
+
+#include "domain.h"
+#include "id.h"
+
+/**
+ * landlock_init_current_hierarchy - Partially initialize landlock_hierarchy
+ *
+ * @hierarchy: The hierarchy to initialize.
+ *
+ * @hierarchy->parent and @hierarchy->usage should already be set.
+ */
+void landlock_init_current_hierarchy(struct landlock_hierarchy *const hierarchy)
+{
+	hierarchy->id = landlock_get_id(1);
+}
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 015d61fd81ec..f82d831ca0a7 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -4,6 +4,7 @@
  *
  * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2018-2020 ANSSI
+ * Copyright © 2024 Microsoft Corporation
  */
 
 #ifndef _SECURITY_LANDLOCK_DOMAIN_H
@@ -26,6 +27,13 @@ struct landlock_hierarchy {
 	 * domain.
 	 */
 	refcount_t usage;
+
+#ifdef CONFIG_AUDIT
+	/**
+	 * @id: Landlock domain ID, sets once at domain creation time.
+	 */
+	u64 id;
+#endif /* CONFIG_AUDIT */
 };
 
 static inline void
@@ -45,4 +53,13 @@ static inline void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy)
 	}
 }
 
+#ifdef CONFIG_AUDIT
+void landlock_init_current_hierarchy(struct landlock_hierarchy *const hierarchy);
+#else /* CONFIG_AUDIT */
+static inline void
+landlock_init_current_hierarchy(struct landlock_hierarchy *const hierarchy)
+{
+}
+#endif /* CONFIG_AUDIT */
+
 #endif /* _SECURITY_LANDLOCK_DOMAIN_H */
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 4b3dfa3e6fcb..7a88fd9b2473 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -21,6 +21,7 @@
 #include <linux/workqueue.h>
 
 #include "access.h"
+#include "audit.h"
 #include "domain.h"
 #include "limits.h"
 #include "object.h"
@@ -503,6 +504,7 @@ static void free_ruleset_work(struct work_struct *const work)
 	free_ruleset(ruleset);
 }
 
+/* Only called by hook_cred_free(). */
 void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
 {
 	if (ruleset && refcount_dec_and_test(&ruleset->usage)) {
@@ -562,6 +564,7 @@ landlock_merge_ruleset(struct landlock_ruleset *const parent,
 	if (err)
 		goto out_put_dom;
 
+	landlock_init_current_hierarchy(new_dom->hierarchy);
 	return new_dom;
 
 out_put_dom:
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 98894ad1abc7..1decd6f114e8 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -10,12 +10,14 @@
 #include <linux/cred.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/lsm_audit.h>
 #include <linux/lsm_hooks.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
 #include <net/af_unix.h>
 #include <net/sock.h>
 
+#include "audit.h"
 #include "common.h"
 #include "cred.h"
 #include "domain.h"
@@ -38,41 +40,29 @@ static bool domain_scope_le(const struct landlock_ruleset *const parent,
 {
 	const struct landlock_hierarchy *walker;
 
+	/* Quick return for non-landlocked tasks. */
 	if (!parent)
 		return true;
+
 	if (!child)
 		return false;
+
 	for (walker = child->hierarchy; walker; walker = walker->parent) {
 		if (walker == parent->hierarchy)
 			/* @parent is in the scoped hierarchy of @child. */
 			return true;
 	}
+
 	/* There is no relationship between @parent and @child. */
 	return false;
 }
 
-static bool task_is_scoped(const struct task_struct *const parent,
-			   const struct task_struct *const child)
-{
-	bool is_scoped;
-	const struct landlock_ruleset *dom_parent, *dom_child;
-
-	rcu_read_lock();
-	dom_parent = landlock_get_task_domain(parent);
-	dom_child = landlock_get_task_domain(child);
-	is_scoped = domain_scope_le(dom_parent, dom_child);
-	rcu_read_unlock();
-	return is_scoped;
-}
-
-static int task_ptrace(const struct task_struct *const parent,
-		       const struct task_struct *const child)
+static int domain_ptrace(const struct landlock_ruleset *const parent,
+			 const struct landlock_ruleset *const child)
 {
-	/* Quick return for non-landlocked tasks. */
-	if (!landlocked(parent))
-		return 0;
-	if (task_is_scoped(parent, child))
+	if (domain_scope_le(parent, child))
 		return 0;
+
 	return -EPERM;
 }
 
@@ -92,7 +82,36 @@ static int task_ptrace(const struct task_struct *const parent,
 static int hook_ptrace_access_check(struct task_struct *const child,
 				    const unsigned int mode)
 {
-	return task_ptrace(current, child);
+	const struct landlock_ruleset *parent_dom, *child_dom;
+	struct landlock_request request = {
+		.type = LANDLOCK_REQUEST_PTRACE,
+		.audit = {
+			.type = LSM_AUDIT_DATA_TASK,
+			.u.tsk = child,
+		},
+	};
+	int err;
+
+	/* Quick return for non-landlocked tasks. */
+	parent_dom = landlock_get_current_domain();
+	if (!parent_dom)
+		return 0;
+
+	rcu_read_lock();
+	child_dom = landlock_get_task_domain(child);
+	err = domain_ptrace(parent_dom, child_dom);
+	rcu_read_unlock();
+
+	/*
+	 * For the ptrace_access_check case, we log the current/parent domain
+	 * and the child task.
+	 */
+	if (err && !(mode & PTRACE_MODE_NOAUDIT)) {
+		request.layer_plus_one = parent_dom->num_layers;
+		landlock_log_denial(parent_dom, &request);
+	}
+
+	return err;
 }
 
 /**
@@ -109,7 +128,35 @@ static int hook_ptrace_access_check(struct task_struct *const child,
  */
 static int hook_ptrace_traceme(struct task_struct *const parent)
 {
-	return task_ptrace(parent, current);
+	const struct landlock_ruleset *parent_dom, *child_dom;
+	struct landlock_request request = {
+		.type = LANDLOCK_REQUEST_PTRACE,
+		.audit = {
+			.type = LSM_AUDIT_DATA_TASK,
+			.u.tsk = parent,
+		},
+	};
+	int err;
+
+	child_dom = landlock_get_current_domain();
+	rcu_read_lock();
+	parent_dom = landlock_get_task_domain(parent);
+	err = domain_ptrace(parent_dom, child_dom);
+
+	/*
+	 * For the ptrace_traceme case, we log the domain which is the cause of
+	 * the denial, which means the parent domain instead of the current
+	 * domain.  This may look weird because the ptrace_traceme action is a
+	 * request to be traced, but the semantic is consistent with
+	 * hook_ptrace_access_check().
+	 */
+	if (err) {
+		request.layer_plus_one = parent_dom->num_layers;
+		landlock_log_denial(parent_dom, &request);
+	}
+
+	rcu_read_unlock();
+	return err;
 }
 
 /**
-- 
2.47.0

