Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E28376BD1
	for <linux-security-module@vger.kernel.org>; Wed,  4 Mar 2026 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652720; cv=none; b=Z24KurdFP+TPqElytJUarpWaE04J9o/viiu3OSyZ5sXfFLqBGkQk8yzD/mnpQw+aLTXtx/ZTy/w/xUPQ1uyZSyeWbdfMDkAZjynizaa6QyHZ3xyYej1SYuzRvw/B+hQyCHbms0gykvENw/GkMwes8kFDPX4eunzu2gxFiMWiO+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652720; c=relaxed/simple;
	bh=YOmJO8CoUbHBMhX4HitFMc2z7F50vMzmRuwX9ARc0cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3i6TI0KB+DFH/spQIrTOI8HZ5ZHVEWEYTKPoym0g3/L6u8emDsr4QdNANt8bDksor7uN6k1eFTftqd5UdElb8I3hiLFwrb+zxZ/vy5NDP5UBkEWvXqs7+K/+4mKdRJp26mDtA2nRk5xFnA6k14uFUGTa7yz2F9ikWGJAqRfMm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=iNkGslL1; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="iNkGslL1"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fR2q93PbpzYVd;
	Wed,  4 Mar 2026 20:31:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1772652709;
	bh=4sbd0AqvNtwuKiDIp9rxKIHqOcMYN8fUJ1l3+ny1Uco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iNkGslL1fOH+/Ci/tbKD2jEALx4iAqGesa/TYU5Mp9enVLOa1fAeV3lJXs2py+tsx
	 RFmH6EOPUIRGEVRNmPrOrDRu90TW/IDxpVW0gGPwLlXf9b5cR1W4/yenAXBKQiQUOk
	 lOCX604WDcyAjQ+YfdFnO89aSaIKL+4Z0FVtl/VU=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fR2q90jgtzRTY;
	Wed,  4 Mar 2026 20:31:49 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v1 2/4] landlock: Add missing kernel-doc "Return:" sections
Date: Wed,  4 Mar 2026 20:31:25 +0100
Message-ID: <20260304193134.250495-2-mic@digikod.net>
In-Reply-To: <20260304193134.250495-1-mic@digikod.net>
References: <20260304193134.250495-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

The kernel-doc -Wreturn check warns about functions with documentation
comments that lack a "Return:" section.  Add "Return:" documentation to
all functions missing it so that kernel-doc -Wreturn passes cleanly.

Convert existing function descriptions into a formal "Return:" section.
Also fix the inaccurate return documentation for
landlock_merge_ruleset() which claimed to return @parent directly, and
document the previously missing ERR_PTR() error return path.  Document
the ABI version and errata return paths for landlock_create_ruleset()
which were previously only implied by the prose.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/domain.c   |  2 ++
 security/landlock/fs.c       |  2 +-
 security/landlock/ruleset.c  |  8 +++++---
 security/landlock/syscalls.c | 17 +++++++++++------
 security/landlock/task.c     |  9 +++++----
 5 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 79cb3bbdf4c5..343a1aabaac6 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -115,6 +115,8 @@ static struct landlock_details *get_current_details(void)
  * restriction.  The subjective credentials must not be in an overridden state.
  *
  * @hierarchy->parent and @hierarchy->usage should already be set.
+ *
+ * Return: 0 on success, -errno on failure.
  */
 int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy)
 {
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index e764470f588c..cfe69075bf4e 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1568,7 +1568,7 @@ static int hook_path_truncate(const struct path *const path)
  *
  * @file: File being opened.
  *
- * Returns the access rights that are required for opening the given file,
+ * Return: The access rights that are required for opening the given file,
  * depending on the file type and open mode.
  */
 static access_mask_t
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index a61ced492f41..de8386af2f30 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -202,6 +202,8 @@ static void build_check_ruleset(void)
  * When merging a ruleset in a domain, or copying a domain, @layers will be
  * added to @ruleset as new constraints, similarly to a boolean AND between
  * access rights.
+ *
+ * Return: 0 on success, -errno on failure.
  */
 static int insert_rule(struct landlock_ruleset *const ruleset,
 		       const struct landlock_id id,
@@ -531,8 +533,8 @@ void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
  * The current task is requesting to be restricted.  The subjective credentials
  * must not be in an overridden state. cf. landlock_init_hierarchy_log().
  *
- * Returns the intersection of @parent and @ruleset, or returns @parent if
- * @ruleset is empty, or returns a duplicate of @ruleset if @parent is empty.
+ * Return: A new domain merging @parent and @ruleset on success, or ERR_PTR()
+ * on failure.  If @parent is NULL, the new domain duplicates @ruleset.
  */
 struct landlock_ruleset *
 landlock_merge_ruleset(struct landlock_ruleset *const parent,
@@ -623,7 +625,7 @@ landlock_find_rule(const struct landlock_ruleset *const ruleset,
  * @rule: A rule that grants a set of access rights for each layer
  * @masks: A matrix of unfulfilled access rights for each layer
  *
- * Returns true if the request is allowed (i.e. the access rights granted all
+ * Return: True if the request is allowed (i.e. the access rights granted all
  * remaining unfulfilled access rights and masks has no leftover set bits).
  */
 bool landlock_unmask_layers(const struct landlock_rule *const rule,
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 0d66a68677b7..3b33839b80c7 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -60,6 +60,8 @@ static bool is_initialized(void)
  * @ksize_min: Minimal required size to be copied.
  * @src: User space pointer or NULL.
  * @usize: (Alleged) size of the data pointed to by @src.
+ *
+ * Return: 0 on success, -errno on failure.
  */
 static __always_inline int
 copy_min_struct_from_user(void *const dst, const size_t ksize,
@@ -178,16 +180,19 @@ const int landlock_abi_version = 8;
  *         - %LANDLOCK_CREATE_RULESET_VERSION
  *         - %LANDLOCK_CREATE_RULESET_ERRATA
  *
- * This system call enables to create a new Landlock ruleset, and returns the
- * related file descriptor on success.
+ * This system call enables to create a new Landlock ruleset.
  *
  * If %LANDLOCK_CREATE_RULESET_VERSION or %LANDLOCK_CREATE_RULESET_ERRATA is
  * set, then @attr must be NULL and @size must be 0.
  *
- * Possible returned errors are:
+ * Return: The ruleset file descriptor on success, the Landlock ABI version if
+ * %LANDLOCK_CREATE_RULESET_VERSION is set, the errata value if
+ * %LANDLOCK_CREATE_RULESET_ERRATA is set, or -errno on failure.  Possible
+ * returned errors are:
  *
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
- * - %EINVAL: unknown @flags, or unknown access, or unknown scope, or too small @size;
+ * - %EINVAL: unknown @flags, or unknown access, or unknown scope, or too small
+ *   @size;
  * - %E2BIG: @attr or @size inconsistencies;
  * - %EFAULT: @attr or @size inconsistencies;
  * - %ENOMSG: empty &landlock_ruleset_attr.handled_access_fs.
@@ -398,7 +403,7 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
  * This system call enables to define a new rule and add it to an existing
  * ruleset.
  *
- * Possible returned errors are:
+ * Return: 0 on success, or -errno on failure.  Possible returned errors are:
  *
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
  * - %EAFNOSUPPORT: @rule_type is %LANDLOCK_RULE_NET_PORT but TCP/IP is not
@@ -464,7 +469,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
  * namespace or is running with no_new_privs.  This avoids scenarios where
  * unprivileged tasks can affect the behavior of privileged children.
  *
- * Possible returned errors are:
+ * Return: 0 on success, or -errno on failure.  Possible returned errors are:
  *
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
  * - %EINVAL: @flags contains an unknown bit.
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 833bc0cfe5c9..bf7c3db7ce46 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -37,6 +37,9 @@
  *
  * Checks if the @parent domain is less or equal to (i.e. an ancestor, which
  * means a subset of) the @child domain.
+ *
+ * Return: True if @parent is an ancestor of or equal to @child, false
+ * otherwise.
  */
 static bool domain_scope_le(const struct landlock_ruleset *const parent,
 			    const struct landlock_ruleset *const child)
@@ -79,8 +82,7 @@ static int domain_ptrace(const struct landlock_ruleset *const parent,
  * If the current task has Landlock rules, then the child must have at least
  * the same rules.  Else denied.
  *
- * Determines whether a process may access another, returning 0 if permission
- * granted, -errno if denied.
+ * Return: 0 if permission is granted, -errno if denied.
  */
 static int hook_ptrace_access_check(struct task_struct *const child,
 				    const unsigned int mode)
@@ -129,8 +131,7 @@ static int hook_ptrace_access_check(struct task_struct *const child,
  * If the parent has Landlock rules, then the current task must have the same
  * or more rules.  Else denied.
  *
- * Determines whether the nominated task is permitted to trace the current
- * process, returning 0 if permission is granted, -errno if denied.
+ * Return: 0 if permission is granted, -errno if denied.
  */
 static int hook_ptrace_traceme(struct task_struct *const parent)
 {
-- 
2.53.0

