Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8848A22425C
	for <linux-security-module@vger.kernel.org>; Thu, 20 Mar 2025 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497657; cv=none; b=PuB0nd6rU3EzBl5OgWcgNMVOhuivu9+UZsHZX5fBkTpllwnraukGt6HLwHIvnmjcZu/9IFblXyX0kORpWcLgO526uLdsieo7Gd6eftUGL4k3OEeVtrGp8xH92L7tgkBt/pYAorMCfwClGi1R/W19ehoCtn9dqFFI4ec4vtUdvW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497657; c=relaxed/simple;
	bh=45JLEnVOCC93HamKeYIR4SfZWtAvGnQzOZkzhWcAN5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQhWSxpP843MRhJTDMzZhJXRfrgu8WwZLPyrFhlrDIxCw7fTAgVkqhUb5JoMobIhbYI+IzwXV90B3pf7/O30vrpuabPvMAMObcHwGBDe6O13B0l3rj9JAZdikFyakH0xAQusbGDui46cOwMzAqfN/wlv/l6fvqLvptnBXvR4YWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=nhs2e0hR; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="nhs2e0hR"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZJZp74QqKzvq;
	Thu, 20 Mar 2025 20:07:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742497647;
	bh=iZl1861XoEEnqIZYskkUa/MWfgyLxE6348VGEHMGhCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nhs2e0hRW5tq2bRhuy/zn4U5F7KAqOFYlIuIBl0ouf3fG0ZjrWJU7VZPJIhYFOS/g
	 B6MyBsY4kUGu6fUBy+gDMVaoFv/6VzQy4+pijTuJGBalTx6FVaJi2jYIkX+Is1Jlhz
	 2IQkJ9aM5kiLPiuYKkl1kAZtRfEX6qejuUb5++Ek=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZJZp64YckzMMp;
	Thu, 20 Mar 2025 20:07:26 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 02/28] landlock: Add unique ID generator
Date: Thu, 20 Mar 2025 20:06:51 +0100
Message-ID: <20250320190717.2287696-3-mic@digikod.net>
In-Reply-To: <20250320190717.2287696-1-mic@digikod.net>
References: <20250320190717.2287696-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Landlock IDs can be generated to uniquely identify Landlock objects.
For now, only Landlock domains get an ID at creation time.  These IDs
map to immutable domain hierarchies.

Landlock IDs have important properties:
- They are unique during the lifetime of the running system thanks to
  the 64-bit values: at worse, 2^60 - 2*2^32 useful IDs.
- They are always greater than 2^32 and must then be stored in 64-bit
  integer types.
- The initial ID (at boot time) is randomly picked between 2^32 and
  2^33, which limits collisions in logs across different boots.
- IDs are sequential, which enables users to order them.
- IDs may not be consecutive but increase with a random 2^4 step, which
  limits side channels.

Such IDs can be exposed to unprivileged processes, even if it is not the
case with this audit patch series.  The domain IDs will be useful for
user space to identify sandboxes and get their properties.

These Landlock IDs are more secure that other absolute kernel IDs such
as pipe's inodes which rely on a shared global counter.

For checkpoint/restore features (i.e. CRIU), we could easily implement a
privileged interface (e.g. sysfs) to set the next ID counter.

IDR/IDA are not used because we only need a bijection from Landlock
objects to Landlock IDs, and we must not recycle IDs.  This enables us
to identify all Landlock objects during the lifetime of the system (e.g.
in logs), but not to access an object from an ID nor know if an ID is
assigned.   Using a counter is simpler, it scales (i.e. avoids growing
memory footprint), and it does not require locking.  We'll use proper
file descriptors (with IDs used as inode numbers) to access Landlock
objects.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v6:
- Clean up headers.

Changes since v5:
- Add KUnit error message, suggested by Günther.

Changes since v3:
- Rename landlock_get_id_range() helper to reflect the "range" of IDs.
- Add docstring for landlock_get_id_range().

Changes since v2:
- Extend commit message.
- Rename global_counter to next_id.
- Fix KUnit's test __init types, spotted by kernel test robot.

Changes since v1:
- New patch.
---
 security/landlock/.kunitconfig               |   2 +
 security/landlock/Makefile                   |   2 +
 security/landlock/id.c                       | 251 +++++++++++++++++++
 security/landlock/id.h                       |  25 ++
 security/landlock/setup.c                    |   2 +
 tools/testing/kunit/configs/all_tests.config |   2 +
 6 files changed, 284 insertions(+)
 create mode 100644 security/landlock/id.c
 create mode 100644 security/landlock/id.h

diff --git a/security/landlock/.kunitconfig b/security/landlock/.kunitconfig
index 03e119466604..f9423f01ac5b 100644
--- a/security/landlock/.kunitconfig
+++ b/security/landlock/.kunitconfig
@@ -1,4 +1,6 @@
+CONFIG_AUDIT=y
 CONFIG_KUNIT=y
+CONFIG_NET=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_LANDLOCK=y
 CONFIG_SECURITY_LANDLOCK_KUNIT_TEST=y
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index b4538b7cf7d2..e1777abbc413 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -4,3 +4,5 @@ landlock-y := setup.o syscalls.o object.o ruleset.o \
 	cred.o task.o fs.o
 
 landlock-$(CONFIG_INET) += net.o
+
+landlock-$(CONFIG_AUDIT) += id.o
diff --git a/security/landlock/id.c b/security/landlock/id.c
new file mode 100644
index 000000000000..11fab9259c15
--- /dev/null
+++ b/security/landlock/id.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock - Unique identification number generator
+ *
+ * Copyright © 2024-2025 Microsoft Corporation
+ */
+
+#include <kunit/test.h>
+#include <linux/atomic.h>
+#include <linux/random.h>
+#include <linux/spinlock.h>
+
+#include "common.h"
+#include "id.h"
+
+#define COUNTER_PRE_INIT 0
+
+static atomic64_t next_id = ATOMIC64_INIT(COUNTER_PRE_INIT);
+
+static void __init init_id(atomic64_t *const counter, const u32 random_32bits)
+{
+	u64 init;
+
+	/*
+	 * Ensures sure 64-bit values are always used by user space (or may
+	 * fail with -EOVERFLOW), and makes this testable.
+	 */
+	init = 1ULL << 32;
+
+	/*
+	 * Makes a large (2^32) boot-time value to limit ID collision in logs
+	 * from different boots, and to limit info leak about the number of
+	 * initially (relative to the reader) created elements (e.g. domains).
+	 */
+	init += random_32bits;
+
+	/* Sets first or ignores.  This will be the first ID. */
+	atomic64_cmpxchg(counter, COUNTER_PRE_INIT, init);
+}
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+static void __init test_init_min(struct kunit *const test)
+{
+	atomic64_t counter = ATOMIC64_INIT(COUNTER_PRE_INIT);
+
+	init_id(&counter, 0);
+	KUNIT_EXPECT_EQ(test, atomic64_read(&counter), 1ULL + U32_MAX);
+}
+
+static void __init test_init_max(struct kunit *const test)
+{
+	atomic64_t counter = ATOMIC64_INIT(COUNTER_PRE_INIT);
+
+	init_id(&counter, ~0);
+	KUNIT_EXPECT_EQ(test, atomic64_read(&counter), 1 + (2ULL * U32_MAX));
+}
+
+static void __init test_init_once(struct kunit *const test)
+{
+	const u64 first_init = 1ULL + U32_MAX;
+	atomic64_t counter = ATOMIC64_INIT(COUNTER_PRE_INIT);
+
+	init_id(&counter, 0);
+	KUNIT_EXPECT_EQ(test, atomic64_read(&counter), first_init);
+
+	init_id(&counter, ~0);
+	KUNIT_EXPECT_EQ_MSG(
+		test, atomic64_read(&counter), first_init,
+		"Should still have the same value after the subsequent init_id()");
+}
+
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
+
+void __init landlock_init_id(void)
+{
+	return init_id(&next_id, get_random_u32());
+}
+
+/*
+ * It's not worth it to try to hide the monotonic counter because it can still
+ * be inferred (with N counter ranges), and if we are allowed to read the inode
+ * number we should also be allowed to read the time creation anyway, and it
+ * can be handy to store and sort domain IDs for user space.
+ *
+ * Returns the value of next_id and increment it to let some space for the next
+ * one.
+ */
+static u64 get_id_range(size_t number_of_ids, atomic64_t *const counter,
+			u8 random_4bits)
+{
+	u64 id, step;
+
+	/*
+	 * We should return at least 1 ID, and we may need a set of consecutive
+	 * ones (e.g. to generate a set of inodes).
+	 */
+	if (WARN_ON_ONCE(number_of_ids <= 0))
+		number_of_ids = 1;
+
+	/*
+	 * Blurs the next ID guess with 1/16 ratio.  We get 2^(64 - 4) -
+	 * (2 * 2^32), so a bit less than 2^60 available IDs, which should be
+	 * much more than enough considering the number of CPU cycles required
+	 * to get a new ID (e.g. a full landlock_restrict_self() call), and the
+	 * cost of draining all available IDs during the system's uptime.
+	 */
+	random_4bits = random_4bits % (1 << 4);
+	step = number_of_ids + random_4bits;
+
+	/* It is safe to cast a signed atomic to an unsigned value. */
+	id = atomic64_fetch_add(step, counter);
+
+	/* Warns if landlock_init_id() was not called. */
+	WARN_ON_ONCE(id == COUNTER_PRE_INIT);
+	return id;
+}
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+static void test_range1_rand0(struct kunit *const test)
+{
+	atomic64_t counter;
+	u64 init;
+
+	init = get_random_u32();
+	atomic64_set(&counter, init);
+	KUNIT_EXPECT_EQ(test, get_id_range(1, &counter, 0), init);
+	KUNIT_EXPECT_EQ(
+		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
+		init + 1);
+}
+
+static void test_range1_rand1(struct kunit *const test)
+{
+	atomic64_t counter;
+	u64 init;
+
+	init = get_random_u32();
+	atomic64_set(&counter, init);
+	KUNIT_EXPECT_EQ(test, get_id_range(1, &counter, 1), init);
+	KUNIT_EXPECT_EQ(
+		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
+		init + 2);
+}
+
+static void test_range1_rand16(struct kunit *const test)
+{
+	atomic64_t counter;
+	u64 init;
+
+	init = get_random_u32();
+	atomic64_set(&counter, init);
+	KUNIT_EXPECT_EQ(test, get_id_range(1, &counter, 16), init);
+	KUNIT_EXPECT_EQ(
+		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
+		init + 1);
+}
+
+static void test_range2_rand0(struct kunit *const test)
+{
+	atomic64_t counter;
+	u64 init;
+
+	init = get_random_u32();
+	atomic64_set(&counter, init);
+	KUNIT_EXPECT_EQ(test, get_id_range(2, &counter, 0), init);
+	KUNIT_EXPECT_EQ(
+		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
+		init + 2);
+}
+
+static void test_range2_rand1(struct kunit *const test)
+{
+	atomic64_t counter;
+	u64 init;
+
+	init = get_random_u32();
+	atomic64_set(&counter, init);
+	KUNIT_EXPECT_EQ(test, get_id_range(2, &counter, 1), init);
+	KUNIT_EXPECT_EQ(
+		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
+		init + 3);
+}
+
+static void test_range2_rand2(struct kunit *const test)
+{
+	atomic64_t counter;
+	u64 init;
+
+	init = get_random_u32();
+	atomic64_set(&counter, init);
+	KUNIT_EXPECT_EQ(test, get_id_range(2, &counter, 2), init);
+	KUNIT_EXPECT_EQ(
+		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
+		init + 4);
+}
+
+static void test_range2_rand16(struct kunit *const test)
+{
+	atomic64_t counter;
+	u64 init;
+
+	init = get_random_u32();
+	atomic64_set(&counter, init);
+	KUNIT_EXPECT_EQ(test, get_id_range(2, &counter, 16), init);
+	KUNIT_EXPECT_EQ(
+		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
+		init + 2);
+}
+
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
+
+/**
+ * landlock_get_id_range - Get a range of unique IDs
+ *
+ * @number_of_ids: Number of IDs to hold.  Must be greater than one.
+ *
+ * Returns: The first ID in the range.
+ */
+u64 landlock_get_id_range(size_t number_of_ids)
+{
+	return get_id_range(number_of_ids, &next_id, get_random_u8());
+}
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+static struct kunit_case __refdata test_cases[] = {
+	/* clang-format off */
+	KUNIT_CASE(test_init_min),
+	KUNIT_CASE(test_init_max),
+	KUNIT_CASE(test_init_once),
+	KUNIT_CASE(test_range1_rand0),
+	KUNIT_CASE(test_range1_rand1),
+	KUNIT_CASE(test_range1_rand16),
+	KUNIT_CASE(test_range2_rand0),
+	KUNIT_CASE(test_range2_rand1),
+	KUNIT_CASE(test_range2_rand2),
+	KUNIT_CASE(test_range2_rand16),
+	{}
+	/* clang-format on */
+};
+
+static struct kunit_suite test_suite = {
+	.name = "landlock_id",
+	.test_cases = test_cases,
+};
+
+kunit_test_init_section_suite(test_suite);
+
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
diff --git a/security/landlock/id.h b/security/landlock/id.h
new file mode 100644
index 000000000000..45dcfb9e9a8b
--- /dev/null
+++ b/security/landlock/id.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock - Unique identification number generator
+ *
+ * Copyright © 2024-2025 Microsoft Corporation
+ */
+
+#ifndef _SECURITY_LANDLOCK_ID_H
+#define _SECURITY_LANDLOCK_ID_H
+
+#ifdef CONFIG_AUDIT
+
+void __init landlock_init_id(void);
+
+u64 landlock_get_id_range(size_t number_of_ids);
+
+#else /* CONFIG_AUDIT */
+
+static inline void __init landlock_init_id(void)
+{
+}
+
+#endif /* CONFIG_AUDIT */
+
+#endif /* _SECURITY_LANDLOCK_ID_H */
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index 0c85ea27e409..bd53c7a56ab9 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -15,6 +15,7 @@
 #include "cred.h"
 #include "errata.h"
 #include "fs.h"
+#include "id.h"
 #include "net.h"
 #include "setup.h"
 #include "task.h"
@@ -67,6 +68,7 @@ static int __init landlock_init(void)
 	landlock_add_task_hooks();
 	landlock_add_fs_hooks();
 	landlock_add_net_hooks();
+	landlock_init_id();
 	landlock_initialized = true;
 	pr_info("Up and running.\n");
 	return 0;
diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
index b0049be00c70..cdd9782f9646 100644
--- a/tools/testing/kunit/configs/all_tests.config
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -41,6 +41,8 @@ CONFIG_DAMON_PADDR=y
 
 CONFIG_REGMAP_BUILD=y
 
+CONFIG_AUDIT=y
+
 CONFIG_SECURITY=y
 CONFIG_SECURITY_APPARMOR=y
 CONFIG_SECURITY_LANDLOCK=y
-- 
2.49.0

