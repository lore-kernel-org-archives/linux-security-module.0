Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7421432E681
	for <linux-security-module@vger.kernel.org>; Mon, 29 Dec 2025 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767018797; cv=none; b=ntYL49elOykdychhwOFRrvYD8eTI5CDx2gH2/t0IwyxYI8a003REzggMLT1MQTI3OKVVJYjucGEAevtURVys5i+00ty09K5ylHSLQPUPAHKbEfGkly5uHtD7kHCt2AJqfEwbFq93fhdBHiSC+6dU1mjoXp6rMG73BUyzp3jqrI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767018797; c=relaxed/simple;
	bh=+HbJ055NXeVIHdus8Xu6yr8NY1MiLplzt/WoU+h1tOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dibhAtyfvYrroxaUGEKIrW30gokRUoGmcDXAZPuJxGMBjS27vMiMBTf8vJROMicn2y1VeklNWnrV+NjcVbyaVuzep0MP5wNdgsdLFkdEFwqmJPJLuQ9cgZ7F9PPGcYBbHeBFGQrUDBFJZxmsHbQ4dbGKtQ/+wjX4h/6Jc5YMEt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpEf7deC; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpEf7deC"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0ac29fca1so76772475ad.2
        for <linux-security-module@vger.kernel.org>; Mon, 29 Dec 2025 06:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767018792; x=1767623592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nlm6FgJqfBTRs4AYYyD46gNApRwsh1rD5CvR0kdhEdc=;
        b=PpEf7deCJ5yOVw10RdldHfxPEWxbYY/CIhq2ZOTKP6Fsnt6eMEUV/gPz4agW+gpIA6
         Ok9EIGyc80PHnh5eJ3gU+/WuMePed6VtlObjOFw9l5SOwWAYhD7flvnhXRAfMFdZCo0z
         zR4mGaCjZndiPCSCyBY4kMr9imLv3VVOntys3J/WDUQI2HqZO/+4P5wXuOgehiqNyRj1
         kVMpfGQbWb/59R6DcrwUMceEu5dBdUiBgJzYTRHfIDMaC8A4n8zcqrEw5QzNhHm/Rzzw
         HOpFGhsXzSgu2OQgru2M9slVAuQixpWkgkItM0dm2j3ygc+aN96XojoYMIBFLfkeE4Ov
         PoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767018792; x=1767623592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nlm6FgJqfBTRs4AYYyD46gNApRwsh1rD5CvR0kdhEdc=;
        b=qJislk00vVGHQPktw3/eVLkv7faqyrV4Fe1IrAJsBCxoF6pUFgBrLq5MgTxxes13mR
         rMlPg/IoRzln9xcsiPWjiPC3cD0Ak55WKMiBErlCuavTV36Jok1NEEkm53PKr5ym+qxR
         YYWCNq7LITKhENdSoBsWRzItR8yPJsKfkKtjXbGIO7cI/1KoM8P6VUa8QqwZ5A1e+ipC
         TxRjP00ilYK2I6tYsabVSsKXLQUOvXYNiRNzZyO6Zs211p4k22Gsh6jtVilX1Rksi5s2
         dTrzsHFs9vOQfGvVS0nNxvJBQlXsy1oB3ghhCWR2delxdyUp7rUN2Iiit9xjzX4tVt6r
         ofqA==
X-Gm-Message-State: AOJu0Yzd1KXCo9FDOr/6MUQWyEJ/Ugjq53U96lIRT8l/9xG29CFeDOn5
	Reyr9n5t4U93qOcQ4NXq+ladYpYi+fNAChNr/YjBhiCDH6+XelJgM9ItAldwCDEv
X-Gm-Gg: AY/fxX4VEYWxYKwTtdsHTFg+rZ2Jg6M7HmdavAxbAlqaztLKAWe6yiyFY6bDhSMeOAC
	8+s2gwtSPPrsMaEh3PAfZsXy0Ginq1l9qSe6aBMBXkcNiSW7EGRo0pvTJTEzHxNvohl4SGc4MiI
	zOJLs26cWlZrjjLUK2osO12dxYMVgOj4GqsZAAJSCIIDDbYumVm2ZxmWVgJfYgoj0s0oA7TzSyJ
	zs5+wjOlB9PkMMTb+M7hBlruin+WzedwnOwepS6k7HztVccW3RLb0bVENCl7eYY+jiJf0hGEgz6
	E0/JD5cTxDQ/M2rOdBqf6qMGoYyQsjz3rIx/WqAz3AT0wWJAIXNI9K/6UmZkSf2MkLfAe0n6mjO
	BCc/D2T7DMkwzIwRjIKdqec4Z1iamgm1EdhA2/B1tmvm85vMjLBJ1utmSonJhIS+jbmMhIRplnF
	KVbE9zB5oFdRjG52qyGdv+U/w6SoNLpwTzQwKZE77I6qUmEYsH8og=
X-Google-Smtp-Source: AGHT+IFarPUuYJK2x4yFCBvuZtk6iCEahjNHz2vubTnO0vQiZXHae8WIqmtETtaGR/2IwYw81dNGPw==
X-Received: by 2002:a17:903:2342:b0:2a0:d5b0:dd80 with SMTP id d9443c01a7336-2a2f2a3ae13mr277918335ad.54.1767018791615;
        Mon, 29 Dec 2025 06:33:11 -0800 (PST)
Received: from kailas.hsd1.or.comcast.net ([2601:1c2:982:6040::e14d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4d895sm277349635ad.54.2025.12.29.06.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 06:33:10 -0800 (PST)
From: Ryan Foster <foster.ryan.r@gmail.com>
To: serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paul@paul-moore.com,
	Ryan Foster <foster.ryan.r@gmail.com>
Subject: [PATCH v5] security: Add KUnit tests for kuid_root_in_ns and vfsuid_root_in_currentns
Date: Mon, 29 Dec 2025 06:23:00 -0800
Message-ID: <20251229143308.1218982-1-foster.ryan.r@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <aVIAFEUjPe6DhrKc@mail.hallyn.com>
References: <aVIAFEUjPe6DhrKc@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Serge,

Thanks for the review.  I have updated the patch to address the feedback
and build error from the intel CI.  

Changes:
- Fixed build error, changed dependency to KUNIT=y so always built in
  and not a module

- Fixed test invalid namespace configuration.  Made test ns children of
  init_user_ns, simpler config and expected logic.

With regards to the kconfig default, I copied this pattern over without
fully understanding the design, e.g. from lib/Kconfig. I believe
it is used to auto enable tests when running full test suite by default,
otherwise allowing for individual opt-in tests.

Thanks,
Ryan 


Signed-off-by: Ryan Foster <foster.ryan.r@gmail.com>
---
 MAINTAINERS               |   1 +
 security/Kconfig          |  17 +++
 security/commoncap.c      |   4 +
 security/commoncap_test.c | 288 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 310 insertions(+)
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
index 285f284dfcac..6a4393fce9a1 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -284,6 +284,23 @@ config LSM
 
 	  If unsure, leave this as the default.
 
+config SECURITY_COMMONCAP_KUNIT_TEST
+	bool "Build KUnit tests for commoncap" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y && USER_NS
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
index 000000000000..e9b278be37f1
--- /dev/null
+++ b/security/commoncap_test.c
@@ -0,0 +1,288 @@
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
+ * that kuid_root_in_ns correctly distinguishes between namespaces.
+ *
+ * Each namespace maps uid 0 to a different kuid, and we verify that each
+ * kuid only owns its corresponding namespace (plus kuid 0 owns all via
+ * init_user_ns parent).
+ *
+ * @test: KUnit test context
+ */
+static void test_kuid_root_in_ns_with_different_mappings(struct kunit *test)
+{
+	struct user_namespace *ns1, *ns2, *ns3;
+
+	/* Create three independent namespaces, each mapping uid 0 to different kuids */
+	ns1 = create_test_user_ns_with_mapping(test, &init_user_ns, KUIDT_INIT(1000));
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ns1);
+
+	ns2 = create_test_user_ns_with_mapping(test, &init_user_ns, KUIDT_INIT(2000));
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ns2);
+
+	ns3 = create_test_user_ns_with_mapping(test, &init_user_ns, KUIDT_INIT(3000));
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ns3);
+
+	/* Test ns1: kuid 1000 owns it, kuid 0 owns it (via parent), others do not */
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(1000), ns1));
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(0), ns1));
+	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(KUIDT_INIT(2000), ns1));
+	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(KUIDT_INIT(3000), ns1));
+
+	/* Test ns2: kuid 2000 owns it, kuid 0 owns it (via parent), others do not */
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(2000), ns2));
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(0), ns2));
+	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(KUIDT_INIT(1000), ns2));
+	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(KUIDT_INIT(3000), ns2));
+
+	/* Test ns3: kuid 3000 owns it, kuid 0 owns it (via parent), others do not */
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(3000), ns3));
+	KUNIT_EXPECT_TRUE(test, kuid_root_in_ns(KUIDT_INIT(0), ns3));
+	KUNIT_EXPECT_FALSE(test, kuid_root_in_ns(KUIDT_INIT(1000), ns3));
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

