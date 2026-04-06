Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884B02F616A
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486257; cv=none; b=AQ9cPVvLQRZWDlRQtaYfVG6qQNoXQnTz6PqV81rILQam6THu5GO78W/sa0g0onjD8RMJRvqREP3Dv9sx/rWO0BWQXQYtg0NhFvmnX6hkz01QiZu2kovSzDvgmz/tD+lcecwj8A7MtipuUiobFaqgy+QXbTi2SGtSSNxG3h+2Q0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486257; c=relaxed/simple;
	bh=APjX0zJBdu0zzzjfzrnGd5L6JNsae9QvPdgxrKbH+JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WSdK7n5U8E7RDEGfUVoNtbCS1facOvXvx6ejUmjB10D0ohgSx5yF/9jA9Cw/xqUzQRs886BTXwhG25wq3kb1fyaYWWs3aXc99zWvbzdDniglRrXLLxSLH2d8Co0e8CUEw4yuYv0lPTosKgzUnWdmYpBFuYJbVGiCT2TQNavCisA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=aYxwFWbC; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="aYxwFWbC"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fqBkN16BFzy3B;
	Mon,  6 Apr 2026 16:37:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775486252;
	bh=MY7Z1Vy09XN0h9hDWTN6HGGVELVbkdFTLt3c6gP+N78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aYxwFWbCGAQnJg9cNrkOvNGogU0UgvDGTy7VkRvovJJVnWdWEg0uUMuEA1XMxHjan
	 N0hFbVbuVhsj8rBXsrypCQ5cNTrYqip+XFMS7KjcjrQ/KvYAwf7IM9oHHkIW4vcgb5
	 SdpSgonnxcDhr4a6Nf7Z3bx3n0Y2rQcGJgeC/jo4=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fqBkM40sJzbXK;
	Mon,  6 Apr 2026 16:37:31 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tingmao Wang <m@maowtm.org>,
	kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 05/17] tracing: Add __print_untrusted_str()
Date: Mon,  6 Apr 2026 16:37:03 +0200
Message-ID: <20260406143717.1815792-6-mic@digikod.net>
In-Reply-To: <20260406143717.1815792-1-mic@digikod.net>
References: <20260406143717.1815792-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Landlock tracepoints expose filesystem paths and process names
that may contain spaces, equal signs, or other characters that
break ftrace field parsing.

Add a new __print_untrusted_str() helper to safely print strings after
escaping all special characters, including common separators (space,
equal sign), quotes, and backslashes.  This transforms a string from an
untrusted source (e.g. user space) to make it:
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

Changes since v1:
https://lore.kernel.org/r/20250523165741.693976-4-mic@digikod.net
- Remove WARN_ON() (pointed out by Steven Rostedt).
---
 include/linux/trace_events.h               |  2 ++
 include/trace/stages/stage3_trace_output.h |  4 +++
 include/trace/stages/stage7_class_define.h |  1 +
 kernel/trace/trace_output.c                | 41 ++++++++++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 37eb2f0f3dd8..7f4325d327ee 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -57,6 +57,8 @@ trace_print_hex_dump_seq(struct trace_seq *p, const char *prefix_str,
 			 int prefix_type, int rowsize, int groupsize,
 			 const void *buf, size_t len, bool ascii);
 
+const char *trace_print_untrusted_str_seq(struct trace_seq *s, const char *str);
+
 int trace_raw_output_prep(struct trace_iterator *iter,
 			  struct trace_event *event);
 extern __printf(2, 3)
diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index fce85ea2df1c..62e98babb969 100644
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
index fcd564a590f4..1164aacd550f 100644
--- a/include/trace/stages/stage7_class_define.h
+++ b/include/trace/stages/stage7_class_define.h
@@ -24,6 +24,7 @@
 #undef __print_array
 #undef __print_dynamic_array
 #undef __print_hex_dump
+#undef __print_untrusted_str
 #undef __get_buf
 
 /*
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 1996d7aba038..9d14c7cc654d 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -16,6 +16,7 @@
 #include <linux/btf.h>
 #include <linux/bpf.h>
 #include <linux/hashtable.h>
+#include <linux/string_helpers.h>
 
 #include "trace_output.h"
 #include "trace_btf.h"
@@ -321,6 +322,46 @@ trace_print_hex_dump_seq(struct trace_seq *p, const char *prefix_str,
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
+					   const char *src)
+{
+	int escaped_size;
+	char *buf;
+	size_t buf_size = seq_buf_get_buf(&s->seq, &buf);
+	const char *ret = trace_seq_buffer_ptr(s);
+
+	/* Buffer exhaustion is normal when the trace buffer is full. */
+	if (!src || buf_size == 0)
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
2.53.0

