Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544461E379B
	for <linux-security-module@vger.kernel.org>; Mon, 28 Jul 2025 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753701345; cv=none; b=njvhB8Jseu6c1/TZYG+utyeImZ00szZGX2CDohXLU1PR8NKCydU/D/+VVA9LjfGGHfX4EfOHe8RphyFzSWLpJQxRa73CbajdeavfnMIM7Eb69xf4MjGQvWFHS45GuVmQGf5eZ2SpT1v6oqAWPay1zNeXkYS0I94I+wNXoaoVAjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753701345; c=relaxed/simple;
	bh=CaA1BXxMe5cDZO6ArFR1yUpIP2diBEvxS4ogJKTOSck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OU7x0Q4nEdd2jzHFyKjp24iA4UUDOdLoCU6xU7ASxORS2w2j9A2J6nj16zg4PWTUv3bill4Vjc6uwBHf5hv5E7c+NXqJNlSywuCZ/Wti7Vs5um77aJzoPCGRNYRfz6R4Ug4EiayKXKptvGxfwyFQqusD0nKUFjVP1W61ip1Ojlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SsF1IMaq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SsF1IMaq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SsF1IMaq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SsF1IMaq"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB5BC1FB47;
	Mon, 28 Jul 2025 11:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753701333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iFs3jTAfr8cCeb3xsI/12HydfiDfj9ETzdXOUs2fbDI=;
	b=SsF1IMaqSr5mg0fI/171N8eWn7dJefqGMvgeOlJ3PEU/eLeOUZsH8JGcZBPFcM2yaO4D1p
	RJSQCfivZHmoCR0AYt4RhzeNTmA5eLG91g+z7/H3nOt8hk/FUMcLY6vGCPkRkcTQY1YYns
	4TUai2Sr01ncV5saCQ46tDZk+opzuPg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=SsF1IMaq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753701333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iFs3jTAfr8cCeb3xsI/12HydfiDfj9ETzdXOUs2fbDI=;
	b=SsF1IMaqSr5mg0fI/171N8eWn7dJefqGMvgeOlJ3PEU/eLeOUZsH8JGcZBPFcM2yaO4D1p
	RJSQCfivZHmoCR0AYt4RhzeNTmA5eLG91g+z7/H3nOt8hk/FUMcLY6vGCPkRkcTQY1YYns
	4TUai2Sr01ncV5saCQ46tDZk+opzuPg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FB8B138A5;
	Mon, 28 Jul 2025 11:15:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aOJcCNVbh2i6UQAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Mon, 28 Jul 2025 11:15:33 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paul@paul-moore.com,
	serge@hallyn.com,
	jmorris@namei.org,
	dan.j.williams@intel.com,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v2 2/3] lockdown/kunit: Introduce kunit tests
Date: Mon, 28 Jul 2025 14:15:16 +0300
Message-Id: <20250728111517.134116-3-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250728111517.134116-1-nik.borisov@suse.com>
References: <20250728111517.134116-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: BB5BC1FB47
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Add a bunch of tests to ensure lockdown's conversion to bitmap hasn't
regressed it.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 security/lockdown/Kconfig         |  5 +++
 security/lockdown/Makefile        |  1 +
 security/lockdown/lockdown.c      |  5 ++-
 security/lockdown/lockdown_test.c | 54 +++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 1 deletion(-)
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
index 000000000000..3a3c6db5b470
--- /dev/null
+++ b/security/lockdown/lockdown_test.c
@@ -0,0 +1,54 @@
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
+	for (int i = 1; i < LOCKDOWN_INTEGRITY_MAX; i++)
+		KUNIT_EXPECT_EQ_MSG(test, -EPERM, security_locked_down(i), "at i=%d", i);
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
2.34.1

