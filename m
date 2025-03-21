Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70501F3B8F
	for <linux-security-module@vger.kernel.org>; Fri, 21 Mar 2025 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742552672; cv=none; b=EtAiscIengjsk03swT6dNKvhnlp9cw8CTtalOUehrx2dWxBdPa7ZDNXAM1+aNkDH/mWyJz0AGT6TJlS5iBGmf7qeBOoHKdlybCgP5sLuUthF/LEjOI5bieB9d3tLP9GMiT4xdr0psmW/GxlWoObjwhIbxNJYt4A+mrSnqQcpjuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742552672; c=relaxed/simple;
	bh=3L1k6EZ6HqN4Jr58ja35SAAQN7Ikbs1lTiTV/MxSrZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8qJKOnxZ1Xij2cIje6STo4JivBRseWGM2HBuzwnIqkEHZyPnA8zE8Z49H3SE+C4hHifSggyzyBD2utifH7wZgVzFYBpu9aofFPk/eGZHRos5F9ubcq08N5Z29R+Y+SZ6SBttK3VsY86An4NJ1BooPrhnvgDthhQCTuQMSTZSwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 28C5421A45;
	Fri, 21 Mar 2025 10:24:29 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99D3213A2C;
	Fri, 21 Mar 2025 10:24:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2PZ8Ilw+3WcvLQAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Fri, 21 Mar 2025 10:24:28 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com,
	serge@hallyn.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	kirill.shutemov@linux.intel.com,
	linux-coco@lists.linux.dev,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 2/2] lockdown/kunit: Introduce kunit tests
Date: Fri, 21 Mar 2025 12:24:21 +0200
Message-ID: <20250321102422.640271-3-nik.borisov@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321102422.640271-1-nik.borisov@suse.com>
References: <20250321102422.640271-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 28C5421A45
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Add a bunch of tests to ensure lockdown's conversion to bitmap hasn't
regressed it.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 security/lockdown/Kconfig         |  5 +++
 security/lockdown/Makefile        |  1 +
 security/lockdown/lockdown.c      |  5 ++-
 security/lockdown/lockdown_test.c | 55 +++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 security/lockdown/lockdown_test.c

diff --git a/security/lockdown/Kconfig b/security/lockdown/Kconfig
index e84ddf484010..5fb750da1f8c 100644
--- a/security/lockdown/Kconfig
+++ b/security/lockdown/Kconfig
@@ -6,6 +6,11 @@ config SECURITY_LOCKDOWN_LSM
 	  Build support for an LSM that enforces a coarse kernel lockdown
 	  behaviour.
 
+config SECURITY_LOCKDOWN_LSM_TEST
+	tristate "Test lockdown functionality" if !KUNIT_ALL_TESTS
+	depends on SECURITY_LOCKDOWN_LSM && KUNIT
+	default KUNIT_ALL_TESTS
+
 config SECURITY_LOCKDOWN_LSM_EARLY
 	bool "Enable lockdown LSM early in init"
 	depends on SECURITY_LOCKDOWN_LSM
diff --git a/security/lockdown/Makefile b/security/lockdown/Makefile
index e3634b9017e7..f35d90e39f1c 100644
--- a/security/lockdown/Makefile
+++ b/security/lockdown/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_SECURITY_LOCKDOWN_LSM) += lockdown.o
+obj-$(CONFIG_SECURITY_LOCKDOWN_LSM_TEST) += lockdown_test.o
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 5014d18c423f..412184121279 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -25,7 +25,10 @@ static const enum lockdown_reason lockdown_levels[] = {LOCKDOWN_NONE,
 /*
  * Put the kernel into lock-down mode.
  */
-static int lock_kernel_down(const char *where, enum lockdown_reason level)
+#if !IS_ENABLED(CONFIG_KUNIT)
+static
+#endif
+int lock_kernel_down(const char *where, enum lockdown_reason level)
 {
 
 	if (level > LOCKDOWN_CONFIDENTIALITY_MAX)
diff --git a/security/lockdown/lockdown_test.c b/security/lockdown/lockdown_test.c
new file mode 100644
index 000000000000..0b4184a40111
--- /dev/null
+++ b/security/lockdown/lockdown_test.c
@@ -0,0 +1,55 @@
+#include <linux/security.h>
+#include <kunit/test.h>
+
+int lock_kernel_down(const char *where, enum lockdown_reason level);
+
+static void lockdown_test_invalid_level(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, -EINVAL, lock_kernel_down("TEST", LOCKDOWN_CONFIDENTIALITY_MAX+1));
+}
+
+static void lockdown_test_depth_locking(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 0, lock_kernel_down("TEST", LOCKDOWN_INTEGRITY_MAX));
+	for (int i = 1; i < LOCKDOWN_INTEGRITY_MAX; i++) {
+		KUNIT_EXPECT_EQ_MSG(test, -EPERM, security_locked_down(i), "at i=%d", i);
+	}
+
+	KUNIT_EXPECT_EQ(test, -EPERM, security_locked_down(LOCKDOWN_INTEGRITY_MAX));
+}
+
+static void lockdown_test_individual_level(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 0, lock_kernel_down("TEST", LOCKDOWN_PERF));
+	KUNIT_EXPECT_EQ(test, -EPERM, security_locked_down(LOCKDOWN_PERF));
+	/* Ensure adjacent levels are untouched */
+	KUNIT_EXPECT_EQ(test, 0, security_locked_down(LOCKDOWN_TRACEFS));
+	KUNIT_EXPECT_EQ(test, 0, security_locked_down(LOCKDOWN_DBG_READ_KERNEL));
+}
+
+static void lockdown_test_no_downgrade(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 0, lock_kernel_down("TEST", LOCKDOWN_CONFIDENTIALITY_MAX));
+	KUNIT_EXPECT_EQ(test, 0, lock_kernel_down("TEST", LOCKDOWN_INTEGRITY_MAX));
+	/*
+	 * Ensure having locked down to a lower leve after a higher level
+	 * lockdown nothing is lost
+	 */
+	KUNIT_EXPECT_EQ(test, -EPERM, security_locked_down(LOCKDOWN_TRACEFS));
+}
+
+static struct kunit_case lockdown_tests[] = {
+	KUNIT_CASE(lockdown_test_invalid_level),
+	KUNIT_CASE(lockdown_test_depth_locking),
+	KUNIT_CASE(lockdown_test_individual_level),
+	KUNIT_CASE(lockdown_test_no_downgrade),
+	{}
+};
+
+static struct kunit_suite lockdown_test_suite = {
+	.name = "lockdown test",
+	.test_cases = lockdown_tests,
+};
+kunit_test_suite(lockdown_test_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.43.0

