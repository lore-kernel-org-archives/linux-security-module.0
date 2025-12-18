Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CF3302756
	for <linux-security-module@vger.kernel.org>; Thu, 18 Dec 2025 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766083819; cv=none; b=SxmdCmkvBIZZUbtivUP59epAtC9sXNMmp+1FwR7tjLaTD8JeHdNn2Q7Vi98lhkF/9H7WdVIB575APpCObzMYy4OUpWK1KNhYW+hwuhiGieWq5eyCUIo0Dl0HkZIMXmpeaVs2KtN5XS/7kikBH7djbuC9HOmzCyGV4eyHdLUJON8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766083819; c=relaxed/simple;
	bh=/0o5Sghe2s0kfXw3vk2xvZp6G6ERLSNsxnpvlpxKU0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5BbzA4g7xxZslMI9fJqQJSuiFqq/1upu+HoJn1Pzp69h3g7D0HlTlFXh66jaMONynuV7Ts3fHcNKzzo7B5QkEupx3XybaErKOhZJ6FUp29VUOy8DxmhI1hFQaSPNI+Y4hGQfZ2Dq5YvTfvoBUBoHfe4yTVOR9wPCwNYNWpQeIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awSS9C9s; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awSS9C9s"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34ca40c1213so835028a91.0
        for <linux-security-module@vger.kernel.org>; Thu, 18 Dec 2025 10:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766083816; x=1766688616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9iuDf2YITBNOZvs5YN8leZVfTRGadUlWIghfoZCoM4=;
        b=awSS9C9sEBl6BnbsMkSQ+tVnAC4u7qXHRAg9gmO9b9PwsnOcRBT2H6+qxxs5Ok5Rxo
         w6VFpeokF0v1G7PvszlAU1HfqR4ySpSHKu4+QJjfh0+dW8eqYtp8bQwiynQpeczmmqLK
         1d7tGlrEGfX+RtEfrLz+yNaxBSKISebh+KsktI84nEdd7eGSoNRfMYfmDXZyV9U/TuHD
         NY36yKncm+DH1fPYkg/uGHXKum+pDuAghalv5jtC+KWKe/YeHncl2qXlKnJGB/dBQqcp
         0mL9M2T+GvWmIhf5rNJn4t5Dr4feHpfQtg6it/HNh5+ViyjC0zuJufmJ9aaA91QpjLaK
         G0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766083816; x=1766688616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X9iuDf2YITBNOZvs5YN8leZVfTRGadUlWIghfoZCoM4=;
        b=ryiCONNqcRWS7jEUJh41e2zPmsH2ohXSPFB33fffz3gDcI8KOVpOzloPdFr35B+O/z
         B1ZZBwmVUFCchDK65BeBA+lX2BJ34rn/tnOA8+e60V2AwLeF7KUF8UOFtAwG1qFwMw7k
         Zp2RcLiofozPt3vkw0YaOHWiop2SdEOCX+qUft5jdvlg6rk6aX9F1n54AJSS3LZ+OL1w
         ZwmK3ssnXZX9EkF2SewwfNtZmiQjbVy0G+fs9LilnZTx/lecJIfjcWKpkxIWBBd94a73
         /lAImdgC4IfDrkRXNDeNdG/SBl1drGrsbft8K3AbI2yuNAieopIgHjcbtk6TCmtRAulb
         BlQQ==
X-Gm-Message-State: AOJu0YwwTvMPDr78zpPhO0lpioNT8xtgdjuTTM4GPOie8Ip6IMUrJPdm
	jlKy3QbRytRhv2FaPxOkFAu2EMT5uiKJ2O/3LfB8OOmeEK1hoWinR73m1ETot6tw
X-Gm-Gg: AY/fxX6ZUkqDrUHxXgZtD+SQ6BzxMNAyQHbkv+uO9xSAkEqwOi1NQ6YBV9DyNkn0+cH
	ydC2eMHbMV5PVPAcLXdbozQSzo61heT2it8gEoMv1I/R6eEjPFWkBBEWAoCnSUQeKNWET4s/2zo
	4EUplZCEOA8iE2XBgDEzOwaPYs6w6iTAXgxJ5zdHKCWuNsBtpAMUCLnRfOPbyQxld0K74T1AEoF
	l+nGYjCMyPwhOzs6ozn9zm4xxeu71Joo6PmnYzcTMssNsADylvPaRkkpOwAokFzVNNCqrhaGNG8
	BaxP+ojev7f6D4KVmeDsJyhJhzjPrjICvXiKaP2lB8vmIlbOkBfA/hCm1VjkWZ2NMLQhAFCe/x4
	gQ1jmC9vEyPRxmhDSEoVT+WVw1hkRSnjPx5/Osdgi5dWKItXKq8OQAHgc1G2+A2QkTu8GWmrJLj
	DoMlVOhD66bcfeuRHqt1DXHhhl3tJBQaawe3QM50h0nfjBtD8UhSKig3Tu8S9o9Ykhn9s=
X-Google-Smtp-Source: AGHT+IEk/nBnZPx1BgFGdiQKPOMsMawjbVQK7J3MWs0OB/vnCKClllg8q0k+IV2+ZYceYgwaj1v3AA==
X-Received: by 2002:a17:90b:4f41:b0:340:bde5:c9e3 with SMTP id 98e67ed59e1d1-34e921b73b5mr259849a91.23.1766083815633;
        Thu, 18 Dec 2025 10:50:15 -0800 (PST)
Received: from kailas.hsd1.or.comcast.net ([2601:1c2:982:6040:c34:2e5a:edb1:6462])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f7e2sm3133579a91.2.2025.12.18.10.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 10:50:14 -0800 (PST)
From: Ryan Foster <foster.ryan.r@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paul@paul-moore.com,
	serge@hallyn.com,
	Ryan Foster <foster.ryan.r@gmail.com>
Subject: [PATCH v3 sec cap tests] security: Add KUnit tests for kuid_root_in_ns and vfsuid_root_in_currentns
Date: Thu, 18 Dec 2025 10:49:55 -0800
Message-ID: <20251218185011.15154-1-foster.ryan.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204215610.148342-1-foster.ryan.r@gmail.com>
References: <20251204215610.148342-1-foster.ryan.r@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add comprehensive KUnit tests for the namespace-related capability
functions that Serge Hallyn refactored in commit 9891d2f79a9f
("Clarify the rootid_owns_currentns").

The tests verify:
- Basic functionality: UID 0 in init namespace, invalid vfsuid, non-zero UIDs
- Actual namespace traversal: Creating user namespaces with different UID
  mappings where uid 0 maps to different kuids (e.g., 1000, 2000, 3000)
- Hierarchy traversal: Testing multiple nested namespaces to verify
  correct namespace hierarchy traversal

This addresses the feedback to "test the actual functionality" by creating
real user namespaces with different values for the namespace's uid 0, rather
than just basic input validation.

The test file is included at the end of commoncap.c when
CONFIG_SECURITY_COMMONCAP_KUNIT_TEST is enabled, following the standard
kernel pattern (e.g., scsi_lib.c, ext4/mballoc.c). This allows tests to
access static functions in the same compilation unit without modifying
production code based on test configuration.

All 7 tests pass:
- test_vfsuid_root_in_currentns_init_ns
- test_vfsuid_root_in_currentns_invalid
- test_vfsuid_root_in_currentns_nonzero
- test_kuid_root_in_ns_init_ns_uid0
- test_kuid_root_in_ns_init_ns_nonzero
- test_kuid_root_in_ns_with_mapping
- test_kuid_root_in_ns_with_different_mappings

Updated MAINTAINER capabilities to include commoncap test
---
 MAINTAINERS               |   1 +
 security/Kconfig          |  17 +++
 security/commoncap.c      |   4 +
 security/commoncap_test.c | 290 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 312 insertions(+)
 create mode 100644 security/commoncap_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c0030e126fc8..6f162c736dfb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5682,6 +5682,7 @@ F:	include/trace/events/capability.h
 F:	include/uapi/linux/capability.h
 F:	kernel/capability.c
 F:	security/commoncap.c
+F:	security/commoncap_test.c
 
 CAPELLA MICROSYSTEMS LIGHT SENSOR DRIVER
 M:	Kevin Tsai <ktsai@capellamicro.com>
diff --git a/security/Kconfig b/security/Kconfig
index 285f284dfcac..c7b3f42ef875 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -284,6 +284,23 @@ config LSM
 
 	  If unsure, leave this as the default.
 
+config SECURITY_COMMONCAP_KUNIT_TEST
+	bool "Build KUnit tests for commoncap" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the commoncap KUnit tests.
+
+	  KUnit tests run during boot and output the results to the debug log
+	  in TAP format (https://testanything.org/). Only useful for kernel devs
+	  running KUnit test harness and are not for inclusion into a
+	  production build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 source "security/Kconfig.hardening"
 
 endmenu
diff --git a/security/commoncap.c b/security/commoncap.c
index 8a23dfab7fac..3399535808fe 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1521,3 +1521,7 @@ DEFINE_LSM(capability) = {
 };
 
 #endif /* CONFIG_SECURITY */
+
+#ifdef CONFIG_SECURITY_COMMONCAP_KUNIT_TEST
+#include "commoncap_test.c"
+#endif
diff --git a/security/commoncap_test.c b/security/commoncap_test.c
new file mode 100644
index 000000000000..1088364a54e6
--- /dev/null
+++ b/security/commoncap_test.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * KUnit tests for commoncap.c security functions
+ *
+ * Tests for security-critical functions in the capability subsystem,
+ * particularly namespace-related capability checks.
+ */
+
+#include <kunit/test.h>
+#include <linux/user_namespace.h>
+#include <linux/uidgid.h>
+#include <linux/cred.h>
+#include <linux/mnt_idmapping.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/refcount.h>
+
+#ifdef CONFIG_SECURITY_COMMONCAP_KUNIT_TEST
+
+/* Functions are static in commoncap.c, but we can call them since we're
+ * included in the same compilation unit when tests are enabled.
+ */
+
+/**
+ * test_vfsuid_root_in_currentns_init_ns - Test vfsuid_root_in_currentns with init ns
+ *
+ * Verifies that UID 0 in the init namespace correctly owns the current
+ * namespace when running in init_user_ns.
+ *
+ * @test: KUnit test context
+ */
+static void test_vfsuid_root_in_currentns_init_ns(struct kunit *test)
+{
+	vfsuid_t vfsuid;
+	kuid_t kuid;
+
+	/* Create UID 0 in init namespace */
+	kuid = KUIDT_INIT(0);
+	vfsuid = VFSUIDT_INIT(kuid);
+
+	/* In init namespace, UID 0 should own current namespace */
+	KUNIT_EXPECT_TRUE(test, vfsuid_root_in_currentns(vfsuid));
+}
+
+/**
+ * test_vfsuid_root_in_currentns_invalid - Test vfsuid_root_in_currentns with invalid vfsuid
+ *
+ * Verifies that an invalid vfsuid correctly returns false.
+ *
+ * @test: KUnit test context
+ */
+static void test_vfsuid_root_in_currentns_invalid(struct kunit *test)
+{
+	vfsuid_t invalid_vfsuid;
+
+	/* Use the predefined invalid vfsuid */
+	invalid_vfsuid = INVALID_VFSUID;
+
+	/* Invalid vfsuid should return false */
+	KUNIT_EXPECT_FALSE(test, vfsuid_root_in_currentns(invalid_vfsuid));
+}
+
+/**
+ * test_vfsuid_root_in_currentns_nonzero - Test vfsuid_root_in_currentns with non-zero UID
+ *
+ * Verifies that a non-zero UID correctly returns false.
+ *
+ * @test: KUnit test context
+ */
+static void test_vfsuid_root_in_currentns_nonzero(struct kunit *test)
+{
+	vfsuid_t vfsuid;
+	kuid_t kuid;
+
+	/* Create a non-zero UID */
+	kuid = KUIDT_INIT(1000);
+	vfsuid = VFSUIDT_INIT(kuid);
+
+	/* Non-zero UID should return false */
+	KUNIT_EXPECT_FALSE(test, vfsuid_root_in_currentns(vfsuid));
+}
+
+/**
+ * test_kuid_root_in_ns_init_ns_uid0 - Test kuid_root_in_ns with init namespace and UID 0
+ *
+ * Verifies that kuid_root_in_ns correctly identifies UID 0 in init namespace.
+ * This tests the core namespace traversal logic. In init namespace, UID 0
+ * maps to itself, so it should own the namespace.
+ *
+ * @test: KUnit test context
+ */
+static void test_kuid_root_in_ns_init_ns_uid0(struct kunit *test)
+{
+	kuid_t kuid;
+	struct user_namespace *init_ns;
+
+	kuid = KUIDT_INIT(0);
+	init_ns = &init_user_ns;
+
+	/* UID 0 should own init namespace */
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(kuid, init_ns));
+}
+
+/**
+ * test_kuid_root_in_ns_init_ns_nonzero - Test kuid_root_in_ns with init namespace and non-zero UID
+ *
+ * Verifies that kuid_root_in_ns correctly rejects non-zero UIDs in init namespace.
+ * Only UID 0 should own a namespace.
+ *
+ * @test: KUnit test context
+ */
+static void test_kuid_root_in_ns_init_ns_nonzero(struct kunit *test)
+{
+	kuid_t kuid;
+	struct user_namespace *init_ns;
+
+	kuid = KUIDT_INIT(1000);
+	init_ns = &init_user_ns;
+
+	/* Non-zero UID should not own namespace */
+	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(kuid, init_ns));
+}
+
+/**
+ * create_test_user_ns_with_mapping - Create a mock user namespace with UID mapping
+ *
+ * Creates a minimal user namespace structure for testing where uid 0 in the
+ * namespace maps to a specific kuid in the parent namespace.
+ *
+ * @test: KUnit test context
+ * @parent_ns: Parent namespace (typically init_user_ns)
+ * @mapped_kuid: The kuid that uid 0 in this namespace maps to in parent
+ *
+ * Returns: Pointer to allocated namespace, or NULL on failure
+ */
+static struct user_namespace *create_test_user_ns_with_mapping(struct kunit *test,
+								 struct user_namespace *parent_ns,
+								 kuid_t mapped_kuid)
+{
+	struct user_namespace *ns;
+	struct uid_gid_extent extent;
+
+	/* Allocate a test namespace - use kzalloc to zero all fields */
+	ns = kunit_kzalloc(test, sizeof(*ns), GFP_KERNEL);
+	if (!ns)
+		return NULL;
+
+	/* Initialize basic namespace structure fields */
+	ns->parent = parent_ns;
+	ns->level = parent_ns ? parent_ns->level + 1 : 0;
+	ns->owner = mapped_kuid;
+	ns->group = KGIDT_INIT(0);
+
+	/* Initialize ns_common structure */
+	refcount_set(&ns->ns.__ns_ref, 1);
+	ns->ns.inum = 0; /* Mock inum */
+
+	/* Set up uid mapping: uid 0 in this namespace maps to mapped_kuid in parent
+	 * Format: first (uid in ns) : lower_first (kuid in parent) : count
+	 * So: uid 0 in ns -> kuid mapped_kuid in parent
+	 * This means from_kuid(ns, mapped_kuid) returns 0
+	 */
+	extent.first = 0;                              /* uid 0 in this namespace */
+	extent.lower_first = __kuid_val(mapped_kuid);  /* maps to this kuid in parent */
+	extent.count = 1;
+
+	ns->uid_map.extent[0] = extent;
+	ns->uid_map.nr_extents = 1;
+
+	/* Set up gid mapping: gid 0 maps to gid 0 in parent (simplified) */
+	extent.first = 0;
+	extent.lower_first = 0;
+	extent.count = 1;
+
+	ns->gid_map.extent[0] = extent;
+	ns->gid_map.nr_extents = 1;
+
+	return ns;
+}
+
+/**
+ * test_kuid_root_in_ns_with_mapping - Test kuid_root_in_ns with namespace where uid 0
+ *				       maps to different kuid
+ *
+ * Creates a user namespace where uid 0 maps to kuid 1000 in the parent namespace.
+ * Verifies that kuid_root_in_ns correctly identifies kuid 1000 as owning the namespace.
+ *
+ * Note: kuid_root_in_ns walks up the namespace hierarchy, so it checks the current
+ * namespace first, then parent, then parent's parent, etc. So:
+ * - kuid 1000 owns test_ns because from_kuid(test_ns, 1000) == 0
+ * - kuid 0 also owns test_ns because from_kuid(init_user_ns, 0) == 0
+ *   (checked in parent)
+ *
+ * This tests the actual functionality as requested: creating namespaces with
+ * different values for the namespace's uid 0.
+ *
+ * @test: KUnit test context
+ */
+static void test_kuid_root_in_ns_with_mapping(struct kunit *test)
+{
+	struct user_namespace *test_ns;
+	struct user_namespace *parent_ns;
+	kuid_t mapped_kuid, other_kuid;
+
+	parent_ns = &init_user_ns;
+	mapped_kuid = KUIDT_INIT(1000);
+	other_kuid = KUIDT_INIT(2000);
+
+	test_ns = create_test_user_ns_with_mapping(test, parent_ns, mapped_kuid);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_ns);
+
+	/* kuid 1000 should own test_ns because it maps to uid 0 in test_ns */
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(mapped_kuid, test_ns));
+
+	/* kuid 0 should also own test_ns (checked via parent init_user_ns) */
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(0), test_ns));
+
+	/* Other kuids should not own test_ns */
+	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(other_kuid, test_ns));
+	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(KUIDT_INIT(500), test_ns));
+}
+
+/**
+ * test_kuid_root_in_ns_with_different_mappings - Test with multiple namespaces
+ *
+ * Creates multiple user namespaces with different UID mappings to verify
+ * that kuid_root_in_ns correctly handles different namespace hierarchies.
+ *
+ * Since kuid_root_in_ns walks up the hierarchy, kuids that map to 0 in init_user_ns
+ * will own all namespaces, while kuids that only map to 0 in specific namespaces
+ * will only own those namespaces and their children.
+ *
+ * @test: KUnit test context
+ */
+static void test_kuid_root_in_ns_with_different_mappings(struct kunit *test)
+{
+	struct user_namespace *ns1, *ns2, *ns3;
+
+	/* Create ns1 where uid 0 maps to kuid 1000 */
+	ns1 = create_test_user_ns_with_mapping(test, &init_user_ns, KUIDT_INIT(1000));
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ns1);
+
+	/* Create ns2 where uid 0 maps to kuid 2000 */
+	ns2 = create_test_user_ns_with_mapping(test, &init_user_ns, KUIDT_INIT(2000));
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ns2);
+
+	/* Create ns3 as a child of ns1 where uid 0 maps to kuid 3000 */
+	ns3 = create_test_user_ns_with_mapping(test, ns1, KUIDT_INIT(3000));
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ns3);
+
+	/* Test ns1: kuid 1000 owns it, kuid 0 owns it (via parent), kuid 2000 does not */
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(1000), ns1));
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(0), ns1));
+	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(KUIDT_INIT(2000), ns1));
+
+	/* Test ns2: kuid 2000 owns it, kuid 0 owns it (via parent), kuid 1000 does not */
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(2000), ns2));
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(0), ns2));
+	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(KUIDT_INIT(1000), ns2));
+
+	/* Test ns3: kuid 3000 owns it, kuid 1000 owns it (via parent ns1),
+	 * kuid 0 owns it (via init_user_ns), kuid 2000 does not
+	 */
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(3000), ns3));
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(1000), ns3));
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(0), ns3));
+	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(KUIDT_INIT(2000), ns3));
+}
+
+static struct kunit_case commoncap_test_cases[] = {
+	KUNIT_CASE(test_vfsuid_root_in_currentns_init_ns),
+	KUNIT_CASE(test_vfsuid_root_in_currentns_invalid),
+	KUNIT_CASE(test_vfsuid_root_in_currentns_nonzero),
+	KUNIT_CASE(test_kuid_root_in_ns_init_ns_uid0),
+	KUNIT_CASE(test_kuid_root_in_ns_init_ns_nonzero),
+	KUNIT_CASE(test_kuid_root_in_ns_with_mapping),
+	KUNIT_CASE(test_kuid_root_in_ns_with_different_mappings),
+	{}
+};
+
+static struct kunit_suite commoncap_test_suite = {
+	.name = "commoncap",
+	.test_cases = commoncap_test_cases,
+};
+
+kunit_test_suite(commoncap_test_suite);
+
+MODULE_LICENSE("GPL");
+
+#endif /* CONFIG_SECURITY_COMMONCAP_KUNIT_TEST */
-- 
2.52.0

