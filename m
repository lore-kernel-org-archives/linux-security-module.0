Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC57B345ECB
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740833; cv=none; b=vDMSMYXulyyYl/Zvd4RczDaO8Ol2E1sjDcXMSGu5t+USJPwNXcvD8eucsx7nTW06lu/nk6Nph9k2F147xaz5CY8QHAbP2AnQWZfrgrZr5cS49ZTTqxrs0OS/dt7/UzaEug3lEL3rwxJQFTL2ieVu4pqj5JyRwkbwaACKRrNvmyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740833; c=relaxed/simple;
	bh=7c2Olx35BmlYp0HYY2Toz2Qjxp5LXtyV8PAtghDZYPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/vy7YG8XQw2UvTJkmnvN8N2Ocvb9Wonjts1ONogRza9YiqRLf5uiwD09LW5V62ko0jo/ZTxEZsTnsio1sEt6svhG/M5PwPejwcR+z4lALD9aPhaDMFK2VF0+n1JnjQKAUjCgVSX/aWrTg6n+Y9KIxwCshDXB5HqZPS52wm0Ao8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=xnFsTCK9; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="xnFsTCK9"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h515Z1ZYgz10wQ;
	Wed, 22 Jul 2026 19:12:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1784740337;
	bh=ODJ9aYtIxNv2/SfrLO+/RlK1CFUi9rm6pZe+fF/KUtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xnFsTCK9+KljimCPqBF9BouBW6SR+azCD1UqZDw7KSohc1TeG+GeoWnz/0FjEPHKr
	 EcsJCfh+jjMCf78/9iBZL1jCihSTQ0bp+VGxew7vxAYT7q0vUCwoPWGdVEeG5FIrtM
	 VGTplYN60U/wj2DK5ID0+Y2f9Y8xNekePj9P+/LE=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h515Y1Dl2zwXJ;
	Wed, 22 Jul 2026 19:12:17 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
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
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 04/20] landlock: Split denial logging from audit into common framework
Date: Wed, 22 Jul 2026 19:11:36 +0200
Message-ID: <20260722171159.2776765-5-mic@digikod.net>
In-Reply-To: <20260722171159.2776765-1-mic@digikod.net>
References: <20260722171159.2776765-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Tracepoint emission requires the denial framework (layer identification,
request validation) without depending on CONFIG_AUDIT.  Separate the
denial logging infrastructure from the audit-specific code by
introducing a common log framework.

Create CONFIG_SECURITY_LANDLOCK_LOG, enabled by default when
CONFIG_AUDIT is set; a following commit extends it to CONFIG_TRACEPOINTS
when the first tracepoint consumer is added.  Move the common framework
(the request types, the layer identification and request validation, and
the landlock_log_denial() and landlock_log_free_domain() entry points)
into log.c and log.h, and keep the audit-specific record formatting in
audit.c. log.o is built for CONFIG_SECURITY_LANDLOCK_LOG and audit.o for
CONFIG_AUDIT, so the common framework is available to a tracepoints-only
build.  The entry points dispatch to no-op static inline audit stubs
without CONFIG_AUDIT, so the call sites stay unconditional.  Rename the
former landlock_log_drop_domain() to landlock_log_free_domain() to match
the landlock_free_domain tracepoint added in a following commit.

landlock_log_denial() counts denials even without audit, so its
declaration and no-op stub are guarded by CONFIG_SECURITY_LANDLOCK_LOG,
not CONFIG_AUDIT; a CONFIG_AUDIT guard would expose the stub and clash
with log.c's definition in a tracepoints-only build.

Widen the ID allocation (id.o and the landlock_init_id() /
landlock_get_id_range() declarations) and the log-state representation
(the domain_exec and log_subdomains_off credential fields, the
landlock_hierarchy log fields, and the code that maintains them) from
CONFIG_AUDIT to CONFIG_SECURITY_LANDLOCK_LOG, so each field and its
writer share one guard and are available to tracing without audit
support.

Widen the denial-path state that feeds the per-denial logging decision
the same way, so the "logged" verdict is computed identically whether or
not CONFIG_AUDIT is set.  Widening fown_layer is what keeps the
file-owner-signal path valid without audit: otherwise
hook_file_send_sigiotask() would leave layer_plus_one at zero, tripping
the is_valid_request() canary and dropping the LANDLOCK_SCOPE_SIGNAL
denial from tracing.

The ruleset-level quiet_masks stays on no CONFIG guard: it is builder
state validated and stored from user input, kept available so
LANDLOCK_ADD_RULE_QUIET flags are accepted and ignored, not rejected,
when CONFIG_SECURITY_LANDLOCK_LOG is disabled.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
https://patch.msgid.link/20260406143717.1815792-5-mic@digikod.net
- Split the denial logging into a common framework
  (landlock_log_denial() and landlock_log_free_domain(), layer
  identification, request validation) and the audit-specific record
  formatting (landlock_audit_denial(), landlock_audit_free_domain())
  built as separate translation units, each gated by its own CONFIG,
  instead of renaming audit.c to log.c.  The dispatchers reach the audit
  helpers through no-op stubs so the call sites stay unconditional.
- Gate CONFIG_SECURITY_LANDLOCK_LOG on CONFIG_AUDIT only; a following
  commit extends it to CONFIG_TRACEPOINTS with the first tracepoint.
- Move the log_subdomains_off credential field and the log-state writers
  (hook_bprm_creds_for_exec(), the landlock_restrict_self() log
  assignments) to CONFIG_SECURITY_LANDLOCK_LOG alongside domain_exec and
  the hierarchy log fields, so each field and its writer share one
  guard.
- Thread the base's quiet flag through the split (object_quiet
  parameter to landlock_audit_denial()).
- Widen the quiet consumer state and the file-owner-signal layer
  identification (fown_layer) from CONFIG_AUDIT to
  CONFIG_SECURITY_LANDLOCK_LOG so the per-denial logged verdict is
  computed identically whether CONFIG_AUDIT is set; the ruleset-level
  quiet_masks stays ungated to accept and ignore quiet flags when the
  log framework is disabled.

Changes since v1:
- New patch.
---
 security/landlock/Kconfig    |   5 +
 security/landlock/Makefile   |   6 +-
 security/landlock/access.h   |   4 +-
 security/landlock/audit.c    | 485 ++-------------------------------
 security/landlock/audit.h    |  61 ++---
 security/landlock/cred.c     |   8 +-
 security/landlock/cred.h     |   8 +-
 security/landlock/domain.c   |  24 +-
 security/landlock/domain.h   |  14 +-
 security/landlock/fs.c       |  27 +-
 security/landlock/fs.h       |   8 +-
 security/landlock/id.h       |   6 +-
 security/landlock/log.c      | 502 +++++++++++++++++++++++++++++++++++
 security/landlock/log.h      |  77 ++++++
 security/landlock/net.c      |   2 +-
 security/landlock/syscalls.c |  12 +-
 security/landlock/task.c     |   6 +-
 17 files changed, 685 insertions(+), 570 deletions(-)
 create mode 100644 security/landlock/log.c
 create mode 100644 security/landlock/log.h

diff --git a/security/landlock/Kconfig b/security/landlock/Kconfig
index 3f1493402052..b4e7f0e9ba9b 100644
--- a/security/landlock/Kconfig
+++ b/security/landlock/Kconfig
@@ -21,6 +21,11 @@ config SECURITY_LANDLOCK
 	  you should also prepend "landlock," to the content of CONFIG_LSM to
 	  enable Landlock at boot time.
 
+config SECURITY_LANDLOCK_LOG
+	bool
+	depends on SECURITY_LANDLOCK
+	default y if AUDIT
+
 config SECURITY_LANDLOCK_KUNIT_TEST
 	bool "KUnit tests for Landlock" if !KUNIT_ALL_TESTS
 	depends on KUNIT=y
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index 23e13644916f..2462e6c5921e 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -13,6 +13,8 @@ landlock-y := \
 
 landlock-$(CONFIG_INET) += net.o
 
-landlock-$(CONFIG_AUDIT) += \
+landlock-$(CONFIG_SECURITY_LANDLOCK_LOG) += \
 	id.o \
-	audit.o
+	log.o
+
+landlock-$(CONFIG_AUDIT) += audit.o
diff --git a/security/landlock/access.h b/security/landlock/access.h
index 1a8227a709d9..bbbb41f41147 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -74,13 +74,13 @@ struct layer_mask {
 	 * @access: The unfulfilled access rights for this layer.
 	 */
 	access_mask_t access : LANDLOCK_NUM_ACCESS_MAX;
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 	/**
 	 * @quiet: Whether we have encountered a rule with the quiet flag for
 	 * this layer.  Used to control logging.
 	 */
 	access_mask_t quiet : 1;
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 } __packed __aligned(sizeof(access_mask_t));
 
 /*
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 7cb00619a741..dfa1e5a64aac 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -5,7 +5,6 @@
  * Copyright © 2023-2025 Microsoft Corporation
  */
 
-#include <kunit/test.h>
 #include <linux/audit.h>
 #include <linux/bitops.h>
 #include <linux/lsm_audit.h>
@@ -18,7 +17,7 @@
 #include "cred.h"
 #include "domain.h"
 #include "limits.h"
-#include "ruleset.h"
+#include "log.h"
 
 static const char *const fs_access_strings[] = {
 	[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = "fs.execute",
@@ -137,393 +136,6 @@ static void log_domain(struct landlock_hierarchy *const hierarchy)
 	WRITE_ONCE(hierarchy->log_status, LANDLOCK_LOG_RECORDED);
 }
 
-static struct landlock_hierarchy *
-get_hierarchy(const struct landlock_domain *const domain, const size_t layer)
-{
-	struct landlock_hierarchy *hierarchy = domain->hierarchy;
-	ssize_t i;
-
-	if (WARN_ON_ONCE(layer >= domain->num_layers))
-		return hierarchy;
-
-	for (i = domain->num_layers - 1; i > layer; i--) {
-		if (WARN_ON_ONCE(!hierarchy->parent))
-			break;
-
-		hierarchy = hierarchy->parent;
-	}
-
-	return hierarchy;
-}
-
-#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
-
-static void test_get_hierarchy(struct kunit *const test)
-{
-	struct landlock_hierarchy dom0_hierarchy = {
-		.id = 10,
-	};
-	struct landlock_hierarchy dom1_hierarchy = {
-		.parent = &dom0_hierarchy,
-		.id = 20,
-	};
-	struct landlock_hierarchy dom2_hierarchy = {
-		.parent = &dom1_hierarchy,
-		.id = 30,
-	};
-	struct landlock_domain dom2 = {
-		.hierarchy = &dom2_hierarchy,
-		.num_layers = 3,
-	};
-
-	KUNIT_EXPECT_EQ(test, 10, get_hierarchy(&dom2, 0)->id);
-	KUNIT_EXPECT_EQ(test, 20, get_hierarchy(&dom2, 1)->id);
-	KUNIT_EXPECT_EQ(test, 30, get_hierarchy(&dom2, 2)->id);
-	/* KUNIT_EXPECT_EQ(test, 30, get_hierarchy(&dom2, -1)->id); */
-}
-
-#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
-
-/* Get the youngest layer that denied the access_request. */
-static size_t get_denied_layer(const struct landlock_domain *const domain,
-			       access_mask_t *const access_request,
-			       const struct layer_masks *masks)
-{
-	for (ssize_t i = ARRAY_SIZE(masks->layers) - 1; i >= 0; i--) {
-		if (masks->layers[i].access & *access_request) {
-			*access_request &= masks->layers[i].access;
-			return i;
-		}
-	}
-
-	/* Not found - fall back to default values */
-	*access_request = 0;
-	return domain->num_layers - 1;
-}
-
-#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
-
-static void test_get_denied_layer(struct kunit *const test)
-{
-	const struct landlock_domain dom = {
-		.num_layers = 5,
-	};
-	const struct layer_masks masks = {
-		.layers[0].access = LANDLOCK_ACCESS_FS_EXECUTE |
-				    LANDLOCK_ACCESS_FS_READ_DIR,
-		.layers[1].access = LANDLOCK_ACCESS_FS_READ_FILE |
-				    LANDLOCK_ACCESS_FS_READ_DIR,
-		.layers[2].access = LANDLOCK_ACCESS_FS_REMOVE_DIR,
-	};
-	access_mask_t access;
-
-	access = LANDLOCK_ACCESS_FS_EXECUTE;
-	KUNIT_EXPECT_EQ(test, 0, get_denied_layer(&dom, &access, &masks));
-	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_EXECUTE);
-
-	access = LANDLOCK_ACCESS_FS_READ_FILE;
-	KUNIT_EXPECT_EQ(test, 1, get_denied_layer(&dom, &access, &masks));
-	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_READ_FILE);
-
-	access = LANDLOCK_ACCESS_FS_READ_DIR;
-	KUNIT_EXPECT_EQ(test, 1, get_denied_layer(&dom, &access, &masks));
-	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_READ_DIR);
-
-	access = LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_READ_DIR;
-	KUNIT_EXPECT_EQ(test, 1, get_denied_layer(&dom, &access, &masks));
-	KUNIT_EXPECT_EQ(test, access,
-			LANDLOCK_ACCESS_FS_READ_FILE |
-				LANDLOCK_ACCESS_FS_READ_DIR);
-
-	access = LANDLOCK_ACCESS_FS_EXECUTE | LANDLOCK_ACCESS_FS_READ_DIR;
-	KUNIT_EXPECT_EQ(test, 1, get_denied_layer(&dom, &access, &masks));
-	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_READ_DIR);
-
-	access = LANDLOCK_ACCESS_FS_WRITE_FILE;
-	KUNIT_EXPECT_EQ(test, 4, get_denied_layer(&dom, &access, &masks));
-	KUNIT_EXPECT_EQ(test, access, 0);
-}
-
-#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
-
-static size_t
-get_layer_from_deny_masks(access_mask_t *const access_request,
-			  const access_mask_t all_existing_optional_access,
-			  const deny_masks_t deny_masks,
-			  optional_access_t quiet_optional_accesses,
-			  bool *quiet)
-{
-	const unsigned long access_opt = all_existing_optional_access;
-	const unsigned long access_req = *access_request;
-	access_mask_t missing = 0;
-	size_t youngest_layer = 0;
-	size_t access_index = 0;
-	unsigned long access_bit;
-	bool should_quiet = false;
-
-	/* This will require change with new object types. */
-	WARN_ON_ONCE(access_opt != _LANDLOCK_ACCESS_FS_OPTIONAL);
-
-	for_each_set_bit(access_bit, &access_opt,
-			 BITS_PER_TYPE(access_mask_t)) {
-		if (access_req & BIT(access_bit)) {
-			const size_t layer =
-				(deny_masks >>
-				 (access_index *
-				  HWEIGHT(LANDLOCK_MAX_NUM_LAYERS - 1))) &
-				(LANDLOCK_MAX_NUM_LAYERS - 1);
-			const bool layer_has_quiet =
-				!!(quiet_optional_accesses & BIT(access_index));
-
-			if (layer > youngest_layer) {
-				youngest_layer = layer;
-				missing = BIT(access_bit);
-				should_quiet = layer_has_quiet;
-			} else if (layer == youngest_layer) {
-				missing |= BIT(access_bit);
-				/*
-				 * Whether the layer has rules with quiet flag
-				 * covering the file accessed does not depend on
-				 * the access, and so the following
-				 * WARN_ON_ONCE() should not fail.
-				 */
-				WARN_ON_ONCE(should_quiet && !layer_has_quiet);
-				should_quiet = layer_has_quiet;
-			}
-		}
-		access_index++;
-	}
-
-	*access_request = missing;
-	*quiet = should_quiet;
-	return youngest_layer;
-}
-
-#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
-
-static void test_get_layer_from_deny_masks(struct kunit *const test)
-{
-	deny_masks_t deny_mask;
-	access_mask_t access;
-	optional_access_t quiet_optional_accesses;
-	bool quiet;
-
-	/* truncate:0 ioctl_dev:2 */
-	deny_mask = 0x20;
-	quiet_optional_accesses = 0;
-
-	access = LANDLOCK_ACCESS_FS_TRUNCATE;
-	KUNIT_EXPECT_EQ(test, 0,
-			get_layer_from_deny_masks(
-				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
-				deny_mask, quiet_optional_accesses, &quiet));
-	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
-	KUNIT_EXPECT_EQ(test, quiet, false);
-
-	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
-	KUNIT_EXPECT_EQ(test, 2,
-			get_layer_from_deny_masks(
-				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
-				deny_mask, quiet_optional_accesses, &quiet));
-	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
-	KUNIT_EXPECT_EQ(test, quiet, false);
-
-	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
-	KUNIT_EXPECT_EQ(test, 2,
-			get_layer_from_deny_masks(
-				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
-				deny_mask, quiet_optional_accesses, &quiet));
-	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
-	KUNIT_EXPECT_EQ(test, quiet, false);
-
-	/* layer denying truncate: quiet, ioctl: not quiet */
-	quiet_optional_accesses = 0b01;
-
-	access = LANDLOCK_ACCESS_FS_TRUNCATE;
-	KUNIT_EXPECT_EQ(test, 0,
-			get_layer_from_deny_masks(
-				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
-				deny_mask, quiet_optional_accesses, &quiet));
-	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
-	KUNIT_EXPECT_EQ(test, quiet, true);
-
-	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
-	KUNIT_EXPECT_EQ(test, 2,
-			get_layer_from_deny_masks(
-				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
-				deny_mask, quiet_optional_accesses, &quiet));
-	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
-	KUNIT_EXPECT_EQ(test, quiet, false);
-
-	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
-	KUNIT_EXPECT_EQ(test, 2,
-			get_layer_from_deny_masks(
-				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
-				deny_mask, quiet_optional_accesses, &quiet));
-	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
-	KUNIT_EXPECT_EQ(test, quiet, false);
-
-	/* Reverse order - truncate:2 ioctl_dev:0 */
-	deny_mask = 0x02;
-	quiet_optional_accesses = 0;
-
-	access = LANDLOCK_ACCESS_FS_TRUNCATE;
-	KUNIT_EXPECT_EQ(test, 2,
-			get_layer_from_deny_masks(
-				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
-				deny_mask, quiet_optional_accesses, &quiet));
-	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
-	KUNIT_EXPECT_EQ(test, quiet, false);
-
-	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
-	KUNIT_EXPECT_EQ(test, 0,
-			get_layer_from_deny_masks(
-				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
-				deny_mask, quiet_optional_accesses, &quiet));
-	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
-	KUNIT_EXPECT_EQ(test, quiet, false);
-
-	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
-	KUNIT_EXPECT_EQ(test, 2,
-			get_layer_from_deny_masks(
-				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
-				deny_mask, quiet_optional_accesses, &quiet));
-	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
-	KUNIT_EXPECT_EQ(test, quiet, false);
-
-	/* layer denying truncate: quiet, ioctl: not quiet */
-	quiet_optional_accesses = 0b01;
-
-	access = LANDLOCK_ACCESS_FS_TRUNCATE;
-	KUNIT_EXPECT_EQ(test, 2,
-			get_layer_from_deny_masks(
-				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
-				deny_mask, quiet_optional_accesses, &quiet));
-	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
-	KUNIT_EXPECT_EQ(test, quiet, true);
-
-	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
-	KUNIT_EXPECT_EQ(test, 0,
-			get_layer_from_deny_masks(
-				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
-				deny_mask, quiet_optional_accesses, &quiet));
-	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
-	KUNIT_EXPECT_EQ(test, quiet, false);
-
-	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
-	KUNIT_EXPECT_EQ(test, 2,
-			get_layer_from_deny_masks(
-				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
-				deny_mask, quiet_optional_accesses, &quiet));
-	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
-	KUNIT_EXPECT_EQ(test, quiet, true);
-
-	/* layer denying truncate: not quiet, ioctl: quiet */
-	quiet_optional_accesses = 0b10;
-
-	access = LANDLOCK_ACCESS_FS_TRUNCATE;
-	KUNIT_EXPECT_EQ(test, 2,
-			get_layer_from_deny_masks(
-				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
-				deny_mask, quiet_optional_accesses, &quiet));
-	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
-	KUNIT_EXPECT_EQ(test, quiet, false);
-
-	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
-	KUNIT_EXPECT_EQ(test, 0,
-			get_layer_from_deny_masks(
-				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
-				deny_mask, quiet_optional_accesses, &quiet));
-	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
-	KUNIT_EXPECT_EQ(test, quiet, true);
-
-	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
-	KUNIT_EXPECT_EQ(test, 2,
-			get_layer_from_deny_masks(
-				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
-				deny_mask, quiet_optional_accesses, &quiet));
-	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
-	KUNIT_EXPECT_EQ(test, quiet, false);
-
-	/* truncate:15 ioctl_dev:15 */
-	deny_mask = 0xff;
-	quiet_optional_accesses = 0;
-
-	access = LANDLOCK_ACCESS_FS_TRUNCATE;
-	KUNIT_EXPECT_EQ(test, 15,
-			get_layer_from_deny_masks(
-				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
-				deny_mask, quiet_optional_accesses, &quiet));
-	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
-	KUNIT_EXPECT_EQ(test, quiet, false);
-
-	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
-	KUNIT_EXPECT_EQ(test, 15,
-			get_layer_from_deny_masks(
-				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
-				deny_mask, quiet_optional_accesses, &quiet));
-	KUNIT_EXPECT_EQ(test, access,
-			LANDLOCK_ACCESS_FS_TRUNCATE |
-				LANDLOCK_ACCESS_FS_IOCTL_DEV);
-	KUNIT_EXPECT_EQ(test, quiet, false);
-
-	/* Both quiet (same layer so quietness must be the same) */
-	quiet_optional_accesses = 0b11;
-
-	access = LANDLOCK_ACCESS_FS_TRUNCATE;
-	KUNIT_EXPECT_EQ(test, 15,
-			get_layer_from_deny_masks(
-				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
-				deny_mask, quiet_optional_accesses, &quiet));
-	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
-	KUNIT_EXPECT_EQ(test, quiet, true);
-
-	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
-	KUNIT_EXPECT_EQ(test, 15,
-			get_layer_from_deny_masks(
-				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
-				deny_mask, quiet_optional_accesses, &quiet));
-	KUNIT_EXPECT_EQ(test, access,
-			LANDLOCK_ACCESS_FS_TRUNCATE |
-				LANDLOCK_ACCESS_FS_IOCTL_DEV);
-	KUNIT_EXPECT_EQ(test, quiet, true);
-}
-
-#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
-
-static bool is_valid_request(const struct landlock_request *const request)
-{
-	if (WARN_ON_ONCE(request->layer_plus_one > LANDLOCK_MAX_NUM_LAYERS))
-		return false;
-
-	if (WARN_ON_ONCE(!(!!request->layer_plus_one ^ !!request->access)))
-		return false;
-
-	if (request->access) {
-		if (WARN_ON_ONCE(!(!!request->layer_masks ^
-				   !!request->all_existing_optional_access)))
-			return false;
-	} else {
-		if (WARN_ON_ONCE(request->layer_masks ||
-				 request->all_existing_optional_access))
-			return false;
-	}
-
-	if (request->deny_masks) {
-		if (WARN_ON_ONCE(!request->all_existing_optional_access))
-			return false;
-		static_assert(sizeof(request->all_existing_optional_access) ==
-			      sizeof(u32));
-		if (WARN_ON_ONCE(
-			    request->quiet_optional_accesses >=
-			    BIT(hweight32(
-				    request->all_existing_optional_access))))
-			return false;
-	}
-
-	return true;
-}
-
 static access_mask_t
 pick_access_mask_for_request_type(const enum landlock_request_type type,
 				  const struct access_masks access_masks)
@@ -541,62 +153,27 @@ pick_access_mask_for_request_type(const enum landlock_request_type type,
 }
 
 /**
- * landlock_log_denial - Create audit records related to a denial
+ * landlock_audit_denial - Create an audit record for a denied access request
  *
  * @subject: The Landlock subject's credential denying an action.
  * @request: Detail of the user space request.
+ * @youngest_denied: The youngest hierarchy node that denied the access.
+ * @youngest_layer: The layer index of @youngest_denied.
+ * @missing: The set of denied access rights.
+ * @object_quiet_flag: Whether the object denied by @youngest_denied is
+ *                     covered by a quiet rule in that layer.
+ *
+ * Called from landlock_log_denial() with the same arguments.
  */
-void landlock_log_denial(const struct landlock_cred_security *const subject,
-			 const struct landlock_request *const request)
+void landlock_audit_denial(const struct landlock_cred_security *const subject,
+			   const struct landlock_request *const request,
+			   struct landlock_hierarchy *const youngest_denied,
+			   const size_t youngest_layer,
+			   const access_mask_t missing,
+			   const bool object_quiet_flag)
 {
 	struct audit_buffer *ab;
-	struct landlock_hierarchy *youngest_denied;
-	size_t youngest_layer;
-	access_mask_t missing;
-	bool object_quiet_flag = false, quiet_applicable_to_access = false;
-
-	if (WARN_ON_ONCE(!subject || !subject->domain ||
-			 !subject->domain->hierarchy || !request))
-		return;
-
-	if (!is_valid_request(request))
-		return;
-
-	missing = request->access;
-	if (missing) {
-		/* Gets the nearest domain that denies the request. */
-		if (request->layer_masks) {
-			youngest_layer = get_denied_layer(subject->domain,
-							  &missing,
-							  request->layer_masks);
-			object_quiet_flag =
-				request->layer_masks->layers[youngest_layer]
-					.quiet;
-		} else {
-			youngest_layer = get_layer_from_deny_masks(
-				&missing, _LANDLOCK_ACCESS_FS_OPTIONAL,
-				request->deny_masks,
-				request->quiet_optional_accesses,
-				&object_quiet_flag);
-		}
-		youngest_denied =
-			get_hierarchy(subject->domain, youngest_layer);
-	} else {
-		youngest_layer = request->layer_plus_one - 1;
-		youngest_denied =
-			get_hierarchy(subject->domain, youngest_layer);
-	}
-
-	if (READ_ONCE(youngest_denied->log_status) == LANDLOCK_LOG_DISABLED)
-		return;
-
-	/*
-	 * Consistently keeps track of the number of denied access requests
-	 * even if audit is currently disabled, or if audit rules currently
-	 * exclude this record type, or if landlock_restrict_self(2)'s flags
-	 * quiet logs.
-	 */
-	atomic64_inc(&youngest_denied->num_denials);
+	bool quiet_applicable_to_access = false;
 
 	if (!audit_enabled)
 		return;
@@ -675,23 +252,19 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 }
 
 /**
- * landlock_log_drop_domain - Create an audit record on domain deallocation
+ * landlock_audit_free_domain - Create an audit record on domain deallocation
  *
  * @hierarchy: The domain's hierarchy being deallocated.
  *
  * Only domains which previously appeared in the audit logs are logged again.
  * This is useful to know when a domain will never show again in the audit log.
  *
- * Called in a work queue scheduled by landlock_put_domain_deferred() called by
- * hook_cred_free().
+ * Called from landlock_log_free_domain().
  */
-void landlock_log_drop_domain(const struct landlock_hierarchy *const hierarchy)
+void landlock_audit_free_domain(const struct landlock_hierarchy *const hierarchy)
 {
 	struct audit_buffer *ab;
 
-	if (WARN_ON_ONCE(!hierarchy))
-		return;
-
 	if (!audit_enabled)
 		return;
 
@@ -712,23 +285,3 @@ void landlock_log_drop_domain(const struct landlock_hierarchy *const hierarchy)
 			 hierarchy->id, atomic64_read(&hierarchy->num_denials));
 	audit_log_end(ab);
 }
-
-#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
-
-static struct kunit_case test_cases[] = {
-	/* clang-format off */
-	KUNIT_CASE(test_get_hierarchy),
-	KUNIT_CASE(test_get_denied_layer),
-	KUNIT_CASE(test_get_layer_from_deny_masks),
-	{}
-	/* clang-format on */
-};
-
-static struct kunit_suite test_suite = {
-	.name = "landlock_audit",
-	.test_cases = test_cases,
-};
-
-kunit_test_suite(test_suite);
-
-#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 4617a855712c..1b36bb3c6cfd 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -8,68 +8,39 @@
 #ifndef _SECURITY_LANDLOCK_AUDIT_H
 #define _SECURITY_LANDLOCK_AUDIT_H
 
-#include <linux/audit.h>
-#include <linux/lsm_audit.h>
+#include <linux/types.h>
 
 #include "access.h"
 
 struct landlock_cred_security;
 struct landlock_hierarchy;
-
-enum landlock_request_type {
-	LANDLOCK_REQUEST_PTRACE = 1,
-	LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY,
-	LANDLOCK_REQUEST_FS_ACCESS,
-	LANDLOCK_REQUEST_NET_ACCESS,
-	LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
-	LANDLOCK_REQUEST_SCOPE_SIGNAL,
-};
-
-/*
- * We should be careful to only use a variable of this type for
- * landlock_log_denial().  This way, the compiler can remove it entirely if
- * CONFIG_AUDIT is not set.
- */
-struct landlock_request {
-	/* Mandatory fields. */
-	enum landlock_request_type type;
-	struct common_audit_data audit;
-
-	/**
-	 * layer_plus_one: First layer level that denies the request + 1.  The
-	 * extra one is useful to detect uninitialized field.
-	 */
-	size_t layer_plus_one;
-
-	/* Required field for configurable access control. */
-	access_mask_t access;
-
-	/* Required fields for requests with layer masks. */
-	const struct layer_masks *layer_masks;
-
-	/* Required fields for requests with deny masks. */
-	const access_mask_t all_existing_optional_access;
-	deny_masks_t deny_masks;
-	optional_access_t quiet_optional_accesses;
-};
+struct landlock_request;
 
 #ifdef CONFIG_AUDIT
 
-void landlock_log_drop_domain(const struct landlock_hierarchy *const hierarchy);
+void landlock_audit_denial(const struct landlock_cred_security *const subject,
+			   const struct landlock_request *const request,
+			   struct landlock_hierarchy *const youngest_denied,
+			   const size_t youngest_layer,
+			   const access_mask_t missing,
+			   const bool object_quiet_flag);
 
-void landlock_log_denial(const struct landlock_cred_security *const subject,
-			 const struct landlock_request *const request);
+void landlock_audit_free_domain(
+	const struct landlock_hierarchy *const hierarchy);
 
 #else /* CONFIG_AUDIT */
 
 static inline void
-landlock_log_drop_domain(const struct landlock_hierarchy *const hierarchy)
+landlock_audit_denial(const struct landlock_cred_security *const subject,
+		      const struct landlock_request *const request,
+		      struct landlock_hierarchy *const youngest_denied,
+		      const size_t youngest_layer, const access_mask_t missing,
+		      const bool object_quiet_flag)
 {
 }
 
 static inline void
-landlock_log_denial(const struct landlock_cred_security *const subject,
-		    const struct landlock_request *const request)
+landlock_audit_free_domain(const struct landlock_hierarchy *const hierarchy)
 {
 }
 
diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index 58b544993db4..03449c26247e 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -41,7 +41,7 @@ static void hook_cred_free(struct cred *const cred)
 		landlock_put_domain_deferred(dom);
 }
 
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 
 static int hook_bprm_creds_for_exec(struct linux_binprm *const bprm)
 {
@@ -50,16 +50,16 @@ static int hook_bprm_creds_for_exec(struct linux_binprm *const bprm)
 	return 0;
 }
 
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(cred_prepare, hook_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, hook_cred_transfer),
 	LSM_HOOK_INIT(cred_free, hook_cred_free),
 
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 	LSM_HOOK_INIT(bprm_creds_for_exec, hook_bprm_creds_for_exec),
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 };
 
 __init void landlock_add_cred_hooks(void)
diff --git a/security/landlock/cred.h b/security/landlock/cred.h
index e7830cfed041..a5ff9957949a 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -36,7 +36,7 @@ struct landlock_cred_security {
 	 */
 	struct landlock_domain *domain;
 
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 	/**
 	 * @domain_exec: Bitmask identifying the domain layers that were enforced by
 	 * the current task's executed file (i.e. no new execve(2) since
@@ -50,17 +50,17 @@ struct landlock_cred_security {
 	 * not require a current domain.
 	 */
 	u8 log_subdomains_off : 1;
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 } __packed;
 
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 
 /* Makes sure all layer executions can be stored. */
 static_assert(BITS_PER_TYPE(typeof_member(struct landlock_cred_security,
 					  domain_exec)) >=
 	      LANDLOCK_MAX_NUM_LAYERS);
 
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 
 static inline struct landlock_cred_security *
 landlock_cred(const struct cred *cred)
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 2e0d75175c2a..6444cf27bda2 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -171,11 +171,11 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
 		/* Clear the bits where the layer in the rule grants access. */
 		masks->layers[layer->level - 1].access &= ~layer->access;
 
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 		/* Collect rule flags for each layer. */
 		if (layer->flags.quiet)
 			masks->layers[layer->level - 1].quiet = true;
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 	}
 
 	for (size_t i = 0; i < ARRAY_SIZE(masks->layers); i++) {
@@ -238,16 +238,16 @@ landlock_init_layer_masks(const struct landlock_domain *const domain,
 
 		masks->layers[i].access = access_request & handled;
 		handled_accesses |= masks->layers[i].access;
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 		masks->layers[i].quiet = false;
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 	}
 	for (size_t i = domain->num_layers; i < ARRAY_SIZE(masks->layers);
 	     i++) {
 		masks->layers[i].access = 0;
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 		masks->layers[i].quiet = false;
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 	}
 
 	return handled_accesses;
@@ -464,14 +464,14 @@ landlock_merge_ruleset(struct landlock_domain *const parent,
 	if (err)
 		return ERR_PTR(err);
 
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 	new_dom->hierarchy->quiet_masks = ruleset->quiet_masks;
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 
 	return no_free_ptr(new_dom);
 }
 
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 
 /**
  * get_current_exe - Get the current's executable path, if any
@@ -582,6 +582,10 @@ int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy)
 	return 0;
 }
 
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
+
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
+
 static deny_masks_t
 get_layer_deny_mask(const access_mask_t all_existing_optional_access,
 		    const unsigned long access_bit, const size_t layer)
@@ -753,4 +757,4 @@ kunit_test_suite(test_suite);
 
 #endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
 
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index f0925297dcba..1237e3e25240 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -21,7 +21,7 @@
 #include <linux/workqueue.h>
 
 #include "access.h"
-#include "audit.h"
+#include "log.h"
 #include "ruleset.h"
 
 enum landlock_log_status {
@@ -84,7 +84,7 @@ struct landlock_hierarchy {
 	 */
 	refcount_t usage;
 
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 	/**
 	 * @log_status: Whether this domain should be logged or not.  Because
 	 * concurrent log entries may be created at the same time, it is still
@@ -119,10 +119,10 @@ struct landlock_hierarchy {
 	 * logged) if the related object is marked as quiet.
 	 */
 	struct access_masks quiet_masks;
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 };
 
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 
 deny_masks_t
 landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
@@ -145,7 +145,7 @@ landlock_free_hierarchy_details(struct landlock_hierarchy *const hierarchy)
 	kfree(hierarchy->details);
 }
 
-#else /* CONFIG_AUDIT */
+#else /* CONFIG_SECURITY_LANDLOCK_LOG */
 
 static inline int
 landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy)
@@ -158,7 +158,7 @@ landlock_free_hierarchy_details(struct landlock_hierarchy *const hierarchy)
 {
 }
 
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 
 static inline void
 landlock_get_hierarchy(struct landlock_hierarchy *const hierarchy)
@@ -172,7 +172,7 @@ static inline void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy)
 	while (hierarchy && refcount_dec_and_test(&hierarchy->usage)) {
 		const struct landlock_hierarchy *const freeme = hierarchy;
 
-		landlock_log_drop_domain(hierarchy);
+		landlock_log_free_domain(hierarchy);
 		landlock_free_hierarchy_details(hierarchy);
 		hierarchy = hierarchy->parent;
 		kfree(freeme);
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 0b77d310ffd4..d39da6e9fa8c 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -42,12 +42,12 @@
 #include <uapi/linux/landlock.h>
 
 #include "access.h"
-#include "audit.h"
 #include "common.h"
 #include "cred.h"
 #include "domain.h"
 #include "fs.h"
 #include "limits.h"
+#include "log.h"
 #include "object.h"
 #include "ruleset.h"
 #include "setup.h"
@@ -932,10 +932,11 @@ is_access_to_paths_allowed(const struct landlock_domain *const domain,
 	path_put(&walker_path);
 
 	/*
-	 * Check CONFIG_AUDIT to enable elision of log_request_parent* and
-	 * associated caller's stack variables thanks to dead code elimination.
+	 * Check CONFIG_SECURITY_LANDLOCK_LOG to enable elision of
+	 * log_request_parent* and associated caller's stack variables thanks to
+	 * dead code elimination.
 	 */
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 	if (!allowed_parent1 && log_request_parent1) {
 		log_request_parent1->type = LANDLOCK_REQUEST_FS_ACCESS;
 		log_request_parent1->audit.type = LSM_AUDIT_DATA_PATH;
@@ -951,7 +952,7 @@ is_access_to_paths_allowed(const struct landlock_domain *const domain,
 		log_request_parent2->access = access_masked_parent2;
 		log_request_parent2->layer_masks = layer_masks_parent2;
 	}
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 
 	return allowed_parent1 && allowed_parent2;
 }
@@ -1801,14 +1802,14 @@ static int hook_file_open(struct file *const file)
 	 * file access rights in the opened struct file.
 	 */
 	landlock_file(file)->allowed_access = allowed_access;
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 	landlock_file(file)->deny_masks = landlock_get_deny_masks(
 		_LANDLOCK_ACCESS_FS_OPTIONAL, optional_access, &layer_masks);
 	landlock_file(file)->quiet_optional_accesses =
 		landlock_get_quiet_optional_accesses(
 			_LANDLOCK_ACCESS_FS_OPTIONAL,
 			landlock_file(file)->deny_masks, &layer_masks);
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 
 	if (access_mask_subset(open_access_request, allowed_access))
 		return 0;
@@ -1842,10 +1843,10 @@ static int hook_file_truncate(struct file *const file)
 		},
 		.all_existing_optional_access = _LANDLOCK_ACCESS_FS_OPTIONAL,
 		.access = LANDLOCK_ACCESS_FS_TRUNCATE,
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 		.deny_masks = landlock_file(file)->deny_masks,
 		.quiet_optional_accesses = landlock_file(file)->quiet_optional_accesses,
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 	});
 	return -EACCES;
 }
@@ -1882,10 +1883,10 @@ static int hook_file_ioctl_common(const struct file *const file,
 		},
 		.all_existing_optional_access = _LANDLOCK_ACCESS_FS_OPTIONAL,
 		.access = LANDLOCK_ACCESS_FS_IOCTL_DEV,
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 		.deny_masks = landlock_file(file)->deny_masks,
 		.quiet_optional_accesses = landlock_file(file)->quiet_optional_accesses,
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 	});
 	return -EACCES;
 }
@@ -1961,9 +1962,9 @@ static void hook_file_set_fowner(struct file *file)
 	prev_tg = landlock_file(file)->fown_tg;
 	landlock_file(file)->fown_subject = fown_subject;
 	landlock_file(file)->fown_tg = fown_tg;
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 	landlock_file(file)->fown_layer = fown_layer;
-#endif /* CONFIG_AUDIT*/
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 
 	/* May be called in an RCU read-side critical section. */
 	landlock_put_domain_deferred(prev_dom);
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index b4421d9df68f..c16f24e30bd5 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -57,7 +57,7 @@ struct landlock_file_security {
 	 */
 	access_mask_t allowed_access;
 
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 	/**
 	 * @deny_masks: Domain layer levels that deny an optional access (see
 	 * _LANDLOCK_ACCESS_FS_OPTIONAL).
@@ -75,7 +75,7 @@ struct landlock_file_security {
 	 * LANDLOCK_SCOPE_SIGNAL.
 	 */
 	u8 fown_layer;
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 
 	/**
 	 * @fown_subject: Landlock credential of the task that set the PID that
@@ -97,7 +97,7 @@ struct landlock_file_security {
 	struct pid *fown_tg;
 };
 
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 
 /* Makes sure all layers can be identified. */
 /* clang-format off */
@@ -113,7 +113,7 @@ static_assert(BITS_PER_TYPE(typeof_member(struct landlock_file_security,
 					  quiet_optional_accesses)) >=
 	      HWEIGHT(_LANDLOCK_ACCESS_FS_OPTIONAL));
 
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 
 /**
  * struct landlock_superblock_security - Superblock security blob
diff --git a/security/landlock/id.h b/security/landlock/id.h
index 45dcfb9e9a8b..2a43c2b523a8 100644
--- a/security/landlock/id.h
+++ b/security/landlock/id.h
@@ -8,18 +8,18 @@
 #ifndef _SECURITY_LANDLOCK_ID_H
 #define _SECURITY_LANDLOCK_ID_H
 
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 
 void __init landlock_init_id(void);
 
 u64 landlock_get_id_range(size_t number_of_ids);
 
-#else /* CONFIG_AUDIT */
+#else /* CONFIG_SECURITY_LANDLOCK_LOG */
 
 static inline void __init landlock_init_id(void)
 {
 }
 
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 
 #endif /* _SECURITY_LANDLOCK_ID_H */
diff --git a/security/landlock/log.c b/security/landlock/log.c
new file mode 100644
index 000000000000..6dd3373c4ba4
--- /dev/null
+++ b/security/landlock/log.c
@@ -0,0 +1,502 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock - Log helpers
+ *
+ * Copyright © 2023-2025 Microsoft Corporation
+ */
+
+#include <kunit/test.h>
+#include <linux/bitops.h>
+#include <uapi/linux/landlock.h>
+
+#include "access.h"
+#include "audit.h"
+#include "common.h"
+#include "cred.h"
+#include "domain.h"
+#include "limits.h"
+#include "log.h"
+#include "ruleset.h"
+
+static struct landlock_hierarchy *
+get_hierarchy(const struct landlock_domain *const domain, const size_t layer)
+{
+	struct landlock_hierarchy *hierarchy = domain->hierarchy;
+	ssize_t i;
+
+	if (WARN_ON_ONCE(layer >= domain->num_layers))
+		return hierarchy;
+
+	for (i = domain->num_layers - 1; i > layer; i--) {
+		if (WARN_ON_ONCE(!hierarchy->parent))
+			break;
+
+		hierarchy = hierarchy->parent;
+	}
+
+	return hierarchy;
+}
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+static void test_get_hierarchy(struct kunit *const test)
+{
+	struct landlock_hierarchy dom0_hierarchy = {
+		.id = 10,
+	};
+	struct landlock_hierarchy dom1_hierarchy = {
+		.parent = &dom0_hierarchy,
+		.id = 20,
+	};
+	struct landlock_hierarchy dom2_hierarchy = {
+		.parent = &dom1_hierarchy,
+		.id = 30,
+	};
+	struct landlock_domain dom2 = {
+		.hierarchy = &dom2_hierarchy,
+		.num_layers = 3,
+	};
+
+	KUNIT_EXPECT_EQ(test, 10, get_hierarchy(&dom2, 0)->id);
+	KUNIT_EXPECT_EQ(test, 20, get_hierarchy(&dom2, 1)->id);
+	KUNIT_EXPECT_EQ(test, 30, get_hierarchy(&dom2, 2)->id);
+	/* KUNIT_EXPECT_EQ(test, 30, get_hierarchy(&dom2, -1)->id); */
+}
+
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
+
+/* Get the youngest layer that denied the access_request. */
+static size_t get_denied_layer(const struct landlock_domain *const domain,
+			       access_mask_t *const access_request,
+			       const struct layer_masks *masks)
+{
+	for (ssize_t i = ARRAY_SIZE(masks->layers) - 1; i >= 0; i--) {
+		if (masks->layers[i].access & *access_request) {
+			*access_request &= masks->layers[i].access;
+			return i;
+		}
+	}
+
+	/* Not found - fall back to default values */
+	*access_request = 0;
+	return domain->num_layers - 1;
+}
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+static void test_get_denied_layer(struct kunit *const test)
+{
+	const struct landlock_domain dom = {
+		.num_layers = 5,
+	};
+	const struct layer_masks masks = {
+		.layers[0].access = LANDLOCK_ACCESS_FS_EXECUTE |
+				    LANDLOCK_ACCESS_FS_READ_DIR,
+		.layers[1].access = LANDLOCK_ACCESS_FS_READ_FILE |
+				    LANDLOCK_ACCESS_FS_READ_DIR,
+		.layers[2].access = LANDLOCK_ACCESS_FS_REMOVE_DIR,
+	};
+	access_mask_t access;
+
+	access = LANDLOCK_ACCESS_FS_EXECUTE;
+	KUNIT_EXPECT_EQ(test, 0, get_denied_layer(&dom, &access, &masks));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_EXECUTE);
+
+	access = LANDLOCK_ACCESS_FS_READ_FILE;
+	KUNIT_EXPECT_EQ(test, 1, get_denied_layer(&dom, &access, &masks));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_READ_FILE);
+
+	access = LANDLOCK_ACCESS_FS_READ_DIR;
+	KUNIT_EXPECT_EQ(test, 1, get_denied_layer(&dom, &access, &masks));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_READ_DIR);
+
+	access = LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_READ_DIR;
+	KUNIT_EXPECT_EQ(test, 1, get_denied_layer(&dom, &access, &masks));
+	KUNIT_EXPECT_EQ(test, access,
+			LANDLOCK_ACCESS_FS_READ_FILE |
+				LANDLOCK_ACCESS_FS_READ_DIR);
+
+	access = LANDLOCK_ACCESS_FS_EXECUTE | LANDLOCK_ACCESS_FS_READ_DIR;
+	KUNIT_EXPECT_EQ(test, 1, get_denied_layer(&dom, &access, &masks));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_READ_DIR);
+
+	access = LANDLOCK_ACCESS_FS_WRITE_FILE;
+	KUNIT_EXPECT_EQ(test, 4, get_denied_layer(&dom, &access, &masks));
+	KUNIT_EXPECT_EQ(test, access, 0);
+}
+
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
+
+static size_t
+get_layer_from_deny_masks(access_mask_t *const access_request,
+			  const access_mask_t all_existing_optional_access,
+			  const deny_masks_t deny_masks,
+			  optional_access_t quiet_optional_accesses,
+			  bool *quiet)
+{
+	const unsigned long access_opt = all_existing_optional_access;
+	const unsigned long access_req = *access_request;
+	access_mask_t missing = 0;
+	size_t youngest_layer = 0;
+	size_t access_index = 0;
+	unsigned long access_bit;
+	bool should_quiet = false;
+
+	/* This will require change with new object types. */
+	WARN_ON_ONCE(access_opt != _LANDLOCK_ACCESS_FS_OPTIONAL);
+
+	for_each_set_bit(access_bit, &access_opt,
+			 BITS_PER_TYPE(access_mask_t)) {
+		if (access_req & BIT(access_bit)) {
+			const size_t layer =
+				(deny_masks >>
+				 (access_index *
+				  HWEIGHT(LANDLOCK_MAX_NUM_LAYERS - 1))) &
+				(LANDLOCK_MAX_NUM_LAYERS - 1);
+			const bool layer_has_quiet =
+				!!(quiet_optional_accesses & BIT(access_index));
+
+			if (layer > youngest_layer) {
+				youngest_layer = layer;
+				missing = BIT(access_bit);
+				should_quiet = layer_has_quiet;
+			} else if (layer == youngest_layer) {
+				missing |= BIT(access_bit);
+				/*
+				 * Whether the layer has rules with quiet flag
+				 * covering the file accessed does not depend on
+				 * the access, and so the following
+				 * WARN_ON_ONCE() should not fail.
+				 */
+				WARN_ON_ONCE(should_quiet && !layer_has_quiet);
+				should_quiet = layer_has_quiet;
+			}
+		}
+		access_index++;
+	}
+
+	*access_request = missing;
+	*quiet = should_quiet;
+	return youngest_layer;
+}
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+static void test_get_layer_from_deny_masks(struct kunit *const test)
+{
+	deny_masks_t deny_mask;
+	access_mask_t access;
+	optional_access_t quiet_optional_accesses;
+	bool quiet;
+
+	/* truncate:0 ioctl_dev:2 */
+	deny_mask = 0x20;
+	quiet_optional_accesses = 0;
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE;
+	KUNIT_EXPECT_EQ(test, 0,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
+	KUNIT_EXPECT_EQ(test, quiet, false);
+
+	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 2,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
+	KUNIT_EXPECT_EQ(test, quiet, false);
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 2,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
+	KUNIT_EXPECT_EQ(test, quiet, false);
+
+	/* layer denying truncate: quiet, ioctl: not quiet */
+	quiet_optional_accesses = 0b01;
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE;
+	KUNIT_EXPECT_EQ(test, 0,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
+	KUNIT_EXPECT_EQ(test, quiet, true);
+
+	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 2,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
+	KUNIT_EXPECT_EQ(test, quiet, false);
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 2,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
+	KUNIT_EXPECT_EQ(test, quiet, false);
+
+	/* Reverse order - truncate:2 ioctl_dev:0 */
+	deny_mask = 0x02;
+	quiet_optional_accesses = 0;
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE;
+	KUNIT_EXPECT_EQ(test, 2,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
+	KUNIT_EXPECT_EQ(test, quiet, false);
+
+	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 0,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
+	KUNIT_EXPECT_EQ(test, quiet, false);
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 2,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
+	KUNIT_EXPECT_EQ(test, quiet, false);
+
+	/* layer denying truncate: quiet, ioctl: not quiet */
+	quiet_optional_accesses = 0b01;
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE;
+	KUNIT_EXPECT_EQ(test, 2,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
+	KUNIT_EXPECT_EQ(test, quiet, true);
+
+	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 0,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
+	KUNIT_EXPECT_EQ(test, quiet, false);
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 2,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
+	KUNIT_EXPECT_EQ(test, quiet, true);
+
+	/* layer denying truncate: not quiet, ioctl: quiet */
+	quiet_optional_accesses = 0b10;
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE;
+	KUNIT_EXPECT_EQ(test, 2,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
+	KUNIT_EXPECT_EQ(test, quiet, false);
+
+	access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 0,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_IOCTL_DEV);
+	KUNIT_EXPECT_EQ(test, quiet, true);
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 2,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
+	KUNIT_EXPECT_EQ(test, quiet, false);
+
+	/* truncate:15 ioctl_dev:15 */
+	deny_mask = 0xff;
+	quiet_optional_accesses = 0;
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE;
+	KUNIT_EXPECT_EQ(test, 15,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
+	KUNIT_EXPECT_EQ(test, quiet, false);
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 15,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access,
+			LANDLOCK_ACCESS_FS_TRUNCATE |
+				LANDLOCK_ACCESS_FS_IOCTL_DEV);
+	KUNIT_EXPECT_EQ(test, quiet, false);
+
+	/* Both quiet (same layer so quietness must be the same) */
+	quiet_optional_accesses = 0b11;
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE;
+	KUNIT_EXPECT_EQ(test, 15,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access, LANDLOCK_ACCESS_FS_TRUNCATE);
+	KUNIT_EXPECT_EQ(test, quiet, true);
+
+	access = LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	KUNIT_EXPECT_EQ(test, 15,
+			get_layer_from_deny_masks(
+				&access, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				deny_mask, quiet_optional_accesses, &quiet));
+	KUNIT_EXPECT_EQ(test, access,
+			LANDLOCK_ACCESS_FS_TRUNCATE |
+				LANDLOCK_ACCESS_FS_IOCTL_DEV);
+	KUNIT_EXPECT_EQ(test, quiet, true);
+}
+
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
+
+static bool is_valid_request(const struct landlock_request *const request)
+{
+	if (WARN_ON_ONCE(request->layer_plus_one > LANDLOCK_MAX_NUM_LAYERS))
+		return false;
+
+	if (WARN_ON_ONCE(!(!!request->layer_plus_one ^ !!request->access)))
+		return false;
+
+	if (request->access) {
+		if (WARN_ON_ONCE(!(!!request->layer_masks ^
+				   !!request->all_existing_optional_access)))
+			return false;
+	} else {
+		if (WARN_ON_ONCE(request->layer_masks ||
+				 request->all_existing_optional_access))
+			return false;
+	}
+
+	if (request->deny_masks) {
+		if (WARN_ON_ONCE(!request->all_existing_optional_access))
+			return false;
+		static_assert(sizeof(request->all_existing_optional_access) ==
+			      sizeof(u32));
+		if (WARN_ON_ONCE(
+			    request->quiet_optional_accesses >=
+			    BIT(hweight32(
+				    request->all_existing_optional_access))))
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * landlock_log_denial - Log a denied access
+ *
+ * @subject: The Landlock subject's credential denying an action.
+ * @request: Detail of the user space request.
+ */
+void landlock_log_denial(const struct landlock_cred_security *const subject,
+			 const struct landlock_request *const request)
+{
+	struct landlock_hierarchy *youngest_denied;
+	size_t youngest_layer;
+	access_mask_t missing;
+	bool object_quiet_flag = false;
+
+	if (WARN_ON_ONCE(!subject || !subject->domain ||
+			 !subject->domain->hierarchy || !request))
+		return;
+
+	if (!is_valid_request(request))
+		return;
+
+	missing = request->access;
+	if (missing) {
+		/* Gets the nearest domain that denies the request. */
+		if (request->layer_masks) {
+			youngest_layer = get_denied_layer(subject->domain,
+							  &missing,
+							  request->layer_masks);
+			object_quiet_flag =
+				request->layer_masks->layers[youngest_layer]
+					.quiet;
+		} else {
+			youngest_layer = get_layer_from_deny_masks(
+				&missing, _LANDLOCK_ACCESS_FS_OPTIONAL,
+				request->deny_masks,
+				request->quiet_optional_accesses,
+				&object_quiet_flag);
+		}
+		youngest_denied =
+			get_hierarchy(subject->domain, youngest_layer);
+	} else {
+		youngest_layer = request->layer_plus_one - 1;
+		youngest_denied =
+			get_hierarchy(subject->domain, youngest_layer);
+	}
+
+	if (READ_ONCE(youngest_denied->log_status) == LANDLOCK_LOG_DISABLED)
+		return;
+
+	/*
+	 * Consistently keeps track of the number of denied access requests even
+	 * if audit is currently disabled, or if audit rules currently exclude
+	 * this record type, or if landlock_restrict_self(2)'s flags quiet logs.
+	 */
+	atomic64_inc(&youngest_denied->num_denials);
+
+	landlock_audit_denial(subject, request, youngest_denied, youngest_layer,
+			      missing, object_quiet_flag);
+}
+
+/**
+ * landlock_log_free_domain - Log domain deallocation
+ *
+ * @hierarchy: The domain's hierarchy being deallocated.
+ *
+ * Called in a work queue scheduled by landlock_put_domain_deferred() called by
+ * hook_cred_free().
+ */
+void landlock_log_free_domain(const struct landlock_hierarchy *const hierarchy)
+{
+	if (WARN_ON_ONCE(!hierarchy))
+		return;
+
+	landlock_audit_free_domain(hierarchy);
+}
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+static struct kunit_case test_cases[] = {
+	/* clang-format off */
+	KUNIT_CASE(test_get_hierarchy),
+	KUNIT_CASE(test_get_denied_layer),
+	KUNIT_CASE(test_get_layer_from_deny_masks),
+	{}
+	/* clang-format on */
+};
+
+static struct kunit_suite test_suite = {
+	.name = "landlock_log",
+	.test_cases = test_cases,
+};
+
+kunit_test_suite(test_suite);
+
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
diff --git a/security/landlock/log.h b/security/landlock/log.h
new file mode 100644
index 000000000000..25afc17cf055
--- /dev/null
+++ b/security/landlock/log.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock - Log helpers
+ *
+ * Copyright © 2023-2025 Microsoft Corporation
+ */
+
+#ifndef _SECURITY_LANDLOCK_LOG_H
+#define _SECURITY_LANDLOCK_LOG_H
+
+#include <linux/lsm_audit.h>
+
+#include "access.h"
+
+struct landlock_cred_security;
+struct landlock_hierarchy;
+
+enum landlock_request_type {
+	LANDLOCK_REQUEST_PTRACE = 1,
+	LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY,
+	LANDLOCK_REQUEST_FS_ACCESS,
+	LANDLOCK_REQUEST_NET_ACCESS,
+	LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
+	LANDLOCK_REQUEST_SCOPE_SIGNAL,
+};
+
+/*
+ * We should be careful to only use a variable of this type for
+ * landlock_log_denial().  This way, the compiler can remove it entirely if
+ * CONFIG_SECURITY_LANDLOCK_LOG is not set.
+ */
+struct landlock_request {
+	/* Mandatory fields. */
+	enum landlock_request_type type;
+	struct common_audit_data audit;
+
+	/**
+	 * layer_plus_one: First layer level that denies the request + 1.  The
+	 * extra one is useful to detect uninitialized field.
+	 */
+	size_t layer_plus_one;
+
+	/* Required field for configurable access control. */
+	access_mask_t access;
+
+	/* Required fields for requests with layer masks. */
+	const struct layer_masks *layer_masks;
+
+	/* Required fields for requests with deny masks. */
+	const access_mask_t all_existing_optional_access;
+	deny_masks_t deny_masks;
+	optional_access_t quiet_optional_accesses;
+};
+
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
+
+void landlock_log_free_domain(const struct landlock_hierarchy *const hierarchy);
+
+void landlock_log_denial(const struct landlock_cred_security *const subject,
+			 const struct landlock_request *const request);
+
+#else /* CONFIG_SECURITY_LANDLOCK_LOG */
+
+static inline void
+landlock_log_free_domain(const struct landlock_hierarchy *const hierarchy)
+{
+}
+
+static inline void
+landlock_log_denial(const struct landlock_cred_security *const subject,
+		    const struct landlock_request *const request)
+{
+}
+
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
+
+#endif /* _SECURITY_LANDLOCK_LOG_H */
diff --git a/security/landlock/net.c b/security/landlock/net.c
index 7447738ca2e6..e27b3ba15664 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -12,11 +12,11 @@
 #include <linux/socket.h>
 #include <net/ipv6.h>
 
-#include "audit.h"
 #include "common.h"
 #include "cred.h"
 #include "domain.h"
 #include "limits.h"
+#include "log.h"
 #include "net.h"
 #include "ruleset.h"
 
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index fe8505dc0ba5..0ad20a6f9564 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -574,11 +574,11 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 
 	new_llcred = landlock_cred(new_cred);
 
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 	prev_log_subdomains = !new_llcred->log_subdomains_off;
 	new_llcred->log_subdomains_off = !prev_log_subdomains ||
 					 !log_subdomains;
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 
 	/*
 	 * The only case when a ruleset may not be set is if
@@ -600,20 +600,20 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 			return PTR_ERR(new_dom);
 		}
 
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 		new_dom->hierarchy->log_same_exec = log_same_exec;
 		new_dom->hierarchy->log_new_exec = log_new_exec;
 		if ((!log_same_exec && !log_new_exec) || !prev_log_subdomains)
 			new_dom->hierarchy->log_status = LANDLOCK_LOG_DISABLED;
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 
 		/* Replaces the old (prepared) domain. */
 		landlock_put_domain(new_llcred->domain);
 		new_llcred->domain = new_dom;
 
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 		new_llcred->domain_exec |= BIT(new_dom->num_layers - 1);
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 	}
 
 	if (flags & LANDLOCK_RESTRICT_SELF_TSYNC) {
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 40e6bfa4bc75..c0da22736ea0 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -20,11 +20,11 @@
 #include <net/af_unix.h>
 #include <net/sock.h>
 
-#include "audit.h"
 #include "common.h"
 #include "cred.h"
 #include "domain.h"
 #include "fs.h"
+#include "log.h"
 #include "ruleset.h"
 #include "setup.h"
 #include "task.h"
@@ -435,9 +435,9 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 			.type = LSM_AUDIT_DATA_TASK,
 			.u.tsk = tsk,
 		},
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 		.layer_plus_one = landlock_file(fown->file)->fown_layer + 1,
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 	});
 	return -EPERM;
 }
-- 
2.54.0

