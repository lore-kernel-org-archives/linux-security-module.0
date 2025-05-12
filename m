Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100BE7DA93
	for <linux-security-module@vger.kernel.org>; Mon, 12 May 2025 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042667; cv=none; b=TkuAMjW2VKmWh9qo+KSF1rooUnwQXn+cJUJS+zBI5QZe6Z4VbGJUU/SQRVq0uoDec/iB8IQRA/XfLpnAZhklazgV6u/rgXAJEFj7dXuFkXPog5nVjwgPJ0jQSPSKnBeDXneli4+S328oR7beW7BiWMk4DvBlN8dctLstwMjrIoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042667; c=relaxed/simple;
	bh=8H+cUMibB+zDEWIz8J87i8V3O8vk0PVv+Qu+GDcVRxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sma+HRbOED07XQpKpVcJyARO96BvzJlxzs4FQ5vtsGc0//mfCpDNACP2IF80GbCE3VEORzljYFTYzK2MwdMTIuPKgMtmC+PFO79Hsk37POZ8FfCYW/zCIDvgGvFY8LoI9Na1l6YBxn2aM77D/lN+txmLg1lNwTP/Gtr0qlhfoZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=WTwDRo50; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="WTwDRo50"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Zwvf63RQ1zxGL;
	Mon, 12 May 2025 11:37:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1747042654;
	bh=nUjB5wKRZ+jL1CzKsnrO4hCOAv/eqMU1/UWxLO+qRCg=;
	h=From:To:Cc:Subject:Date:From;
	b=WTwDRo50ogM7LyqlulgAm7/JcQDwQh9YBHbcWCl+LH/OOmhzzU0Vznoe3oK9j133B
	 cWGmaZmLnW+DcvIxT5jzKdPH7ptrl0KaS6RSvObfqzO4LfnpCeaA+4fXdXN6yJultI
	 mxxmsIDrVo77qSyrkug5zH9//z/DNuV8dMxmsn9M=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Zwvf601V3zvqT;
	Mon, 12 May 2025 11:37:33 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v2] landlock: Improve bit operations in audit code
Date: Mon, 12 May 2025 11:37:30 +0200
Message-ID: <20250512093732.1408485-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Use the BIT() and BIT_ULL() macros in the new audit code instead of
explicit shifts to improve readability.  Use bitmask instead of modulo
operation to simplify code.

Add test_range1_rand15() and test_range2_rand15() KUnit tests to improve
get_id_range() coverage.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
https://lore.kernel.org/r/20250507185404.1029055-1-mic@digikod.net
- Use bitmask instead of modulo operation to simplify random value
  truncation, suggested by Günther.
- Add KUnit tests.
---
 security/landlock/audit.c    |  2 +-
 security/landlock/id.c       | 33 +++++++++++++++++++++++++++++++--
 security/landlock/syscalls.c |  3 ++-
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 58d5c40d4d0e..c52d079cdb77 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -437,7 +437,7 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 		return;
 
 	/* Checks if the current exec was restricting itself. */
-	if (subject->domain_exec & (1 << youngest_layer)) {
+	if (subject->domain_exec & BIT(youngest_layer)) {
 		/* Ignores denials for the same execution. */
 		if (!youngest_denied->log_same_exec)
 			return;
diff --git a/security/landlock/id.c b/security/landlock/id.c
index 11fab9259c15..56f7cc0fc744 100644
--- a/security/landlock/id.c
+++ b/security/landlock/id.c
@@ -7,6 +7,7 @@
 
 #include <kunit/test.h>
 #include <linux/atomic.h>
+#include <linux/bitops.h>
 #include <linux/random.h>
 #include <linux/spinlock.h>
 
@@ -25,7 +26,7 @@ static void __init init_id(atomic64_t *const counter, const u32 random_32bits)
 	 * Ensures sure 64-bit values are always used by user space (or may
 	 * fail with -EOVERFLOW), and makes this testable.
 	 */
-	init = 1ULL << 32;
+	init = BIT_ULL(32);
 
 	/*
 	 * Makes a large (2^32) boot-time value to limit ID collision in logs
@@ -105,7 +106,7 @@ static u64 get_id_range(size_t number_of_ids, atomic64_t *const counter,
 	 * to get a new ID (e.g. a full landlock_restrict_self() call), and the
 	 * cost of draining all available IDs during the system's uptime.
 	 */
-	random_4bits = random_4bits % (1 << 4);
+	random_4bits &= 0b1111;
 	step = number_of_ids + random_4bits;
 
 	/* It is safe to cast a signed atomic to an unsigned value. */
@@ -144,6 +145,19 @@ static void test_range1_rand1(struct kunit *const test)
 		init + 2);
 }
 
+static void test_range1_rand15(struct kunit *const test)
+{
+	atomic64_t counter;
+	u64 init;
+
+	init = get_random_u32();
+	atomic64_set(&counter, init);
+	KUNIT_EXPECT_EQ(test, get_id_range(1, &counter, 15), init);
+	KUNIT_EXPECT_EQ(
+		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
+		init + 16);
+}
+
 static void test_range1_rand16(struct kunit *const test)
 {
 	atomic64_t counter;
@@ -196,6 +210,19 @@ static void test_range2_rand2(struct kunit *const test)
 		init + 4);
 }
 
+static void test_range2_rand15(struct kunit *const test)
+{
+	atomic64_t counter;
+	u64 init;
+
+	init = get_random_u32();
+	atomic64_set(&counter, init);
+	KUNIT_EXPECT_EQ(test, get_id_range(2, &counter, 15), init);
+	KUNIT_EXPECT_EQ(
+		test, get_id_range(get_random_u8(), &counter, get_random_u8()),
+		init + 17);
+}
+
 static void test_range2_rand16(struct kunit *const test)
 {
 	atomic64_t counter;
@@ -232,10 +259,12 @@ static struct kunit_case __refdata test_cases[] = {
 	KUNIT_CASE(test_init_once),
 	KUNIT_CASE(test_range1_rand0),
 	KUNIT_CASE(test_range1_rand1),
+	KUNIT_CASE(test_range1_rand15),
 	KUNIT_CASE(test_range1_rand16),
 	KUNIT_CASE(test_range2_rand0),
 	KUNIT_CASE(test_range2_rand1),
 	KUNIT_CASE(test_range2_rand2),
+	KUNIT_CASE(test_range2_rand15),
 	KUNIT_CASE(test_range2_rand16),
 	{}
 	/* clang-format on */
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index b9561e3417ae..33eafb71e4f3 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -9,6 +9,7 @@
 
 #include <asm/current.h>
 #include <linux/anon_inodes.h>
+#include <linux/bitops.h>
 #include <linux/build_bug.h>
 #include <linux/capability.h>
 #include <linux/cleanup.h>
@@ -563,7 +564,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	new_llcred->domain = new_dom;
 
 #ifdef CONFIG_AUDIT
-	new_llcred->domain_exec |= 1 << (new_dom->num_layers - 1);
+	new_llcred->domain_exec |= BIT(new_dom->num_layers - 1);
 #endif /* CONFIG_AUDIT */
 
 	return commit_creds(new_cred);
-- 
2.49.0

