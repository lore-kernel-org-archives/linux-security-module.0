Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3969B369D5F
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 01:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019566; cv=none; b=XtJBwUz1NoRcOXeS+OTU4QVoGBkiIcoB7YIwVbyp9AoHEx3Hfnzl5av8K/jNM5bOA5ppLwky3cKjPEU/wmPs1TSC3aBd0Zw1M2lCsXeH5QQc7z5HTY/Rp9YbzJxq8nm8/g2+XulHKAPYNUzlJonAYkErvazZNPc7pPABcVe8tdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019566; c=relaxed/simple;
	bh=moBOfUmbdHS94qSP33raegmaKYYJoraho4benxR3JdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V//az7A2a9USFGPCkRZwz+1Zi/YEB1QibL+ZOWmu613AoNa3FrpVSvoPIouRfEPUKs764knPh7Pdds2u7IGkmfv8oUs3R8Ub8FMoRDGJEri3qqCKHLm1Ey1Yu3E+7XbDmWgyBTKBpXNY1LX4B/1nmBQ5kmgV8Ba8SJpPN4SlQeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qZEJg+O/; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZEJg+O/"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7d1bcb92072so85970737b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 18:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019564; x=1780624364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6D2ipigGm4Qh+rWj0g1Z+KaYmugk/663SOJobhVAuGc=;
        b=qZEJg+O/Bdq0uL6wPDmUZW7+aHKML8h+iqMn3nOO4NwEZJkDelUOrm0ZMJmbtxKnqP
         A3a9k28y1pd08mhYso0SE6x/U9ko562rZ2Y4nX7U5Zfdqg6gnPFxd7v/abO1agr7lQfj
         jcBd9HKoSNWEQjj7YeGknHk2H83bLNdN2/+Qu+l/NUt+HTqPpnKcUZPJXzkOWTVGqRlv
         Co8Xx4+OWV0vagvSTtXGsEljPmzmgs3W80XmKNlSnpQNPupEABofoVTXGZIeC/n2GZ12
         9/Zdt7bqBQquJNRMgrSDGUrVYROn7Ix2GwQOiNbb8ZqLblD80YP/WkwjjN5HgWl6phCx
         3wgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019564; x=1780624364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6D2ipigGm4Qh+rWj0g1Z+KaYmugk/663SOJobhVAuGc=;
        b=FT4aNwXf5TZ67I6Pr8wAi+NUTilyBYhj6Ncqjfpj0n3eInpM+/tY74M6Yff7GvVzHx
         URUR1LnYlIFR9SWLwF0MLQoOx1s6XL33qISzTLSNKOBbV2wnTp6kDrpLCjFC03W1w1te
         kl3lb6S4addytckhEMnMYomg0kP5bsxxUqjyBP7WfVFYVSqhZWv8MghCLcwONYxweDP2
         YX77aVkTv2InkCS5DrcUxrgTnHjBe7GlUj5Tdmw9bEAucZmNnoFaGMlgwEqxprcEIy9/
         SZnqHkVdWS2Iai+K+2cvNqBZ3vtcnEfXJ4EqYm9Gn3QnPj2g7yu9I9vIGPfxCJdUD0ZJ
         33sQ==
X-Forwarded-Encrypted: i=1; AFNElJ+P60kQnrEZzJA/ugZHQpWhXKL9eu3aKmSHg0FjlHpniujXqqoTebq6OcuNYs7a8l41GRDJZQeRJxIsZR71hxwqNARAaio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7WpLQADwW1klumiMYo6DAARXb29vuVOxtyLLOJ8xEy6dnjr1k
	zro8q+/6loYkMiUg3yNOIkNQ4ST/rqsOM8fswM3ga8lUv+NJyWFOccid
X-Gm-Gg: Acq92OH7h+bsHjzoX/f8dLCvCUZLvmjTllpDrUJemQFTtsl4OJMmevZ4ZRYVeb9+xTn
	XrM1IWI7HZFLRSzqpWLGT2m8XRU6c5rhIHVE1osGNTc4H9TNI5X2G0lEDJr15F+V3e+aPNkVxxu
	/vDMksTyd3MIao3I5PD+y7tt3tDY8eh8l37UFzYsJzX3r3ITH6fmvYA9C9hjbjMayUdedVtTWai
	Z0Hgx4BhK06T4LuLeJhBIzyUWsXdT5KfUG8v4ZYbtNxRXH4/u8RbkjKZRP83rDUT1LWpNbrvsI3
	AKblZaaJ0AUPxMg9Dx6RAnK60huc9B4i5gq5j5KqR0g/p9Je/zFF7uzX/OvExjnyXQBv6BVb9Gi
	2gEzvO/vRgSf+OM2WWnPuT9thalDKrB7XTkWAhgCBnJirZvGWkrYubtk+wRC14vtRcTTTdb7eSg
	tQFBAf1PDLGAyezFBB3L2sgYL1aNECRqP2fCxR9owhOs7sGg0CalYlamyFJFLXgBFILY7RsLfY+
	fSQncrSf+Q=
X-Received: by 2002:a05:690c:4391:b0:7de:795e:e9d7 with SMTP id 00721157ae682-7de795ee9f4mr2943067b3.39.1780019564308;
        Thu, 28 May 2026 18:52:44 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:7a41:d368:8442:1cb2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7de6d1f3943sm1284717b3.26.2026.05.28.18.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:52:44 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v8 10/10] landlock: Add KUnit tests for LANDLOCK_ADD_RULE_NO_INHERIT
Date: Thu, 28 May 2026 21:52:09 -0400
Message-ID: <20260529015210.500291-11-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529015210.500291-1-utilityemal77@gmail.com>
References: <20260529015210.500291-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the landlock_ruleset KUnit suite with five tests for the
no_inherit handling in landlock_unmask_layers():

- test_unmask_no_inherit_propagates: a rule with no_inherit unmasks
  access and sets the no_inherit bit on the layer mask.
- test_unmask_no_inherit_skip: a layer with no_inherit already set in
  the mask is skipped (no access removal).
- test_unmask_no_inherit_both_set: when both rule and mask have
  no_inherit, the skip still happens and the bit stays set.
- test_unmask_multilayer_no_inherit: no_inherit on one layer of a
  multi-layer rule only affects that layer.
- test_unmask_no_inherit_sequential: applying a descendant rule
  (no_inherit) followed by an ancestor rule causes the ancestor to be
  skipped, modeling a path walk.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v7..v8 changes:
    
      * Renamed patch from 'Implement KUnit test' to 'Add KUnit tests'
        (now plural).
      * Replaced the single test_unmask_layers_no_inherit() case with
        five focused tests aligned with the new per-layer no_inherit
        bit added to struct layer_mask in patch 6:
    
        - test_unmask_no_inherit_propagates
        - test_unmask_no_inherit_skip
        - test_unmask_no_inherit_both_set
        - test_unmask_multilayer_no_inherit
        - test_unmask_no_inherit_sequential
    
      * Added alloc_rule() and fill_masks() helpers to share setup
        across the new tests.

 security/landlock/ruleset.c | 182 ++++++++++++++++++++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index c78e2b2d73ff..9f47d106aca3 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -6,6 +6,7 @@
  * Copyright © 2018-2020 ANSSI
  */
 
+#include <kunit/test.h>
 #include <linux/bits.h>
 #include <linux/bug.h>
 #include <linux/cleanup.h>
@@ -766,3 +767,184 @@ landlock_init_layer_masks(const struct landlock_ruleset *const domain,
 
 	return handled_accesses;
 }
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+/*
+ * Helper to allocate a rule with @num_layers layers and initialize
+ * its num_layers field.  Caller must fill in individual layers.
+ */
+static struct landlock_rule *alloc_rule(struct kunit *test, u32 num_layers)
+{
+	struct landlock_rule *rule;
+
+	rule = kzalloc(struct_size(rule, layers, num_layers), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, rule);
+	rule->num_layers = num_layers;
+	return rule;
+}
+
+/*
+ * Build a layer_masks with the first @num_layers layers' access set to
+ * @val, and all no_inherit flags cleared.  Layers beyond @num_layers stay
+ * zeroed, matching what landlock_init_layer_masks() produces for a domain
+ * with that many layers.
+ */
+static void fill_masks(struct layer_masks *masks, access_mask_t val,
+		       size_t num_layers)
+{
+	memset(masks, 0, sizeof(*masks));
+	for (size_t i = 0; i < num_layers; i++)
+		masks->layers[i].access = val;
+}
+
+/* Verify that a rule with no_inherit unmasks access and propagates the flag. */
+static void test_unmask_no_inherit_propagates(struct kunit *const test)
+{
+	struct landlock_rule *rule = alloc_rule(test, 1);
+	struct layer_masks masks;
+	const access_mask_t req = BIT_ULL(0) | BIT_ULL(1);
+
+	rule->layers[0].level = 1;
+	rule->layers[0].access = BIT_ULL(0);
+	rule->layers[0].flags.no_inherit = true;
+
+	fill_masks(&masks, req, 1);
+	landlock_unmask_layers(rule, &masks);
+
+	/* access bit 0 should be cleared, bit 1 remains */
+	KUNIT_EXPECT_EQ(test, (access_mask_t)masks.layers[0].access,
+			BIT_ULL(1));
+	KUNIT_EXPECT_TRUE(test, masks.layers[0].no_inherit);
+	KUNIT_EXPECT_EQ(test, (access_mask_t)masks.layers[1].access, 0);
+	kfree(rule);
+}
+
+/* Verify that a pre-set no_inherit in the mask causes the layer to be skipped. */
+static void test_unmask_no_inherit_skip(struct kunit *const test)
+{
+	struct landlock_rule *rule = alloc_rule(test, 1);
+	struct layer_masks masks;
+	const access_mask_t req = BIT_ULL(0);
+
+	rule->layers[0].level = 1;
+	rule->layers[0].access = BIT_ULL(0);
+
+	fill_masks(&masks, req, 1);
+	masks.layers[0].no_inherit = true;
+	landlock_unmask_layers(rule, &masks);
+
+	/* bit 0 should NOT be cleared because layer was skipped */
+	KUNIT_EXPECT_EQ(test, (access_mask_t)masks.layers[0].access, req);
+	KUNIT_EXPECT_TRUE(test, masks.layers[0].no_inherit);
+	kfree(rule);
+}
+
+/*
+ * Verify that no_inherit on the rule is still set when the mask already
+ * has no_inherit (the skip prevents access removal but the flag propagates).
+ */
+static void test_unmask_no_inherit_both_set(struct kunit *const test)
+{
+	struct landlock_rule *rule = alloc_rule(test, 1);
+	struct layer_masks masks;
+	const access_mask_t req = BIT_ULL(0);
+
+	rule->layers[0].level = 1;
+	rule->layers[0].access = BIT_ULL(0);
+	rule->layers[0].flags.no_inherit = true;
+
+	fill_masks(&masks, req, 1);
+	masks.layers[0].no_inherit = true;
+	landlock_unmask_layers(rule, &masks);
+
+	KUNIT_EXPECT_EQ(test, (access_mask_t)masks.layers[0].access, req);
+	KUNIT_EXPECT_TRUE(test, masks.layers[0].no_inherit);
+	kfree(rule);
+}
+
+/*
+ * Verify that no_inherit on layer 1 of a multi-layer rule only affects
+ * layer 1; layer 2 still contributes normally.
+ */
+static void test_unmask_multilayer_no_inherit(struct kunit *const test)
+{
+	struct landlock_rule *rule = alloc_rule(test, 2);
+	struct layer_masks masks;
+	const access_mask_t req = BIT_ULL(0) | BIT_ULL(1);
+
+	rule->layers[0].level = 1;
+	rule->layers[0].access = BIT_ULL(0);
+	rule->layers[0].flags.no_inherit = true;
+
+	rule->layers[1].level = 2;
+	rule->layers[1].access = BIT_ULL(1);
+
+	fill_masks(&masks, req, 2);
+	landlock_unmask_layers(rule, &masks);
+
+	/* Layer 1: bit 0 cleared, no_inherit set */
+	KUNIT_EXPECT_EQ(test, (access_mask_t)masks.layers[0].access, BIT_ULL(1));
+	KUNIT_EXPECT_TRUE(test, masks.layers[0].no_inherit);
+
+	/* Layer 2: bit 1 cleared, no_inherit not set */
+	KUNIT_EXPECT_EQ(test, (access_mask_t)masks.layers[1].access, BIT_ULL(0));
+	KUNIT_EXPECT_FALSE(test, masks.layers[1].no_inherit);
+	kfree(rule);
+}
+
+/*
+ * Verify that when applying two rules sequentially (as happens during
+ * a path walk), no_inherit from the first rule prevents the second
+ * rule from contributing to that layer.
+ */
+static void test_unmask_no_inherit_sequential(struct kunit *const test)
+{
+	struct landlock_rule *rule1 = alloc_rule(test, 1);
+	struct landlock_rule *rule2 = alloc_rule(test, 1);
+	struct layer_masks masks;
+	const access_mask_t req = BIT_ULL(0) | BIT_ULL(1);
+
+	/* Rule 1: no_inherit on layer 1, grants access bit 0 */
+	rule1->layers[0].level = 1;
+	rule1->layers[0].access = BIT_ULL(0);
+	rule1->layers[0].flags.no_inherit = true;
+
+	/* Rule 2: also on layer 1, grants access bit 1 (ancestor rule) */
+	rule2->layers[0].level = 1;
+	rule2->layers[0].access = BIT_ULL(1);
+
+	/* Apply rule1 first (descendant), then rule2 (ancestor) */
+	fill_masks(&masks, req, 1);
+	landlock_unmask_layers(rule1, &masks);
+	landlock_unmask_layers(rule2, &masks);
+
+	/*
+	 * Rule2 should be skipped because rule1 set no_inherit.
+	 * bit 0 cleared by rule1, bit 1 remains because rule2 skipped.
+	 */
+	KUNIT_EXPECT_EQ(test, (access_mask_t)masks.layers[0].access, BIT_ULL(1));
+	KUNIT_EXPECT_TRUE(test, masks.layers[0].no_inherit);
+	kfree(rule1);
+	kfree(rule2);
+}
+
+/* clang-format off */
+static struct kunit_case test_cases[] = {
+	KUNIT_CASE(test_unmask_no_inherit_propagates),
+	KUNIT_CASE(test_unmask_no_inherit_skip),
+	KUNIT_CASE(test_unmask_no_inherit_both_set),
+	KUNIT_CASE(test_unmask_multilayer_no_inherit),
+	KUNIT_CASE(test_unmask_no_inherit_sequential),
+	{}
+};
+/* clang-format on */
+
+static struct kunit_suite test_suite = {
+	.name = "landlock_ruleset",
+	.test_cases = test_cases,
+};
+
+kunit_test_suite(test_suite);
+
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
-- 
2.53.0

