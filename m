Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0C41DE4F6
	for <linux-security-module@vger.kernel.org>; Fri, 21 Nov 2025 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763747311; cv=none; b=sECGA3579XHCMFlxNwNdN3TPGkjQ7hcpPMzq7njZ0W4GbpJj2yGGIcfMIBCXB7oXxPA8YWBBNo8OysAtZ+tZP2E4+g2Qw2/yF30fp4YyQJY3kEePqowj00ygvVfmqFGouFckMfrFSB4cb9MHYTtheM5CU1dAGgVzGHNzOc67/1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763747311; c=relaxed/simple;
	bh=NULRrJfiaMcji9y13f7iXvuyBqCUp2oDsalvWoh3bn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JF0+KYhDZDSDMRETFWMKBwN6sUpJp7mw2VM79MSLC9vWYj5NfNVFPdH683yBbXKDdEG/gGXvkLO0hYgIHy5VNystXyjbf2Rf2RLKILzB9dYe6vBdzuWa4J2mY2uvLn+54dg+kEh/ACSkKg1iZddXSSGwKerpCKnhsVD1nCfn2vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpVXDH3C; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpVXDH3C"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-297e264528aso26773835ad.2
        for <linux-security-module@vger.kernel.org>; Fri, 21 Nov 2025 09:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763747309; x=1764352109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eQqmO4BmDMVoeWkR2e76r309EUpKcaBoghmCD5rl1o=;
        b=EpVXDH3CV3zSKy/SD4xkshO49uWo+D9Fl6csh0Qk5T+zXLy3NmXachmnNzaKB0ZEzL
         uqHFzGIsTY8L5IA43ugePj5vd4ucghVqnB0ZnBCMH3BZ42MX4QRaEDkOQLpo3qZ9pN6b
         UI9OO1JMFejZ60I2RaTH5Okau/dusWA9XX9g5JZn4XeaMRNHujaHwvtiy7Y2PuaN+W1+
         7gQOSiebTbjOueYLLAlO4Nn4EZrk4pMXOhT9yueClA/KyD9FjaDx0QpW56sIln141gut
         FO2yxgbK/Mp1SsG+xERMx/K4yHe2hkvjoVBzp1dr4E0jTUilYzCE8KLYsKGJlmJ7X3N/
         IFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763747309; x=1764352109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+eQqmO4BmDMVoeWkR2e76r309EUpKcaBoghmCD5rl1o=;
        b=h8Ovjyy8BCKETfWJ0aQbXJz7Y7qr1ksQfabDrnilJG32EcUCrOa0r4k9+HwSiDBu+p
         KqUypC8X+5kmE6XsBPvO6Nz2EQ7TNQSX842GFypoYJuStor+FaVEZjpXbuGy0MX5sdAh
         V+1ffeoN8mTCwVZYM9CCljv8aUCVRo27so8GBKOgQXEAtzWyzs9uzZSL1NV1mKKWQjwH
         d4DN6rfeEuaii4g8bVFezmONczWUgDeMPefY4fHbpclsgqYClRFrxSvtwTQofhedRHZU
         2WD2o7hpQUaFeDL/F3iPzihk0gr2FnEkMjfiqMYCTZcEQQKQ539jSFBVhn4EzRR17D30
         cgMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu95z20XvfGBBwuaVH3Lh03nrW/9QKYRYlCqrM97AiPz4QrFc1eiNFFKLHgIX9R2guRiw7t1CbvOY1FfpEILwi1fx7kFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4aNdNCKlzyhP4ldNqr/+he6hWyslzQTpIFa8iUfpwh6w2KCUX
	RvKrWhd2dyfopCX8BQkxr4BxnpTaoEsti16VvhJMQqWsiCljSl9fc3PF
X-Gm-Gg: ASbGncuRqGiu40H5qaHLzKZbi7MKnaVTy3zh1NTDZaiZwybPXGFgt4MzN4p6G3PppTT
	QZwrkuo3VR9eVQx9M3S4B02cHg1EXJS3vtb/HlV8AmN/lNeovQFZR3YDmT0wCWnRPk64kKe6+vJ
	m7XbKFnblovi3hSwaFlFoHv1TYW28oIQbuVqVsjnemPEaZoz9Mu2dpcF9RjldxjfF5palKDunOA
	5udBPBQznDfJIon+88t1FjHFKUJ6xnkNQEoG7e24ZjNZlEP3+H+4oCSkIkCBU+N9oJRKPjSwSKA
	GkfALxYVitQl9U7r2FCGsnNqjIh1VkzCgoeBBlkdig2aYaUWF+1TSUG67JLhSEnRZwinIivwGWY
	54WtuolBv21QCWOBsq0tBasxpQ/vKok0GO+e/NJmU4gOjYoJ8xniAI/I5pInYpF5Fkzwvow4vqu
	fN5MH07JMBP3vaODFiEJ+BQUalEkAWlddUb2pnmEk3cE7+c4YVwguYZLr6pTFipposhXNC
X-Google-Smtp-Source: AGHT+IEnbLYDdEUSfyjfVgKDClXEpb/AwJhU3QHKe6oiaOxiArgSFmxpyTyY9U4LCCnzyNTQxqCNqw==
X-Received: by 2002:a17:903:1a2f:b0:274:3db8:e755 with SMTP id d9443c01a7336-29b6bf3b833mr43051295ad.30.1763747308753;
        Fri, 21 Nov 2025 09:48:28 -0800 (PST)
Received: from kailas.hsd1.or.comcast.net ([2601:1c2:982:6040:d03b:3305:c447:d166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25e0f0sm61261185ad.46.2025.11.21.09.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 09:48:27 -0800 (PST)
From: Ryan Foster <foster.ryan.r@gmail.com>
To: serge@hallyn.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ryan Foster <foster.ryan.r@gmail.com>
Subject: [PATCH v2] security: Rename functions and add namespace mapping tests
Date: Fri, 21 Nov 2025 09:48:26 -0800
Message-ID: <20251121174826.190381-1-foster.ryan.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110143748.4144288-1-foster.ryan.r@gmail.com>
References: <20251110143748.4144288-1-foster.ryan.r@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename rootid_owns_currentns() to uid_owns_currentns() and
rootid_owns_userns() to uid_owns_ns() for clarity, as the function checks
any UID, not just root. Update all call sites accordingly.

Add tests that create actual user namespaces with different UID mappings
to verify namespace traversal logic. The tests create namespaces where
uid 0 maps to different kuids (e.g., kuid 1000, 2000) and verify that
uid_owns_ns() correctly identifies ownership based on the namespace
hierarchy traversal.

This addresses feedback to use clearer function naming and test actual
namespace functionality with real user namespace creation and mappings,
rather than just basic input validation.
---
 security/commoncap.c      |  26 ++--
 security/commoncap_test.c | 286 ++++++++++++++++++++++++++++++++------
 2 files changed, 254 insertions(+), 58 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 15d8147a34c4..cca291df9551 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -359,16 +359,16 @@ int cap_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry)
 }
 
 #ifdef CONFIG_SECURITY_COMMONCAP_KUNIT_TEST
-bool rootid_owns_userns(struct user_namespace *ns, kuid_t kroot);
-bool rootid_owns_userns(struct user_namespace *ns, kuid_t kroot)
+bool uid_owns_ns(struct user_namespace *ns, kuid_t kuid);
+bool uid_owns_ns(struct user_namespace *ns, kuid_t kuid)
 #else
-static bool rootid_owns_userns(struct user_namespace *ns, kuid_t kroot)
+static bool uid_owns_ns(struct user_namespace *ns, kuid_t kuid)
 #endif
 {
 	struct user_namespace *iter;
 
 	for (iter = ns;; iter = iter->parent) {
-		if (from_kuid(iter, kroot) == 0)
+		if (from_kuid(iter, kuid) == 0)
 			return true;
 		if (iter == &init_user_ns)
 			break;
@@ -378,19 +378,19 @@ static bool rootid_owns_userns(struct user_namespace *ns, kuid_t kroot)
 }
 
 #ifdef CONFIG_SECURITY_COMMONCAP_KUNIT_TEST
-bool rootid_owns_currentns(vfsuid_t rootvfsuid);
-bool rootid_owns_currentns(vfsuid_t rootvfsuid)
+bool uid_owns_currentns(vfsuid_t vfsuid);
+bool uid_owns_currentns(vfsuid_t vfsuid)
 #else
-static bool rootid_owns_currentns(vfsuid_t rootvfsuid)
+static bool uid_owns_currentns(vfsuid_t vfsuid)
 #endif
 {
-	kuid_t kroot;
+	kuid_t kuid;
 
-	if (!vfsuid_valid(rootvfsuid))
+	if (!vfsuid_valid(vfsuid))
 		return false;
 
-	kroot = vfsuid_into_kuid(rootvfsuid);
-	return rootid_owns_userns(current_user_ns(), kroot);
+	kuid = vfsuid_into_kuid(vfsuid);
+	return uid_owns_ns(current_user_ns(), kuid);
 }
 
 static __u32 sansflags(__u32 m)
@@ -497,7 +497,7 @@ int cap_inode_getsecurity(struct mnt_idmap *idmap,
 		goto out_free;
 	}
 
-	if (!rootid_owns_currentns(vfsroot)) {
+	if (!uid_owns_currentns(vfsroot)) {
 		size = -EOVERFLOW;
 		goto out_free;
 	}
@@ -738,7 +738,7 @@ int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
 	/* Limit the caps to the mounter of the filesystem
 	 * or the more limited uid specified in the xattr.
 	 */
-	if (!rootid_owns_currentns(rootvfsuid))
+	if (!uid_owns_currentns(rootvfsuid))
 		return -ENODATA;
 
 	cpu_caps->permitted.val = le32_to_cpu(caps->data[0].permitted);
diff --git a/security/commoncap_test.c b/security/commoncap_test.c
index 962aa899455d..7f066dc0df5d 100644
--- a/security/commoncap_test.c
+++ b/security/commoncap_test.c
@@ -10,6 +10,8 @@
 #include <linux/user_namespace.h>
 #include <linux/uidgid.h>
 #include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/refcount.h>
 
 /* Forward declare types and functions we need from mnt_idmapping.h
  * We avoid including the full header because it contains inline functions
@@ -50,38 +52,38 @@ static inline kuid_t vfsuid_into_kuid(vfsuid_t vfsuid)
 #ifdef CONFIG_SECURITY_COMMONCAP_KUNIT_TEST
 
 /* Forward declarations - functions are exported when KUNIT_TEST is enabled */
-extern bool rootid_owns_userns(struct user_namespace *ns, kuid_t kroot);
-extern bool rootid_owns_currentns(vfsuid_t rootvfsuid);
+extern bool uid_owns_ns(struct user_namespace *ns, kuid_t kuid);
+extern bool uid_owns_currentns(vfsuid_t vfsuid);
 
 /**
- * test_rootid_owns_currentns_init_ns - Test rootid_owns_currentns with init ns
+ * test_uid_owns_currentns_init_ns - Test uid_owns_currentns with init ns
  *
- * Verifies that a root ID in the init namespace correctly owns the current
+ * Verifies that UID 0 in the init namespace correctly owns the current
  * namespace when running in init_user_ns.
  *
  * @test: KUnit test context
  */
-static void test_rootid_owns_currentns_init_ns(struct kunit *test)
+static void test_uid_owns_currentns_init_ns(struct kunit *test)
 {
-	vfsuid_t root_vfsuid;
-	kuid_t root_kuid;
+	vfsuid_t vfsuid;
+	kuid_t kuid;
 
-	/* Create a root UID in init namespace */
-	root_kuid = KUIDT_INIT(0);
-	root_vfsuid = VFSUIDT_INIT(root_kuid);
+	/* Create UID 0 in init namespace */
+	kuid = KUIDT_INIT(0);
+	vfsuid = VFSUIDT_INIT(kuid);
 
-	/* In init namespace, root should own current namespace */
-	KUNIT_EXPECT_TRUE(test, rootid_owns_currentns(root_vfsuid));
+	/* In init namespace, UID 0 should own current namespace */
+	KUNIT_EXPECT_TRUE(test, uid_owns_currentns(vfsuid));
 }
 
 /**
- * test_rootid_owns_currentns_invalid - Test rootid_owns_currentns with invalid vfsuid
+ * test_uid_owns_currentns_invalid - Test uid_owns_currentns with invalid vfsuid
  *
  * Verifies that an invalid vfsuid correctly returns false.
  *
  * @test: KUnit test context
  */
-static void test_rootid_owns_currentns_invalid(struct kunit *test)
+static void test_uid_owns_currentns_invalid(struct kunit *test)
 {
 	vfsuid_t invalid_vfsuid;
 
@@ -89,74 +91,268 @@ static void test_rootid_owns_currentns_invalid(struct kunit *test)
 	invalid_vfsuid = INVALID_VFSUID;
 
 	/* Invalid vfsuid should return false */
-	KUNIT_EXPECT_FALSE(test, rootid_owns_currentns(invalid_vfsuid));
+	KUNIT_EXPECT_FALSE(test, uid_owns_currentns(invalid_vfsuid));
 }
 
 /**
- * test_rootid_owns_currentns_nonroot - Test rootid_owns_currentns with non-root UID
+ * test_uid_owns_currentns_nonzero - Test uid_owns_currentns with non-zero UID
  *
- * Verifies that a non-root UID correctly returns false.
+ * Verifies that a non-zero UID correctly returns false.
  *
  * @test: KUnit test context
  */
-static void test_rootid_owns_currentns_nonroot(struct kunit *test)
+static void test_uid_owns_currentns_nonzero(struct kunit *test)
 {
-	vfsuid_t nonroot_vfsuid;
-	kuid_t nonroot_kuid;
+	vfsuid_t vfsuid;
+	kuid_t kuid;
 
-	/* Create a non-root UID */
-	nonroot_kuid = KUIDT_INIT(1000);
-	nonroot_vfsuid = VFSUIDT_INIT(nonroot_kuid);
+	/* Create a non-zero UID */
+	kuid = KUIDT_INIT(1000);
+	vfsuid = VFSUIDT_INIT(kuid);
 
-	/* Non-root UID should return false */
-	KUNIT_EXPECT_FALSE(test, rootid_owns_currentns(nonroot_vfsuid));
+	/* Non-zero UID should return false */
+	KUNIT_EXPECT_FALSE(test, uid_owns_currentns(vfsuid));
 }
 
 /**
- * test_rootid_owns_userns_init_ns - Test rootid_owns_userns with init namespace
+ * test_uid_owns_ns_init_ns_uid0 - Test uid_owns_ns with init namespace and UID 0
  *
- * Verifies that rootid_owns_userns correctly identifies root UID in init namespace.
- * This tests the core namespace traversal logic.
+ * Verifies that uid_owns_ns correctly identifies UID 0 in init namespace.
+ * This tests the core namespace traversal logic. In init namespace, UID 0
+ * maps to itself, so it should own the namespace.
  *
  * @test: KUnit test context
  */
-static void test_rootid_owns_userns_init_ns(struct kunit *test)
+static void test_uid_owns_ns_init_ns_uid0(struct kunit *test)
 {
-	kuid_t root_kuid;
+	kuid_t kuid;
 	struct user_namespace *init_ns;
 
-	root_kuid = KUIDT_INIT(0);
+	kuid = KUIDT_INIT(0);
 	init_ns = &init_user_ns;
 
-	/* Root UID should own init namespace */
-	KUNIT_EXPECT_TRUE(test, rootid_owns_userns(init_ns, root_kuid));
+	/* UID 0 should own init namespace */
+	KUNIT_EXPECT_TRUE(test, uid_owns_ns(init_ns, kuid));
 }
 
 /**
- * test_rootid_owns_userns_nonroot - Test rootid_owns_userns with non-root UID
+ * test_uid_owns_ns_init_ns_nonzero - Test uid_owns_ns with init namespace and non-zero UID
  *
- * Verifies that rootid_owns_userns correctly rejects non-root UIDs.
+ * Verifies that uid_owns_ns correctly rejects non-zero UIDs in init namespace.
+ * Only UID 0 should own a namespace.
  *
  * @test: KUnit test context
  */
-static void test_rootid_owns_userns_nonroot(struct kunit *test)
+static void test_uid_owns_ns_init_ns_nonzero(struct kunit *test)
 {
-	kuid_t nonroot_kuid;
+	kuid_t kuid;
 	struct user_namespace *init_ns;
 
-	nonroot_kuid = KUIDT_INIT(1000);
+	kuid = KUIDT_INIT(1000);
 	init_ns = &init_user_ns;
 
-	/* Non-root UID should not own namespace */
-	KUNIT_EXPECT_FALSE(test, rootid_owns_userns(init_ns, nonroot_kuid));
+	/* Non-zero UID should not own namespace */
+	KUNIT_EXPECT_FALSE(test, uid_owns_ns(init_ns, kuid));
+}
+
+/**
+ * test_uid_owns_ns_init_ns_various_uids - Test uid_owns_ns with various UIDs
+ *
+ * Verifies that uid_owns_ns correctly identifies only UID 0 as owning
+ * the namespace, regardless of the UID value tested.
+ *
+ * @test: KUnit test context
+ */
+static void test_uid_owns_ns_init_ns_various_uids(struct kunit *test)
+{
+	struct user_namespace *init_ns;
+	kuid_t kuid;
+
+	init_ns = &init_user_ns;
+
+	/* UID 0 should own the namespace */
+	kuid = KUIDT_INIT(0);
+	KUNIT_EXPECT_TRUE(test, uid_owns_ns(init_ns, kuid));
+
+	/* Other UIDs should not own the namespace */
+	kuid = KUIDT_INIT(1);
+	KUNIT_EXPECT_FALSE(test, uid_owns_ns(init_ns, kuid));
+
+	kuid = KUIDT_INIT(1000);
+	KUNIT_EXPECT_FALSE(test, uid_owns_ns(init_ns, kuid));
+
+	kuid = KUIDT_INIT(65534);
+	KUNIT_EXPECT_FALSE(test, uid_owns_ns(init_ns, kuid));
+}
+
+/**
+ * create_test_user_ns_with_mapping - Create a test user namespace with uid mapping
+ *
+ * Creates a minimal user namespace for testing where uid 0 in the namespace
+ * maps to the specified kuid in the parent namespace.
+ *
+ * The mapping semantics:
+ * - first: uid in this namespace (0)
+ * - lower_first: kuid in parent namespace (mapped_kuid)
+ * - count: range size (1)
+ *
+ * This means: from_kuid(ns, mapped_kuid) will return 0
+ * because map_id_up looks for kuid in [lower_first, lower_first+count)
+ * and returns first + (kuid - lower_first) = 0 + (mapped_kuid - mapped_kuid) = 0
+ *
+ * @test: KUnit test context
+ * @parent_ns: Parent user namespace
+ * @mapped_kuid: The kuid that uid 0 in the new namespace maps to
+ *
+ * Returns: The new user namespace, or NULL on failure
+ */
+static struct user_namespace *create_test_user_ns_with_mapping(struct kunit *test,
+								struct user_namespace *parent_ns,
+								kuid_t mapped_kuid)
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
+ * test_uid_owns_ns_with_mapping - Test uid_owns_ns with namespace where uid 0
+ *				   maps to different kuid
+ *
+ * Creates a user namespace where uid 0 maps to kuid 1000 in the parent namespace.
+ * Verifies that uid_owns_ns correctly identifies kuid 1000 as owning the namespace.
+ *
+ * Note: uid_owns_ns walks up the namespace hierarchy, so it checks the current
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
+static void test_uid_owns_ns_with_mapping(struct kunit *test)
+{
+	struct user_namespace *test_ns;
+	struct user_namespace *parent_ns;
+	kuid_t mapped_kuid, other_kuid;
+
+	parent_ns = &init_user_ns;
+	mapped_kuid = KUIDT_INIT(1000);  /* uid 0 in test_ns maps to kuid 1000 */
+	other_kuid = KUIDT_INIT(2000);   /* This should not own the namespace */
+
+	/* Create test namespace where uid 0 maps to kuid 1000 */
+	test_ns = create_test_user_ns_with_mapping(test, parent_ns, mapped_kuid);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_ns);
+
+	/* kuid 1000 should own the namespace (because uid 0 in test_ns maps to it) */
+	KUNIT_EXPECT_TRUE(test, uid_owns_ns(test_ns, mapped_kuid));
+
+	/* kuid 0 also owns the namespace because it maps to 0 in init_user_ns (parent) */
+	KUNIT_EXPECT_TRUE(test, uid_owns_ns(test_ns, KUIDT_INIT(0)));
+
+	/* Other kuids that don't map to 0 in test_ns or any parent should not own */
+	KUNIT_EXPECT_FALSE(test, uid_owns_ns(test_ns, other_kuid));
+	KUNIT_EXPECT_FALSE(test, uid_owns_ns(test_ns, KUIDT_INIT(500)));
+}
+
+/**
+ * test_uid_owns_ns_with_different_mappings - Test with multiple namespaces
+ *					      having different mappings
+ *
+ * Creates multiple test namespaces with different uid 0 mappings to verify
+ * the function correctly identifies ownership based on the mapping.
+ *
+ * Since uid_owns_ns walks up the hierarchy, kuids that map to 0 in init_user_ns
+ * (like kuid 0) will own all namespaces. But we can still verify that the
+ * specific mapped kuids own their respective namespaces.
+ *
+ * @test: KUnit test context
+ */
+static void test_uid_owns_ns_with_different_mappings(struct kunit *test)
+{
+	struct user_namespace *ns1, *ns2, *ns3;
+	struct user_namespace *parent_ns;
+
+	parent_ns = &init_user_ns;
+
+	/* Namespace 1: uid 0 maps to kuid 1000 */
+	ns1 = create_test_user_ns_with_mapping(test, parent_ns, KUIDT_INIT(1000));
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ns1);
+	/* kuid 1000 owns ns1 because it maps to uid 0 in ns1 */
+	KUNIT_EXPECT_TRUE(test, uid_owns_ns(ns1, KUIDT_INIT(1000)));
+	/* kuid 0 also owns ns1 because it maps to 0 in init_user_ns (parent) */
+	KUNIT_EXPECT_TRUE(test, uid_owns_ns(ns1, KUIDT_INIT(0)));
+	/* kuid 2000 doesn't map to 0 in ns1 or any parent */
+	KUNIT_EXPECT_FALSE(test, uid_owns_ns(ns1, KUIDT_INIT(2000)));
+
+	/* Namespace 2: uid 0 maps to kuid 2000 */
+	ns2 = create_test_user_ns_with_mapping(test, parent_ns, KUIDT_INIT(2000));
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ns2);
+	/* kuid 2000 owns ns2 because it maps to uid 0 in ns2 */
+	KUNIT_EXPECT_TRUE(test, uid_owns_ns(ns2, KUIDT_INIT(2000)));
+	/* kuid 0 also owns ns2 because it maps to 0 in init_user_ns (parent) */
+	KUNIT_EXPECT_TRUE(test, uid_owns_ns(ns2, KUIDT_INIT(0)));
+	/* kuid 1000 doesn't map to 0 in ns2 or any parent */
+	KUNIT_EXPECT_FALSE(test, uid_owns_ns(ns2, KUIDT_INIT(1000)));
+
+	/* Namespace 3: uid 0 maps to kuid 0 (identity mapping) */
+	ns3 = create_test_user_ns_with_mapping(test, parent_ns, KUIDT_INIT(0));
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ns3);
+	/* kuid 0 owns ns3 because it maps to uid 0 in ns3 */
+	KUNIT_EXPECT_TRUE(test, uid_owns_ns(ns3, KUIDT_INIT(0)));
+	/* kuid 1000 doesn't map to 0 in ns3 or any parent */
+	KUNIT_EXPECT_FALSE(test, uid_owns_ns(ns3, KUIDT_INIT(1000)));
+	/* kuid 2000 doesn't map to 0 in ns3 or any parent */
+	KUNIT_EXPECT_FALSE(test, uid_owns_ns(ns3, KUIDT_INIT(2000)));
 }
 
 static struct kunit_case commoncap_test_cases[] = {
-	KUNIT_CASE(test_rootid_owns_currentns_init_ns),
-	KUNIT_CASE(test_rootid_owns_currentns_invalid),
-	KUNIT_CASE(test_rootid_owns_currentns_nonroot),
-	KUNIT_CASE(test_rootid_owns_userns_init_ns),
-	KUNIT_CASE(test_rootid_owns_userns_nonroot),
+	KUNIT_CASE(test_uid_owns_currentns_init_ns),
+	KUNIT_CASE(test_uid_owns_currentns_invalid),
+	KUNIT_CASE(test_uid_owns_currentns_nonzero),
+	KUNIT_CASE(test_uid_owns_ns_init_ns_uid0),
+	KUNIT_CASE(test_uid_owns_ns_init_ns_nonzero),
+	KUNIT_CASE(test_uid_owns_ns_init_ns_various_uids),
+	KUNIT_CASE(test_uid_owns_ns_with_mapping),
+	KUNIT_CASE(test_uid_owns_ns_with_different_mappings),
 	{}
 };
 
-- 
2.43.0

