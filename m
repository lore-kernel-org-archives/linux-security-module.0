Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.166.143.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342300;
	b=B6NuvceYIx0mhtIUwPNMKMsgvab742jIBixWVUa0sJn+ge8oPxGdtWGXaXvTB+w/Zac1
	 fSXcH8o4PXPw5/BG2JK4V+XqXs8z7Lq+P7iH3/TzAImhGyYHoyG5KjFjjznJ4yNibqGwx
	 Oh0ryLMOUGC4aVrz2muIQVof1kPbLrbetsBrceTMDh/OIVHsns1dM1X/6oEoS7sY8PD0m
	 3MdlDDPE2Wh2UUmMtyK/gWl3P97RAkURekCMlkvDPAyS31UWQkgD9glLXrrnFppddnHZk
	 stQkaDR6zamZ6+5qLKoPEukUwAGHqPAPDM3sTBUC6O1N+5bhNhBFV6o1us+6QDRmxtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342300;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=rN7PA0lkl9uD8i8sXlYl8/Uayw3H6aAuWQn9MnW4Ek0=;
	b=kVHUvlvPqOr+rpROk+zKTZgbDUdcCNtCJX2/iFXKGj91jEO6iRlT4Ch+4ZrhQSo5SjTA
	 fIkHvst8FnMVqElvH82edTIDYneGNsnMwBCUQ8t0rWR6+L/aoyiO5scFVuALCEixZKiO7
	 t1wg+c9rgjvFSsA/HCDYp5WY5EugO9Fi7GsFsza5dr5P8A7i2s974L2g+BJ+jQoUwOgne
	 YSSK13c2Hb+skrZqlXyUBTZcKOyTcjUeL3gVUlJYKVwN6NiHooTpD9t0FryHL3mfSKc+U
	 ew0VyeZ5JeIfrCsu1dgP8eZgQUL1CMnLnj03q1TdZYJAwD4ouSm3/fB90IkBbjp2bGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=cXdVbxhB;
	arc=none smtp.remote-ip=83.166.143.173
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06C860A3828
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 20:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A06C860A3828
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=cXdVbxhB
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPJ6X2VCZzF7C;
	Tue, 10 Nov 2026 21:24:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794342292;
	bh=rN7PA0lkl9uD8i8sXlYl8/Uayw3H6aAuWQn9MnW4Ek0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cXdVbxhBblieKmSLUPikRKlFREwbiXtokCMx0iIn9PNdc/BPneFHgMY5wtPsOJHNQ
	 uJeQII6rg5bDnteKY0JWqL0XP2tWYWvmZbt8+ahz/6JLrIM8bTdKC8GMxForjyRyy3
	 CxGKG5GYS9nRpGAQA6K5JSNXaeyu9aVq7+iujVsY=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jPJ6W1pCfz88;
	Tue, 10 Nov 2026 21:24:51 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ada Smith <adasmithgt@gmail.com>,
	Hungyu Lin <dennylin0707@gmail.com>,
	James Morris <jmorris@namei.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 5/6] selftests/landlock: Test capability checks outside the capable hook
Date: Tue, 10 Nov 2026 21:24:33 +0100
Message-ID: <20261110202436.2408244-6-mic@digikod.net>
In-Reply-To: <20261110202436.2408244-1-mic@digikod.net>
References: <20261110202436.2408244-1-mic@digikod.net>
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

The previous commits make Landlock restrict the capability checks that
commoncap makes from LSM hooks other than capable, which no test covers:
mapping below vm.mmap_min_addr (CAP_SYS_RAWIO), adding inheritable
capabilities outside of the permitted set (CAP_SETPCAP), and using the
admin memory reserve under vm.overcommit_memory=2 (CAP_SYS_ADMIN).

Each test first checks that the operation fails without the capability,
so that it exercises the capability check, and then checks it with the
capability effective in four variants: unsandboxed, in a domain that
denies the capability, in a domain that allows it, and in a domain that
does not handle capabilities.

Audit tests check that the capset and mmap_addr denials are logged, that
the admin reserve check is not, and that allowed uses log nothing.

The admin reserve test has to change system-wide overcommit settings: it
sets a commit limit that only fits its mapping with the reserve, with
margins of 96 MiB for other processes.  It changes them after the
fixture setup, so that the teardown restores them after any failure, and
it only runs as root (EUID 0) while writing them.

Add CAP_SYS_RAWIO to the capabilities that the tests may raise, and drop
the stale count from the comment of this list.

Without the fixes, the three denied variants and the denial audit test
fail.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/cap_test.c | 535 ++++++++++++++++++++
 tools/testing/selftests/landlock/common.h   |   4 +-
 2 files changed, 538 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/cap_test.c b/tools/testing/selftests/landlock/cap_test.c
index 3d7fd02e21ed..c79bb42c6282 100644
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
@@ -738,6 +740,451 @@ TEST(cap_target_userns_independent)
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
+ * Creates a ruleset that handles capabilities and allows @cap if @is_allowed,
+ * or, if !@handle_caps, a ruleset that only handles a filesystem access right.
+ * Returns the ruleset FD, or -1 with errno set.
+ */
+static int create_variant_ruleset(const bool handle_caps, const bool is_allowed,
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
+	if (ruleset_fd < 0 || !is_allowed)
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
+/* Returns 0 on success, or -1 with errno set. */
+static int write_sysctl(const char *const path, const unsigned long value)
+{
+	char buf[32];
+	int fd, len, err = 0;
+	ssize_t ret;
+
+	len = snprintf(buf, sizeof(buf), "%lu", value);
+	fd = open(path, O_WRONLY | O_CLOEXEC);
+	if (fd < 0)
+		return -1;
+	ret = write(fd, buf, len);
+	if (ret != len) {
+		if (ret >= 0)
+			errno = EIO;
+		err = -1;
+	}
+	if (close(fd) && !err)
+		err = -1;
+	return err;
+}
+
+/*
+ * cap_mmap_addr() requires CAP_SYS_RAWIO to map below the vm.mmap_min_addr
+ * sysctl (dac_mmap_min_addr).
+ */
+TEST_F(cap_other_hooks, mmap_min_addr)
+{
+	const size_t page_size = sysconf(_SC_PAGESIZE);
+	void *addr;
+
+	if (read_sysctl(_metadata, "/proc/sys/vm/mmap_min_addr") == 0)
+		SKIP(return, "vm.mmap_min_addr is 0");
+
+	enforce_cap_variant(_metadata, variant, CAP_SYS_RAWIO);
+
+	addr = mmap(NULL, page_size, PROT_READ,
+		    MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+	EXPECT_EQ(MAP_FAILED, addr);
+	EXPECT_EQ(EPERM, errno);
+
+	set_cap(_metadata, CAP_SYS_RAWIO);
+	addr = mmap(NULL, page_size, PROT_READ,
+		    MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+	if (variant->is_allowed) {
+		EXPECT_EQ(NULL, addr)
+		{
+			TH_LOG("Failed to map page 0: %s", strerror(errno));
+		}
+		if (addr != MAP_FAILED)
+			EXPECT_EQ(0, munmap(addr, page_size));
+	} else {
+		EXPECT_EQ(MAP_FAILED, addr);
+		EXPECT_EQ(EPERM, errno);
+		if (addr != MAP_FAILED)
+			munmap(addr, page_size);
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
+	EXPECT_EQ(-1, add_inheritable_cap(CAP_NET_RAW));
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
+		EXPECT_EQ(-1, add_inheritable_cap(CAP_NET_RAW));
+		EXPECT_EQ(EPERM, errno);
+	}
+	clear_cap(_metadata, CAP_SETPCAP);
+}
+
+/*
+ * With vm.overcommit_memory=2, cap_vm_enough_memory() lets CAP_SYS_ADMIN use
+ * the vm.admin_reserve_kbytes reserve.  The test sets a commit limit that
+ * leaves room for the test mapping only with the reserve, and keeps some room
+ * for other processes.  The fixture setup only saves the settings, so that the
+ * teardown restores them after any failure once they are changed.
+ */
+#define OVERCOMMIT_PATH "/proc/sys/vm/"
+#define ADMIN_RESERVE_KB (256UL * 1024)
+#define HEADROOM_KB (64UL * 1024)
+#define MAPPING_KB (160UL * 1024)
+
+/* clang-format off */
+FIXTURE(cap_admin_reserve) {
+	/* clang-format on */
+	unsigned long overcommit_memory, overcommit_kbytes, overcommit_ratio;
+	unsigned long admin_reserve_kbytes, committed;
+	bool is_set;
+};
+
+FIXTURE_VARIANT(cap_admin_reserve)
+{
+	const bool is_sandboxed;
+	const bool handle_caps;
+	const bool is_allowed;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(cap_admin_reserve, unsandboxed) {
+	.is_sandboxed = false,
+	.handle_caps = false,
+	.is_allowed = true,
+};
+/* clang-format on */
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(cap_admin_reserve, denied) {
+	.is_sandboxed = true,
+	.handle_caps = true,
+	.is_allowed = false,
+};
+/* clang-format on */
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(cap_admin_reserve, allowed) {
+	.is_sandboxed = true,
+	.handle_caps = true,
+	.is_allowed = true,
+};
+/* clang-format on */
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(cap_admin_reserve, unhandled) {
+	.is_sandboxed = true,
+	.handle_caps = false,
+	.is_allowed = true,
+};
+/* clang-format on */
+
+static unsigned long read_committed_kb(struct __test_metadata *const _metadata)
+{
+	unsigned long committed = 0;
+	char line[128];
+	FILE *file;
+
+	file = fopen("/proc/meminfo", "re");
+	ASSERT_NE(NULL, file);
+
+	while (fgets(line, sizeof(line), file))
+		if (sscanf(line, "Committed_AS: %lu kB", &committed) == 1)
+			break;
+
+	EXPECT_EQ(0, fclose(file));
+	EXPECT_NE(0, committed);
+	return committed;
+}
+
+/*
+ * sysctl_perm() only lets the root user write the vm.* sysctls.  Switching to
+ * EUID 0 raises all permitted capabilities, so drop them again.
+ */
+static void set_root_euid(struct __test_metadata *const _metadata)
+{
+	set_cap(_metadata, CAP_SETUID);
+	ASSERT_EQ(0, seteuid(0));
+	disable_caps(_metadata);
+}
+
+/*
+ * Switching back to the real UID needs no capability.  Keep the permitted
+ * capabilities, which the setuid fixup would otherwise clear.
+ */
+static void restore_euid(struct __test_metadata *const _metadata)
+{
+	ASSERT_EQ(0, prctl(PR_SET_KEEPCAPS, 1));
+	ASSERT_EQ(0, seteuid(getuid()));
+	disable_caps(_metadata);
+}
+
+FIXTURE_SETUP(cap_admin_reserve)
+{
+	self->is_set = false;
+	disable_caps(_metadata);
+
+	self->overcommit_memory =
+		read_sysctl(_metadata, OVERCOMMIT_PATH "overcommit_memory");
+	self->overcommit_kbytes =
+		read_sysctl(_metadata, OVERCOMMIT_PATH "overcommit_kbytes");
+	self->overcommit_ratio =
+		read_sysctl(_metadata, OVERCOMMIT_PATH "overcommit_ratio");
+	self->admin_reserve_kbytes =
+		read_sysctl(_metadata, OVERCOMMIT_PATH "admin_reserve_kbytes");
+	self->committed = read_committed_kb(_metadata);
+	ASSERT_NE(0, self->committed);
+}
+
+FIXTURE_TEARDOWN(cap_admin_reserve)
+{
+	if (!self->is_set)
+		return;
+
+	/* Restores every value, even if one of the writes fails. */
+	set_cap(_metadata, CAP_SETUID);
+	EXPECT_EQ(0, seteuid(0));
+	disable_caps(_metadata);
+	EXPECT_EQ(0, write_sysctl(OVERCOMMIT_PATH "overcommit_memory",
+				  self->overcommit_memory));
+	/* Writing one of these two resets the other to 0. */
+	if (self->overcommit_kbytes) {
+		EXPECT_EQ(0, write_sysctl(OVERCOMMIT_PATH "overcommit_kbytes",
+					  self->overcommit_kbytes));
+	} else {
+		EXPECT_EQ(0, write_sysctl(OVERCOMMIT_PATH "overcommit_ratio",
+					  self->overcommit_ratio));
+	}
+	EXPECT_EQ(0, write_sysctl(OVERCOMMIT_PATH "admin_reserve_kbytes",
+				  self->admin_reserve_kbytes));
+	restore_euid(_metadata);
+}
+
+/*
+ * Called from the test, after the fixture setup, so that the teardown restores
+ * the settings if any of these writes fails.
+ */
+static void set_admin_reserve(struct __test_metadata *const _metadata,
+			      FIXTURE_DATA(cap_admin_reserve) *const self)
+{
+	set_root_euid(_metadata);
+	self->is_set = true;
+	ASSERT_EQ(0, write_sysctl(OVERCOMMIT_PATH "admin_reserve_kbytes",
+				  ADMIN_RESERVE_KB));
+	ASSERT_EQ(0, write_sysctl(OVERCOMMIT_PATH "overcommit_kbytes",
+				  self->committed + ADMIN_RESERVE_KB +
+					  HEADROOM_KB));
+	ASSERT_EQ(0, write_sysctl(OVERCOMMIT_PATH "overcommit_memory", 2));
+	restore_euid(_metadata);
+}
+
+/* Returns 0 if a writable private mapping of MAPPING_KB fits, or errno. */
+static int
+test_admin_reserve(const FIXTURE_VARIANT(cap_admin_reserve) *const variant,
+		   const bool is_admin)
+{
+	const size_t size = MAPPING_KB * 1024;
+	int ruleset_fd, status;
+	void *addr;
+	pid_t child;
+
+	child = fork();
+	if (child < 0)
+		return errno;
+
+	if (child == 0) {
+		if (variant->is_sandboxed) {
+			ruleset_fd = create_variant_ruleset(
+				variant->handle_caps, variant->is_allowed,
+				CAP_SYS_ADMIN);
+			if (ruleset_fd < 0)
+				_exit(255);
+			if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) ||
+			    landlock_restrict_self(ruleset_fd, 0))
+				_exit(255);
+			close(ruleset_fd);
+		}
+
+		if (is_admin) {
+			cap_t cap_p = cap_get_proc();
+			const cap_value_t cap = CAP_SYS_ADMIN;
+
+			if (!cap_p ||
+			    cap_set_flag(cap_p, CAP_EFFECTIVE, 1, &cap,
+					 CAP_SET) ||
+			    cap_set_proc(cap_p))
+				_exit(255);
+			cap_free(cap_p);
+		}
+
+		addr = mmap(NULL, size, PROT_READ | PROT_WRITE,
+			    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+		_exit(addr == MAP_FAILED ? errno : 0);
+	}
+
+	if (waitpid(child, &status, 0) != child || !WIFEXITED(status))
+		return 255;
+	return WEXITSTATUS(status);
+}
+
+TEST_F(cap_admin_reserve, mmap)
+{
+	set_admin_reserve(_metadata, self);
+
+	EXPECT_EQ(ENOMEM, test_admin_reserve(variant, false));
+	EXPECT_EQ(variant->is_allowed ? 0 : ENOMEM,
+		  test_admin_reserve(variant, true));
+}
+
 /* Audit tests */
 
 static int matches_log_cap(int audit_fd, int cap_number)
@@ -828,6 +1275,94 @@ TEST_F(cap_audit, denied)
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
+	int ruleset_fd;
+	__u64 domain_id;
+	void *addr;
+
+	ruleset_fd = create_cap_ruleset();
+	ASSERT_LE(0, ruleset_fd);
+	/* Allow CAP_AUDIT_CONTROL for child-side audit cleanup. */
+	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_AUDIT_CONTROL));
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	set_cap(_metadata, CAP_SETPCAP);
+	EXPECT_EQ(-1, add_inheritable_cap(CAP_NET_RAW));
+	EXPECT_EQ(EPERM, errno);
+	clear_cap(_metadata, CAP_SETPCAP);
+	EXPECT_EQ(0, matches_log_cap(self->audit_fd, CAP_SETPCAP));
+	EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd, getpid(),
+						  &domain_id));
+
+	/* The mmap_addr hook has nothing to check without a limit. */
+	if (read_sysctl(_metadata, "/proc/sys/vm/mmap_min_addr")) {
+		set_cap(_metadata, CAP_SYS_RAWIO);
+		addr = mmap(NULL, page_size, PROT_READ,
+			    MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+		EXPECT_EQ(MAP_FAILED, addr);
+		EXPECT_EQ(EPERM, errno);
+		clear_cap(_metadata, CAP_SYS_RAWIO);
+		EXPECT_EQ(0, matches_log_cap(self->audit_fd, CAP_SYS_RAWIO));
+	}
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	addr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	EXPECT_NE(MAP_FAILED, addr);
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+	if (addr != MAP_FAILED)
+		EXPECT_EQ(0, munmap(addr, page_size));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
+}
+
+/* Allowed capability uses in the capset and mmap_addr paths. */
+TEST_F(cap_audit, other_hooks_allowed)
+{
+	const size_t page_size = sysconf(_SC_PAGESIZE);
+	struct audit_records records = {};
+	int ruleset_fd;
+	void *addr;
+
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
+	if (read_sysctl(_metadata, "/proc/sys/vm/mmap_min_addr")) {
+		set_cap(_metadata, CAP_SYS_RAWIO);
+		addr = mmap(NULL, page_size, PROT_READ,
+			    MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+		EXPECT_EQ(NULL, addr);
+		clear_cap(_metadata, CAP_SYS_RAWIO);
+		if (addr != MAP_FAILED)
+			EXPECT_EQ(0, munmap(addr, page_size));
+	}
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
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

