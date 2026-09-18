Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A995208D7
	for <linux-security-module@vger.kernel.org>; Fri, 18 Sep 2026 18:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757481; cv=none; b=SvIZuchsj37NBQS6rYPMGilwlBG0gbE7ecPWXwojTASSNHGnvvUMVbKU1MKTIR++ik8P7apg4FhXW2PMLLUJlUSDSaVaAEpKx7RX4UMXHBCC4uBFCV0EwkHr9G9lieWY6aQSbje9/2xm9jSFpQP0++kmkBUF8KKi/JLZuDf3V08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757481; c=relaxed/simple;
	bh=hAQZLUsKIfZsGalxaPurvYjjpFUyAajajLJXmJFVqbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggbr5QsUeJPt9M7k93qEeGFv28pruLStS7fJJccV5Drncfr9dHD2R7xyqBReNtO4QtPdgVGupmB84zy4bIG4Mpxi4Jx9gSqC0Vc+6G28445ARKI3qQWJBWPQn3iZlkc/KB8Df5IQhCGbiZneDgsAEjAJMCNO13RGgzk8eCmepAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=kEDyiIb6; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="kEDyiIb6"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hmhXS31PlzmD3;
	Fri, 18 Sep 2026 20:50:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789757448;
	bh=3cJxPPU50XyUCSzBJ4MiffTmc4qMqXHnMDICULfhRVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kEDyiIb6J9b0QzjeTX4wU9V719lssOiFKoehwNZ1rNcr3L61IgKN8t108+BKGp2Ot
	 C1Q5KNYzGbcsVS/ymTRqTnUtsV4Z3v8L7Pv7eT0Ggi1JNN+rXI/Ccku8ryEtXTAhHW
	 DjWSc+N1Iwb/uspN9TNNGz7fid9LENwheawhw0oc=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hmhXR3CL9zKnn;
	Fri, 18 Sep 2026 20:50:47 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Paul Moore <paul@paul-moore.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v1 3/9] landlock: Fix rule tracepoint context
Date: Fri, 18 Sep 2026 20:50:26 +0200
Message-ID: <20260918185036.608651-4-mic@digikod.net>
In-Reply-To: <20260918185036.608651-1-mic@digikod.net>
References: <20260918185036.608651-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Name each event after the identity it reports. Add-rule events describe
UAPI rule insertion, so rename them after LANDLOCK_RULE_PATH_BENEATH and
LANDLOCK_RULE_NET_PORT. Check-rule events describe matches in internal
rule trees, so rename them after LANDLOCK_KEY_INODE and
LANDLOCK_KEY_NET_PORT. This remains accurate if multiple UAPI rule types
share one lookup and stored rule. Keep denial event names based on
filesystem and network families because they describe final access
decisions.

Use u64 for growable access masks passed by value to add-rule and
check-rule typed BTF callbacks. CO-RE can relocate pointer-reached
fields, but it cannot widen a scalar callback slot declared by a BPF
program. Keep native access_mask_t for internal state and trace records.

For add-rule callbacks, report the normalized per-call contribution
passed to landlock_insert_rule() and expose the complete validated flags
value. Put the ruleset and flags first as a common invocation prefix.
This distinguishes duplicate and effective-zero additions without
recovering arguments from saved syscall registers.

Cc: Günther Noack <gnoack@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Fixes: 63747c94774d ("landlock: Add landlock_add_rule_fs and landlock_add_rule_net tracepoints")
Fixes: 3f1f106e4c14 ("landlock: Add tracepoints for rule checking")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 Documentation/trace/events-landlock.rst       | 22 +++----
 include/trace/events/landlock.h               | 62 +++++++++++--------
 security/landlock/fs.c                        | 10 +--
 security/landlock/net.c                       |  5 +-
 tools/testing/selftests/landlock/fs_test.c    | 28 ++++-----
 tools/testing/selftests/landlock/net_test.c   | 11 ++--
 tools/testing/selftests/landlock/trace.h      | 56 ++++++++---------
 .../selftests/landlock/trace_fs_test.c        | 54 +++++++++-------
 tools/testing/selftests/landlock/trace_test.c | 51 ++++++++-------
 9 files changed, 162 insertions(+), 137 deletions(-)

diff --git a/Documentation/trace/events-landlock.rst b/Documentation/trace/events-landlock.rst
index af9267cca47d..9bb81a5c676e 100644
--- a/Documentation/trace/events-landlock.rst
+++ b/Documentation/trace/events-landlock.rst
@@ -6,7 +6,7 @@ Landlock Trace Events
 =====================
 
 :Author: Mickaël Salaün
-:Date: August 2026
+:Date: September 2026
 
 Landlock emits trace events for sandbox lifecycle operations and access
 denials.  These events can be consumed by ftrace (for human-readable
@@ -31,8 +31,8 @@ Landlock trace events are organized in four categories:
 **Syscall events** are emitted during Landlock system calls:
 
 - ``landlock_create_ruleset``: a new ruleset is created
-- ``landlock_add_rule_fs``: a filesystem rule is added to a ruleset
-- ``landlock_add_rule_net``: a network port rule is added to a ruleset
+- ``landlock_add_rule_path_beneath``: a filesystem rule is added to a ruleset
+- ``landlock_add_rule_net_port``: a network port rule is added to a ruleset
 - ``landlock_create_domain``: a new domain is created from a ruleset
 - ``landlock_enforce_domain``: a domain is enforced on a thread
 
@@ -47,8 +47,8 @@ Landlock trace events are organized in four categories:
 
 **Rule evaluation events** are emitted during rule matching:
 
-- ``landlock_check_rule_fs``: a filesystem rule is evaluated
-- ``landlock_check_rule_net``: a network port rule is evaluated
+- ``landlock_check_rule_inode``: an inode-keyed rule is evaluated
+- ``landlock_check_rule_net_port``: a network-port-keyed rule is evaluated
 
 **Lifecycle events**:
 
@@ -189,7 +189,7 @@ rather than the caller's, so correlate those to the syscall by domain ID.
 Interpreting check_rule events
 ==============================
 
-The ``check_rule_fs`` and ``check_rule_net`` events expose the per-layer
+The ``check_rule_inode`` and ``check_rule_net_port`` events expose the per-layer
 rule evaluation, which is useful for understanding *why* a specific
 access is allowed or denied.
 
@@ -244,22 +244,22 @@ check.
 
 For example, a program sandboxed with read and execute access to the
 whole filesystem reads ``/etc/passwd``; both the ``execve()`` and the
-read match the rule covering ``/`` (inode 2), so ``check_rule_fs`` fires
+read match the rule covering ``/`` (inode 2), so ``check_rule_inode`` fires
 with the requested rights intersected against what that rule grants.
 The ``access_request=`` mask includes ``truncate`` because the file-open hook
 evaluates that optional right alongside the required access, but the
 rule does not grant it, so ``truncate`` never appears in ``grants=``::
 
-  cat-127 [...] landlock_check_rule_fs: domain=1e40cb56f access_request=execute|read_file|truncate dev=0:17 ino=2 grants={execute|read_file}
-  cat-127 [...] landlock_check_rule_fs: domain=1e40cb56f access_request=read_file|truncate dev=0:17 ino=2 grants={read_file}
+  cat-127 [...] landlock_check_rule_inode: domain=1e40cb56f access_request=execute|read_file|truncate dev=0:17 ino=2 grants={execute|read_file}
+  cat-127 [...] landlock_check_rule_inode: domain=1e40cb56f access_request=read_file|truncate dev=0:17 ino=2 grants={read_file}
 
 The ``[...]`` replaces the ftrace CPU, flags, and timestamp columns.  A
 single ``grants=`` group means the enforcing domain has one layer.  With
 two nested sandboxes that each grant the same rights, the rule spans both
 layers, so ``grants=`` has one group per layer::
 
-  cat-128 [...] landlock_check_rule_fs: domain=184788b52 access_request=execute|read_file|truncate dev=0:17 ino=2 grants={execute|read_file,execute|read_file}
-  cat-128 [...] landlock_check_rule_fs: domain=184788b52 access_request=read_file|truncate dev=0:17 ino=2 grants={read_file,read_file}
+  cat-128 [...] landlock_check_rule_inode: domain=184788b52 access_request=execute|read_file|truncate dev=0:17 ino=2 grants={execute|read_file,execute|read_file}
+  cat-128 [...] landlock_check_rule_inode: domain=184788b52 access_request=read_file|truncate dev=0:17 ino=2 grants={read_file,read_file}
 
 eBPF access
 ===========
diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index 4e304cab1dab..b7e6a6638822 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -28,6 +28,8 @@ struct path;
 struct sock;
 struct task_struct;
 
+static_assert(sizeof(access_mask_t) <= sizeof(u64));
+
 TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY);
 TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_FS_ACCESS);
 TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_NET_ACCESS);
@@ -114,7 +116,7 @@ __trace_print_untrusted_str(struct trace_seq *p, const char *src, size_t len)
  * Fills the dense per-domain-layer array layers (one access mask per layer,
  * indexed by level - 1) from rule's sparse layer stack, keeping only the
  * requested rights (access_request).  Layers with no matching rule entry get
- * a zero mask.  Shared by the check_rule_fs and check_rule_net events.
+ * a zero mask.  Shared by the check_rule_inode and check_rule_net_port events.
  *
  * rule->layers is sorted by ascending level, with levels in the domain's
  * [1, num_layers] range (see landlock_merge_ruleset()), so every entry maps
@@ -389,12 +391,14 @@ TRACE_EVENT(landlock_free_ruleset,
 );
 
 /**
- * landlock_add_rule_fs - Filesystem rule added to a ruleset
+ * landlock_add_rule_path_beneath - Path-beneath rule added to a ruleset
  *
  * @ruleset: Source ruleset (never NULL).
- * @access_rights: Effective access mask stored in the rule, not the raw
- *                 sys_landlock_add_rule() argument (unhandled rights
- *                 added).
+ * @flags: Complete validated landlock_add_rule_flags value supplied by this
+ *         successful call, not the rule's accumulated quiet state.
+ * @access_rights: Canonical per-call access mask passed to
+ *                 landlock_insert_rule() after normalization, not the raw
+ *                 sys_landlock_add_rule() argument or accumulated rule.
  * @path: Filesystem path for the rule (never NULL).
  * @pathname: Resolved absolute path string (never NULL; error placeholder
  *            on resolution failure).
@@ -403,13 +407,13 @@ TRACE_EVENT(landlock_free_ruleset,
  * the reported ruleset is a stable snapshot that no concurrent writer can
  * change.
  */
-TRACE_EVENT(landlock_add_rule_fs,
+TRACE_EVENT(landlock_add_rule_path_beneath,
 
-	TP_PROTO(const struct landlock_ruleset *ruleset,
-		 access_mask_t access_rights, const struct path *path,
+	TP_PROTO(const struct landlock_ruleset *ruleset, u32 flags,
+		 u64 access_rights, const struct path *path,
 		 const char *pathname),
 
-	TP_ARGS(ruleset, access_rights, path, pathname),
+	TP_ARGS(ruleset, flags, access_rights, path, pathname),
 
 	TP_STRUCT__entry(
 		__field(	u64,		ruleset_id	)
@@ -443,25 +447,27 @@ TRACE_EVENT(landlock_add_rule_fs,
 );
 
 /**
- * landlock_add_rule_net - Network port rule added to a ruleset
+ * landlock_add_rule_net_port - Network-port rule added to a ruleset
  *
  * @ruleset: Source ruleset (never NULL).
- * @access_rights: Effective access mask stored in the rule, not the raw
- *                 sys_landlock_add_rule() argument (unhandled rights
- *                 added).
- * @port: Network port, the landlock_net_port_attr.port UAPI value
- *        forwarded directly.
+ * @flags: Complete validated landlock_add_rule_flags value supplied by this
+ *         successful call, not the rule's accumulated quiet state.
+ * @access_rights: Canonical per-call access mask passed to
+ *                 landlock_insert_rule() after normalization, not the raw
+ *                 sys_landlock_add_rule() argument or accumulated rule.
+ * @port: Network port in host endianness, forwarded directly from
+ *        &landlock_net_port_attr.port.
  *
  * Emitted by sys_landlock_add_rule() under the modified ruleset's lock, so
  * the reported ruleset is a stable snapshot that no concurrent writer can
  * change.
  */
-TRACE_EVENT(landlock_add_rule_net,
+TRACE_EVENT(landlock_add_rule_net_port,
 
-	TP_PROTO(const struct landlock_ruleset *ruleset,
-		 access_mask_t access_rights, u64 port),
+	TP_PROTO(const struct landlock_ruleset *ruleset, u32 flags,
+		 u64 access_rights, u64 port),
 
-	TP_ARGS(ruleset, access_rights, port),
+	TP_ARGS(ruleset, flags, access_rights, port),
 
 	TP_STRUCT__entry(
 		__field(	u64,		ruleset_id	)
@@ -625,7 +631,7 @@ TRACE_EVENT(landlock_free_domain,
 );
 
 /**
- * landlock_check_rule_fs - Filesystem rule evaluated during access check
+ * landlock_check_rule_inode - Inode rule evaluated during access check
  *
  * @domain: Enforcing domain (never NULL).
  * @rule: Matching rule with per-layer access masks (never NULL).
@@ -638,11 +644,11 @@ TRACE_EVENT(landlock_free_domain,
  * domain layer.  See Documentation/trace/events-landlock.rst for how to
  * interpret it.
  */
-TRACE_EVENT(landlock_check_rule_fs,
+TRACE_EVENT(landlock_check_rule_inode,
 
 	TP_PROTO(const struct landlock_domain *domain,
 		 const struct landlock_rule *rule,
-		 access_mask_t access_request, const struct dentry *dentry),
+		 u64 access_request, const struct dentry *dentry),
 
 	TP_ARGS(domain, rule, access_request, dentry),
 
@@ -664,7 +670,8 @@ TRACE_EVENT(landlock_check_rule_fs,
 		__trace_landlock_fill_layers(__get_dynamic_array(grants),
 					     __get_dynamic_array_len(grants) /
 						     sizeof(access_mask_t),
-					     rule, access_request);
+					     rule,
+					     (access_mask_t)access_request);
 	),
 
 	TP_printk("domain=%llx access_request=%s dev=%u:%u ino=%lu grants=%s",
@@ -675,7 +682,7 @@ TRACE_EVENT(landlock_check_rule_fs,
 );
 
 /**
- * landlock_check_rule_net - Network port rule evaluated during access check
+ * landlock_check_rule_net_port - Network port rule evaluated
  *
  * @domain: Enforcing domain (never NULL).
  * @rule: Matching rule with per-layer access masks (never NULL).
@@ -687,11 +694,11 @@ TRACE_EVENT(landlock_check_rule_fs,
  * layer.  See Documentation/trace/events-landlock.rst for how to
  * interpret it.
  */
-TRACE_EVENT(landlock_check_rule_net,
+TRACE_EVENT(landlock_check_rule_net_port,
 
 	TP_PROTO(const struct landlock_domain *domain,
 		 const struct landlock_rule *rule,
-		 access_mask_t access_request, u64 port),
+		 u64 access_request, u64 port),
 
 	TP_ARGS(domain, rule, access_request, port),
 
@@ -711,7 +718,8 @@ TRACE_EVENT(landlock_check_rule_net,
 		__trace_landlock_fill_layers(__get_dynamic_array(grants),
 					     __get_dynamic_array_len(grants) /
 						     sizeof(access_mask_t),
-					     rule, access_request);
+					     rule,
+					     (access_mask_t)access_request);
 	),
 
 	TP_printk("domain=%llx access_request=%s port=%llu grants=%s",
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 330a1871bf94..cab43892ec2f 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -356,14 +356,14 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 	 * held for BTF consistency (enforced by lockdep_assert_held in
 	 * TP_fast_assign).
 	 */
-	if (!err && trace_landlock_add_rule_fs_enabled()) {
+	if (!err && trace_landlock_add_rule_path_beneath_enabled()) {
 		char *buffer __free(__putname) = __getname();
 		const char *pathname =
 			buffer ? resolve_path_for_trace(path, buffer) :
 				 "<no_mem>";
 
-		trace_landlock_add_rule_fs(ruleset, access_rights, path,
-					   pathname);
+		trace_landlock_add_rule_path_beneath(
+			ruleset, flags, access_rights, path, pathname);
 	}
 	mutex_unlock(&ruleset->lock);
 
@@ -423,8 +423,8 @@ static bool unmask_layers_fs(const struct landlock_domain *const domain,
 
 	ret = landlock_unmask_layers(domain, id, masks, &rule);
 	if (rule)
-		trace_landlock_check_rule_fs(domain, rule, access_request,
-					     dentry);
+		trace_landlock_check_rule_inode(domain, rule, access_request,
+						dentry);
 	return ret;
 }
 
diff --git a/security/landlock/net.c b/security/landlock/net.c
index 8f2aaac54b33..5552c60388f8 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -47,7 +47,8 @@ int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
 	 * TP_fast_assign).
 	 */
 	if (!err)
-		trace_landlock_add_rule_net(ruleset, access_rights, port);
+		trace_landlock_add_rule_net_port(ruleset, flags, access_rights,
+						 port);
 	mutex_unlock(&ruleset->lock);
 
 	return err;
@@ -63,7 +64,7 @@ static bool unmask_layers_net(const struct landlock_domain *const domain,
 
 	ret = landlock_unmask_layers(domain, id, masks, &rule);
 	if (rule)
-		trace_landlock_check_rule_net(
+		trace_landlock_check_rule_net_port(
 			domain, rule, access_request,
 			ntohs((__force __be16)id.key.data));
 	return ret;
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 18dbdb99aeba..6e979cef884d 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -10493,9 +10493,9 @@ FIXTURE_TEARDOWN_PARENT(trace_layout1)
 }
 
 /*
- * Verifies that check_rule_fs events include correct field values: domain, dev,
- * ino, access_request, and grants.  All values are verified against stat() of
- * the rule path on a deterministic tmpfs layout.
+ * Verifies that check_rule_inode events include correct field values: domain,
+ * dev, ino, access_request, and grants.  All values are verified against stat()
+ * of the rule path on a deterministic tmpfs layout.
  */
 TEST_F(trace_layout1, check_rule_fs_fields)
 {
@@ -10529,7 +10529,7 @@ TEST_F(trace_layout1, check_rule_fs_fields)
 	EXPECT_EQ(1,
 		  tracefs_count_matches(buf, REGEX_CHECK_RULE_FS(TRACE_TASK)))
 	{
-		TH_LOG("Expected 1 check_rule_fs event\n%s", buf);
+		TH_LOG("Expected 1 check_rule_inode event\n%s", buf);
 	}
 
 	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_CHECK_RULE_FS(TRACE_TASK),
@@ -10570,8 +10570,8 @@ TEST_F(trace_layout1, check_rule_fs_fields)
 }
 
 /*
- * Verifies check_rule_fs behavior with multiple rules.  With rules at s1d1 and
- * s1d2 (a child of s1d1), accessing s1d2 produces only 1 event because the
+ * Verifies check_rule_inode behavior with multiple rules.  With rules at s1d1
+ * and s1d2 (a child of s1d1), accessing s1d2 produces only 1 event because the
  * pathwalk short-circuits after the first rule fully unmasks the single layer.
  */
 TEST_F(trace_layout1, check_rule_fs_multiple_rules)
@@ -10643,14 +10643,14 @@ TEST_F(trace_layout1, check_rule_fs_multiple_rules)
 	ASSERT_NE(NULL, buf);
 
 	/*
-	 * Only 1 check_rule_fs event: the rule on dir_s1d2 fully unmasked the
-	 * single layer, so the pathwalk short-circuits before reaching the
+	 * Only one check_rule_inode event: the rule on dir_s1d2 fully unmasks
+	 * the single layer, so the pathwalk short-circuits before reaching the
 	 * dir_s1d1 rule.
 	 */
 	count = tracefs_count_matches(buf, REGEX_CHECK_RULE_FS(TRACE_TASK));
 	EXPECT_EQ(1, count)
 	{
-		TH_LOG("Expected 1 check_rule_fs event, got %d\n%s", count,
+		TH_LOG("Expected 1 check_rule_inode event, got %d\n%s", count,
 		       buf);
 	}
 
@@ -10777,7 +10777,7 @@ TEST_F(trace_layout1, check_rule_fs_optional_access)
 	count = tracefs_count_matches(buf, REGEX_CHECK_RULE_FS(TRACE_TASK));
 	EXPECT_EQ(1, count)
 	{
-		TH_LOG("Expected 1 check_rule_fs event, got %d\n%s", count,
+		TH_LOG("Expected 1 check_rule_inode event, got %d\n%s", count,
 		       buf);
 	}
 
@@ -10796,7 +10796,7 @@ TEST_F(trace_layout1, check_rule_fs_optional_access)
 }
 
 /*
- * Verifies that check_rule_fs fires for a rule that matches the inode even when
+ * Verifies that check_rule_inode fires for a rule matching the inode even when
  * it grants none of the requested rights, so the grants set is empty.  Landlock
  * cannot know a rule ignores the request before reading it, so the event is
  * still emitted (grants={}), which lets a tracer see that the rule matched.
@@ -10884,7 +10884,7 @@ TEST_F(trace_layout1, check_rule_fs_empty_grant)
 	count = tracefs_count_matches(buf, REGEX_CHECK_RULE_FS(TRACE_TASK));
 	EXPECT_EQ(2, count)
 	{
-		TH_LOG("Expected 2 check_rule_fs events, got %d\n%s", count,
+		TH_LOG("Expected 2 check_rule_inode events, got %d\n%s", count,
 		       buf);
 	}
 
@@ -10894,7 +10894,7 @@ TEST_F(trace_layout1, check_rule_fs_empty_grant)
 		tracefs_count_matches(
 			buf,
 			TRACE_PREFIX(
-				TRACE_TASK) "landlock_check_rule_fs: domain=[0-9a-f]\\+ "
+				TRACE_TASK) "landlock_check_rule_inode: domain=[0-9a-f]\\+ "
 					    "access_request=read_dir "
 					    "dev=[0-9]\\+:[0-9]\\+ ino=[0-9]\\+ "
 					    "grants={}$"))
@@ -10908,7 +10908,7 @@ TEST_F(trace_layout1, check_rule_fs_empty_grant)
 		tracefs_count_matches(
 			buf,
 			TRACE_PREFIX(
-				TRACE_TASK) "landlock_check_rule_fs: domain=[0-9a-f]\\+ "
+				TRACE_TASK) "landlock_check_rule_inode: domain=[0-9a-f]\\+ "
 					    "access_request=read_dir "
 					    "dev=[0-9]\\+:[0-9]\\+ ino=[0-9]\\+ "
 					    "grants={read_dir}$"))
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index a18761e0fd82..4fb705e1596d 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -3712,7 +3712,7 @@ TEST_F(trace_net_connect, deny_access_net)
 	free(buf);
 }
 
-/* Field verification for the check_rule_net event on an allowed access. */
+/* Field verification for the check_rule_net_port event on an allowed access. */
 
 /* clang-format off */
 FIXTURE(trace_net_check_rule) {
@@ -3757,10 +3757,11 @@ FIXTURE_TEARDOWN(trace_net_check_rule)
 
 /*
  * Verifies that an allowed bind matching a net-port rule emits exactly one
- * landlock_check_rule_net event with the enforcing domain, the requested
+ * landlock_check_rule_net_port event with the enforcing domain, the requested
  * access, the checked port (host endianness), and the per-layer grants.  The
- * whole event is anchored to exact values so a revert of the check_rule_net
- * emit (or a byte-order or field-plumbing regression) fails the test.
+ * whole event is anchored to exact values so removing the check_rule_net_port
+ * emission or introducing a byte-order or field-plumbing regression fails the
+ * test.
  */
 TEST_F(trace_net_check_rule, check_rule_net_fields)
 {
@@ -3832,7 +3833,7 @@ TEST_F(trace_net_check_rule, check_rule_net_fields)
 	EXPECT_EQ(1,
 		  tracefs_count_matches(buf, REGEX_CHECK_RULE_NET(TRACE_TASK)))
 	{
-		TH_LOG("Expected 1 check_rule_net event\n%s", buf);
+		TH_LOG("Expected 1 check_rule_net_port event\n%s", buf);
 	}
 
 	ASSERT_EQ(0,
diff --git a/tools/testing/selftests/landlock/trace.h b/tools/testing/selftests/landlock/trace.h
index ba0c5e92001f..e6873853376c 100644
--- a/tools/testing/selftests/landlock/trace.h
+++ b/tools/testing/selftests/landlock/trace.h
@@ -27,14 +27,14 @@
 	TRACEFS_LANDLOCK_DIR "/landlock_create_domain/enable"
 #define TRACEFS_ENFORCE_DOMAIN_ENABLE \
 	TRACEFS_LANDLOCK_DIR "/landlock_enforce_domain/enable"
-#define TRACEFS_ADD_RULE_FS_ENABLE \
-	TRACEFS_LANDLOCK_DIR "/landlock_add_rule_fs/enable"
-#define TRACEFS_ADD_RULE_NET_ENABLE \
-	TRACEFS_LANDLOCK_DIR "/landlock_add_rule_net/enable"
+#define TRACEFS_ADD_RULE_PATH_BENEATH_ENABLE \
+	TRACEFS_LANDLOCK_DIR "/landlock_add_rule_path_beneath/enable"
+#define TRACEFS_ADD_RULE_NET_PORT_ENABLE \
+	TRACEFS_LANDLOCK_DIR "/landlock_add_rule_net_port/enable"
 #define TRACEFS_CHECK_RULE_FS_ENABLE \
-	TRACEFS_LANDLOCK_DIR "/landlock_check_rule_fs/enable"
+	TRACEFS_LANDLOCK_DIR "/landlock_check_rule_inode/enable"
 #define TRACEFS_CHECK_RULE_NET_ENABLE \
-	TRACEFS_LANDLOCK_DIR "/landlock_check_rule_net/enable"
+	TRACEFS_LANDLOCK_DIR "/landlock_check_rule_net_port/enable"
 #define TRACEFS_DENY_ACCESS_FS_ENABLE \
 	TRACEFS_LANDLOCK_DIR "/landlock_deny_access_fs/enable"
 #define TRACEFS_DENY_ACCESS_NET_ENABLE \
@@ -79,18 +79,18 @@
  */
 #define KWORKER_TASK "kworker/[0-9]\\+:[0-9]\\+"
 
-#define REGEX_ADD_RULE_FS(task)           \
-	TRACE_PREFIX(task)                \
-	"landlock_add_rule_fs: "          \
-	"ruleset=[0-9a-f]\\+\\.[0-9]\\+ " \
-	"access_rights=[a-z_|]* "         \
-	"dev=[0-9]\\+:[0-9]\\+ "          \
-	"ino=[0-9]\\+ "                   \
+#define REGEX_ADD_RULE_PATH_BENEATH(task)  \
+	TRACE_PREFIX(task)                 \
+	"landlock_add_rule_path_beneath: " \
+	"ruleset=[0-9a-f]\\+\\.[0-9]\\+ "  \
+	"access_rights=[a-z_|]* "          \
+	"dev=[0-9]\\+:[0-9]\\+ "           \
+	"ino=[0-9]\\+ "                    \
 	"path=[^ ]\\+$"
 
-#define REGEX_ADD_RULE_NET(task)          \
+#define REGEX_ADD_RULE_NET_PORT(task)     \
 	TRACE_PREFIX(task)                \
-	"landlock_add_rule_net: "         \
+	"landlock_add_rule_net_port: "    \
 	"ruleset=[0-9a-f]\\+\\.[0-9]\\+ " \
 	"access_rights=[a-z_|]* "         \
 	"port=[0-9]\\+$"
@@ -110,21 +110,21 @@
 	"parent=[0-9a-f]\\+ "      \
 	"ruleset=[0-9a-f]\\+\\.[0-9]\\+$"
 
-#define REGEX_CHECK_RULE_FS(task)  \
-	TRACE_PREFIX(task)         \
-	"landlock_check_rule_fs: " \
-	"domain=[0-9a-f]\\+ "      \
-	"access_request=[a-z_|]* " \
-	"dev=[0-9]\\+:[0-9]\\+ "   \
-	"ino=[0-9]\\+ "            \
+#define REGEX_CHECK_RULE_FS(task)     \
+	TRACE_PREFIX(task)            \
+	"landlock_check_rule_inode: " \
+	"domain=[0-9a-f]\\+ "         \
+	"access_request=[a-z_|]* "    \
+	"dev=[0-9]\\+:[0-9]\\+ "      \
+	"ino=[0-9]\\+ "               \
 	"grants={[a-z_|,]*}$"
 
-#define REGEX_CHECK_RULE_NET(task)  \
-	TRACE_PREFIX(task)          \
-	"landlock_check_rule_net: " \
-	"domain=[0-9a-f]\\+ "       \
-	"access_request=[a-z_|]* "  \
-	"port=[0-9]\\+ "            \
+#define REGEX_CHECK_RULE_NET(task)       \
+	TRACE_PREFIX(task)               \
+	"landlock_check_rule_net_port: " \
+	"domain=[0-9a-f]\\+ "            \
+	"access_request=[a-z_|]* "       \
+	"port=[0-9]\\+ "                 \
 	"grants={[a-z_|,]*}$"
 
 #define REGEX_DENY_ACCESS_FS(task)  \
diff --git a/tools/testing/selftests/landlock/trace_fs_test.c b/tools/testing/selftests/landlock/trace_fs_test.c
index 4543a25c1f55..6666d4746cb1 100644
--- a/tools/testing/selftests/landlock/trace_fs_test.c
+++ b/tools/testing/selftests/landlock/trace_fs_test.c
@@ -121,7 +121,8 @@ FIXTURE_SETUP(trace_fs)
 	}
 	self->tracefs_ok = 1;
 
-	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_ADD_RULE_FS_ENABLE, true));
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_ADD_RULE_PATH_BENEATH_ENABLE,
+					  true));
 	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_CHECK_RULE_FS_ENABLE, true));
 	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_DENY_ACCESS_FS_ENABLE, true));
 	ASSERT_EQ(0, tracefs_clear());
@@ -134,7 +135,7 @@ FIXTURE_TEARDOWN(trace_fs)
 		return;
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	tracefs_enable_event(TRACEFS_ADD_RULE_FS_ENABLE, false);
+	tracefs_enable_event(TRACEFS_ADD_RULE_PATH_BENEATH_ENABLE, false);
 	tracefs_enable_event(TRACEFS_CHECK_RULE_FS_ENABLE, false);
 	tracefs_enable_event(TRACEFS_DENY_ACCESS_FS_ENABLE, false);
 	tracefs_fixture_teardown();
@@ -183,11 +184,11 @@ TEST_F(trace_fs, unsandboxed)
 }
 
 /*
- * Verifies that adding a filesystem rule emits a landlock_add_rule_fs trace
- * event with the expected path and field values: ruleset ID is non-zero,
- * access_rights is non-zero, and path matches.
+ * Verifies that adding a filesystem rule emits a landlock_add_rule_path_beneath
+ * event with the expected path and field values: the ruleset ID and
+ * access_rights are non-zero, and the path matches.
  */
-TEST_F(trace_fs, add_rule_fs)
+TEST_F(trace_fs, add_rule_path_beneath)
 {
 	struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE |
@@ -215,28 +216,30 @@ TEST_F(trace_fs, add_rule_fs)
 	buf = tracefs_read_buf();
 	ASSERT_NE(NULL, buf);
 
-	count = tracefs_count_matches(buf, REGEX_ADD_RULE_FS(TRACE_TASK));
+	count = tracefs_count_matches(buf,
+				      REGEX_ADD_RULE_PATH_BENEATH(TRACE_TASK));
 	EXPECT_EQ(1, count)
 	{
-		TH_LOG("Expected 1 add_rule_fs event, got %d\n%s", count, buf);
+		TH_LOG("Expected 1 add_rule_path_beneath event, got %d\n%s",
+		       count, buf);
 	}
 
 	/* Ruleset ID should be non-zero. */
-	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_ADD_RULE_FS(TRACE_TASK),
-					   "ruleset", field_buf,
-					   sizeof(field_buf)));
+	ASSERT_EQ(0, tracefs_extract_field(
+			     buf, REGEX_ADD_RULE_PATH_BENEATH(TRACE_TASK),
+			     "ruleset", field_buf, sizeof(field_buf)));
 	EXPECT_STRNE("0", field_buf);
 
 	/* Access rights should be non-zero. */
-	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_ADD_RULE_FS(TRACE_TASK),
-					   "access_rights", field_buf,
-					   sizeof(field_buf)));
+	ASSERT_EQ(0, tracefs_extract_field(
+			     buf, REGEX_ADD_RULE_PATH_BENEATH(TRACE_TASK),
+			     "access_rights", field_buf, sizeof(field_buf)));
 	EXPECT_STRNE("", field_buf);
 
 	/* Path should be /usr. */
-	ASSERT_EQ(0,
-		  tracefs_extract_field(buf, REGEX_ADD_RULE_FS(TRACE_TASK),
-					"path", field_buf, sizeof(field_buf)));
+	ASSERT_EQ(0, tracefs_extract_field(
+			     buf, REGEX_ADD_RULE_PATH_BENEATH(TRACE_TASK),
+			     "path", field_buf, sizeof(field_buf)));
 	EXPECT_STREQ("/usr", field_buf);
 
 	free(buf);
@@ -246,7 +249,7 @@ TEST_F(trace_fs, add_rule_fs)
  * Verifies that a path whose escaping exceeds the trace scratch sequence does
  * not corrupt a sibling symbolic field.
  */
-TEST_F(trace_fs, add_rule_fs_escaped_path_overflow)
+TEST_F(trace_fs, add_rule_path_beneath_escaped_path_overflow)
 {
 	static const char access_prefix[] = "execute|write_file|read_file|";
 	static const char access_suffix[] = "|ioctl_dev|resolve_unix";
@@ -277,10 +280,12 @@ TEST_F(trace_fs, add_rule_fs_escaped_path_overflow)
 	buf = tracefs_read_buf();
 	ASSERT_NE(NULL, buf);
 
-	count = tracefs_count_matches(buf, REGEX_ADD_RULE_FS(TRACE_TASK));
+	count = tracefs_count_matches(buf,
+				      REGEX_ADD_RULE_PATH_BENEATH(TRACE_TASK));
 	EXPECT_EQ(1, count)
 	{
-		TH_LOG("Expected 1 add_rule_fs event, got %d\n%s", count, buf);
+		TH_LOG("Expected 1 add_rule_path_beneath event, got %d\n%s",
+		       count, buf);
 	}
 
 	/*
@@ -288,9 +293,9 @@ TEST_F(trace_fs, add_rule_fs_escaped_path_overflow)
 	 * field also catches scratch-sequence poisoning when the compiler
 	 * evaluates the overflowing path first, as GCC currently does.
 	 */
-	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_ADD_RULE_FS(TRACE_TASK),
-					   "access_rights", field_buf,
-					   sizeof(field_buf)));
+	ASSERT_EQ(0, tracefs_extract_field(
+			     buf, REGEX_ADD_RULE_PATH_BENEATH(TRACE_TASK),
+			     "access_rights", field_buf, sizeof(field_buf)));
 	EXPECT_EQ(0,
 		  strncmp(field_buf, access_prefix, sizeof(access_prefix) - 1));
 	EXPECT_EQ(NULL, strstr(field_buf, "|refer|"));
@@ -298,7 +303,8 @@ TEST_F(trace_fs, add_rule_fs_escaped_path_overflow)
 	ASSERT_LE(sizeof(access_suffix) - 1, field_len);
 	EXPECT_STREQ(access_suffix,
 		     field_buf + field_len - (sizeof(access_suffix) - 1));
-	expect_truncated_path(_metadata, buf, REGEX_ADD_RULE_FS(TRACE_TASK));
+	expect_truncated_path(_metadata, buf,
+			      REGEX_ADD_RULE_PATH_BENEATH(TRACE_TASK));
 
 	free(buf);
 }
diff --git a/tools/testing/selftests/landlock/trace_test.c b/tools/testing/selftests/landlock/trace_test.c
index afdaf8511b3a..f9b293a9dd56 100644
--- a/tools/testing/selftests/landlock/trace_test.c
+++ b/tools/testing/selftests/landlock/trace_test.c
@@ -49,8 +49,10 @@ FIXTURE_SETUP(trace)
 	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_CREATE_RULESET_ENABLE, true));
 	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_CREATE_DOMAIN_ENABLE, true));
 	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_ENFORCE_DOMAIN_ENABLE, true));
-	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_ADD_RULE_FS_ENABLE, true));
-	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_ADD_RULE_NET_ENABLE, true));
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_ADD_RULE_PATH_BENEATH_ENABLE,
+					  true));
+	ASSERT_EQ(0,
+		  tracefs_enable_event(TRACEFS_ADD_RULE_NET_PORT_ENABLE, true));
 	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_CHECK_RULE_FS_ENABLE, true));
 	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_CHECK_RULE_NET_ENABLE, true));
 	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_DENY_ACCESS_FS_ENABLE, true));
@@ -72,8 +74,8 @@ FIXTURE_TEARDOWN(trace)
 	tracefs_enable_event(TRACEFS_CREATE_RULESET_ENABLE, false);
 	tracefs_enable_event(TRACEFS_CREATE_DOMAIN_ENABLE, false);
 	tracefs_enable_event(TRACEFS_ENFORCE_DOMAIN_ENABLE, false);
-	tracefs_enable_event(TRACEFS_ADD_RULE_FS_ENABLE, false);
-	tracefs_enable_event(TRACEFS_ADD_RULE_NET_ENABLE, false);
+	tracefs_enable_event(TRACEFS_ADD_RULE_PATH_BENEATH_ENABLE, false);
+	tracefs_enable_event(TRACEFS_ADD_RULE_NET_PORT_ENABLE, false);
 	tracefs_enable_event(TRACEFS_CHECK_RULE_FS_ENABLE, false);
 	tracefs_enable_event(TRACEFS_CHECK_RULE_NET_ENABLE, false);
 	tracefs_enable_event(TRACEFS_DENY_ACCESS_FS_ENABLE, false);
@@ -103,8 +105,10 @@ TEST_F(trace, no_trace_when_disabled)
 	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_CREATE_DOMAIN_ENABLE, false));
 	ASSERT_EQ(0,
 		  tracefs_enable_event(TRACEFS_ENFORCE_DOMAIN_ENABLE, false));
-	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_ADD_RULE_FS_ENABLE, false));
-	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_ADD_RULE_NET_ENABLE, false));
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_ADD_RULE_PATH_BENEATH_ENABLE,
+					  false));
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_ADD_RULE_NET_PORT_ENABLE,
+					  false));
 	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_CHECK_RULE_FS_ENABLE, false));
 	ASSERT_EQ(0,
 		  tracefs_enable_event(TRACEFS_CHECK_RULE_NET_ENABLE, false));
@@ -265,10 +269,11 @@ TEST_F(trace, ruleset_version)
 	ASSERT_NE(0, !!dot);
 	EXPECT_STREQ("0", dot + 1);
 
-	/* Verify 2 add_rule_fs events were emitted. */
-	EXPECT_EQ(2, tracefs_count_matches(buf, REGEX_ADD_RULE_FS(TRACE_TASK)))
+	/* Verify two add_rule_path_beneath events were emitted. */
+	EXPECT_EQ(2, tracefs_count_matches(
+			     buf, REGEX_ADD_RULE_PATH_BENEATH(TRACE_TASK)))
 	{
-		TH_LOG("Expected 2 add_rule_fs events\n%s", buf);
+		TH_LOG("Expected 2 add_rule_path_beneath events\n%s", buf);
 	}
 
 	/*
@@ -373,7 +378,7 @@ TEST_F(trace, create_domain)
 		tracefs_count_matches(buf, REGEX_CHECK_RULE_FS(TRACE_TASK));
 	ASSERT_LE(1, check_count)
 	{
-		TH_LOG("Expected check_rule_fs events\n%s", buf);
+		TH_LOG("Expected check_rule_inode events\n%s", buf);
 	}
 
 	EXPECT_EQ(0, tracefs_extract_field(buf, REGEX_CHECK_RULE_FS(TRACE_TASK),
@@ -508,9 +513,11 @@ TEST_F(trace, add_rule_invalid_fd)
 	buf = tracefs_read_buf();
 	ASSERT_NE(NULL, buf);
 
-	EXPECT_EQ(0, tracefs_count_matches(buf, REGEX_ADD_RULE_FS(TRACE_TASK)))
+	EXPECT_EQ(0, tracefs_count_matches(
+			     buf, REGEX_ADD_RULE_PATH_BENEATH(TRACE_TASK)))
 	{
-		TH_LOG("No add_rule_fs event expected on invalid fd\n%s", buf);
+		TH_LOG("No add_rule_path_beneath event expected on invalid fd\n%s",
+		       buf);
 	}
 
 	free(buf);
@@ -902,10 +909,10 @@ TEST_F(trace, non_audit_visible_denial_counting)
 }
 
 /*
- * Verifies that landlock_add_rule_net emits a trace event with the correct port
- * and allowed access mask fields.
+ * Verifies that landlock_add_rule_net_port emits a trace event with the correct
+ * port and allowed access mask fields.
  */
-TEST_F(trace, add_rule_net_fields)
+TEST_F(trace, add_rule_net_port_fields)
 {
 	struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
@@ -931,9 +938,10 @@ TEST_F(trace, add_rule_net_fields)
 	buf = tracefs_read_buf();
 	ASSERT_NE(NULL, buf);
 
-	EXPECT_EQ(1, tracefs_count_matches(buf, REGEX_ADD_RULE_NET(TRACE_TASK)))
+	EXPECT_EQ(1, tracefs_count_matches(buf,
+					   REGEX_ADD_RULE_NET_PORT(TRACE_TASK)))
 	{
-		TH_LOG("Expected 1 add_rule_net event\n%s", buf);
+		TH_LOG("Expected 1 add_rule_net_port event\n%s", buf);
 	}
 
 	/*
@@ -941,7 +949,8 @@ TEST_F(trace, add_rule_net_fields)
 	 * (landlock_net_port_attr.port).  On little-endian, htons(8080) is
 	 * 36895, so this comparison catches byte-order bugs.
 	 */
-	EXPECT_EQ(0, tracefs_extract_field(buf, REGEX_ADD_RULE_NET(TRACE_TASK),
+	EXPECT_EQ(0, tracefs_extract_field(buf,
+					   REGEX_ADD_RULE_NET_PORT(TRACE_TASK),
 					   "port", field, sizeof(field)));
 	EXPECT_STREQ("8080", field);
 	/*
@@ -950,9 +959,9 @@ TEST_F(trace, add_rule_net_fields)
 	 * net access bits are unhandled because the ruleset only handles
 	 * BIND_TCP).
 	 */
-	EXPECT_EQ(0,
-		  tracefs_extract_field(buf, REGEX_ADD_RULE_NET(TRACE_TASK),
-					"access_rights", field, sizeof(field)));
+	EXPECT_EQ(0, tracefs_extract_field(
+			     buf, REGEX_ADD_RULE_NET_PORT(TRACE_TASK),
+			     "access_rights", field, sizeof(field)));
 	EXPECT_STREQ("bind_tcp|connect_tcp|bind_udp|connect_send_udp", field);
 
 	free(buf);
-- 
2.55.0

