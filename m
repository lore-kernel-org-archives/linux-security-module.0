Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6E62D8DD6
	for <linux-security-module@vger.kernel.org>; Thu,  4 Dec 2025 21:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764885375; cv=none; b=cZzgXSfEuvPInY7Lp1v3WwmVDFzXThtabGf2KdHNf2ykLiQ9WLMJXuuPXWIaSGFLHOrKzxAKjjxekgruG6gh2ubOG8fM8V2vXyRckK+eVaabqUejV7N+RvDtiLaZRdUqADemuDfBbnD4gSo3OcxxhuLC5ln5acdm6hfXH0yQhDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764885375; c=relaxed/simple;
	bh=1OzAP8QYDJFGQLO1m4tUDCn5Y+FAfG+t+Qg39tZE5UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBOhjGHCuXt2HspmF7halyeoA0tcMeLYKyVSwmyPR3NBQUDklp2fkTnbAMDgr+oMpVq5ZXDmmMGTth+ONN9f4houS5sX2GkeTjmbZAEkxXe1wBeQIngADMxnLiT0MuuHH/PsxqEQrkLoIHRisRaLjVLhLzoF4HlOcIrN9QsYf/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJrXSEAR; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJrXSEAR"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34381ec9197so1266513a91.1
        for <linux-security-module@vger.kernel.org>; Thu, 04 Dec 2025 13:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764885372; x=1765490172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ww/VMC8wTs0WFN9a1LmPmA1Xu92cHbV5D2cGiRkdIY=;
        b=KJrXSEAR5soVpSRL2yKyPKsOrYzGI1R+WKQNxC7iOHE7Q3CPiqM2V8AcGYKlVa+uCy
         zMf6cJd+yCW79OyuXmp/sPhe3vkzwFAxDz6BeNRl3Sz1qTnhn+gkS7vgi9qL+wvfN+lY
         XKxZw5q+51kSG/q0Qs2u/nTwBiRJ9X5HKimYybMJyAHir2LLT3RqLf2nWpbtyqC5CDI5
         YLyo7rb5/T/JKovJWdqPQdwN54sT+wuizvOsak5uEVs3JmW7hjmAbCdNkkjWMCSr3SGK
         fZNDVM+AT7vmIG/W19vn7yBmR8lDwiNrXU4o8TBRXHOErCwrPPO4wWcF4QOZBchWRSaw
         nrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764885372; x=1765490172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Ww/VMC8wTs0WFN9a1LmPmA1Xu92cHbV5D2cGiRkdIY=;
        b=qypPyFlR1pfcMJOusxHikYQ0EbAG5xr6ba1GaHMAwd2+4+c4dmhwzh2Iur+ghd/4eB
         9jaz0scoxow5NomRbHZXYoWEQowQm3XdMXumK7IpRgppmZu2sR/6Qp/6xIFW6Y/Y3XgR
         N4cx6jmpBC83LDUsCNaiVbPYPEbDoHEmX/FbP6hfUhGFhorVoMqKcyqvtOi43QxjWjGA
         mRY+8IZsU/Bf4UUi+OfGcSGpmXyAqG/bcFdeI+Rzt5mDpCTmlQfirSVQ8CB0xY6dNsHf
         M/WP/XdM0piWdJmKuRzajCLkJ9n3Nb99vxiabXUioiAzqGXdTHDorpGHKSP0laFYoFX7
         y6wQ==
X-Gm-Message-State: AOJu0YzH7m/gZvVDGkRgXsZSdbfFbGWWNOFbJM6iqEDlKJhiX3ZgC3ZF
	L6YlEOWgKWTtzgLF0M2hqI4jUIuhtyfpDaJALeX206RFfTiYP73FZu7XlyxeMr2y
X-Gm-Gg: ASbGncuVg12gc2vjaftGAcy/XNpJUL3x/4ZLs8kcUslWGqAQEhqEBe+LmWD5Iobwl2R
	a5nOB62UalisdD/fgLR867QdmR5ZGnBVRYXgl55do4I645mQW5JHba5s+thWxT/QB/Qehi+OJ/F
	Ec8hbbUnx/ATt3pLiiGsw2unxs7gDMoLqLz9UtUL8+UkiNhBbZtFA+2tboETdJLOolASA//Wifd
	VYmdh1LAjlbiwFcext7N1krKcMNvv+/+O3Ob0foufBsLoV/7bASFRzcj560a+VuPkzEO0tMKLuG
	M5Qr9YD2WtD3OgW5o9PBXSL7dqPnqJmn6l0qVQolvllhT93MOWqaYzwmTva4k5eXi1Hu61VaPjC
	GZ9/sBlRY7hJ4TnWbbfBSYohS21v3va4NPEit//D5aWQBRS9Yf852t/FkIHT0P9lkq5+QKupwlY
	N55KQlmwr1J+qzf4NLp9NQ0yy+3dht0lJ7LhFXFfLc9Op9vJ55OEI68Dss3mALDORtPgUJ
X-Google-Smtp-Source: AGHT+IGdGnYH3CUqMgEI1Ziq/CBQEROZpc4K04Jne2Vc9sczKNzNBVDGeI+Mje34fC621EkIq8MBEg==
X-Received: by 2002:a17:90a:9f84:b0:340:e8e9:cc76 with SMTP id 98e67ed59e1d1-349125d3475mr6220952a91.11.1764885372036;
        Thu, 04 Dec 2025 13:56:12 -0800 (PST)
Received: from kailas.hsd1.or.comcast.net ([2601:1c2:982:6040:9be5:76bb:9ba9:8a19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3494ea7b5d1sm2805679a91.13.2025.12.04.13.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 13:56:11 -0800 (PST)
From: Ryan Foster <foster.ryan.r@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: serge@hallyn.com,
	paul@paul-moore.com,
	linux-kernel@vger.kernel.org,
	Ryan Foster <foster.ryan.r@gmail.com>
Subject: [PATCH] security: Add KUnit tests for kuid_root_in_ns and vfsuid_root_in_currentns
Date: Thu,  4 Dec 2025 13:56:09 -0800
Message-ID: <20251204215610.148342-1-foster.ryan.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aSXICxT6u0Rx1FhW@mail.hallyn.com>
References: <aSXICxT6u0Rx1FhW@mail.hallyn.com>
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
---
 security/Kconfig          |  17 +++
 security/commoncap.c      |   4 +
 security/commoncap_test.c | 290 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 311 insertions(+)
 create mode 100644 security/commoncap_test.c

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
2.43.0

