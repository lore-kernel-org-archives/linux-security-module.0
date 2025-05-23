Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B37223710
	for <linux-security-module@vger.kernel.org>; Fri, 23 May 2025 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748019881; cv=none; b=Ru+jppp7X3Sw+TR/ZaBo3TDm8Khc9xZTb0Q0E3CC5lSj5SBWsHfXWYvqjCdclFBQguRTkb6dq1ejZ3yadD8T0G0Ekk0xMbHEbxcML3vBYoiq8K/a5Fp82ZtDyaISvD/7bkur+p+T5JZNFt+IXgydJE9gfmJ76TxtpoTjeUUONQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748019881; c=relaxed/simple;
	bh=yHaHFkCpYbsn/CndJsNQzchXiary+ahZx6/ZLpUMwOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFsnXba+fN2SP13JMUFj5JTIPhS/1a8BeRCZX9qqE/QfM/Iw5bXwNnAcY9NhgRmETBFeiK4Z9dt7r4IrpdWDtsbCEOub2saWr/rsxJ6/11PnL/ysX40GOkUzNJtviwhwjFyhrZBme1T+MyI7l7ItAjlCYwLtPTlgPFBkwuMymfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=CB9oQllR; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="CB9oQllR"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b3rv61GCWzfWf;
	Fri, 23 May 2025 18:57:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748019474;
	bh=2HWfAP81p7RLsGfr2RvkhJ4ZCCT0ch+jn0J9ewgvV3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CB9oQllRK3VOLOmNLlRIqGu64eUSW7yxEd0P1fDYKbdehY9BZGP9W/KBICTTIb0l7
	 W5aoNZMy4g+xqOLJ9nWWZ/K1Tk2q4B6bJE8dDOW56leAoC1Xcm48RxZ1QC5H7P+vq6
	 NyBVFpho940QqiK4T+2p+1cHDQo2M2SypLB+vIDs=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4b3rv5443mzg6w;
	Fri, 23 May 2025 18:57:53 +0200 (CEST)
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
Subject: [RFC PATCH v1 3/5] tracing: Add __print_untrusted_str()
Date: Fri, 23 May 2025 18:57:39 +0200
Message-ID: <20250523165741.693976-4-mic@digikod.net>
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

Add a new __print_untrusted_str() helper to safely print strings after escaping
all special characters, including common separators (space, equal sign),
quotes, and backslashes.  This transforms a string from an untrusted source
(e.g. user space) to make it:
- safe to parse,
- easy to read (for simple strings),
- easy to get back the original.

Cc: Günther Noack <gnoack@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 include/linux/trace_events.h               |  3 ++
 include/trace/stages/stage3_trace_output.h |  4 +++
 include/trace/stages/stage7_class_define.h |  1 +
 kernel/trace/trace_output.c                | 40 ++++++++++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index fa9cf4292dff..78f543bb7558 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -54,6 +54,9 @@ trace_print_hex_dump_seq(struct trace_seq *p, const char *prefix_str,
 			 int prefix_type, int rowsize, int groupsize,
 			 const void *buf, size_t len, bool ascii);
 
+const char *trace_print_untrusted_str_seq(struct trace_seq *s, const char *str);
+
+
 struct trace_iterator;
 struct trace_event;
 
diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index 1e7b0bef95f5..36947ca2abcb 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -133,6 +133,10 @@
 	trace_print_hex_dump_seq(p, prefix_str, prefix_type,		\
 				 rowsize, groupsize, buf, len, ascii)
 
+#undef __print_untrusted_str
+#define __print_untrusted_str(str)							\
+		trace_print_untrusted_str_seq(p, __get_str(str))
+
 #undef __print_ns_to_secs
 #define __print_ns_to_secs(value)			\
 	({						\
diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
index fcd564a590f4..bc10b69b755d 100644
--- a/include/trace/stages/stage7_class_define.h
+++ b/include/trace/stages/stage7_class_define.h
@@ -24,6 +24,7 @@
 #undef __print_array
 #undef __print_dynamic_array
 #undef __print_hex_dump
+#undef __print_untrusted_string
 #undef __get_buf
 
 /*
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index b9ab06c99543..17d576941147 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -16,6 +16,7 @@
 #include <linux/btf.h>
 #include <linux/bpf.h>
 #include <linux/hashtable.h>
+#include <linux/string_helpers.h>
 
 #include "trace_output.h"
 #include "trace_btf.h"
@@ -297,6 +298,45 @@ trace_print_hex_dump_seq(struct trace_seq *p, const char *prefix_str,
 }
 EXPORT_SYMBOL(trace_print_hex_dump_seq);
 
+/**
+ * trace_print_untrusted_str_seq - print a string after escaping characters
+ * @s: trace seq struct to write to
+ * @src: The string to print
+ *
+ * Prints a string to a trace seq after escaping all special characters,
+ * including common separators (space, equal sign), quotes, and backslashes.
+ * This transforms a string from an untrusted source (e.g. user space) to make
+ * it:
+ * - safe to parse,
+ * - easy to read (for simple strings),
+ * - easy to get back the original.
+ */
+const char *trace_print_untrusted_str_seq(struct trace_seq *s,
+                                          const char *src)
+{
+	int escaped_size;
+	char *buf;
+	size_t buf_size = seq_buf_get_buf(&s->seq, &buf);
+	const char *ret = trace_seq_buffer_ptr(s);
+
+	if (!src || WARN_ON(buf_size == 0))
+		return NULL;
+
+	escaped_size = string_escape_mem(src, strlen(src), buf, buf_size,
+		ESCAPE_SPACE | ESCAPE_SPECIAL | ESCAPE_NAP | ESCAPE_APPEND |
+		ESCAPE_OCTAL, " ='\"\\");
+	if (unlikely(escaped_size >= buf_size)) {
+		/* We need some room for the final '\0'. */
+		seq_buf_set_overflow(&s->seq);
+		s->full = 1;
+		return NULL;
+	}
+	seq_buf_commit(&s->seq, escaped_size);
+	trace_seq_putc(s, 0);
+	return ret;
+}
+EXPORT_SYMBOL(trace_print_untrusted_str_seq);
+
 int trace_raw_output_prep(struct trace_iterator *iter,
 			  struct trace_event *trace_event)
 {
-- 
2.49.0

