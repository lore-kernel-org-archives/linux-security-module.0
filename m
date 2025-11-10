Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA2A303A14
	for <linux-security-module@vger.kernel.org>; Mon, 10 Nov 2025 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785474; cv=none; b=Jx1K0zsvzutKGaxjzKtM5Mj7uZeacgEmaHOSAUs7OefeEerW69dFRcVUF2zGFf8XzFP/6xcHF4GfCuslSTQzOoyJWYnkzibLrQobxKanlfWEOXeVj5oCIokETLROgJovA6g9uyuJAoBR10fVm8kY2cNluKPpxVpmDn/vvVvJ/HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785474; c=relaxed/simple;
	bh=j9W6mR1nSLLoY/o7TRhp+EtDj01g2jfhAY+2KL+HIIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dUWKSF5s75veEbVoVjkPwwUNuSbIbMZLAsz8vz3ZK0vp6p8gEKIhk1hXT2yHUGLP3D8UGgPs7fMdOeuDWiDQKOa2vUOec5rBuDPVcji2l8WGKhpcVoKatJb7LNT3pT37NCU1iat78NUhBNiU/jsBpTPN0Uumsx9lMSFns8S3fxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktzdP2w4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktzdP2w4"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-298145fe27eso13723315ad.1
        for <linux-security-module@vger.kernel.org>; Mon, 10 Nov 2025 06:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762785472; x=1763390272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W95TLkiz0fBF9QeEMsYG7RnrM7ocxkZkSz+UtJe4oVA=;
        b=ktzdP2w4nyH45+CLo0ZKzuNZSTKFvuopMF9JziV+E+Oy/Ui+lVuwqB2Qv6cFeS4M8O
         KkJcGGAjABmQ/h8+24w3kn7tkdzZtVdyjqhGmHWm6ue2B7AY+oZCCkU0NY719YSCWtWO
         oRIbm7vjjuDbGNo5aeQRdzU+1Pqsa5RWBKFkDMQbjpi6cZ+HhiQt1Zl5rFAJOnoe7hGX
         2kt4CS27+QAi4GY4LzZhJ6Ce7dco0TOF51wpNX5e+mf7b5GN8Qn7eB9jXX8K4h9LnhMn
         1g0VobL+fn3hZ6nAkUzumygAyKweDwX4nK+KOEiEcYZnK7wI+a4amYtPVVOvq5l9Iawh
         6W4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762785472; x=1763390272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W95TLkiz0fBF9QeEMsYG7RnrM7ocxkZkSz+UtJe4oVA=;
        b=CfEtZa4kb6GruGyypaBxJ4vM24apeRj/Cc2X3aQaCK6eccDh2o36jfuXzXEk4VuAUA
         f83eYXSC5BORfArfqmGxq/S6XHTGy65bAAUKOK3ZwUXcGv9IfB0O1xd8DFrBF68shqR5
         QmUQYRJiwagDaCPaHMbfQ857QevRSUZcW9dVezVtq1DERYmog6y6bTrxlI0cFDWMBMpE
         zhdpOT5OXMm5asII0HTDXOn/sSM/2piq9l8z4YC+nkPRCXAHJrKsBteLV/SNxe2NtGob
         P88PG0tta8mYbz3G852iN6I4+LzLBJbDdvODDFbwM2BOEaplDeij4BPZeXatJQBdstSF
         eTeA==
X-Gm-Message-State: AOJu0YxqsoHKQVL2KXM8mIiDOiIEkJ+JzGT8u41uR5qATqxYV4taYHlL
	I8d67md7RZDZk3/c8CnfN5PAcfGykgnmxn6oxDnSY+vyDpLiSctLQrcL
X-Gm-Gg: ASbGnctJBgPzW0ADY0B2Gujdl15ZsaJ80vxlEWXLMpvSXDbJO0EToVKk2kXKkaXj027
	gvDJT/twnCWkvZ2gqvCeHpysV0s9swjgp6/6tDRGsi1xZKDNdDVBkgTg5l2En8wvq8MURN6RemN
	jeVQap3n/xBz8o3O+62jdXnnYmiA4eIq/AM+e1SYKuJsrS0NMotox3AAp/y35es6ZR+Rlm0hgis
	gUonE5EELXJONslHqcAR692EPW2IPRDf9H1GJpJEVreF4/2reQELzVPAmoh3devsk61XghpeE1G
	EZd5VwVetPcgOzog893GAn+N3TUjf2p4IpH6hVMT9b/iCqlb/XALrLdxL7Z4vsinvXz4BLsg5sC
	gxDKqM6Y6qS8ixxZnOVO/5/hvSa116yHP09Wnq3CUcQqOR2TdTUPfSjCIWbIJNkrd8VkxI6vJmL
	4oX1M5FpvZvqh52U9IZBJqAMe8telY8vRZZvhGyW4ixxHeSlkCCAgADSqY7APQXu9XTWY=
X-Google-Smtp-Source: AGHT+IGxw1dtMjLMgPWeoxTBjJbiGNI5QXhcVtgUFuK/x/r1bmfa9tqNF3NtpZlQ+wAeJu3yb8oynA==
X-Received: by 2002:a17:902:ecc5:b0:295:565b:c691 with SMTP id d9443c01a7336-297e5629152mr123128585ad.17.1762785472179;
        Mon, 10 Nov 2025 06:37:52 -0800 (PST)
Received: from kailas.hsd1.or.comcast.net ([2601:1c2:982:6040:67c:16ff:fee7:1184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296509682casm148113295ad.22.2025.11.10.06.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:37:51 -0800 (PST)
From: Ryan Foster <foster.ryan.r@gmail.com>
To: selinux@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	serge@hallyn.com,
	paul@paul-moore.com,
	Ryan Foster <foster.ryan.r@gmail.com>
Subject: [PATCH] security: Add KUnit tests for rootid_owns_currentns()
Date: Mon, 10 Nov 2025 06:37:48 -0800
Message-ID: <20251110143748.4144288-1-foster.ryan.r@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rootid_owns_currentns() function in security/commoncap.c is a
security-critical function used to determine if a root ID from a
parent namespace owns the current namespace. This function is used
in multiple security-critical paths:

1. cap_inode_getsecurity() - file capability retrieval
2. get_vfs_caps_from_disk() - file capability loading during exec

Despite its security-critical nature, this function had no test
coverage. This patch adds KUnit tests to verify the function's
behavior in various scenarios:

- Root ID in init namespace (positive case)
- Invalid vfsuid (negative case)
- Non-root UID (negative case)

The function is made testable by exporting it when
CONFIG_SECURITY_COMMONCAP_KUNIT_TEST is enabled, while maintaining
static visibility in production builds.

This follows the pattern established by other security subsystems
(IPE, Landlock) for KUnit testing.

Signed-off-by: Ryan Foster <foster.ryan.r@gmail.com>
---
 security/Kconfig          |  17 ++++++
 security/Makefile         |   1 +
 security/commoncap.c      |   5 ++
 security/commoncap_test.c | 109 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+)
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
diff --git a/security/Makefile b/security/Makefile
index 22ff4c8bd8ce..5b1285fde552 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_KEYS)			+= keys/
 
 # always enable default capabilities
 obj-y					+= commoncap.o
+obj-$(CONFIG_SECURITY_COMMONCAP_KUNIT_TEST)	+= commoncap_test.o
 obj-$(CONFIG_SECURITY) 			+= lsm_syscalls.o
 obj-$(CONFIG_MMU)			+= min_addr.o
 
diff --git a/security/commoncap.c b/security/commoncap.c
index 6bd4adeb4795..4d0e014ce7cd 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -358,7 +358,12 @@ int cap_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry)
 	return error;
 }
 
+#ifdef CONFIG_SECURITY_COMMONCAP_KUNIT_TEST
+bool rootid_owns_currentns(vfsuid_t rootvfsuid);
+bool rootid_owns_currentns(vfsuid_t rootvfsuid)
+#else
 static bool rootid_owns_currentns(vfsuid_t rootvfsuid)
+#endif
 {
 	struct user_namespace *ns;
 	kuid_t kroot;
diff --git a/security/commoncap_test.c b/security/commoncap_test.c
new file mode 100644
index 000000000000..9757d433d314
--- /dev/null
+++ b/security/commoncap_test.c
@@ -0,0 +1,109 @@
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
+#include <linux/module.h>
+
+/* We need to include the actual vfsuid_t definition but avoid the problematic
+ * inline functions in mnt_idmapping.h. Include just the type definitions.
+ */
+#include <linux/types.h>
+
+/* Forward declare the minimal types we need - match the actual kernel definitions */
+struct mnt_idmap;
+typedef struct {
+	uid_t val;
+} vfsuid_t;
+
+/* Minimal macros we need - match kernel definitions from mnt_idmapping.h */
+static inline uid_t __vfsuid_val(vfsuid_t uid)
+{
+	return uid.val;
+}
+
+#define VFSUIDT_INIT(val) ((vfsuid_t){ __kuid_val(val) })
+#define INVALID_VFSUID VFSUIDT_INIT(INVALID_UID)
+
+#ifdef CONFIG_SECURITY_COMMONCAP_KUNIT_TEST
+
+/* Forward declaration - function is exported when KUNIT_TEST is enabled */
+extern bool rootid_owns_currentns(vfsuid_t rootvfsuid);
+
+/**
+ * test_rootid_owns_currentns_init_ns - Test rootid_owns_currentns with init ns
+ *
+ * Verifies that a root ID in the init namespace correctly owns the current
+ * namespace when running in init_user_ns.
+ */
+static void test_rootid_owns_currentns_init_ns(struct kunit *test)
+{
+	vfsuid_t root_vfsuid;
+	kuid_t root_kuid;
+
+	/* Create a root UID in init namespace */
+	root_kuid = KUIDT_INIT(0);
+	root_vfsuid = VFSUIDT_INIT(root_kuid);
+
+	/* In init namespace, root should own current namespace */
+	KUNIT_EXPECT_TRUE(test, rootid_owns_currentns(root_vfsuid));
+}
+
+/**
+ * test_rootid_owns_currentns_invalid - Test rootid_owns_currentns with invalid vfsuid
+ *
+ * Verifies that an invalid vfsuid correctly returns false.
+ */
+static void test_rootid_owns_currentns_invalid(struct kunit *test)
+{
+	vfsuid_t invalid_vfsuid;
+
+	/* Use the predefined invalid vfsuid */
+	invalid_vfsuid = INVALID_VFSUID;
+
+	/* Invalid vfsuid should return false */
+	KUNIT_EXPECT_FALSE(test, rootid_owns_currentns(invalid_vfsuid));
+}
+
+/**
+ * test_rootid_owns_currentns_nonroot - Test rootid_owns_currentns with non-root UID
+ *
+ * Verifies that a non-root UID correctly returns false.
+ */
+static void test_rootid_owns_currentns_nonroot(struct kunit *test)
+{
+	vfsuid_t nonroot_vfsuid;
+	kuid_t nonroot_kuid;
+
+	/* Create a non-root UID */
+	nonroot_kuid = KUIDT_INIT(1000);
+	nonroot_vfsuid = VFSUIDT_INIT(nonroot_kuid);
+
+	/* Non-root UID should return false */
+	KUNIT_EXPECT_FALSE(test, rootid_owns_currentns(nonroot_vfsuid));
+}
+
+static struct kunit_case commoncap_test_cases[] = {
+	KUNIT_CASE(test_rootid_owns_currentns_init_ns),
+	KUNIT_CASE(test_rootid_owns_currentns_invalid),
+	KUNIT_CASE(test_rootid_owns_currentns_nonroot),
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
+
-- 
2.43.0

