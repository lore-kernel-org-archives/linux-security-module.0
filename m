Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E9B3CAA50
	for <linux-security-module@vger.kernel.org>; Sun, 26 Jul 2026 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785082487; cv=none; b=AlAWLAv6x0tKQaMeq2/D/IoPh4oeTXHedbAiRirIjnXRVeQslDbl8+N1pPGY0CEr+XpRqfnoHLt3oq85TqFHLeK9pl1C8MS1iyAdjaaV7ad8ldWMoRf0MFU9+48KRpsJaNqadpMmX8wLNv0bnNGSnQPu4DsZfUFBH8jNqaUGcvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785082487; c=relaxed/simple;
	bh=ei1bVhxxrrZLqPxM+U2iqnPHg19omMxWOXRhvj3XWfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GiBQTeya8bcBhpcRyraTPmYtU7oCEV5mIEwrz6qtRU15jseNFTV8drbCZVTnoLkBZY98a2tTS8RWcT79MLC3rD3Ko4ouBrJtzyRfnq72PGtFHZGpNo3w3IlnbbTa5k4S3C+ddmDDYy3HTLGQgNVEVZzfZ4UfCMKwk63OtspgRZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=cxPzsWGi; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="cxPzsWGi"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h7Rd04tNPzcpZ;
	Sun, 26 Jul 2026 18:14:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785082468;
	bh=gPEj/D4/x3enVoXIM0/GTUEQiuiCoLLmGGGvn+jWSlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cxPzsWGiBFHZ3N4VFu/BNeq4KLZraC9WDpfA6ENQyEhOZle3Bw5A+GZ2tdZ6b6ZQx
	 pRH/gaFUFhC9KBYcAm619ooYOptuOF4JpbpiQgyS++mahklAwNHI17+6oOiNiO3rGt
	 Ac3X2H8e+ZbDhz1yphOJIeieZg93WtUgLajnpMZk=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4h7Rcz47fqzmft;
	Sun, 26 Jul 2026 18:14:27 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Daniel Durning <danieldurning.work@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Suess <utilityemal77@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Shervin Oloumi <enlightened@google.com>,
	Tingmao Wang <m@maowtm.org>,
	kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 10/12] selftests/landlock: Add capability restriction tests
Date: Sun, 26 Jul 2026 18:13:55 +0200
Message-ID: <20260726161400.3010511-11-mic@digikod.net>
In-Reply-To: <20260726161400.3010511-1-mic@digikod.net>
References: <20260726161400.3010511-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add tests to exercise LANDLOCK_PERM_CAPABILITY_USE enforcement.  A
sandboxed process is denied a handled capability when no rule grants it,
and an explicit rule restores the capability.  Unknown capability values
above CAP_LAST_CAP are silently accepted at rule-add time but have no
runtime effect, so deny-by-default still applies once the domain is
enforced.  Stacking variants cover the three per-layer combinations that
exercise distinct walker paths (allow/deny, allow/allow, deny/allow)
plus a mixed-layer case where one layer does not handle
LANDLOCK_PERM_CAPABILITY_USE, forcing the walker to skip it.  Invalid
rule attributes (unknown flags, out-of-range values) return the expected
errors.

Two tests exercise non-standard capability gain paths.  The first
enforces a domain via CAP_SYS_ADMIN (no_new_privs is not set) and
verifies that denied capabilities are blocked even when still in the
effective set.  The second creates a user namespace under a Landlock
domain to verify that capabilities gained through the kernel's user
namespace ownership bypass (cap_capable_helper) are still restricted by
the domain's rules.

Audit tests verify that a denied capability produces the expected audit
record with the capability number, and that an allowed capability
generates no denial record.

Test coverage for security/landlock is 92.1% of 2543 lines according to
LLVM 22.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
https://patch.msgid.link/20260527181127.879771-8-mic@digikod.net
- Rebased for ABI 11 and the renamed capability rule attribute (perm
  plus allowed_capabilities/quiet_capabilities).
- Add per-member quiet audit tests for the capability permission:
  cap_audit.quieted, plus quiet-only and allow+quiet legs in
  add_rule_bad_attr and the add_cap_rule_full helper.
- add_rule_bad_attr: drop the dead quiet_capabilities reset after the
  allow+quiet rule and reset it explicitly where the following rule
  needs an allow-only attr, clarifying intent.
- Strengthen the audit tests with positive controls: cap_audit.quieted
  and cap_audit.noaudit_probe_not_logged now also assert that a normal
  (non-quiet, non-noaudit) capability denial in the same domain IS
  logged, proving suppression is not global.  cap_audit.quieted also
  asserts the quieted capability is still denied (EPERM), not merely
  unlogged.
- Add cap_audit.quiet_unknown_bit_no_effect (an unknown quiet bit does
  not suppress a known capability denial).

Changes since v1:
https://patch.msgid.link/20260312100444.2609563-8-mic@digikod.net
- Reflow comments after check-linux.sh comment fixes.
- Rename LANDLOCK_PERM_NAMESPACE_ENTER references to
  LANDLOCK_PERM_NAMESPACE_USE and bump the abi_version expectation
  to 11 (companion changes to the introducing commit).
- Add add_rule_unknown_no_runtime_effect: assert that a rule listing
  only unknown capability bits is accepted at rule-add time but has
  no runtime effect, so an actual CAP_* exercise (sethostname with
  CAP_SYS_ADMIN) is still denied by deny-by-default once the domain
  is enforced.
- Add cap_stacking parent_denies variant covering the inverse
  direction of stacking: layer 1 denies CAP_SYS_ADMIN, layer 2
  allows, capability still denied.  Completes the per-layer walker
  direction coverage.
- Assert records.domain == 0 in cap_audit.allowed so the test also
  checks that no domain-allocation record is emitted when nothing
  is denied.
---
 tools/testing/selftests/landlock/base_test.c |  18 +
 tools/testing/selftests/landlock/cap_test.c  | 889 +++++++++++++++++++
 2 files changed, 907 insertions(+)
 create mode 100644 tools/testing/selftests/landlock/cap_test.c

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index b8b5fa1042ba..bcb5bdafd9ed 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -142,6 +142,24 @@ TEST(errata)
 	ASSERT_EQ(EINVAL, errno);
 }
 
+#define PERM_LAST LANDLOCK_PERM_CAPABILITY_USE
+
+TEST(ruleset_with_unknown_perm)
+{
+	__u64 perm_mask;
+
+	for (perm_mask = 1ULL << 63; perm_mask != PERM_LAST; perm_mask >>= 1) {
+		struct landlock_ruleset_attr ruleset_attr = {
+			.handled_perm = perm_mask,
+		};
+
+		/* Unknown handled_perm values must be rejected. */
+		ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
+						      sizeof(ruleset_attr), 0));
+		ASSERT_EQ(EINVAL, errno);
+	}
+}
+
 /* Tests ordering of syscall argument checks. */
 TEST(create_ruleset_checks_ordering)
 {
diff --git a/tools/testing/selftests/landlock/cap_test.c b/tools/testing/selftests/landlock/cap_test.c
new file mode 100644
index 000000000000..a86fd72b5639
--- /dev/null
+++ b/tools/testing/selftests/landlock/cap_test.c
@@ -0,0 +1,889 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock tests - Capability restriction
+ *
+ * Copyright © 2026 Cloudflare, Inc.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/capability.h>
+#include <linux/landlock.h>
+#include <sched.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/wait.h>
+#include <sys/xattr.h>
+#include <unistd.h>
+
+#include "audit.h"
+#include "common.h"
+
+static bool list_has_xattr(const char *list, ssize_t len, const char *name)
+{
+	const char *p;
+
+	for (p = list; p < list + len; p += strlen(p) + 1)
+		if (strcmp(p, name) == 0)
+			return true;
+	return false;
+}
+
+static int create_cap_ruleset(void)
+{
+	const struct landlock_ruleset_attr attr = {
+		.handled_perm = LANDLOCK_PERM_CAPABILITY_USE,
+	};
+
+	return landlock_create_ruleset(&attr, sizeof(attr), 0);
+}
+
+static int add_cap_rule(int ruleset_fd, __u64 cap)
+{
+	const struct landlock_capability_attr attr = {
+		.perm = LANDLOCK_PERM_CAPABILITY_USE,
+		.allowed_capabilities = (1ULL << cap),
+	};
+
+	return landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY, &attr,
+				 0);
+}
+
+static int add_cap_rule_full(int ruleset_fd, __u64 allowed, __u64 quiet)
+{
+	const struct landlock_capability_attr attr = {
+		.perm = LANDLOCK_PERM_CAPABILITY_USE,
+		.allowed_capabilities = allowed,
+		.quiet_capabilities = quiet,
+	};
+
+	return landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY, &attr,
+				 0);
+}
+
+TEST(add_rule_bad_attr)
+{
+	const struct landlock_ruleset_attr ns_only_attr = {
+		.handled_perm = LANDLOCK_PERM_NAMESPACE_USE,
+	};
+	int ruleset_fd;
+	struct landlock_capability_attr attr = {};
+
+	ruleset_fd = create_cap_ruleset();
+	ASSERT_LE(0, ruleset_fd);
+
+	/* Empty perm selector returns ENOMSG. */
+	attr.perm = 0;
+	attr.allowed_capabilities = (1ULL << CAP_NET_RAW);
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
+					&attr, 0));
+	ASSERT_EQ(ENOMSG, errno);
+
+	/* Useless rule: neither allowed nor quiet capabilities set. */
+	attr.perm = LANDLOCK_PERM_CAPABILITY_USE;
+	attr.allowed_capabilities = 0;
+	attr.quiet_capabilities = 0;
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
+					&attr, 0));
+	ASSERT_EQ(ENOMSG, errno);
+
+	/* Quiet-only rule (empty allowed set) is legal. */
+	attr.perm = LANDLOCK_PERM_CAPABILITY_USE;
+	attr.allowed_capabilities = 0;
+	attr.quiet_capabilities = (1ULL << CAP_NET_RAW);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
+				       &attr, 0));
+
+	/* Allow and quiet different members in the same rule. */
+	attr.perm = LANDLOCK_PERM_CAPABILITY_USE;
+	attr.allowed_capabilities = (1ULL << CAP_SYS_ADMIN);
+	attr.quiet_capabilities = (1ULL << CAP_NET_RAW);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
+				       &attr, 0));
+
+	/* perm with unhandled bit. */
+	attr.perm = LANDLOCK_PERM_CAPABILITY_USE | LANDLOCK_PERM_NAMESPACE_USE;
+	attr.allowed_capabilities = (1ULL << CAP_NET_RAW);
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
+					&attr, 0));
+	ASSERT_EQ(EINVAL, errno);
+
+	/* perm with wrong type. */
+	attr.perm = LANDLOCK_PERM_NAMESPACE_USE;
+	attr.allowed_capabilities = (1ULL << CAP_NET_RAW);
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
+					&attr, 0));
+	ASSERT_EQ(EINVAL, errno);
+
+	/*
+	 * Unknown capability bits (e.g. bit 63) are silently accepted for
+	 * forward compatibility.  Only known bits are stored.
+	 */
+	attr.perm = LANDLOCK_PERM_CAPABILITY_USE;
+	attr.allowed_capabilities = 1ULL << 63;
+	attr.quiet_capabilities = 0;
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
+				       &attr, 0));
+
+	/*
+	 * LANDLOCK_ADD_RULE_QUIET (and any other flag) is filesystem/network
+	 * only and must be rejected for capability rules, even with an
+	 * otherwise-valid attr (cases.md Q-E5).
+	 */
+	attr.perm = LANDLOCK_PERM_CAPABILITY_USE;
+	attr.allowed_capabilities = (1ULL << CAP_NET_RAW);
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
+					&attr, LANDLOCK_ADD_RULE_QUIET));
+	ASSERT_EQ(EINVAL, errno);
+
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Ruleset handles PERM_NAMESPACE_USE but not PERM_CAPABILITY_USE:
+	 * adding a capability rule must be rejected.
+	 */
+	ruleset_fd =
+		landlock_create_ruleset(&ns_only_attr, sizeof(ns_only_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	attr.perm = LANDLOCK_PERM_CAPABILITY_USE;
+	attr.allowed_capabilities = (1ULL << CAP_NET_RAW);
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
+					&attr, 0));
+	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
+/*
+ * Unknown capability values above CAP_LAST_CAP are silently accepted
+ * (allow-list: they have no effect since the kernel never checks them).
+ */
+TEST(add_rule_unknown)
+{
+	int ruleset_fd;
+	struct landlock_capability_attr attr = {
+		.perm = LANDLOCK_PERM_CAPABILITY_USE,
+	};
+
+	ruleset_fd = create_cap_ruleset();
+	ASSERT_LE(0, ruleset_fd);
+
+	/* Just above CAP_LAST_CAP should succeed. */
+	attr.allowed_capabilities = (1ULL << (CAP_LAST_CAP + 1));
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
+				       &attr, 0));
+
+	/* High values (below bit 63) should succeed. */
+	attr.allowed_capabilities = (1ULL << 62);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
+				       &attr, 0));
+
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
+/*
+ * A rule that lists only capability bits unknown to the running kernel is
+ * accepted by landlock_add_rule() but has no runtime effect: once the domain is
+ * enforced, any actual CAP_* capability is still denied by the per-category
+ * deny-by-default behaviour.  This documents the forward-compatibility
+ * contract: unknown bits are silently accepted so the same policy can be loaded
+ * across kernels, but they never grant a capability that the running kernel
+ * knows nothing about.
+ */
+TEST(add_rule_unknown_no_runtime_effect)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_perm = LANDLOCK_PERM_CAPABILITY_USE,
+	};
+	struct landlock_capability_attr attr = {
+		.perm = LANDLOCK_PERM_CAPABILITY_USE,
+		/* Only unknown bits above CAP_LAST_CAP. */
+		.allowed_capabilities = (1ULL << (CAP_LAST_CAP + 1)) |
+					(1ULL << 62),
+	};
+	int ruleset_fd;
+
+	disable_caps(_metadata);
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
+				       &attr, 0));
+
+	/*
+	 * Isolate hostname changes and establish a baseline: with CAP_SYS_ADMIN
+	 * and absent the domain, sethostname(2) succeeds.  This ensures the
+	 * EPERM below is attributable to Landlock rather than to a missing
+	 * capability, and fails if the hook always allows.
+	 */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, unshare(CLONE_NEWUTS));
+	ASSERT_EQ(0, sethostname("baseline", 8));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * CAP_SYS_ADMIN is a real, known capability but was not authorised by
+	 * the rule above; deny-by-default applies.  sethostname(2) requires
+	 * CAP_SYS_ADMIN.
+	 */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	EXPECT_EQ(-1, sethostname("test", 4));
+	EXPECT_EQ(EPERM, errno);
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+/* clang-format off */
+FIXTURE(cap_enforce) {};
+/* clang-format on */
+
+FIXTURE_VARIANT(cap_enforce)
+{
+	const bool is_sandboxed;
+	const bool handle_caps;
+	const __u64 allowed_cap;
+	const int expected_sysadmin;
+	const int expected_chroot;
+};
+
+/*
+ * Unsandboxed baseline: no Landlock domain is enforced.  Both capabilities
+ * should work normally.
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(cap_enforce, unsandboxed) {
+	.is_sandboxed = false,
+	.handle_caps = false,
+	.allowed_cap = 0,
+	.expected_sysadmin = 0,
+	.expected_chroot = 0,
+};
+/* clang-format on */
+
+/*
+ * Denied: capabilities are handled but no rule allows them.  All capability
+ * checks must be denied by Landlock even if the capability is effective.
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(cap_enforce, denied) {
+	.is_sandboxed = true,
+	.handle_caps = true,
+	.allowed_cap = 0,
+	.expected_sysadmin = EPERM,
+	.expected_chroot = EPERM,
+};
+/* clang-format on */
+
+/*
+ * Allowed: CAP_SYS_ADMIN is allowed by rule, CAP_SYS_CHROOT is not.  Only the
+ * explicitly allowed capability should succeed.
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(cap_enforce, allowed) {
+	.is_sandboxed = true,
+	.handle_caps = true,
+	.allowed_cap = CAP_SYS_ADMIN,
+	.expected_sysadmin = 0,
+	.expected_chroot = EPERM,
+};
+/* clang-format on */
+
+/*
+ * Unhandled: the ruleset does not handle LANDLOCK_PERM_CAPABILITY_USE at all
+ * (only handles FS access).  Both capabilities should work since the domain
+ * does not restrict them.
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(cap_enforce, unhandled) {
+	.is_sandboxed = true,
+	.handle_caps = false,
+	.allowed_cap = 0,
+	.expected_sysadmin = 0,
+	.expected_chroot = 0,
+};
+/* clang-format on */
+
+FIXTURE_SETUP(cap_enforce)
+{
+	disable_caps(_metadata);
+}
+
+FIXTURE_TEARDOWN(cap_enforce)
+{
+}
+
+/*
+ * Capability enforcement: tests the four fundamental enforcement scenarios
+ * (unsandboxed baseline, denied, allowed, unhandled) using two independent
+ * capability checks (sethostname for CAP_SYS_ADMIN, chroot for CAP_SYS_CHROOT).
+ */
+TEST_F(cap_enforce, use)
+{
+	int ruleset_fd;
+
+	/* Isolate hostname changes from other tests. */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, unshare(CLONE_NEWUTS));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	if (variant->is_sandboxed) {
+		if (variant->handle_caps) {
+			ruleset_fd = create_cap_ruleset();
+		} else {
+			const struct landlock_ruleset_attr attr = {
+				.handled_access_fs =
+					LANDLOCK_ACCESS_FS_READ_FILE,
+			};
+
+			ruleset_fd =
+				landlock_create_ruleset(&attr, sizeof(attr), 0);
+		}
+		ASSERT_LE(0, ruleset_fd);
+
+		if (variant->allowed_cap)
+			ASSERT_EQ(0, add_cap_rule(ruleset_fd,
+						  variant->allowed_cap));
+
+		enforce_ruleset(_metadata, ruleset_fd);
+		EXPECT_EQ(0, close(ruleset_fd));
+	}
+
+	/* Test CAP_SYS_ADMIN via sethostname. */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	if (variant->expected_sysadmin) {
+		EXPECT_EQ(-1, sethostname("test", 4));
+		EXPECT_EQ(variant->expected_sysadmin, errno);
+	} else {
+		EXPECT_EQ(0, sethostname("test", 4));
+	}
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	/* Test CAP_SYS_CHROOT via chroot. */
+	set_cap(_metadata, CAP_SYS_CHROOT);
+	if (variant->expected_chroot) {
+		EXPECT_EQ(-1, chroot("/"));
+		EXPECT_EQ(variant->expected_chroot, errno);
+	} else {
+		EXPECT_EQ(0, chroot("/"));
+	}
+}
+
+/*
+ * Layer stacking: both layers must allow CAP_SYS_ADMIN for the capability to be
+ * exercisable.  Variants cover the three per-layer combinations that exercise
+ * distinct walker paths (allow/deny, allow/allow, deny/allow), an unsandboxed
+ * baseline, and a mixed-layer case where one layer does not handle
+ * PERM_CAPABILITY_USE at all.
+ */
+/* clang-format off */
+FIXTURE(cap_stacking) {};
+/* clang-format on */
+
+FIXTURE_VARIANT(cap_stacking)
+{
+	const bool is_sandboxed;
+	const bool first_layer_allows;
+	const bool second_layer_allows;
+	const bool second_layer_is_fs_only;
+	const int expected_sysadmin;
+	const int expected_chroot;
+};
+
+/*
+ * Unsandboxed baseline: no Landlock layers are stacked.  Both capabilities
+ * should work normally.
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(cap_stacking, unsandboxed) {
+	.is_sandboxed = false,
+	.first_layer_allows = false,
+	.second_layer_allows = false,
+	.expected_sysadmin = 0,
+	.expected_chroot = 0,
+};
+/* clang-format on */
+
+/* Layer 1 allows CAP_SYS_ADMIN, layer 2 denies -> denied. */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(cap_stacking, deny) {
+	.is_sandboxed = true,
+	.first_layer_allows = true,
+	.second_layer_allows = false,
+	.expected_sysadmin = EPERM,
+	.expected_chroot = EPERM,
+};
+/* clang-format on */
+
+/* Both layers allow CAP_SYS_ADMIN -> sysadmin succeeds, chroot still denied. */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(cap_stacking, allow) {
+	.is_sandboxed = true,
+	.first_layer_allows = true,
+	.second_layer_allows = true,
+	.expected_sysadmin = 0,
+	.expected_chroot = EPERM,
+};
+/* clang-format on */
+
+/*
+ * Layer 1 denies CAP_SYS_ADMIN, layer 2 allows -> still denied: a child layer
+ * cannot grant what an ancestor layer withheld.  Complements the
+ * parent-allows/child-denies variant; together they verify the walker checks
+ * both layers and accepts only the (allow, allow) cell.
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(cap_stacking, parent_denies) {
+	.is_sandboxed = true,
+	.first_layer_allows = false,
+	.second_layer_allows = true,
+	.expected_sysadmin = EPERM,
+	.expected_chroot = EPERM,
+};
+/* clang-format on */
+
+/*
+ * Mixed layers: first layer handles PERM_CAPABILITY_USE (denies all caps),
+ * second layer is FS-only (does not handle it).  The perm walker iterates from
+ * youngest (layer 1) to oldest (layer 0) and must skip the FS-only layer to
+ * find the denying layer beneath.
+ */
+/* clang-format off */
+FIXTURE_VARIANT_ADD(cap_stacking, mixed_layers) {
+	/* clang-format on */
+	.is_sandboxed = true,
+	.first_layer_allows = false,
+	.second_layer_is_fs_only = true,
+	.expected_sysadmin = EPERM,
+	.expected_chroot = EPERM,
+};
+
+FIXTURE_SETUP(cap_stacking)
+{
+	disable_caps(_metadata);
+}
+
+FIXTURE_TEARDOWN(cap_stacking)
+{
+}
+
+TEST_F(cap_stacking, two_layers)
+{
+	int ruleset_fd;
+
+	if (variant->is_sandboxed) {
+		/*
+		 * First layer: handles PERM_CAPABILITY_USE; rule added per
+		 * variant.
+		 */
+		ruleset_fd = create_cap_ruleset();
+		ASSERT_LE(0, ruleset_fd);
+		if (variant->first_layer_allows)
+			ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_SYS_ADMIN));
+
+		enforce_ruleset(_metadata, ruleset_fd);
+		EXPECT_EQ(0, close(ruleset_fd));
+
+		if (variant->second_layer_is_fs_only) {
+			/*
+			 * Second layer: FS-only (does not handle
+			 * PERM_CAPABILITY_USE).  The perm walker must skip this
+			 * layer.
+			 */
+			const struct landlock_ruleset_attr fs_attr = {
+				.handled_access_fs =
+					LANDLOCK_ACCESS_FS_READ_FILE,
+			};
+
+			ruleset_fd = landlock_create_ruleset(
+				&fs_attr, sizeof(fs_attr), 0);
+		} else {
+			/* Second layer: cap allow or deny. */
+			ruleset_fd = create_cap_ruleset();
+			if (variant->second_layer_allows)
+				ASSERT_EQ(0, add_cap_rule(ruleset_fd,
+							  CAP_SYS_ADMIN));
+		}
+		ASSERT_LE(0, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd);
+		EXPECT_EQ(0, close(ruleset_fd));
+	}
+
+	/* Test CAP_SYS_ADMIN via sethostname. */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	if (variant->expected_sysadmin) {
+		EXPECT_EQ(-1, sethostname("test", 4));
+		EXPECT_EQ(variant->expected_sysadmin, errno);
+	} else {
+		EXPECT_EQ(0, sethostname("test", 4));
+	}
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	/* Test CAP_SYS_CHROOT via chroot. */
+	set_cap(_metadata, CAP_SYS_CHROOT);
+	if (variant->expected_chroot) {
+		EXPECT_EQ(-1, chroot("/"));
+		EXPECT_EQ(variant->expected_chroot, errno);
+	} else {
+		EXPECT_EQ(0, chroot("/"));
+	}
+	clear_cap(_metadata, CAP_SYS_CHROOT);
+}
+
+/*
+ * Verify that LANDLOCK_PERM_CAPABILITY_USE enforces when the domain is applied
+ * without no_new_privs, using CAP_SYS_ADMIN for landlock_restrict_self()
+ * authorization instead.  Privileged processes (e.g. container managers) can
+ * sandbox themselves this way.
+ */
+TEST(cap_without_nnp)
+{
+	int ruleset_fd;
+
+	disable_caps(_metadata);
+
+	ruleset_fd = create_cap_ruleset();
+	ASSERT_LE(0, ruleset_fd);
+
+	/* Allow CAP_SYS_CHROOT but not CAP_SYS_ADMIN. */
+	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_SYS_CHROOT));
+
+	/*
+	 * Enforce WITHOUT NNP: landlock_restrict_self() succeeds when the
+	 * caller has CAP_SYS_ADMIN (checked before the new domain takes
+	 * effect).
+	 */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * CAP_SYS_ADMIN is still in effective set but Landlock denies it:
+	 * cap_capable() returns 0, then hook_capable() returns -EPERM.
+	 */
+	EXPECT_EQ(-1, sethostname("test", 4));
+	EXPECT_EQ(EPERM, errno);
+
+	/* CAP_SYS_CHROOT is allowed by the rule. */
+	set_cap(_metadata, CAP_SYS_CHROOT);
+	EXPECT_EQ(0, chroot("/"));
+}
+
+/*
+ * Verify that capabilities gained through user namespace ownership are still
+ * restricted by LANDLOCK_PERM_CAPABILITY_USE.  When a process creates a user
+ * namespace, the kernel grants CAP_FULL_SET in the new namespace via
+ * cap_capable_helper()'s ownership bypass.  Landlock's hook_capable() must
+ * still deny capabilities not in the allowed set, ensuring that user namespace
+ * creation cannot be used to escape capability restrictions.
+ */
+TEST(cap_userns_ownership_bypass)
+{
+	pid_t child;
+	int status;
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		int ruleset_fd;
+
+		disable_caps(_metadata);
+
+		ruleset_fd = create_cap_ruleset();
+		ASSERT_LE(0, ruleset_fd);
+
+		/* Allow CAP_SYS_ADMIN only. */
+		ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_SYS_ADMIN));
+		enforce_ruleset(_metadata, ruleset_fd);
+		EXPECT_EQ(0, close(ruleset_fd));
+
+		/*
+		 * Create a user namespace.  This is unprivileged and does not
+		 * require capabilities.  LANDLOCK_PERM_NAMESPACE_USE is not
+		 * handled so namespace creation is unrestricted.
+		 */
+		ASSERT_EQ(0, unshare(CLONE_NEWUSER));
+
+		/*
+		 * After unshare(CLONE_NEWUSER), the kernel set cap_effective =
+		 * CAP_FULL_SET in the new namespace.  Create a UTS namespace
+		 * (requires CAP_SYS_ADMIN in the new user NS).  Landlock allows
+		 * CAP_SYS_ADMIN.
+		 */
+		ASSERT_EQ(0, unshare(CLONE_NEWUTS))
+		{
+			TH_LOG("unshare(CLONE_NEWUTS): %s", strerror(errno));
+		}
+
+		/*
+		 * sethostname checks against uts_ns->user_ns, which is now the
+		 * new user NS.  CAP_SYS_ADMIN is allowed.
+		 */
+		EXPECT_EQ(0, sethostname("test", 4));
+
+		/*
+		 * chroot checks against current_user_ns(), which is the new
+		 * user NS.  The process has CAP_SYS_CHROOT in cap_effective
+		 * (from user NS creation), so cap_capable() returns 0.  But
+		 * Landlock denies because no rule allows CAP_SYS_CHROOT.
+		 */
+		EXPECT_EQ(-1, chroot("/"));
+		EXPECT_EQ(EPERM, errno);
+
+		_exit(_metadata->exit_code);
+		return;
+	}
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
+/* Audit tests */
+
+static int matches_log_cap(int audit_fd, int cap_number)
+{
+	static const char log_template[] = REGEX_LANDLOCK_PREFIX
+		" blockers=perm\\.capability_use capability=%d $";
+	char log_match[sizeof(log_template) + 10];
+	int log_match_len;
+
+	log_match_len = snprintf(log_match, sizeof(log_match), log_template,
+				 cap_number);
+	if (log_match_len >= sizeof(log_match))
+		return -E2BIG;
+
+	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
+				  NULL);
+}
+
+FIXTURE(cap_audit)
+{
+	struct audit_filter audit_filter;
+	int audit_fd;
+};
+
+FIXTURE_SETUP(cap_audit)
+{
+	ASSERT_TRUE(is_in_init_user_ns());
+
+	disable_caps(_metadata);
+
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+	self->audit_fd = audit_init_with_exe_filter(&self->audit_filter);
+	EXPECT_LE(0, self->audit_fd);
+	clear_cap(_metadata, CAP_AUDIT_CONTROL);
+}
+
+FIXTURE_TEARDOWN(cap_audit)
+{
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+	EXPECT_EQ(0, audit_cleanup(self->audit_fd, &self->audit_filter));
+}
+
+/*
+ * Verifies that a denied capability produces the expected audit record with the
+ * correct capability number and blocker string.
+ */
+TEST_F(cap_audit, denied)
+{
+	struct audit_records records;
+	int ruleset_fd;
+	__u64 domain_id;
+
+	/* Baseline: chroot works before Landlock. */
+	set_cap(_metadata, CAP_SYS_CHROOT);
+	ASSERT_EQ(0, chroot("/"));
+	clear_cap(_metadata, CAP_SYS_CHROOT);
+
+	ruleset_fd = create_cap_ruleset();
+	ASSERT_LE(0, ruleset_fd);
+	/* Allow CAP_AUDIT_CONTROL for child-side audit cleanup. */
+	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_AUDIT_CONTROL));
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/* Deny CAP_SYS_CHROOT (no allow rule). */
+	set_cap(_metadata, CAP_SYS_CHROOT);
+	EXPECT_EQ(-1, chroot("/"));
+	EXPECT_EQ(EPERM, errno);
+	clear_cap(_metadata, CAP_SYS_CHROOT);
+
+	EXPECT_EQ(0, matches_log_cap(self->audit_fd, CAP_SYS_CHROOT));
+
+	/*
+	 * The domain allocation record is emitted in the same event as the
+	 * first denial; anchor its status=allocated and enforcing pid.  Both
+	 * access and domain records are now consumed, so none remain.
+	 */
+	EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd, getpid(),
+						  &domain_id));
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
+}
+
+TEST_F(cap_audit, allowed)
+{
+	struct audit_records records;
+	int ruleset_fd;
+
+	ruleset_fd = create_cap_ruleset();
+	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_SYS_ADMIN));
+	/* Allow CAP_AUDIT_CONTROL for child-side audit cleanup. */
+	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_AUDIT_CONTROL));
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	EXPECT_EQ(0, sethostname("test", 4));
+
+	/* No records: allowed operations never trigger audit logging. */
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
+}
+
+/*
+ * A quieted capability denial is still denied (EPERM); only its audit record is
+ * suppressed.  Quiet-only rule (empty allowed set).
+ */
+TEST_F(cap_audit, quieted)
+{
+	struct audit_records records;
+	int ruleset_fd;
+
+	ruleset_fd = create_cap_ruleset();
+	ASSERT_LE(0, ruleset_fd);
+	/* Allow CAP_AUDIT_CONTROL for child-side audit cleanup. */
+	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_AUDIT_CONTROL));
+	ASSERT_EQ(0,
+		  add_cap_rule_full(ruleset_fd, 0, (1ULL << CAP_SYS_CHROOT)));
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	set_cap(_metadata, CAP_SYS_CHROOT);
+	EXPECT_EQ(-1, chroot("/"));
+	EXPECT_EQ(EPERM, errno);
+	clear_cap(_metadata, CAP_SYS_CHROOT);
+
+	/*
+	 * Positive control: CAP_SYS_ADMIN is denied but not quieted, so its
+	 * denial IS logged.  This proves quieting is per-member, not global.
+	 */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	EXPECT_EQ(-1, sethostname("test", 4));
+	EXPECT_EQ(EPERM, errno);
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	/*
+	 * The quieted CAP_SYS_CHROOT denial is suppressed; the CAP_SYS_ADMIN
+	 * denial is logged.
+	 */
+	EXPECT_EQ(0, matches_log_cap(self->audit_fd, CAP_SYS_ADMIN));
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+}
+
+/*
+ * Quieting an unknown capability bit has no effect: a rule that quiets only a
+ * bit above CAP_LAST_CAP still logs the denial of a known capability.
+ */
+TEST_F(cap_audit, quiet_unknown_bit_no_effect)
+{
+	struct audit_records records;
+	int ruleset_fd;
+	__u64 domain_id;
+
+	ruleset_fd = create_cap_ruleset();
+	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_AUDIT_CONTROL));
+	/* Quiet only an unknown bit (bit 63 is above CAP_LAST_CAP). */
+	ASSERT_EQ(0, add_cap_rule_full(ruleset_fd, 0, (1ULL << 63)));
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	set_cap(_metadata, CAP_SYS_CHROOT);
+	EXPECT_EQ(-1, chroot("/"));
+	EXPECT_EQ(EPERM, errno);
+	clear_cap(_metadata, CAP_SYS_CHROOT);
+
+	/* The unknown quiet bit does not suppress the known denial. */
+	EXPECT_EQ(0, matches_log_cap(self->audit_fd, CAP_SYS_CHROOT));
+	EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd, getpid(),
+						  &domain_id));
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
+}
+
+/*
+ * A capability check made with CAP_OPT_NOAUDIT is denied by Landlock but not
+ * logged: hook_capable() emits no Landlock audit record when the caller passes
+ * CAP_OPT_NOAUDIT, so the denial is silent here even though CAP_SYS_ADMIN is
+ * neither allowed nor quieted.  The probe is the
+ * ns_capable_noaudit(CAP_SYS_ADMIN) call in tmpfs simple_xattr_list(), which
+ * decides whether trusted.* xattrs are visible to listxattr(2).
+ */
+TEST_F(cap_audit, noaudit_probe_not_logged)
+{
+	struct audit_records records;
+	int ruleset_fd, fd;
+	char list[256];
+	ssize_t len;
+
+	/*
+	 * Private tmpfs holding a trusted.* xattr so its listxattr(2)
+	 * visibility depends only on the CAP_SYS_ADMIN noaudit probe.
+	 */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, unshare(CLONE_NEWNS));
+	ASSERT_EQ(0, mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL));
+	ASSERT_EQ(0, mount("test", "/tmp", "tmpfs", 0, NULL));
+	fd = open("/tmp/f", O_CREAT | O_RDWR | O_CLOEXEC, 0600);
+	ASSERT_LE(0, fd);
+	ASSERT_EQ(0, fsetxattr(fd, "trusted.landlock_test", "x", 1, 0));
+
+	/* Baseline: with CAP_SYS_ADMIN, the trusted xattr is listed. */
+	len = flistxattr(fd, list, sizeof(list));
+	ASSERT_LE(0, len);
+	ASSERT_TRUE(list_has_xattr(list, len, "trusted.landlock_test"));
+
+	ruleset_fd = create_cap_ruleset();
+	ASSERT_LE(0, ruleset_fd);
+	/* Allow CAP_AUDIT_CONTROL for child-side audit cleanup. */
+	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_AUDIT_CONTROL));
+	/* CAP_SYS_ADMIN is neither allowed nor quieted. */
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * CAP_SYS_ADMIN is still effective, but Landlock denies the noaudit
+	 * probe, so the trusted.* xattr is filtered out of the listing.
+	 */
+	len = flistxattr(fd, list, sizeof(list));
+	ASSERT_LE(0, len);
+	EXPECT_FALSE(list_has_xattr(list, len, "trusted.landlock_test"));
+	EXPECT_EQ(0, close(fd));
+
+	/*
+	 * Positive control: a normal (audited) CAP_SYS_ADMIN denial in the same
+	 * domain IS logged.  This proves the empty record set above is caused
+	 * by CAP_OPT_NOAUDIT, not by an always-allow or always-silent bug.
+	 */
+	EXPECT_EQ(-1, sethostname("test", 4));
+	EXPECT_EQ(EPERM, errno);
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	EXPECT_EQ(0, matches_log_cap(self->audit_fd, CAP_SYS_ADMIN));
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+}
+
+TEST_HARNESS_MAIN
-- 
2.54.0

