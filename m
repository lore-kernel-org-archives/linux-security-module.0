Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AE531328E;
	Thu, 17 Sep 2026 00:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604615; cv=none; b=blGYQ3ZusovvrV0fEaHSuKVs5LmuVV3JjdK58W52LVBMf1fYFVRYmDYmPXYAhGgin9D04CJz2r62FY7wku8MnJohkLDoAEsIMCgkC2BJqoyjzPcokaBeUyFptgTF3iTMXD6cEwxt1s0gUwStZr8JRq2z/C8hc2gK7MAD5AgOSNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604615; c=relaxed/simple;
	bh=2dWOoAScSeIiKgVRpgMZ6w+qzOKok7SkSwpny2uNySs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8eWFuiYLx+Vfe+a9h/eTrCJhU3xDdR/7DrIuxqaNVCQWuuC0ngWAWDYTPasGwOpBc/VvZ6Fs52rFgrkISLtSUyvjTMIPLT/0JVvjOMhfybP3c/LJzNvNkslqfiDIuxweUmcKuH2VVYrKHOuKJ1cXrPq0aBHUQ2PIsE5HnRmgZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MO9p4U1j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MO9p4U1j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E88A1F00899;
	Thu, 17 Sep 2026 00:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604613;
	bh=/6ZKzbTNPnpfoJwkQzuIsoomBE/MLjH9JGmNsSrwXUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MO9p4U1j3804lt0V0vU1eY1oxN7NftBFYSKVlTGtFiUUNf1Sb113cgypIoneghn6G
	 9IZ0gWOmAhOe+Esk58/UbAjWk7pSneRJUQwMoGZosBPzOwafU0ozTbYD9n3rWsUSAi
	 q/kb6uDrvWSmxa/QJq+D5qV5HxMUsO1p1Y/uqSXWbGuJtmncdLXqtgLgjgsGD+sfaR
	 y0PTxQVwKlpnzzSe3jUpvxoOY8gmTkb4Eh4Rp5R42uGse51UlXt8dX/cJWtmA3kRwI
	 qwWEcIaoTMvjLyJ+axt38GH9Tcdna87VyahU6p7Cqt3+gv+iew1z/OUYT1zntVzYrt
	 ZTrdUyl2HZcSg==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Petr Mladek <pmladek@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	David Gow <david@davidgow.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/7] seq_buf: Do not pop from an overflowed seq_buf
Date: Wed, 16 Sep 2026 17:23:13 -0700
Message-Id: <20260917002333.2306346-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917002312.i.923-kees@kernel.org>
References: <20260917002312.i.923-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5368; i=kees@kernel.org; h=from:subject; bh=2dWOoAScSeIiKgVRpgMZ6w+qzOKok7SkSwpny2uNySs=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmrjb4c8Fvl7fgp+XHF6+6UIDHDzOTeb4v9Ik5KmarO1 Px+rqGho5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCIK6Qx/xV1u8hXfnfguY3eK zeGQI0qMl/8ezGn/MvuoX0HQ/v7GWww/GYu6Xp6zbDgQamLDlDl1okLI0x0vitjUAnVfXtu1Yrk nGwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When a seq_buf has overflowed, its len is size + 1, so seq_buf_pop()
decrements len to size and reads buffer[size], one byte past the end of
the buffer. It also leaves len equal to size, which no longer counts as
overflowed, so a truncated seq_buf then looks like a complete, full one.

An overflowed seq_buf has no last character to pop: the length of what
was written has been lost, and the last byte of the buffer may be the
NUL written by vsnprintf() or bytes that were never committed. Return
-1 for an overflowed seq_buf, as for an empty one, and leave it
overflowed, as the rest of the seq_buf API does until seq_buf_clear()
or seq_buf_init().

The current callers do not reach this, e.g. trace_syscalls only calls
trace_seq_pop() when the trace_seq it pops from has not overflowed, and
kernel/bpf/diagnostics.c sets the length from strnlen() before popping.

Add tests for the pop corner cases.

Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.1.0.

Fixes: 32e0f607ac6a2 ("tracing: Add trace_seq_pop() and seq_buf_pop()")
Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Mickaël Salaün" <mic@digikod.net>
Cc: "Günther Noack" <gnoack@google.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Shuvam Pandey <shuvampandey1@gmail.com>
Cc: David Gow <david@davidgow.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-trace-kernel@vger.kernel.org>
Cc: <linux-security-module@vger.kernel.org>
Cc: <bpf@vger.kernel.org>
---
 include/linux/seq_buf.h   |  4 ++--
 include/linux/trace_seq.h |  4 +++-
 lib/tests/seq_buf_kunit.c | 42 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 3 deletions(-)

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
index 697d619aafdc..9aaa141d0965 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -86,7 +86,9 @@ static inline bool trace_seq_has_overflowed(struct trace_seq *s)
  *
  * Removes the last written character to the trace_seq @s.
  *
- * Returns the last character or -1 if it is empty.
+ * Returns the last character, or -1 if @s is empty or its buffer has
+ * overflowed. Note that a @s that is full, but has not overflowed, still
+ * pops.
  */
 static inline int trace_seq_pop(struct trace_seq *s)
 {
diff --git a/lib/tests/seq_buf_kunit.c b/lib/tests/seq_buf_kunit.c
index eb466386bbef..9048037f6ba0 100644
--- a/lib/tests/seq_buf_kunit.c
+++ b/lib/tests/seq_buf_kunit.c
@@ -113,6 +113,47 @@ static void seq_buf_putc_test(struct kunit *test)
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
@@ -223,6 +264,7 @@ static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_puts_test),
 	KUNIT_CASE(seq_buf_puts_overflow_test),
 	KUNIT_CASE(seq_buf_putc_test),
+	KUNIT_CASE(seq_buf_pop_test),
 	KUNIT_CASE(seq_buf_printf_test),
 	KUNIT_CASE(seq_buf_printf_overflow_test),
 	KUNIT_CASE(seq_buf_get_buf_commit_test),
-- 
2.34.1

