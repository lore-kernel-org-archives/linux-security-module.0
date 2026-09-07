Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808E343A809
	for <linux-security-module@vger.kernel.org>; Mon,  7 Sep 2026 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795857; cv=none; b=i9v66QtOThbQ1hSEffQJ8V159/zndJW2bYMKTc5i4JANgnJx88mutZH7ljQamnS1XrCvMtvD9Bx6EkboYOZoKpEcGEgMBIup6/EfZ7pRzpawVqjgoPkGQgSjDnZiMMs4AWZzKhMntR0+IW/P2P5mBR4mo8nMkhvKzCoRaYCpQlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795857; c=relaxed/simple;
	bh=q0JC8ZCyOUkNe3QOhwME4K8qc1vt2dTOlhEgRoeOCD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BXZX+WHmU8F0khdUsw4SN9XcmgvnCQu1PEKtLXmJ5yFvXrAbZNZRiBKC1Us2cJdOAzsjSqM8deTbII7tK4I+Tr8aFfSHq504E/0VCwzLNDdIv56IxTUBWuZzbfUqi9qBUeOkW8UoWRAnAoIxpBrq2t9uhx7UPLCMYdY2REmHLf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=CsvuUbjY; arc=none smtp.client-ip=83.166.143.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="CsvuUbjY"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hdrw93VN0zQ5y;
	Mon,  7 Sep 2026 17:44:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1788795849;
	bh=PDqYhNAVv54EBJAJsltUZvPuXdi6vzppVMBCdtYhQLA=;
	h=From:To:Cc:Subject:Date:From;
	b=CsvuUbjYeVKzz0cwvijV0njKU+ybbJJARO+YhqRCXuy7Y/59E9OKpMJkX5/iarEQX
	 NdjdJEeg4NvEc8iUWBhE8D9npfl60ulP0ogz74ccEqpIyIS5KahkDknSRg0rI8oW+K
	 CBM6RpHbnlx+hvYQrqbAkg1E4kyIFzU9oKzUyGsw=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hdrw86CQnz58l;
	Mon,  7 Sep 2026 17:44:08 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v1 1/2] landlock: Bound escaped trace path output
Date: Mon,  7 Sep 2026 17:43:58 +0200
Message-ID: <20260907154401.124362-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Filesystem paths may expand fourfold when trace text escapes spaces and
other untrusted bytes.  A sufficiently long representation can exhaust
the shared scratch sequence.  A sibling __print_flags() helper may then
return an unterminated one-past pointer because TP_printk() argument
ordering is unspecified.

Use a fixed budget rather than the scratch space available at call time,
so output does not vary with sibling evaluation order.  Limit an
untrusted string to three quarters of the trace sequence, leaving the
rest for sibling helpers and final event metadata.  Compute and commit
complete escaped output transactionally so an exact fill cannot consume
the terminating NUL or poison the scratch sequence.

For strings that exceed the limit, retain the largest prefix ending at a
complete escape unit, then append a raw UTF-8 ellipsis.  Keep the
helper's existing octal fallback so complete values remain unchanged.
Hex fallback would consume the same four bytes per escaped byte without
increasing the prefix or strengthening the marker.  ESCAPE_NAP renders
every non-ASCII input byte in octal, so legitimate data cannot reproduce
the marker without being escaped.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 include/trace/events/landlock.h | 70 +++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 17 deletions(-)

diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index f82588f6f90e..d05253afaf59 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -28,6 +28,16 @@ struct task_struct;
 
 #ifdef CREATE_TRACE_POINTS
 
+/* About 6 KiB, leaving about 2 KiB for sibling helpers and fixed fields. */
+#define TRACE_UNTRUSTED_STR_OUTPUT_SIZE \
+	(TRACE_SEQ_BUFFER_SIZE - TRACE_SEQ_BUFFER_SIZE / 4)
+
+/*
+ * A raw UTF-8 ellipsis (…) marks truncation and cannot collide with escaped
+ * input: ESCAPE_NAP renders every non-ASCII input byte in octal.
+ */
+#define TRACE_TRUNCATION_MARKER "\xe2\x80\xa6"
+
 /*
  * Escapes @len bytes of an untrusted string into the trace sequence @p so it
  * cannot inject field separators or control characters into the ftrace text
@@ -37,33 +47,59 @@ struct task_struct;
  * NUL-terminated or carries embedded NUL bytes (an abstract socket name) is
  * escaped in full instead of being truncated at the first NUL.
  *
- * Return: a pointer into @p's buffer, or NULL if @src is NULL or the buffer is
- * exhausted (normal when the trace buffer is full).
+ * Strings that exceed the output limit retain the largest complete escaped
+ * prefix followed by the truncation marker.
+ *
+ * Return: a pointer into @p's buffer, or NULL if @src is NULL or the fixed
+ * output reservation is unavailable.
  */
 static inline const char *
 __trace_print_untrusted_str(struct trace_seq *p, const char *src, size_t len)
 {
+	const unsigned int escape_flags = ESCAPE_SPACE | ESCAPE_SPECIAL |
+					  ESCAPE_NAP | ESCAPE_APPEND |
+					  ESCAPE_OCTAL;
+	const size_t marker_len = sizeof(TRACE_TRUNCATION_MARKER) - 1;
+	size_t buf_size, prefix_len, prefix_size;
 	int escaped_size;
 	char *buf;
-	size_t buf_size = seq_buf_get_buf(&p->seq, &buf);
-	const char *ret = trace_seq_buffer_ptr(p);
+	const char *ret;
 
-	/* Buffer exhaustion is normal when the trace buffer is full. */
-	if (!src || buf_size == 0)
+	buf_size = seq_buf_get_buf(&p->seq, &buf);
+	if (!src || buf_size < TRACE_UNTRUSTED_STR_OUTPUT_SIZE)
 		return NULL;
 
-	escaped_size =
-		string_escape_mem(src, len, buf, buf_size,
-				  ESCAPE_SPACE | ESCAPE_SPECIAL | ESCAPE_NAP |
-					  ESCAPE_APPEND | ESCAPE_OCTAL,
-				  " ='\"\\");
-	if (unlikely(escaped_size >= buf_size)) {
-		/* We need some room for the final '\0'. */
-		seq_buf_set_overflow(&p->seq);
-		p->full = 1;
-		return NULL;
+	ret = trace_seq_buffer_ptr(p);
+	escaped_size = string_escape_mem(src, len, buf,
+					 TRACE_UNTRUSTED_STR_OUTPUT_SIZE,
+					 escape_flags, " ='\"\\");
+	if (likely(escaped_size < TRACE_UNTRUSTED_STR_OUTPUT_SIZE)) {
+		seq_buf_commit(&p->seq, escaped_size);
+		trace_seq_putc(p, 0);
+		return ret;
+	}
+
+	prefix_len = 0;
+	prefix_size = 0;
+	while (prefix_len < len) {
+		const char *const src_char = src + prefix_len;
+		int char_size;
+
+		char_size = string_escape_mem(src_char, 1, NULL, 0,
+					      escape_flags, " ='\"\\");
+		if (char_size > TRACE_UNTRUSTED_STR_OUTPUT_SIZE - marker_len -
+					1 - prefix_size)
+			break;
+		prefix_size += char_size;
+		prefix_len++;
 	}
-	seq_buf_commit(&p->seq, escaped_size);
+
+	escaped_size = string_escape_mem(src, prefix_len, buf, prefix_size,
+					 escape_flags, " ='\"\\");
+	if (WARN_ON_ONCE(escaped_size != prefix_size))
+		return NULL;
+	memcpy(buf + prefix_size, TRACE_TRUNCATION_MARKER, marker_len);
+	seq_buf_commit(&p->seq, prefix_size + marker_len);
 	trace_seq_putc(p, 0);
 	return ret;
 }
-- 
2.55.0

