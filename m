Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A712214203;
	Sat,  8 Mar 2025 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459496; cv=none; b=dJk98ouEZpQ4cqo/o3Yl0ij5QfYVh/h0ThiDWuV76g0h1eHxHHO4ZbGPqxu/7Sd+e/g/YjA63st2PKEe9tMf2jGURN9AsLPHJJ2XiE1CP0tttOkCGnwEZSaebAZcpdYHoC3+Waik7SsOW0yQwLTPAg2ekIioVvG7UNCukqtw8Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459496; c=relaxed/simple;
	bh=qYsJ55J+gH40nTYTq7KYAy0uiwXf1MUoCS70Z3qvNvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPZce9YlahVwDDYjaylJ/3X4MDBJf0NWsUtZEX7TDhHoAf6OE9R+RoUrdBmcNNuJdUq/vvr/S67x7iC5+oAYVMNZk/RiT5XIrSOnPTtvdoed0xk8x93pQ1/aiiVxWa3HalXVYMlBpQl3SOzCwnWKYsmnQt30QdsrUGDOAvngemw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=gb41c+SE; arc=none smtp.client-ip=84.16.66.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="gb41c+SE"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9BsV4MqXzNs1;
	Sat,  8 Mar 2025 19:44:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741459486;
	bh=QiKP7b/Dm/KNRWq66l/HuRjtqw6GR5zzVNgMzJzHzfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gb41c+SECvufq/u5Bl17wifFXuUFivpZNW8Fgzhn26fUmhM9dT7K7Bv7NwGv0UD4w
	 M9+5N8qwq9E5+uY4rodCilHZzd7R064osG6idwbqxDCPnGWI3LSH2cIklabc4J2MzZ
	 DceGWZbszvRyo7jnGCm9KGPUVWc71li0GmFGcf3k=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9BsT3pPPzGx;
	Sat,  8 Mar 2025 19:44:45 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
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
	Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 09/26] landlock: Add AUDIT_LANDLOCK_ACCESS and log ptrace denials
Date: Sat,  8 Mar 2025 19:44:05 +0100
Message-ID: <20250308184422.2159360-10-mic@digikod.net>
In-Reply-To: <20250308184422.2159360-1-mic@digikod.net>
References: <20250308184422.2159360-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add a new AUDIT_LANDLOCK_ACCESS record type dedicated to an access
request denied by a Landlock domain.  AUDIT_LANDLOCK_ACCESS indicates
that something unexpected happened.

For now, only denied access are logged, which means that any
AUDIT_LANDLOCK_ACCESS record is always followed by a SYSCALL record with
"success=no".  However, log parsers should check this syscall property
because this is the only sign that a request was denied.  Indeed, we
could have "success=yes" if Landlock would support a "permissive" mode.
We could also add a new field for this mode to AUDIT_LANDLOCK_DOMAIN
(see following commit).

By default, the only logged access requests are those coming from the
same executed program that enforced the Landlock restriction on itself.
In other words, no audit record are created for a task after it called
execve(2).  This is required to avoid log spam because programs may only
be aware of their own restrictions, but not the inherited ones.

Following commits will allow to conditionally generate
AUDIT_LANDLOCK_ACCESS records according to dedicated
landlock_restrict_self(2)'s flags.

The AUDIT_LANDLOCK_ACCESS message contains:
- the "domain" ID restricting the action on an object,
- the "blockers" that are missing to allow the requested access,
- a set of fields identifying the related object (e.g. task identified
  with "opid" and "ocomm").

The blockers are implicit restrictions (e.g. ptrace), or explicit access
rights (e.g. filesystem), or explicit scopes (e.g. signal).  This field
contains a list of at least one element, each separated with a comma.

The initial blocker is "ptrace", which describe all implicit Landlock
restrictions related to ptrace (e.g. deny tracing of tasks outside a
sandbox).

Add audit support to ptrace_access_check and ptrace_traceme hooks.  For
the ptrace_access_check case, we log the current/parent domain and the
child task.  For the ptrace_traceme case, we log the parent domain and
the parent task.  Indeed, the requester is the current task, but the
action would be performed by the parent task.

Audit event sample:

  type=LANDLOCK_ACCESS msg=audit(1729738800.349:44): domain=195ba459b blockers=ptrace opid=1 ocomm="systemd"
  type=SYSCALL msg=audit(1729738800.349:44): arch=c000003e syscall=101 success=no [...] pid=300 auid=0

A following commit adds user documentation.

Add KUnit tests to check reading of domain ID relative to layer level.

The quick return for non-landlocked tasks is moved from task_ptrace() to
each LSM hooks.

Because the landlock_log_denial() function is only called when an access
is denied, the compiler should be able to optimize the struct
landlock_request initializations.  It is not useful to inline the
audit_enabled check because other computation are performed anyway, and
by the same landlock_log_denia() code.

Use scoped guards for RCU read-side critical sections.

Cc: Günther Noack <gnoack@google.com>
Acked-by: Paul Moore <paul@paul-moore.com> (Audit)
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250308184422.2159360-10-mic@digikod.net
---

Changes since v5:
- Add Acked-by Paul.
- Move request declarations in the landlock_log_denial() calls to
  not impact allowed requests with audit, and return as soon as possible
  when access is allowed.
- Remove the audit_context() check in landlock_log_denial() because the
  context may not already exist.  This issue was identified thanks to a
  new test.
- Remove unlikely().

Changes since v4:
- Rename AUDIT_LANDLOCK_DENY to AUDIT_LANDLOCK_ACCESS, requested by
  Paul.
- Make landlock_log_denial() get Landlock credential instead of Landlock
  domain to be able to filter on the domain_exe variable.
- Rebase on top of the migration from struct landlock_ruleset to struct
  landlock_cred_security.
- Rename landlock_init_current_hierarchy() to
  landlock_init_hierarchy_log().
- Rebase on top of the scoped guard patches.
- By default, do not log denials after an execution.
- Use scoped guards for RCU read-side critical sections.

Changes since v3:
- Extend commit message.

Changes since v2:
- Log domain IDs as hexadecimal number: this is a more compact notation
  (i.e. at least one less digit), it improves alignment in logs, and it
  makes most IDs start with 1 as leading digit (because of the 2^32
  minimal value).  Do not use the "0x" prefix that would add useless
  data to logs.
- Constify function arguments.
- Clean up Makefile entries.

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
 security/landlock/Makefile  |   5 +-
 security/landlock/audit.c   | 146 ++++++++++++++++++++++++++++++++++++
 security/landlock/audit.h   |  53 +++++++++++++
 security/landlock/domain.c  |  28 +++++++
 security/landlock/domain.h  |  22 ++++++
 security/landlock/ruleset.c |   6 ++
 security/landlock/task.c    |  96 ++++++++++++++++++------
 8 files changed, 334 insertions(+), 25 deletions(-)
 create mode 100644 security/landlock/audit.c
 create mode 100644 security/landlock/audit.h
 create mode 100644 security/landlock/domain.c

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index d9a069b4a775..5dd53f416a4a 100644
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
+#define AUDIT_LANDLOCK_ACCESS	1423	/* Landlock denial */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index e1777abbc413..3160c2bdac1d 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -5,4 +5,7 @@ landlock-y := setup.o syscalls.o object.o ruleset.o \
 
 landlock-$(CONFIG_INET) += net.o
 
-landlock-$(CONFIG_AUDIT) += id.o
+landlock-$(CONFIG_AUDIT) += \
+	id.o \
+	audit.o \
+	domain.o
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
new file mode 100644
index 000000000000..8c7c71386a66
--- /dev/null
+++ b/security/landlock/audit.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock LSM - Audit helpers
+ *
+ * Copyright © 2023-2025 Microsoft Corporation
+ */
+
+#include <kunit/test.h>
+#include <linux/audit.h>
+#include <linux/lsm_audit.h>
+
+#include "audit.h"
+#include "cred.h"
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
+ * @subject: The Landlock subject's credential denying an action.
+ * @request: Detail of the user space request.
+ */
+void landlock_log_denial(const struct landlock_cred_security *const subject,
+			 const struct landlock_request *const request)
+{
+	struct audit_buffer *ab;
+	struct landlock_hierarchy *youngest_denied;
+	size_t youngest_layer;
+
+	if (WARN_ON_ONCE(!subject || !subject->domain ||
+			 !subject->domain->hierarchy || !request))
+		return;
+
+	if (!is_valid_request(request))
+		return;
+
+	if (!audit_enabled)
+		return;
+
+	youngest_layer = request->layer_plus_one - 1;
+	youngest_denied = get_hierarchy(subject->domain, youngest_layer);
+
+	/* Ignores denials after an execution. */
+	if (!(subject->domain_exec & (1 << youngest_layer)))
+		return;
+
+	ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
+			     AUDIT_LANDLOCK_ACCESS);
+	if (!ab)
+		return;
+
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
index 000000000000..daca14d77649
--- /dev/null
+++ b/security/landlock/audit.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock LSM - Audit helpers
+ *
+ * Copyright © 2023-2025 Microsoft Corporation
+ */
+
+#ifndef _SECURITY_LANDLOCK_AUDIT_H
+#define _SECURITY_LANDLOCK_AUDIT_H
+
+#include <linux/audit.h>
+#include <linux/lsm_audit.h>
+
+#include "cred.h"
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
+void landlock_log_denial(const struct landlock_cred_security *const subject,
+			 const struct landlock_request *const request);
+
+#else /* CONFIG_AUDIT */
+
+static inline void
+landlock_log_denial(const struct landlock_cred_security *const subject,
+		    const struct landlock_request *const request)
+{
+}
+
+#endif /* CONFIG_AUDIT */
+
+#endif /* _SECURITY_LANDLOCK_AUDIT_H */
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
new file mode 100644
index 000000000000..f6877ae79380
--- /dev/null
+++ b/security/landlock/domain.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock LSM - Domain management
+ *
+ * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2020 ANSSI
+ * Copyright © 2024-2025 Microsoft Corporation
+ */
+
+#include "domain.h"
+#include "id.h"
+
+#ifdef CONFIG_AUDIT
+
+/**
+ * landlock_init_hierarchy_log - Partially initialize landlock_hierarchy
+ *
+ * @hierarchy: The hierarchy to initialize.
+ *
+ * @hierarchy->parent and @hierarchy->usage should already be set.
+ */
+int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy)
+{
+	hierarchy->id = landlock_get_id_range(1);
+	return 0;
+}
+
+#endif /* CONFIG_AUDIT */
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 015d61fd81ec..1020878180d3 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -4,6 +4,7 @@
  *
  * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2018-2020 ANSSI
+ * Copyright © 2024-2025 Microsoft Corporation
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
@@ -45,4 +53,18 @@ static inline void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy)
 	}
 }
 
+#ifdef CONFIG_AUDIT
+
+int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy);
+
+#else /* CONFIG_AUDIT */
+
+static inline int
+landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy)
+{
+	return 0;
+}
+
+#endif /* CONFIG_AUDIT */
+
 #endif /* _SECURITY_LANDLOCK_DOMAIN_H */
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index adb7f87828df..f273a40e9780 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -23,6 +23,7 @@
 #include <linux/workqueue.h>
 
 #include "access.h"
+#include "audit.h"
 #include "domain.h"
 #include "limits.h"
 #include "object.h"
@@ -505,6 +506,7 @@ static void free_ruleset_work(struct work_struct *const work)
 	free_ruleset(ruleset);
 }
 
+/* Only called by hook_cred_free(). */
 void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
 {
 	if (ruleset && refcount_dec_and_test(&ruleset->usage)) {
@@ -564,6 +566,10 @@ landlock_merge_ruleset(struct landlock_ruleset *const parent,
 	if (err)
 		return ERR_PTR(err);
 
+	err = landlock_init_hierarchy_log(new_dom->hierarchy);
+	if (err)
+		return ERR_PTR(err);
+
 	return no_free_ptr(new_dom);
 }
 
diff --git a/security/landlock/task.c b/security/landlock/task.c
index da8f82c8054a..e8a0b4ead381 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -11,12 +11,14 @@
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
@@ -39,41 +41,29 @@ static bool domain_scope_le(const struct landlock_ruleset *const parent,
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
 
@@ -93,7 +83,39 @@ static int task_ptrace(const struct task_struct *const parent,
 static int hook_ptrace_access_check(struct task_struct *const child,
 				    const unsigned int mode)
 {
-	return task_ptrace(current, child);
+	const struct landlock_cred_security *parent_subject;
+	const struct landlock_ruleset *child_dom;
+	int err;
+
+	/* Quick return for non-landlocked tasks. */
+	parent_subject = landlock_cred(current_cred());
+	if (!parent_subject)
+		return 0;
+
+	scoped_guard(rcu)
+	{
+		child_dom = landlock_get_task_domain(child);
+		err = domain_ptrace(parent_subject->domain, child_dom);
+	}
+
+	if (!err)
+		return 0;
+
+	/*
+	 * For the ptrace_access_check case, we log the current/parent domain
+	 * and the child task.
+	 */
+	if (!(mode & PTRACE_MODE_NOAUDIT))
+		landlock_log_denial(parent_subject, &(struct landlock_request) {
+			.type = LANDLOCK_REQUEST_PTRACE,
+			.audit = {
+				.type = LSM_AUDIT_DATA_TASK,
+				.u.tsk = child,
+			},
+			.layer_plus_one = parent_subject->domain->num_layers,
+		});
+
+	return err;
 }
 
 /**
@@ -110,7 +132,35 @@ static int hook_ptrace_access_check(struct task_struct *const child,
  */
 static int hook_ptrace_traceme(struct task_struct *const parent)
 {
-	return task_ptrace(parent, current);
+	const struct landlock_cred_security *parent_subject;
+	const struct landlock_ruleset *child_dom;
+	int err;
+
+	child_dom = landlock_get_current_domain();
+
+	guard(rcu)();
+	parent_subject = landlock_cred(__task_cred(parent));
+	err = domain_ptrace(parent_subject->domain, child_dom);
+
+	if (!err)
+		return 0;
+
+	/*
+	 * For the ptrace_traceme case, we log the domain which is the cause of
+	 * the denial, which means the parent domain instead of the current
+	 * domain.  This may look weird because the ptrace_traceme action is a
+	 * request to be traced, but the semantic is consistent with
+	 * hook_ptrace_access_check().
+	 */
+	landlock_log_denial(parent_subject, &(struct landlock_request) {
+		.type = LANDLOCK_REQUEST_PTRACE,
+		.audit = {
+			.type = LSM_AUDIT_DATA_TASK,
+			.u.tsk = parent,
+		},
+		.layer_plus_one = parent_subject->domain->num_layers,
+	});
+	return err;
 }
 
 /**
@@ -129,7 +179,7 @@ static bool domain_is_scoped(const struct landlock_ruleset *const client,
 			     access_mask_t scope)
 {
 	int client_layer, server_layer;
-	struct landlock_hierarchy *client_walker, *server_walker;
+	const struct landlock_hierarchy *client_walker, *server_walker;
 
 	/* Quick return if client has no domain */
 	if (WARN_ON_ONCE(!client))
-- 
2.48.1

