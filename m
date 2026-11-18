Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.25.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013556;
	b=2NKQmu9YBfs0cP3hX5lgTz1/WgKDauDzb5AZCmRHZ1/Evg7APE2ccw0f1hoOqZ8I6ouM
	 CxKjIz1EL3ArVhkYJ4frj1Dkf89aevigWfUuAeCLI3yKOXrJOeiaa75onuSb1aISnGq+/
	 V2lnB65spYf06PXmZnLMk4qu8TGNs9pK2X3zrpLsAxJyiY6tGtuhWGiM6UU0ks9aZHuvL
	 /z3P+FKOEf+xubKHNmbSd5aZCgt2LpfSnz3r+6b1FpUx2k5SkB3WWQ6LmIPPO6A5tb0jb
	 eYm04dlrLR0FqKkxyRU5DJau60Vqg+2Oz2SalV4iu34Is54+6rdV6vlSN8oRHqpmHcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013556;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=XFboxQPm4rVhxpT61VitSaShWJtHw2+HTrunzLWPcIM=;
	b=GViZnPznYonUHO360kplx8HBHRikimP3Ktc4scoydUZQY0TWYMvB0YjrQn84kpzxe2ii
	 cYl/TWHGMEe+pXqwjKe7lXVuhNi468KneCoyrLCVIyuaVMwKDJGknn5SqKfaEkTeai4FB
	 YD1SckvSJqcvpVazCMX1X5juQmq8ojIf/LgD2UUlhTpTpLfEZV5ZOl+oA/f0bBjCAUoA7
	 eN/6yusfTmOV7hz/kcqXslN8EwYmR+SQnYsaWA7XpT2mpyIV6TLif1C5tdoSeZC/rffsh
	 nvZF7FM7uW3SiNKYXfpNRqQQ6rZ25hFFeGFcXdjVVdlfVFSFaR1NQAotCBAMkE37blg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=EfFR6B7+;
	arc=none smtp.remote-ip=185.125.25.12
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FABC60A2608
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FABC60A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=EfFR6B7+
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jV4MJ1lXhzBtg;
	Wed, 18 Nov 2026 15:52:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1795013548;
	bh=XFboxQPm4rVhxpT61VitSaShWJtHw2+HTrunzLWPcIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EfFR6B7++61K5RSWRyMHW1VdJHHQ9rm6YiL5qNmSrYUHY7eLsCnyQvzE6kjzo3+Xv
	 z9btw+GSlcyV92znpFcljOO1Rfgs/Oc70COukRzTJXy1cXJkdlSLAQ0XbLhyE/k/Rz
	 R/2C5SPOdcEH5SekUmkZM19azM7bf8mcDU4aSE74=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jV4MG5pnlzchC;
	Wed, 18 Nov 2026 15:52:26 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ada Smith <adasmithgt@gmail.com>,
	Hungyu Lin <dennylin0707@gmail.com>,
	James Morris <jmorris@namei.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>,
	Serge Hallyn <sergeh@kernel.org>,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 5/6] selftests/landlock: Test capability checks outside the capable hook
Date: Wed, 18 Nov 2026 15:52:09 +0100
Message-ID: <20261118145217.2551053-6-mic@digikod.net>
In-Reply-To: <20261118145217.2551053-1-mic@digikod.net>
References: <20261118145217.2551053-1-mic@digikod.net>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Test the commoncap checks that the previous commits make Landlock
restrict: mapping below vm.mmap_min_addr (CAP_SYS_RAWIO) and adding
inheritable capabilities (CAP_SETPCAP).  Each test checks that the
operation needs the capability, then runs it with the capability in four
variants: unsandboxed, denied, allowed and unhandled.  The mmap_addr
tests skip if the architecture rejects the low page before the hook
(e.g. 32-bit ARM).

Audit tests check that these denials are logged, and that the admin
reserve check and allowed uses are not.  The admin reserve has no
functional test because it depends on vm.overcommit_memory=2, a
system-wide setting.

Add CAP_SETPCAP and CAP_SYS_RAWIO to the capabilities that the tests may
raise.

Without the mmap_addr and capset fixes, their denied variants and the
denial audit test fail.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <serge@hallyn.com>
Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
https://patch.msgid.link/20261117101157.2520463-6-mic@digikod.net
- Use ASSERT_*() for results that later checks depend on (errno, audit
  records, mappings), and drop the cleanup of the test mappings
  (suggested by Günther Noack).
- Rename the is_allowed parameter of create_variant_ruleset() to
  allow_cap (suggested by Günther Noack).
- Shorten the commit message.

Changes since v1:
https://patch.msgid.link/20261110202436.2408244-6-mic@digikod.net
- Replace the admin reserve test, which changed system-wide overcommit
  settings and was racy (e.g. with swap, as reported by Sashiko), with a
  comment.
- Map the last page below vm.mmap_min_addr instead of page 0, and skip
  when the architecture rejects it, e.g. on 32-bit ARM (reported by
  Sashiko).
- Mention CAP_SETPCAP in the commit message (reported by Sashiko).
- Add Serge Hallyn's Acked-by.
---
 tools/testing/selftests/landlock/cap_test.c | 328 ++++++++++++++++++++
 tools/testing/selftests/landlock/common.h   |   4 +-
 2 files changed, 331 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/cap_test.c b/tools/testing/selftests/landlock/cap_test.c
index 3d7fd02e21ed..7c58ece1c6f0 100644
--- a/tools/testing/selftests/landlock/cap_test.c
+++ b/tools/testing/selftests/landlock/cap_test.c
@@ -12,7 +12,9 @@
 #include <linux/landlock.h>
 #include <sched.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
+#include <sys/mman.h>
 #include <sys/mount.h>
 #include <sys/wait.h>
 #include <sys/xattr.h>
@@ -738,6 +740,247 @@ TEST(cap_target_userns_independent)
 	EXPECT_EQ(0, close(target_userns_fd));
 }
 
+/*
+ * Capability checks that commoncap makes from hooks other than the capable
+ * hook.  Each test first checks that the operation needs the capability, then
+ * checks it with the capability effective.  Variants cover an unsandboxed
+ * baseline, a domain that denies the capability, a domain that allows it, and a
+ * domain that does not handle capabilities.
+ */
+/* clang-format off */
+FIXTURE(cap_other_hooks) {};
+/* clang-format on */
+
+FIXTURE_VARIANT(cap_other_hooks)
+{
+	const bool is_sandboxed;
+	const bool handle_caps;
+	const bool is_allowed;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(cap_other_hooks, unsandboxed) {
+	.is_sandboxed = false,
+	.handle_caps = false,
+	.is_allowed = true,
+};
+/* clang-format on */
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(cap_other_hooks, denied) {
+	.is_sandboxed = true,
+	.handle_caps = true,
+	.is_allowed = false,
+};
+/* clang-format on */
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(cap_other_hooks, allowed) {
+	.is_sandboxed = true,
+	.handle_caps = true,
+	.is_allowed = true,
+};
+/* clang-format on */
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(cap_other_hooks, unhandled) {
+	.is_sandboxed = true,
+	.handle_caps = false,
+	.is_allowed = true,
+};
+/* clang-format on */
+
+FIXTURE_SETUP(cap_other_hooks)
+{
+	disable_caps(_metadata);
+}
+
+FIXTURE_TEARDOWN(cap_other_hooks)
+{
+}
+
+/*
+ * Creates a ruleset that handles capabilities and allows @cap if @allow_cap,
+ * or, if !@handle_caps, a ruleset that only handles a filesystem access right.
+ * Returns the ruleset FD, or -1 with errno set.
+ */
+static int create_variant_ruleset(const bool handle_caps, const bool allow_cap,
+				  const int cap)
+{
+	const struct landlock_ruleset_attr fs_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
+	};
+	int ruleset_fd, err;
+
+	if (!handle_caps)
+		return landlock_create_ruleset(&fs_attr, sizeof(fs_attr), 0);
+
+	ruleset_fd = create_cap_ruleset();
+	if (ruleset_fd < 0 || !allow_cap)
+		return ruleset_fd;
+
+	if (add_cap_rule(ruleset_fd, cap)) {
+		err = errno;
+		close(ruleset_fd);
+		errno = err;
+		return -1;
+	}
+	return ruleset_fd;
+}
+
+static void
+enforce_cap_variant(struct __test_metadata *const _metadata,
+		    const FIXTURE_VARIANT(cap_other_hooks) *const variant,
+		    const int cap)
+{
+	int ruleset_fd;
+
+	if (!variant->is_sandboxed)
+		return;
+
+	ruleset_fd = create_variant_ruleset(variant->handle_caps,
+					    variant->is_allowed, cap);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
+static unsigned long read_sysctl(struct __test_metadata *const _metadata,
+				 const char *const path)
+{
+	char buf[32];
+	ssize_t len;
+	int fd;
+
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd)
+	{
+		TH_LOG("Failed to open %s: %s", path, strerror(errno));
+	}
+	len = read(fd, buf, sizeof(buf) - 1);
+	ASSERT_LT(0, len);
+	EXPECT_EQ(0, close(fd));
+
+	buf[len] = '\0';
+	return strtoul(buf, NULL, 10);
+}
+
+/*
+ * Returns the last page below the vm.mmap_min_addr sysctl, or MAP_FAILED if
+ * there is none or if the architecture rejects it before the mmap_addr hook
+ * (e.g. below FIRST_USER_ADDRESS on 32-bit ARM).  The caller must not have
+ * CAP_SYS_RAWIO in its effective set.
+ */
+static void *get_low_page(struct __test_metadata *const _metadata)
+{
+	const size_t page_size = sysconf(_SC_PAGESIZE);
+	unsigned long min_addr;
+	void *addr, *ret;
+
+	min_addr = read_sysctl(_metadata, "/proc/sys/vm/mmap_min_addr");
+	if (!min_addr)
+		return MAP_FAILED;
+
+	addr = (void *)((min_addr - 1) & ~(page_size - 1));
+	ret = mmap(addr, page_size, PROT_READ,
+		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+	ASSERT_EQ(MAP_FAILED, ret);
+	if (errno == EINVAL)
+		return MAP_FAILED;
+
+	ASSERT_EQ(EPERM, errno);
+	return addr;
+}
+
+/*
+ * cap_mmap_addr() requires CAP_SYS_RAWIO to map below the vm.mmap_min_addr
+ * sysctl (dac_mmap_min_addr).
+ */
+TEST_F(cap_other_hooks, mmap_min_addr)
+{
+	const size_t page_size = sysconf(_SC_PAGESIZE);
+	void *low_page, *addr;
+
+	low_page = get_low_page(_metadata);
+	if (low_page == MAP_FAILED)
+		SKIP(return, "Cannot map below vm.mmap_min_addr");
+
+	enforce_cap_variant(_metadata, variant, CAP_SYS_RAWIO);
+
+	addr = mmap(low_page, page_size, PROT_READ,
+		    MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+	ASSERT_EQ(MAP_FAILED, addr);
+	EXPECT_EQ(EPERM, errno);
+
+	set_cap(_metadata, CAP_SYS_RAWIO);
+	addr = mmap(low_page, page_size, PROT_READ,
+		    MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+	if (variant->is_allowed) {
+		ASSERT_EQ(low_page, addr)
+		{
+			TH_LOG("Failed to map below vm.mmap_min_addr: %s",
+			       strerror(errno));
+		}
+	} else {
+		ASSERT_EQ(MAP_FAILED, addr);
+		EXPECT_EQ(EPERM, errno);
+	}
+	clear_cap(_metadata, CAP_SYS_RAWIO);
+}
+
+static int add_inheritable_cap(const cap_value_t cap)
+{
+	cap_t cap_p;
+	int ret, err;
+
+	cap_p = cap_get_proc();
+	if (!cap_p)
+		return -1;
+
+	ret = cap_set_flag(cap_p, CAP_INHERITABLE, 1, &cap, CAP_SET);
+	if (!ret)
+		ret = cap_set_proc(cap_p);
+	err = errno;
+	cap_free(cap_p);
+	errno = err;
+	return ret;
+}
+
+/*
+ * cap_capset() requires CAP_SETPCAP to add an inheritable capability that is
+ * not in the permitted set.  CAP_NET_RAW is in the bounding set, but
+ * disable_caps() does not put it in the permitted set.
+ */
+TEST_F(cap_other_hooks, capset_inheritable)
+{
+	enforce_cap_variant(_metadata, variant, CAP_SETPCAP);
+
+	ASSERT_EQ(-1, add_inheritable_cap(CAP_NET_RAW));
+	EXPECT_EQ(EPERM, errno);
+
+	set_cap(_metadata, CAP_SETPCAP);
+	if (variant->is_allowed) {
+		EXPECT_EQ(0, add_inheritable_cap(CAP_NET_RAW))
+		{
+			TH_LOG("Failed to raise CAP_NET_RAW: %s",
+			       strerror(errno));
+		}
+	} else {
+		ASSERT_EQ(-1, add_inheritable_cap(CAP_NET_RAW));
+		EXPECT_EQ(EPERM, errno);
+	}
+	clear_cap(_metadata, CAP_SETPCAP);
+}
+
+/*
+ * cap_vm_enough_memory() lets CAP_SYS_ADMIN use the vm.admin_reserve_kbytes
+ * reserve, but only with vm.overcommit_memory=2.  The Landlock check of this
+ * reserve has no functional test: it would have to change these system-wide
+ * settings and set a tight commit limit, which could make allocations of other
+ * processes fail and would race with them.  cap_audit.other_hooks checks that
+ * this check is not logged.
+ */
+
 /* Audit tests */
 
 static int matches_log_cap(int audit_fd, int cap_number)
@@ -828,6 +1071,91 @@ TEST_F(cap_audit, denied)
 	EXPECT_EQ(0, records.domain);
 }
 
+/*
+ * Denials in the capset and mmap_addr paths are audited like capable hook
+ * denials.  The vm_enough_memory hook only withholds the admin reserve, with
+ * CAP_OPT_NOAUDIT, so an accounted mapping made with CAP_SYS_ADMIN effective
+ * leaves no record.
+ */
+TEST_F(cap_audit, other_hooks)
+{
+	const size_t page_size = sysconf(_SC_PAGESIZE);
+	struct audit_records records = {};
+	void *low_page, *addr;
+	int ruleset_fd;
+	__u64 domain_id;
+
+	low_page = get_low_page(_metadata);
+	ruleset_fd = create_cap_ruleset();
+	ASSERT_LE(0, ruleset_fd);
+	/* Allow CAP_AUDIT_CONTROL for child-side audit cleanup. */
+	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_AUDIT_CONTROL));
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	set_cap(_metadata, CAP_SETPCAP);
+	ASSERT_EQ(-1, add_inheritable_cap(CAP_NET_RAW));
+	EXPECT_EQ(EPERM, errno);
+	clear_cap(_metadata, CAP_SETPCAP);
+	EXPECT_EQ(0, matches_log_cap(self->audit_fd, CAP_SETPCAP));
+	EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd, getpid(),
+						  &domain_id));
+
+	if (low_page != MAP_FAILED) {
+		set_cap(_metadata, CAP_SYS_RAWIO);
+		addr = mmap(low_page, page_size, PROT_READ,
+			    MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+		ASSERT_EQ(MAP_FAILED, addr);
+		EXPECT_EQ(EPERM, errno);
+		clear_cap(_metadata, CAP_SYS_RAWIO);
+		EXPECT_EQ(0, matches_log_cap(self->audit_fd, CAP_SYS_RAWIO));
+	}
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	addr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(MAP_FAILED, addr);
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
+}
+
+/* Allowed capability uses in the capset and mmap_addr paths. */
+TEST_F(cap_audit, other_hooks_allowed)
+{
+	const size_t page_size = sysconf(_SC_PAGESIZE);
+	struct audit_records records = {};
+	void *low_page, *addr;
+	int ruleset_fd;
+
+	low_page = get_low_page(_metadata);
+	ruleset_fd = create_cap_ruleset();
+	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_SETPCAP));
+	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_SYS_RAWIO));
+	/* Allow CAP_AUDIT_CONTROL for child-side audit cleanup. */
+	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_AUDIT_CONTROL));
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	set_cap(_metadata, CAP_SETPCAP);
+	EXPECT_EQ(0, add_inheritable_cap(CAP_NET_RAW));
+	clear_cap(_metadata, CAP_SETPCAP);
+
+	if (low_page != MAP_FAILED) {
+		set_cap(_metadata, CAP_SYS_RAWIO);
+		addr = mmap(low_page, page_size, PROT_READ,
+			    MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+		ASSERT_EQ(low_page, addr);
+		clear_cap(_metadata, CAP_SYS_RAWIO);
+	}
+
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+}
+
 TEST_F(cap_audit, allowed)
 {
 	struct audit_records records = {};
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index e29406900c04..a6fdfb422fad 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -36,7 +36,7 @@ static const char bin_wait_pipe_sandbox[] = "./wait-pipe-sandbox";
 static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
 {
 	cap_t cap_p;
-	/* Only these three capabilities are useful for the tests. */
+	/* Only these capabilities are useful for the tests. */
 	const cap_value_t caps[] = {
 		/* clang-format off */
 		CAP_AUDIT_CONTROL,
@@ -44,9 +44,11 @@ static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
 		CAP_MKNOD,
 		CAP_NET_ADMIN,
 		CAP_NET_BIND_SERVICE,
+		CAP_SETPCAP,
 		CAP_SETUID,
 		CAP_SYS_ADMIN,
 		CAP_SYS_CHROOT,
+		CAP_SYS_RAWIO,
 		/* clang-format on */
 	};
 	const unsigned int noroot = SECBIT_NOROOT | SECBIT_NOROOT_LOCKED;
-- 
2.56.0

