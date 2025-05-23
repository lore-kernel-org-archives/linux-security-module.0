Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06E929711A
	for <linux-security-module@vger.kernel.org>; Fri, 23 May 2025 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748019487; cv=none; b=rWyPqOHgGl1EndJKtRhj+qLE3lqkAdJbZXTtckQ1JeiMNCXbrXhfE/COeVtQhljOhAtwBxWboGHBuMIyyunOA2Fozgv6IE0jUzDEtl1iBjzCEdYBtGx6XtPRaSCAF6NIyhTDHee5IJQ41PjflSklxIvgQLpEsJlocGQuSvezSYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748019487; c=relaxed/simple;
	bh=uPbKmpl5ZK2xe9dKiLUKjn4HUAgklrfPsCQRW9H23lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VzoWNgh+9ccww5/LeNI1kaJyMeBtXzjVjbPZWrt96oHZ5aRs99UEk9SeAjKdGVgyN8hf9NphkNT1i2yOJptUE0bJafolMciXOZCjXSY7dKOOYQvHMQ72Y/YNNL/Q3UY4ueiPnqZLqYHOhEx06zPouBmkXDCouF9V2YfLXZsrX1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0KF0a+Wo; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0KF0a+Wo"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b3rv76HXtzRdN;
	Fri, 23 May 2025 18:57:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748019475;
	bh=eTAQWYmg1rYKTJFffa5hFncYpXU+syRK3SKIlDA3kHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0KF0a+WoiV8uRH0xDcgqVT9Ne3FYdRAMEBFzsiUOtDINToX9cmDNYpmhoBXQvikDY
	 r4hCvd9CirwZAhnAr6xfo9BS5kHaKxFHgXNJt3Q90JIB2sov5Av3YcK44OMTYE33kH
	 HjP+wuj3Pch+MncHdZ8y+1CEHL68JlcRkWvxRCc0=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4b3rv71VjfzLhQ;
	Fri, 23 May 2025 18:57:55 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Ryan Sullivan <rysulliv@redhat.com>,
	Shervin Oloumi <enlightened@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH v1 4/5] landlock: Add landlock_add_rule_fs tracepoint
Date: Fri, 23 May 2025 18:57:40 +0200
Message-ID: <20250523165741.693976-5-mic@digikod.net>
In-Reply-To: <20250523165741.693976-1-mic@digikod.net>
References: <20250523165741.693976-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add a tracepoint for Landlock path_beneath rule addition.  This is
useful to tie a Landlock object with a file for debug purpose.

Allocate the absolute path names when adding new rules.  This is OK
because landlock_add_rule(2) is not a performance critical code.

Here is an example of landlock_add_rule_fs traces:
  ruleset=0x000000007e3b1c4a key=inode:0xffff888004f59260 allowed=0xd dev=0:16 ino=306 path=/usr
  ruleset=0x000000007e3b1c4a key=inode:0xffff888004f59240 allowed=0xffff dev=0:16 ino=346 path=/root

TODO: Use Landlock IDs instead of kernel addresses to identify Landlock
objects (e.g. inode).

Cc: Günther Noack <gnoack@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 MAINTAINERS                     |  1 +
 include/trace/events/landlock.h | 68 +++++++++++++++++++++++++++++++++
 security/landlock/Makefile      | 11 +++++-
 security/landlock/fs.c          | 22 +++++++++++
 security/landlock/fs.h          |  3 ++
 security/landlock/trace.c       | 14 +++++++
 6 files changed, 117 insertions(+), 2 deletions(-)
 create mode 100644 include/trace/events/landlock.h
 create mode 100644 security/landlock/trace.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d48dd6726fe6..f75c21a935c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13393,6 +13393,7 @@ F:	Documentation/admin-guide/LSM/landlock.rst
 F:	Documentation/security/landlock.rst
 F:	Documentation/userspace-api/landlock.rst
 F:	fs/ioctl.c
+F:	include/trace/events/landlock.h
 F:	include/uapi/linux/landlock.h
 F:	samples/landlock/
 F:	security/landlock/
diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
new file mode 100644
index 000000000000..41e10965ba7b
--- /dev/null
+++ b/include/trace/events/landlock.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright © 2025 Microsoft Corporation
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM landlock
+
+#if !defined(_TRACE_LANDLOCK_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_LANDLOCK_H
+
+#include <linux/tracepoint.h>
+
+struct landlock_rule_ref;
+struct landlock_ruleset;
+struct path;
+typedef u16 access_mask_t;
+
+TRACE_EVENT(landlock_add_rule_fs,
+
+	TP_PROTO(
+		const struct landlock_ruleset *ruleset,
+		const struct landlock_rule_ref *ref,
+		access_mask_t access_rights,
+		const struct path *path,
+		const char *pathname
+	),
+
+	TP_ARGS(ruleset, ref, access_rights, path, pathname),
+
+	TP_STRUCT__entry(
+		__field(const struct landlock_ruleset *, ruleset)
+		__field(uintptr_t, ref_key)
+		__field(access_mask_t, allowed)
+		__field(dev_t, dev)
+		__field(ino_t, ino)
+		__string(pathname, pathname)
+	),
+
+	TP_fast_assign(
+		__entry->ruleset = ruleset;
+		__entry->ref_key = ref->key.data;
+		__entry->allowed = access_rights;
+		__entry->dev = path->dentry->d_sb->s_dev;
+		__entry->ino = path->dentry->d_inode->i_ino;
+		__assign_str(pathname);
+	),
+
+	/*
+	 * The inode number may not be the user-visible one, but it will be the same
+	 * used by audit.
+	 */
+	TP_printk(
+		"ruleset=0x%p key=inode:0x%lx allowed=0x%x dev=%u:%u ino=%lu path=%s",
+		__entry->ruleset,
+		__entry->ref_key,
+		__entry->allowed,
+		MAJOR(__entry->dev),
+		MINOR(__entry->dev),
+		__entry->ino,
+		__print_untrusted_str(pathname)
+	)
+);
+
+#endif /* _TRACE_LANDLOCK_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index 3160c2bdac1d..c19b406a6c67 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -1,7 +1,14 @@
 obj-$(CONFIG_SECURITY_LANDLOCK) := landlock.o
 
-landlock-y := setup.o syscalls.o object.o ruleset.o \
-	cred.o task.o fs.o
+landlock-y := \
+	setup.o \
+	syscalls.o \
+	object.o \
+	ruleset.o \
+	cred.o \
+	task.o \
+	fs.o \
+	trace.o
 
 landlock-$(CONFIG_INET) += net.o
 
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 73a20a501c3c..e5d673240882 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -36,6 +36,7 @@
 #include <linux/types.h>
 #include <linux/wait_bit.h>
 #include <linux/workqueue.h>
+#include <trace/events/landlock.h>
 #include <uapi/linux/fiemap.h>
 #include <uapi/linux/landlock.h>
 
@@ -345,6 +346,27 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 	mutex_lock(&ruleset->lock);
 	err = landlock_insert_rule(ruleset, ref, access_rights);
 	mutex_unlock(&ruleset->lock);
+
+	if (!err && trace_landlock_add_rule_fs_enabled()) {
+		const char *pathname;
+		/* Does not handle deleted files. */
+		char *buffer __free(__putname) = __getname();
+
+		if (buffer) {
+			const char *absolute_path =
+				d_absolute_path(path, buffer, PATH_MAX);
+			if (!IS_ERR_OR_NULL(absolute_path))
+				pathname = absolute_path;
+			else
+				pathname = "<too_long>";
+		} else {
+			/* Same format as audit_log_d_path(). */
+			pathname = "<no_memory>";
+		}
+		trace_landlock_add_rule_fs(ruleset, &ref, access_rights, path,
+					   pathname);
+	}
+
 	/*
 	 * No need to check for an error because landlock_insert_rule()
 	 * increments the refcount for the new object if needed.
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index bf9948941f2f..60be95ebfb0b 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -11,6 +11,7 @@
 #define _SECURITY_LANDLOCK_FS_H
 
 #include <linux/build_bug.h>
+#include <linux/cleanup.h>
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/rcupdate.h>
@@ -128,4 +129,6 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 			    const struct path *const path,
 			    access_mask_t access_hierarchy);
 
+DEFINE_FREE(__putname, char *, if (_T) __putname(_T))
+
 #endif /* _SECURITY_LANDLOCK_FS_H */
diff --git a/security/landlock/trace.c b/security/landlock/trace.c
new file mode 100644
index 000000000000..98874cda473b
--- /dev/null
+++ b/security/landlock/trace.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock - Tracepoints
+ *
+ * Copyright © 2025 Microsoft Corporation
+ */
+
+#include <linux/path.h>
+
+#include "access.h"
+#include "ruleset.h"
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/landlock.h>
-- 
2.49.0

