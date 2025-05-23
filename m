Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7955A2957B6
	for <linux-security-module@vger.kernel.org>; Fri, 23 May 2025 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748019487; cv=none; b=DZuOWDnpCKaK2B7fZwQHt/oNqxUeq5+TOtkp7kA+N01rR8eqJs67nSVpwOGWHNtRw1v/TH0yfw96gjVpCy0SBubmr7yVB9npabaM+IldSS4MY7s3ydCGS5vsg9bnHAQRCfKVCvzZBZXTMizQ3LsRCRxBSsWbGpYm8oum+Pd4ap0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748019487; c=relaxed/simple;
	bh=qoT4E9GhBZuvYKLo8fK5UUgcK2Flcfg1QzMdbP1/jfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EoHFJK6l/QEwe8lny00GoS059GxjNtbcqM/4HVU1Q+tG1e29ouoX9W1T7qSAj/FXpxgZs/Rzj5hE8JeLuCpSI4ZhIkSuben4Qh0lmWAg4O00arRKX01gZAQTmdsGn/rvyz2nFRx04/PtUUA0yPL1Qfv58Gd+6w0/Hwh3UfKhwVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=U00W9avv; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="U00W9avv"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b3rv946vNzSp0;
	Fri, 23 May 2025 18:57:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748019477;
	bh=bOTcKXU+PDpiWDHdJRBRF5Z4uUKEW6uWVNwHUlqc3s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U00W9avvgb1hOW3vvTA/78kZbESS8P31RQ+pFqmgBmHk9TgjGzXDUhMYzRo5XkivN
	 pea7D2cSICG9mmQl8DaKAZEs/wzk+QX9wutbzoVItFMPqhrb7KsYGENmzhet2HgA9k
	 SGyAL20cFr3AuhiPTN7UiR2t3EJoZo3w8rFL8XOI=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4b3rv86MlTzM3C;
	Fri, 23 May 2025 18:57:56 +0200 (CEST)
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
Subject: [RFC PATCH v1 5/5] landlock: Add landlock_check_rule tracepoint
Date: Fri, 23 May 2025 18:57:41 +0200
Message-ID: <20250523165741.693976-6-mic@digikod.net>
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

Add a tracepoint called by landlock_unmask_layers() when a rule matches
the current Landlock domain.  This enables us to observe each matching
rule for a specific access request.

The main difference with audit events is that traces are disabled by
default, can be very verbose, and can be filtered according to Landlock
properties (e.g. domain ID).  This event show all steps leading to an
access decision.  We can also attach eBPF programs to this tracepoint
and the landlock_add_rule_fs one to get a more standalone view of
Landlock.

In the followning example, we create a directory with special
characters, then create a initial sandbox allowing reading the parent
directory, and then a nested sandbox not allowing reading of the parent
directory:
  mkdir "$(printf 'a\\\n\047\042 \a\e')"
  cd "$_"
  LL_FS_RO=/usr LL_FS_RW=.. ../sandboxer sh -c \
          "LL_FS_RO=/usr LL_FS_RW=. ../sandboxer ls .."

The landlock_add_rule_fs traces show the initial sandbox's rules:
  ruleset=0x000000007e3b1c4a key=inode:0xffff888004f59260 allowed=0xd dev=0:16 ino=306 path=/usr
  ruleset=0x000000007e3b1c4a key=inode:0xffff888004f59240 allowed=0xffff dev=0:16 ino=346 path=/root

0xd maps to FS_EXECUTE | FS_READ_FILE | FS_READ_DIR, and 0xffff maps to
all supported access rights.

We can then see some access requests with the landlock_check_rule
traces. The first 0x4005 maps to a read-execute (with optional truncate)
request, and the second 0x4004 maps to a read (with optional truncate)
request:
  domain=1362e78a1 key=inode:0xffff888004f59240 request=0x4005 allowed={0xffff}
  domain=1362e78a1 key=inode:0xffff888004f59260 request=0x4004 allowed={0xd}

The landlock_add_rule_fs traces show the nested sandbox's rules:
  ruleset=0x000000007e3b1c4a key=inode:0xffff888004f59260 allowed=0xd dev=0:16 ino=306 path=/usr
  ruleset=0x000000007e3b1c4a key=inode:0xffff888004f59280 allowed=0xffff dev=0:16 ino=210608 path=/root/a\\\n\047\"\040\a\e

We can finally see some access requests with the landlock_check_rule
traces, listing access rights per layers.  Because the second layer does
not allow access (0x0) to /root (inode:0xffff888004f59240), this request
is denied:
  domain=1362e78a7 key=inode:0xffff888004f59240 request=0x4008 allowed={0xffff,0x0}
  domain=1362e78a7 key=inode:0xffff888004f59260 request=0x4004 allowed={0xd,0xd}

Cc: Günther Noack <gnoack@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 include/trace/events/landlock.h | 56 +++++++++++++++++++++++++++++++++
 security/landlock/ruleset.c     |  3 ++
 security/landlock/trace.c       |  1 +
 3 files changed, 60 insertions(+)

diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index 41e10965ba7b..c88c51aaf22b 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -11,6 +11,7 @@
 
 #include <linux/tracepoint.h>
 
+struct landlock_rule;
 struct landlock_rule_ref;
 struct landlock_ruleset;
 struct path;
@@ -62,6 +63,61 @@ TRACE_EVENT(landlock_add_rule_fs,
 	)
 );
 
+TRACE_EVENT(landlock_check_rule,
+
+	TP_PROTO(
+		const struct landlock_ruleset *domain,
+		const struct landlock_rule_ref *ref,
+		access_mask_t access_request,
+		const struct landlock_rule *rule
+	),
+
+	TP_ARGS(domain, ref, access_request, rule),
+
+	TP_STRUCT__entry(
+		__field(__u64, domain_id)
+		__field(access_mask_t, access_request)
+		__field(int, ref_type)
+		__field(uintptr_t, ref_key)
+		__dynamic_array(access_mask_t, layers, domain->num_layers)
+	),
+
+	TP_fast_assign(
+		__entry->domain_id = domain->hierarchy->id;
+		__entry->access_request = access_request;
+		__entry->ref_type = ref->type;
+		/* TODO: Use an object's Landlock ID instead of a kernel address. */
+		__entry->ref_key = ref->key.data;
+
+		for (size_t level = 1, i = 0;
+			level <= __get_dynamic_array_len(layers) / sizeof(access_mask_t);
+			level++) {
+			access_mask_t allowed;
+
+			if (i < rule->num_layers &&
+			    level == rule->layers[i].level) {
+				allowed = rule->layers[i].access;
+				i++;
+			} else {
+				allowed = 0;
+			}
+			((access_mask_t *)__get_dynamic_array( layers))[level - 1] = allowed;
+		}
+	),
+
+	/* TODO: Do not print network ports as big endian. */
+	TP_printk("domain=%llx key=%s:0x%lx request=0x%x allowed=%s",
+		__entry->domain_id,
+		__print_symbolic(__entry->ref_type,
+			{ LANDLOCK_KEY_INODE, "inode" },
+			{ LANDLOCK_KEY_NET_PORT, "net_port" }
+		),
+		__entry->ref_key,
+		__entry->access_request,
+		__print_dynamic_array(layers, sizeof(access_mask_t))
+	)
+);
+
 #endif /* _TRACE_LANDLOCK_H */
 
 /* This part must be outside protection */
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 20a4bbb2526f..f9e407e4038c 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
+#include <trace/events/landlock.h>
 
 #include "access.h"
 #include "audit.h"
@@ -629,6 +630,8 @@ bool landlock_unmask_layers(const struct landlock_ruleset *const domain,
 	if (!rule)
 		return false;
 
+	trace_landlock_check_rule(domain, &ref, access_request, rule);
+
 	/*
 	 * An access is granted if, for each policy layer, at least one rule
 	 * encountered on the pathwalk grants the requested access,
diff --git a/security/landlock/trace.c b/security/landlock/trace.c
index 98874cda473b..c0c450536be9 100644
--- a/security/landlock/trace.c
+++ b/security/landlock/trace.c
@@ -8,6 +8,7 @@
 #include <linux/path.h>
 
 #include "access.h"
+#include "domain.h"
 #include "ruleset.h"
 
 #define CREATE_TRACE_POINTS
-- 
2.49.0

