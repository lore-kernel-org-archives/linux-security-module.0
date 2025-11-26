Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E1B31AF2A
	for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764159670; cv=none; b=Y9Gp8KrKNqy/p4gElWgf96S7XftTaksehksusvwqk73f7LxTTiY8EKJ589I5FPQr0LJ07JAmIF5jNcMIMbYAsUVeMn7nnCR3LxLeJNQQhxGz/7M9pDyt0fEKo5Qg0O3lo8G07GLtLBF4DpYR0+18aIIHytGB1sKtbEqaE6oauR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764159670; c=relaxed/simple;
	bh=Vn3oaos5+DCo6R4F5yq/UMz2En87vy58Ep9Ivcl01mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOFiJpTsSxLh6fvXGqmCyh+rWRVOs2JkWdyzfDxkjTjIUec38ZSiImAI34B35mPIiYsRD2gXP78gKI+cGT71lKgSZiTYUftj9QItjH2ji0JK0o2S476JO4ahg4bleLk2wP8xFwokUWIT+yG+VuSw0URrJ06VcF5FFeHYKXOgYQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSkeSR2M; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSkeSR2M"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-640d0895d7cso1167500d50.1
        for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 04:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764159667; x=1764764467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNJ8QW6rGDhZa9fk6NwsGdRfr26cdHeqQYReTfEm3oU=;
        b=XSkeSR2MrMmRpLIG4VmX9eyQxkdZVrA+FTgq3RF2KIqsOHQvy8wGrLAypsvYAeeHBc
         NAudOfuBv0AuFklsEdWaeCAtrg25ySRWB9TBgLDKDHA6XYALiCN1q13FVwObAWv6mFCW
         IvVW1UahyEGEfePc0pOCxZa6x3XFi+Z1mzwGeArG4HBC63+j8zk9PEizJqvVt7ZHikAm
         6nTx543x3sI+/yJ9hbVvPnmEKibDMiPsFUececJzUcxFt/OVsMn9ednGQ8A2pTZTsNwx
         jfDWxnLJNogbip/MApqEAqF6inieriHgwDlQ4NeJJUibwQCGQEMMa3n3ogBiT7QzPp1G
         1+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764159667; x=1764764467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rNJ8QW6rGDhZa9fk6NwsGdRfr26cdHeqQYReTfEm3oU=;
        b=OlA04t2Yman5jeYVE7hG7duf9AUTF052FaCiqLhBlOh+2i4cXJONJerkbqyoPMzBFF
         I4uZsdhB2/rcPYslsSqvBNV8SxATNjntue6rdUU8Zr+YeaU/0ObO1LgzUrlO9Izflp1G
         881mMJHib61kFIDulZypKi2y1K/io2wV03t+mNMUGVZoINWBqfl3QZUxqUtGAnNYbMVf
         UTvBifwrdxQ/7WIXLXwVJ0ZUvoVpbdQN65Y/M+c1IxehhO74QBSdc8VbMZvTIBTaRvEH
         Q2uxuL9L9A1z76Ald7MufU4RONaXWEW+qkBRcp5jQkiN140r53vNFtQrSNnNKir6nrFA
         byZg==
X-Gm-Message-State: AOJu0YxyXIcrMtjKTFaiYxUoFTFkMNWE+SVrMbgOMA2dIc8p8KNSo8/F
	WSiIH9H1uN1MExfCm/dK9GUPfR16ccs0KKoHRL1/Ul07I93QvzephfOAACrxIGKt
X-Gm-Gg: ASbGncvLmOkX9sds7BrhJjaOlQMGMU8ksLWcG1Xdoawx/+Tq6s3/GYPVN+rlgGVdff4
	lhiAl1OkfnI5uTSSzpLZeqqQhq6gZUIX0/ecdTleNXVQOwwYtQzLv8obxlMQWc2aiVgRwoQFCyf
	LW+3kKFoh8mTJwiZGrm+MaTWaX9vjOogO+H91BwD4XT3VS4TDhDT/1SAQ6yFkhvmUBmgA6tvA8X
	8BRnUZ36e+CBFc/lknyGx+jwtbD1uXBbqcCJrQD3zMDwaNFq2DNARjlBzPpxwg+vS36eJLoAe9y
	biTj4DlOWNIKBOymAfj41AlkRCQB3wK/H4YFm7c1zd1bG1lP7XOa+WST4A6pv/NGTWcBvCLkZrX
	j9ugdVUidoTjWp4IwG9YKdDBBvvO94VnfMclcKD8ZRsZ/D87oVyAvW8qtbTv51W3M0onlcxArHz
	tdlSGfvLrjyzQdPDhSxT1hYKoKaQwBA4g4dQ2i1cAvR1BmM+PgeHvuBVc2WZpR
X-Google-Smtp-Source: AGHT+IFzq3w1Sht+fAcvLQ5IPMf3ERYZyuRuS6KVSuCiJug34ymmzxd7/8j3PecuL3AQXHYgaFcZ+A==
X-Received: by 2002:a05:690e:1c1c:b0:640:d707:4f6 with SMTP id 956f58d0204a3-6430260f822mr13219286d50.24.1764159667402;
        Wed, 26 Nov 2025 04:21:07 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a7992799dsm66318057b3.33.2025.11.26.04.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 04:21:07 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v3 5/5] landlock: landlock: Implement KUnit test for LANDLOCK_ADD_RULE_NO_INHERIT
Date: Wed, 26 Nov 2025 07:20:39 -0500
Message-ID: <20251126122039.3832162-7-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126122039.3832162-1-utilityemal77@gmail.com>
References: <20251126122039.3832162-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a unit test for rule_flag collection, ensuring that access masks
are properly propagated with the flags.

changes v2..v3:

   * Removing erroneously misplaced code and placed in the proper
     patch.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/landlock/ruleset.c | 89 +++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index f7b6a48bbf39..0e0de8b20dc4 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -22,6 +22,7 @@
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 #include <uapi/linux/landlock.h>
+#include <kunit/test.h>
 
 #include "access.h"
 #include "audit.h"
@@ -774,3 +775,91 @@ landlock_init_layer_masks(const struct landlock_ruleset *const domain,
 	}
 	return handled_accesses;
 }
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+/**
+ * test_unmask_layers_no_inherit - Test landlock_unmask_layers() with no_inherit
+ * @rule_flags: Pointer to collected_rule_flags structure to track flags.
+ */
+static void test_unmask_layers_no_inherit(struct kunit *const test)
+{
+	struct landlock_rule *rule;
+	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS];
+	struct collected_rule_flags rule_flags;
+	const access_mask_t access_request = BIT_ULL(0) | BIT_ULL(1);
+	const layer_mask_t layers_initialized = BIT_ULL(0) | BIT_ULL(1);
+	size_t i;
+
+	rule = kzalloc(struct_size(rule, layers, 2), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, rule);
+
+	rule->num_layers = 2;
+
+	/* Layer 1: allows access 0, no_inherit */
+	rule->layers[0].level = 1;
+	rule->layers[0].access = BIT_ULL(0);
+	rule->layers[0].flags.no_inherit = 1;
+
+	/* Layer 2: allows access 1 */
+	rule->layers[1].level = 2;
+	rule->layers[1].access = BIT_ULL(1);
+
+	/* Case 1: No rule_flags provided (should behave normally) */
+	for (i = 0; i < ARRAY_SIZE(layer_masks); i++)
+		layer_masks[i] = layers_initialized;
+
+	landlock_unmask_layers(rule, access_request, &layer_masks,
+			       ARRAY_SIZE(layer_masks), NULL);
+
+	/* Access 0 should be unmasked by layer 1 */
+	KUNIT_EXPECT_EQ(test, layer_masks[0], layers_initialized & ~BIT_ULL(0));
+	/* Access 1 should be unmasked by layer 2 */
+	KUNIT_EXPECT_EQ(test, layer_masks[1], layers_initialized & ~BIT_ULL(1));
+
+	/* Case 2: rule_flags provided, no existing no_inherit_masks */
+	for (i = 0; i < ARRAY_SIZE(layer_masks); i++)
+		layer_masks[i] = layers_initialized;
+	memset(&rule_flags, 0, sizeof(rule_flags));
+
+	landlock_unmask_layers(rule, access_request, &layer_masks,
+			       ARRAY_SIZE(layer_masks), &rule_flags);
+
+	/* Access 0 should be unmasked by layer 1 */
+	KUNIT_EXPECT_EQ(test, layer_masks[0], layers_initialized & ~BIT_ULL(0));
+	/* Access 1 should be unmasked by layer 2 */
+	KUNIT_EXPECT_EQ(test, layer_masks[1], layers_initialized & ~BIT_ULL(1));
+
+	/* rule_flags should collect no_inherit from layer 1 */
+	KUNIT_EXPECT_EQ(test, rule_flags.no_inherit_masks, (layer_mask_t)BIT_ULL(0));
+
+	/* Case 3: rule_flags provided, layer 1 is masked by no_inherit_masks */
+	for (i = 0; i < ARRAY_SIZE(layer_masks); i++)
+		layer_masks[i] = layers_initialized;
+	memset(&rule_flags, 0, sizeof(rule_flags));
+	rule_flags.no_inherit_masks = BIT_ULL(0); /* Mask layer 1 */
+
+	landlock_unmask_layers(rule, access_request, &layer_masks,
+			       ARRAY_SIZE(layer_masks), &rule_flags);
+
+	/* Access 0 should NOT be unmasked by layer 1 because it is skipped */
+	KUNIT_EXPECT_EQ(test, layer_masks[0], layers_initialized);
+	/* Access 1 should be unmasked by layer 2 */
+	KUNIT_EXPECT_EQ(test, layer_masks[1], layers_initialized & ~BIT_ULL(1));
+
+	kfree(rule);
+}
+
+static struct kunit_case ruleset_test_cases[] = {
+	KUNIT_CASE(test_unmask_layers_no_inherit),
+	{}
+};
+
+static struct kunit_suite ruleset_test_suite = {
+	.name = "landlock_ruleset",
+	.test_cases = ruleset_test_cases,
+};
+
+kunit_test_suite(ruleset_test_suite);
+
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
-- 
2.51.0

