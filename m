Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007FB4C224A;
	Wed, 30 Sep 2026 23:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790812373; cv=none; b=Y10Akh7rM2LVSdn3ejC7zx5MYhPOiQ0MeVfSuejY2ZwXxVNsD5t+zEkIS04rXeb8ZvkwxmtVlQ/fKPzYsGlDzNH4SPTpKp7WgxKB6kZYsHs4UoRhSSo7PQ8IYsJ1DOIbvJU/TqNs7knXKlcye1Pr2fQY2c0eJuZBO+A4FxaQ/9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790812373; c=relaxed/simple;
	bh=+wzf3MCK0k5b4spAzsf+dCLhLnezuYJM2T60DnOvev4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qySHXPzu/SACDKof35yt31xcvEJZzefQk/5Fl/qqmwLqyUjdhAq+/Q6/0VA146gUlTnXrF6AEU0lKR/vHH9UT8dhgmBf5KXyn7wuy9MzpZLkLZJO1aS5jhoO6N3CU5B0CzZ2//PgSIj8HqCOiyRX5znT7N5xAoz+YVU7HqZU+Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jpe3JYM3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jpe3JYM3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDDB1F00898;
	Wed, 30 Sep 2026 23:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790812370;
	bh=C+agq54WE0HX8gYLICSvvyTPH8K0IpFdMx44lcFnFWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jpe3JYM3iK4XOBgBE/6euYMenyV1EqgqSWaNVkb7zAMMvTg+HVDuXTJ5GBtouluit
	 RuzKdhrpDSY2hvLrKFRypOiQWsERM+np5FRqpLVr+Uxe4OM3EMC1IksuciS8VdA7WX
	 te2rnoKHfPLGcls2kFFY2duQZ2Nbb7/wwDTrQF2k5HSskL9bl//llkIS754qRwqWQh
	 NVUDGk/Vr2yw1B2ionMn9z349dKIEqC6I5usg61WyF95RQa29eWiuehyi9qiCubG2a
	 WPDahdPGtymMNvK8zQE7iOY9pwxjsN3xxeYI6PXngXwHYCAbe8Iou6d8pzhoAU+30U
	 qubIYy4FZfViw==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Gow <david@davidgow.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Petr Mladek <pmladek@suse.com>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	nikitash.mariiaw@gmail.com,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 02/11] seq_buf: Do not pop from an overflowed seq_buf
Date: Wed, 30 Sep 2026 16:52:30 -0700
Message-Id: <20260930235247.157921-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930235231.out.387-kees@kernel.org>
References: <20260930235231.out.387-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4958; i=kees@kernel.org; h=from:subject; bh=+wzf3MCK0k5b4spAzsf+dCLhLnezuYJM2T60DnOvev4=; b=owGbwMvMwCVmps19z/KJym7G02pJDFl7FxzZMrkzf8//rptcV56fUtzK98NR97LQObPMdJbuX X23v9zn6ShlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZjI3teMDLvYMy/u/Wh6tu5M 0yLBKbPyw//sKOrfU3HUeMbLRy3uuw0ZGf4+2G5t/WTzye2b8365KnUb7di0YlHOvadPD6/PzJz +8To3AA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When a seq_buf has overflowed, its len is size + 1, so seq_buf_pop()
decrements len to size and reads buffer[size], one byte past the end of
the buffer. It also leaves len equal to size, which no longer counts as
overflowed, so a truncated seq_buf then looks like a complete, full one.

An overflowed seq_buf logically has no last character to pop: the
length of what was written has been lost, and the last byte of the
buffer may be the NUL written by vsnprintf() or bytes that were never
committed. Return -1 for an overflowed seq_buf, as for an empty one,
and leave it overflowed, as the rest of the seq_buf API does until
seq_buf_clear() or seq_buf_init().

The current callers do not reach this, e.g. trace_syscalls only calls
trace_seq_pop() when the trace_seq it pops from has not overflowed, and
kernel/bpf/diagnostics.c sets the length from strnlen() before popping.

Add tests for the pop corner cases.

Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.1.0.

Fixes: 32e0f607ac6a2 ("tracing: Add trace_seq_pop() and seq_buf_pop()")
Assisted-by: LLM
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/seq_buf.h   |  4 ++--
 include/linux/trace_seq.h |  5 ++++-
 lib/tests/seq_buf_kunit.c | 42 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 9f2839e73f8a..f5a350347bc5 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -155,11 +155,11 @@ static inline void seq_buf_commit(struct seq_buf *s, int num)
  *
  * Removes the last written character to the seq_buf @s.
  *
- * Returns the last character or -1 if it is empty.
+ * Returns the last character, or -1 if @s is empty or has overflowed.
  */
 static inline int seq_buf_pop(struct seq_buf *s)
 {
-	if (!s->len)
+	if (!s->len || seq_buf_has_overflowed(s))
 		return -1;
 
 	s->len--;
diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 697d619aafdc..7174ebf3f015 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -86,7 +86,10 @@ static inline bool trace_seq_has_overflowed(struct trace_seq *s)
  *
  * Removes the last written character to the trace_seq @s.
  *
- * Returns the last character or -1 if it is empty.
+ * Returns the last character, or -1 if the underlying seq_buf is empty or
+ * has overflowed. Note that only that buffer is consulted: a @s marked
+ * full by a write that did not fit, which trace_seq_has_overflowed()
+ * reports as overflowed, still pops the last character written.
  */
 static inline int trace_seq_pop(struct trace_seq *s)
 {
diff --git a/lib/tests/seq_buf_kunit.c b/lib/tests/seq_buf_kunit.c
index 9ceccdc3029f..d5a0c618b880 100644
--- a/lib/tests/seq_buf_kunit.c
+++ b/lib/tests/seq_buf_kunit.c
@@ -115,6 +115,47 @@ static void seq_buf_putc_test(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "");
 }
 
+static void seq_buf_pop_test(struct kunit *test)
+{
+	DECLARE_SEQ_BUF(s, 8);
+	struct seq_buf t;
+	char *buf;
+
+	/* Nothing to pop. */
+	KUNIT_EXPECT_EQ(test, seq_buf_pop(&s), -1);
+	KUNIT_EXPECT_EQ(test, s.len, 0);
+
+	seq_buf_puts(&s, "hello");
+	KUNIT_EXPECT_EQ(test, seq_buf_pop(&s), 'o');
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 4);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hell");
+
+	/* A 0xff byte must not be mistaken for an empty buffer. */
+	seq_buf_putc(&s, 0xff);
+	KUNIT_EXPECT_EQ(test, seq_buf_pop(&s), 0xff);
+
+	/* A full buffer pops its last byte. */
+	seq_buf_puts(&s, "abc");
+	seq_buf_putc(&s, 'd');
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 8);
+	KUNIT_EXPECT_EQ(test, seq_buf_pop(&s), 'd');
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 7);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hellabc");
+
+	/*
+	 * An overflowed buffer has nothing to pop, and stays overflowed. Use
+	 * a buffer allocated at its exact size, so that KASAN reports any
+	 * read past its end.
+	 */
+	buf = kunit_kmalloc(test, 16, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, buf);
+	seq_buf_init(&t, buf, 16);
+	KUNIT_EXPECT_EQ(test, seq_buf_printf(&t, "%s", "longer than sixteen"), -1);
+	KUNIT_EXPECT_EQ(test, seq_buf_pop(&t), -1);
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&t));
+}
+
 static void seq_buf_printf_test(struct kunit *test)
 {
 	DECLARE_SEQ_BUF(s, 32);
@@ -355,6 +396,7 @@ static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_puts_test),
 	KUNIT_CASE(seq_buf_puts_overflow_test),
 	KUNIT_CASE(seq_buf_putc_test),
+	KUNIT_CASE(seq_buf_pop_test),
 	KUNIT_CASE(seq_buf_printf_test),
 	KUNIT_CASE(seq_buf_printf_overflow_test),
 	KUNIT_CASE(seq_buf_get_buf_commit_test),
-- 
2.34.1

