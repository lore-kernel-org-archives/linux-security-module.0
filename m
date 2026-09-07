Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D43050EBE3
	for <linux-security-module@vger.kernel.org>; Mon,  7 Sep 2026 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795860; cv=none; b=BPIhGq1uGcRLXEHMQnSGGkLHFurmoMiEutiSW6tv65lkiiieERiEW9gUTo7cHuwp5o63O/NYK+i630Fdx/T8Qo4i41bsfcnezHr9BKJ0IlpDOXQgbE6Elu8OLrPb4z3CJoM2QfWZImWHMRG8dCZER0mw3kPGnuGP/vRnMrBhnb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795860; c=relaxed/simple;
	bh=ZQgxeVBWmdj62IzXFBfCBc+fU9t72bqXveUb9wsNGao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TSzZ40Aew7N+Av9LetUO3PUQb7VUEFuudmwppusMWZq63OoH130FYUNC2L91Wri1aJyZkPwh0tim90xncC5MX571qijC2MRlOWV1IbKgsq1J8y7mObhe1FhzSdaix71p0qf72a74llneDg725VXd4zRv7mED6L6uo+AISd1mLwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=zipwwov5; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="zipwwov5"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hdrwC5wLKzRrt
	for <linux-security-module@vger.kernel.org>; Mon,  7 Sep 2026 17:44:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1788795851;
	bh=9QLEATy57bw8f1/Nv93pwkDcNIXAEjIJnQC4zdUm6I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zipwwov5pzdkTfDqGF3TEAT8RHm2sMD9UH+74JGCyBUtMVJNF8QiEoYt+0S43HJ0C
	 9SGabSVVdEunNMzGJUPeTkeGxwiyBREA7slrGyyytt1yj877T/VMO+B7W7xgD+wnD0
	 DHQaJjghiMc+e5QI7hHuUel6l//J2uBIjImEGX1Y=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hdrwC1hQbzw9f;
	Mon,  7 Sep 2026 17:44:11 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v1 2/2] landlock: Test trace path output boundaries
Date: Mon,  7 Sep 2026 17:43:59 +0200
Message-ID: <20260907154401.124362-2-mic@digikod.net>
In-Reply-To: <20260907154401.124362-1-mic@digikod.net>
References: <20260907154401.124362-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Use focused KUnit tests to exercise the renderer's internal boundary and
composition contracts with synthetic scratch states, including both
sibling-helper evaluation orders.  Check the exact output and
reservation boundaries, including a four-byte octal escape accepted at
exact capacity and rejected one byte short.  Also verify an unchanged
cursor on failure, that bracketed process names and embedded NUL bytes
remain data, and that input ellipsis bytes are escaped rather than
mistaken for the raw truncation marker.

The composition test requires generic trace output helpers.  Enable
CONFIG_FTRACE and CONFIG_SCHED_TRACER because the latter selects the
otherwise-hidden CONFIG_TRACING support required by
trace_print_flags_seq().

Use kselftests to exercise the complete tracefs path for both affected
filesystem events.  A valid path containing 2640 spaces exceeds the
scratch output budget.  Require its escaped prefix to end in the raw
UTF-8 ellipsis while access_rights and blockers remain intact.

This division keeps the exact safety contract compiler-independent while
proving that real tracepoints preserve their surrounding symbolic
fields.  The end-to-end assertions fail after a full fix revert with
both GCC and Clang, while the composition KUnit test fails if the
scratch reserve is removed.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/.kunitconfig                |   2 +
 security/landlock/trace.c                     | 182 ++++++++++++++++++
 .../selftests/landlock/trace_fs_test.c        | 160 +++++++++++++++
 3 files changed, 344 insertions(+)

diff --git a/security/landlock/.kunitconfig b/security/landlock/.kunitconfig
index f9423f01ac5b..fe36228d37ea 100644
--- a/security/landlock/.kunitconfig
+++ b/security/landlock/.kunitconfig
@@ -1,6 +1,8 @@
 CONFIG_AUDIT=y
+CONFIG_FTRACE=y
 CONFIG_KUNIT=y
 CONFIG_NET=y
+CONFIG_SCHED_TRACER=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_LANDLOCK=y
 CONFIG_SECURITY_LANDLOCK_KUNIT_TEST=y
diff --git a/security/landlock/trace.c b/security/landlock/trace.c
index 2ea7aac8d75d..8c21e5de6f0d 100644
--- a/security/landlock/trace.c
+++ b/security/landlock/trace.c
@@ -6,6 +6,7 @@
  * Copyright © 2026 Cloudflare, Inc.
  */
 
+#include <kunit/test.h>
 #include <linux/cleanup.h>
 #include <linux/dcache.h>
 #include <linux/err.h>
@@ -183,3 +184,184 @@ void landlock_trace_denial(
 		break;
 	}
 }
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+static void test_trace_seq_init(struct trace_seq *const seq, const size_t size)
+{
+	memset(seq, 0, sizeof(*seq));
+	seq_buf_init(&seq->seq, seq->buffer, size);
+}
+
+static void test_untrusted_str_data(struct kunit *const test)
+{
+	const char binary[] = { 'a', '\0', '<' };
+	static const char ellipsis[] = "\xe2\x80\xa6";
+	struct trace_seq *const seq =
+		kunit_kzalloc(test, sizeof(*seq), GFP_KERNEL);
+	const char *output;
+
+	KUNIT_ASSERT_NOT_NULL(test, seq);
+	test_trace_seq_init(seq, TRACE_SEQ_BUFFER_SIZE);
+	output = __trace_print_untrusted_str(seq, "<too_long>", 10);
+	KUNIT_ASSERT_NOT_NULL(test, output);
+	KUNIT_EXPECT_STREQ(test, output, "<too_long>");
+
+	test_trace_seq_init(seq, TRACE_SEQ_BUFFER_SIZE);
+	output = __trace_print_untrusted_str(seq, binary, sizeof(binary));
+	KUNIT_ASSERT_NOT_NULL(test, output);
+	KUNIT_EXPECT_STREQ(test, output, "a\\000<");
+
+	/* Input ellipsis bytes are escaped and cannot mimic the raw marker. */
+	test_trace_seq_init(seq, TRACE_SEQ_BUFFER_SIZE);
+	output = __trace_print_untrusted_str(seq, ellipsis,
+					     sizeof(ellipsis) - 1);
+	KUNIT_ASSERT_NOT_NULL(test, output);
+	KUNIT_EXPECT_STREQ(test, output, "\\342\\200\\246");
+}
+
+static void test_untrusted_str_boundaries(struct kunit *const test)
+{
+	static const char escaped_space[] = "\\040";
+	const size_t output_size = TRACE_UNTRUSTED_STR_OUTPUT_SIZE;
+	const size_t marker_len = sizeof(TRACE_TRUNCATION_MARKER) - 1;
+	const size_t escape_len = sizeof(escaped_space) - 1;
+	const size_t exact_prefix_len =
+		output_size - marker_len - 1 - escape_len;
+	const size_t short_prefix_len = exact_prefix_len + 1;
+	struct trace_seq *const seq =
+		kunit_kzalloc(test, sizeof(*seq), GFP_KERNEL);
+	char *const input = kunit_kmalloc(test, output_size + 1, GFP_KERNEL);
+	char *const expected = kunit_kmalloc(test, output_size, GFP_KERNEL);
+	const char *output;
+
+	KUNIT_ASSERT_NOT_NULL(test, seq);
+	KUNIT_ASSERT_NOT_NULL(test, input);
+	KUNIT_ASSERT_NOT_NULL(test, expected);
+
+	/* The escaped string and its trailing NUL exactly fit the limit. */
+	memset(input, 'a', output_size - 1);
+	test_trace_seq_init(seq, TRACE_SEQ_BUFFER_SIZE);
+	output = __trace_print_untrusted_str(seq, input, output_size - 1);
+	KUNIT_ASSERT_NOT_NULL(test, output);
+	KUNIT_EXPECT_EQ(test, seq->seq.len, output_size);
+	KUNIT_EXPECT_EQ(test, memcmp(output, input, output_size - 1), 0);
+
+	/* Stop before a four-byte escape when only three bytes remain. */
+	memset(input, 'a', short_prefix_len);
+	input[short_prefix_len] = ' ';
+	memset(input + short_prefix_len + 1, 'b', 5);
+	memset(expected, 'a', short_prefix_len);
+	memcpy(expected + short_prefix_len, TRACE_TRUNCATION_MARKER,
+	       marker_len + 1);
+	test_trace_seq_init(seq, TRACE_SEQ_BUFFER_SIZE);
+	output = __trace_print_untrusted_str(seq, input, short_prefix_len + 6);
+	KUNIT_ASSERT_NOT_NULL(test, output);
+	KUNIT_EXPECT_STREQ(test, output, expected);
+
+	/* Include a four-byte escape that exactly fills the prefix capacity. */
+	memset(input, 'a', exact_prefix_len);
+	input[exact_prefix_len] = ' ';
+	memset(input + exact_prefix_len + 1, 'b', marker_len + 1);
+	memset(expected, 'a', exact_prefix_len);
+	memcpy(expected + exact_prefix_len, escaped_space, escape_len);
+	memcpy(expected + exact_prefix_len + escape_len,
+	       TRACE_TRUNCATION_MARKER, marker_len + 1);
+	test_trace_seq_init(seq, TRACE_SEQ_BUFFER_SIZE);
+	output = __trace_print_untrusted_str(seq, input,
+					     exact_prefix_len + marker_len + 2);
+	KUNIT_ASSERT_NOT_NULL(test, output);
+	KUNIT_EXPECT_STREQ(test, output, expected);
+
+	/* Literal backslashes remain escaped in complete output. */
+	test_trace_seq_init(seq, TRACE_SEQ_BUFFER_SIZE);
+	output = __trace_print_untrusted_str(seq, "/\\000", 5);
+	KUNIT_ASSERT_NOT_NULL(test, output);
+	KUNIT_EXPECT_STREQ(test, output, "/\\\\000");
+}
+
+static void test_untrusted_str_cursor(struct kunit *const test)
+{
+	const size_t padding_len =
+		TRACE_SEQ_BUFFER_SIZE - TRACE_UNTRUSTED_STR_OUTPUT_SIZE + 1;
+	struct trace_seq *const seq =
+		kunit_kzalloc(test, sizeof(*seq), GFP_KERNEL);
+	char *const padding = kunit_kzalloc(test, padding_len, GFP_KERNEL);
+	const char *output;
+
+	KUNIT_ASSERT_NOT_NULL(test, seq);
+	KUNIT_ASSERT_NOT_NULL(test, padding);
+
+	/* Accept available space exactly equal to the fixed reservation. */
+	test_trace_seq_init(seq, TRACE_SEQ_BUFFER_SIZE);
+	trace_seq_putmem(seq, padding, padding_len - 1);
+	output = __trace_print_untrusted_str(seq, "/a", 2);
+	KUNIT_ASSERT_NOT_NULL(test, output);
+	KUNIT_EXPECT_STREQ(test, output, "/a");
+	KUNIT_EXPECT_EQ(test, seq->seq.len, padding_len - 1 + sizeof("/a"));
+
+	/* Reject one byte less without changing the scratch cursor. */
+	test_trace_seq_init(seq, TRACE_SEQ_BUFFER_SIZE);
+	trace_seq_putmem(seq, padding, padding_len);
+	output = __trace_print_untrusted_str(seq, "/a", 2);
+	KUNIT_EXPECT_NULL(test, output);
+	KUNIT_EXPECT_EQ(test, seq->seq.len, padding_len);
+}
+
+static void test_untrusted_str_composition(struct kunit *const test)
+{
+	static const struct trace_print_flags flags[] = {
+		{ .mask = 1, .name = "read" },
+	};
+	const size_t output_size = TRACE_UNTRUSTED_STR_OUTPUT_SIZE;
+	const size_t prefix_len = output_size - sizeof(TRACE_TRUNCATION_MARKER);
+	struct trace_seq *const seq =
+		kunit_kzalloc(test, sizeof(*seq), GFP_KERNEL);
+	char *const expected = kunit_kmalloc(test, output_size, GFP_KERNEL);
+	char *const path = kunit_kmalloc(test, output_size, GFP_KERNEL);
+	const char *flags_output, *path_output;
+
+	KUNIT_ASSERT_NOT_NULL(test, seq);
+	KUNIT_ASSERT_NOT_NULL(test, expected);
+	KUNIT_ASSERT_NOT_NULL(test, path);
+	memset(path, 'a', output_size);
+	memset(expected, 'a', prefix_len);
+	memcpy(expected + prefix_len, TRACE_TRUNCATION_MARKER,
+	       sizeof(TRACE_TRUNCATION_MARKER));
+
+	/* Exercise both legal TP_printk() sibling evaluation orders. */
+	test_trace_seq_init(seq, TRACE_SEQ_BUFFER_SIZE);
+	path_output = __trace_print_untrusted_str(seq, path, output_size);
+	flags_output =
+		trace_print_flags_seq(seq, "|", 1, flags, ARRAY_SIZE(flags));
+	KUNIT_ASSERT_NOT_NULL(test, path_output);
+	KUNIT_EXPECT_STREQ(test, path_output, expected);
+	KUNIT_EXPECT_STREQ(test, flags_output, "read");
+
+	test_trace_seq_init(seq, TRACE_SEQ_BUFFER_SIZE);
+	flags_output =
+		trace_print_flags_seq(seq, "|", 1, flags, ARRAY_SIZE(flags));
+	path_output = __trace_print_untrusted_str(seq, path, output_size);
+	KUNIT_ASSERT_NOT_NULL(test, path_output);
+	KUNIT_EXPECT_STREQ(test, path_output, expected);
+	KUNIT_EXPECT_STREQ(test, flags_output, "read");
+}
+
+static struct kunit_case test_cases[] = {
+	/* clang-format off */
+	KUNIT_CASE(test_untrusted_str_data),
+	KUNIT_CASE(test_untrusted_str_boundaries),
+	KUNIT_CASE(test_untrusted_str_cursor),
+	KUNIT_CASE(test_untrusted_str_composition),
+	{}
+	/* clang-format on */
+};
+
+static struct kunit_suite test_suite = {
+	.name = "landlock_trace",
+	.test_cases = test_cases,
+};
+
+kunit_test_suite(test_suite);
+
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
diff --git a/tools/testing/selftests/landlock/trace_fs_test.c b/tools/testing/selftests/landlock/trace_fs_test.c
index 5220f6a4bee1..4543a25c1f55 100644
--- a/tools/testing/selftests/landlock/trace_fs_test.c
+++ b/tools/testing/selftests/landlock/trace_fs_test.c
@@ -6,8 +6,10 @@
  */
 
 #define _GNU_SOURCE
+#include <assert.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <limits.h>
 #include <linux/landlock.h>
 #include <sched.h>
 #include <stdio.h>
@@ -23,6 +25,63 @@
 
 #define TRACE_TASK "trace_fs_test"
 
+/* Mirrors TRACE_SEQ_SIZE, conservatively larger than the usable buffer. */
+#define TRACE_SEQUENCE_SIZE 8192
+#define OCTAL_ESCAPE_LEN 4
+#define LONG_PATH_COMPONENT_COUNT 11
+#define LONG_PATH_COMPONENT_LEN 240
+#define LONG_PATH_LEN                                                \
+	(LONG_PATH_COMPONENT_COUNT * (LONG_PATH_COMPONENT_LEN + 1) + \
+	 sizeof("/tmp"))
+#define LONG_ESCAPED_PATH_LEN \
+	(LONG_PATH_COMPONENT_COUNT * LONG_PATH_COMPONENT_LEN * OCTAL_ESCAPE_LEN)
+
+static_assert(LONG_ESCAPED_PATH_LEN > TRACE_SEQUENCE_SIZE,
+	      "escaped path must exceed the trace sequence");
+static_assert(LONG_PATH_LEN < PATH_MAX, "path must fit in PATH_MAX");
+
+static void create_long_path(struct __test_metadata *const _metadata,
+			     char *path)
+{
+	size_t path_len;
+
+	strcpy(path, "/tmp");
+	path_len = strlen(path);
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, mount("tmpfs", "/tmp", "tmpfs", 0, NULL));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	for (int i = 0; i < LONG_PATH_COMPONENT_COUNT; i++) {
+		path[path_len++] = '/';
+		memset(path + path_len, ' ', LONG_PATH_COMPONENT_LEN);
+		path_len += LONG_PATH_COMPONENT_LEN;
+		path[path_len] = '\0';
+		ASSERT_EQ(0, mkdir(path, 0700));
+	}
+}
+
+static void expect_truncated_path(struct __test_metadata *const _metadata,
+				  const char *const trace,
+				  const char *const event_regex)
+{
+	static const char marker[] = "\xe2\x80\xa6";
+	char *path;
+	size_t path_len;
+
+	path = malloc(TRACE_SEQUENCE_SIZE);
+	ASSERT_NE(NULL, path);
+	ASSERT_EQ(0, tracefs_extract_field(trace, event_regex, "path", path,
+					   TRACE_SEQUENCE_SIZE));
+	EXPECT_EQ(path, strstr(path, "/tmp/"));
+	EXPECT_NE(NULL, strstr(path, "\\040"));
+
+	path_len = strlen(path);
+	ASSERT_LE(sizeof(marker) - 1, path_len);
+	EXPECT_STREQ(marker, path + path_len - (sizeof(marker) - 1));
+	free(path);
+}
+
 /*
  * Like REGEX_DENY_ACCESS_FS(), but pins the logged field to a specific value
  * ("0" or "1") so a test can tell a suppressed (quiet) denial from a logged
@@ -183,6 +242,107 @@ TEST_F(trace_fs, add_rule_fs)
 	free(buf);
 }
 
+/*
+ * Verifies that a path whose escaping exceeds the trace scratch sequence does
+ * not corrupt a sibling symbolic field.
+ */
+TEST_F(trace_fs, add_rule_fs_escaped_path_overflow)
+{
+	static const char access_prefix[] = "execute|write_file|read_file|";
+	static const char access_suffix[] = "|ioctl_dev|resolve_unix";
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
+	};
+	struct landlock_path_beneath_attr path_beneath = {
+		.allowed_access = LANDLOCK_ACCESS_FS_READ_FILE,
+	};
+	char path[PATH_MAX];
+	char *buf, field_buf[256];
+	size_t field_len;
+	int ruleset_fd, count;
+
+	create_long_path(_metadata, path);
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	path_beneath.parent_fd = open(path, O_PATH | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, path_beneath.parent_fd);
+
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				       &path_beneath, 0));
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	count = tracefs_count_matches(buf, REGEX_ADD_RULE_FS(TRACE_TASK));
+	EXPECT_EQ(1, count)
+	{
+		TH_LOG("Expected 1 add_rule_fs event, got %d\n%s", count, buf);
+	}
+
+	/*
+	 * The marker catches a full revert with any compiler.  The symbolic
+	 * field also catches scratch-sequence poisoning when the compiler
+	 * evaluates the overflowing path first, as GCC currently does.
+	 */
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_ADD_RULE_FS(TRACE_TASK),
+					   "access_rights", field_buf,
+					   sizeof(field_buf)));
+	EXPECT_EQ(0,
+		  strncmp(field_buf, access_prefix, sizeof(access_prefix) - 1));
+	EXPECT_EQ(NULL, strstr(field_buf, "|refer|"));
+	field_len = strlen(field_buf);
+	ASSERT_LE(sizeof(access_suffix) - 1, field_len);
+	EXPECT_STREQ(access_suffix,
+		     field_buf + field_len - (sizeof(access_suffix) - 1));
+	expect_truncated_path(_metadata, buf, REGEX_ADD_RULE_FS(TRACE_TASK));
+
+	free(buf);
+}
+
+/*
+ * Verifies that an overflowing denied path does not corrupt its sibling
+ * symbolic blockers field.
+ */
+TEST_F(trace_fs, deny_access_fs_escaped_path_overflow)
+{
+	char path[PATH_MAX];
+	char *buf, field_buf[64];
+	int count, err;
+
+	create_long_path(_metadata, path);
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	sandbox_child_fs_access(_metadata, "/usr", LANDLOCK_ACCESS_FS_READ_DIR,
+				LANDLOCK_ACCESS_FS_READ_DIR, path);
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	count = tracefs_count_matches(buf, REGEX_DENY_ACCESS_FS(TRACE_TASK));
+	EXPECT_EQ(1, count)
+	{
+		TH_LOG("Expected 1 deny_access_fs event, got %d\n%s", count,
+		       buf);
+	}
+
+	/*
+	 * The marker catches a full revert with any compiler.  The symbolic
+	 * field also catches scratch-sequence poisoning when the compiler
+	 * evaluates the overflowing path first, as GCC currently does.
+	 */
+	err = tracefs_extract_field(buf, REGEX_DENY_ACCESS_FS(TRACE_TASK),
+				    "blockers", field_buf, sizeof(field_buf));
+	ASSERT_EQ(0, err);
+	EXPECT_STREQ("read_dir", field_buf);
+	expect_truncated_path(_metadata, buf, REGEX_DENY_ACCESS_FS(TRACE_TASK));
+
+	free(buf);
+}
+
 /*
  * Verifies that an allowed access emits check_rule events (rule matched during
  * pathwalk) but does NOT emit deny_access events (no denial).
-- 
2.55.0

