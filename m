Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC312FF66A
	for <linux-security-module@vger.kernel.org>; Sun, 21 Jun 2026 03:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782013968; cv=none; b=QnXP8NIMRsjX6ptqQxCkbwkh0Q7fTIiIbKIFjZn1DYhk7+wQmxCNHSKd3nb2pkNXe0Yo1o0Tz6KIu3DNh8Mxsw1f44wDKVjyKA4yXTtOkS7guOXrKeRJydSMMIVj03DsRMg1cMItnVXuCyzJrF0uf8Q5IrqoctPcxwFBeXltFus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782013968; c=relaxed/simple;
	bh=xkaT//ultNEcoRx0cWcNwB199rzihL2ORnVamwFN++g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+8qv41P3RkEXbcZLFdP/CwBcP6nWkaZO2gTI6rV4zlum9u+4fopZWNUUfbOn7e4buP9trXWhFbKZFw1rAQNpA0C6qqdljlAajIC7i4qcAeAm6nnqfX9LJoBCWK8GV7A/VUlTpX9Cr2zhb445fSkSgpD/yzd50cWtFFpiLpwqAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4zwELgJ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4zwELgJ"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7e8b45dfb3dso38552827b3.3
        for <linux-security-module@vger.kernel.org>; Sat, 20 Jun 2026 20:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782013966; x=1782618766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDkGwUuaWFGJQXhEpX2ajKjANBEFh4pT3RuQ4Cg8jG0=;
        b=K4zwELgJNb8Zqww14R/ShRyRJQsyP7lNWPL994bMueSve6J9Hc4Q5KHLK5dXa6UEHY
         ikrtzh0Vw4zuIXjOAyY6ESkfomvNGSgtnJ0XO0STBQS2HaZOd77E960kdS+claTq+Dn3
         OSrNrNQKjBZ6+tSf4itbqvvg0wgrnl3ae9sNRL8O/+22TyGiOpUMqktsRQWMdglP4tiU
         0VWhsEABcUNtIEPeWiGMTloVDPm96svqwz2stKDtkkix1WpLsZDRpiCuQ8QvuPAqB0lT
         9LRABf35LD4rxLrefKCj2roNXapID0lw23zG2Ok7JUJxf3SSOfXqB4smB6tOOFJZ2f8X
         zTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782013966; x=1782618766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HDkGwUuaWFGJQXhEpX2ajKjANBEFh4pT3RuQ4Cg8jG0=;
        b=R11pAJrvQfSEqslug0fboJ6xA0X5qhaUIHCDnSk/4QyehD4qIw+4XuoOe3+A8oUJ5v
         SGNnBHitHPKwt+MquC22THXXIby7L2HjHGSQbsiz32UPVNT7bLlWY53Ktw97VCxlUO3K
         W0rhIYEcv8Q5LQq/P9gONYFAHVN3HOeJtGv0Yw3n79Gn0R8b9GSnbfCmP/aJ6iL/FXte
         TFOkS3NTiMxeOu5Y8tHr7yfbbxeY3j55W9tTPRSfOyQCK0JBTHHcXbU5wteO5GPYzSxn
         xfHNvtpGoETkj8IvmFC/fT7dwbVGkFxXLDRdLfvRUCX1l/xD6Dmz0RUYnxBVdNizEiCS
         orWQ==
X-Gm-Message-State: AOJu0YzQ+26QYfW89j96nbLVsuDApSyMQAlw1iVjcvlCEUw8TFKzlMeG
	LGeo/jj76PPUofV42IA/z1frECeMW+eeNCcysG9zCcWPQJSOeEenIzevPjaimw==
X-Gm-Gg: AfdE7cnXHhHFCgwNciKxrv92galku1tKqthFcWdpHgvyhkxwFpk4NmaRFR3Y9pBQ1q0
	fUVFnjKawBuVcXl9/I8WlD7l5dgtg/M2kU5NSlLZvV+pVivqDqvdFzLK7jecBoDEfGZ3mzMBMpp
	nTza//NEEDKKLCmuLZYwNaXVbM5qmceamHAtBaKzEpfD8pXyTCIzB+XKOj8LLocWXSzdVLr6j76
	OR2biZKQdDR+GSexlPl6E1yHUNsTBcr7GW/DmZoFxuPyJ9a/qkEaAUNcZkB6S73U16TryOq4NBx
	w9ubPxEnaIHrzuxSmh3EBDA3mqe6f4Dxgimvwv5KnAI1S18twGxX49984GcOSax5kjWEBA+erV1
	FrNosbQs3GL9zZKem0PhcOqfFabB8C9rMEjct1ovhZoDSTHL51S7r4xoUhEXkXcBhIhcd5eRxeT
	rjpw/A6P1QYSYmkD9m3sVi9kKAHxhENauAEdfEIFA86SUpjiPtLxzg2STc
X-Received: by 2002:a05:690c:c4cd:b0:7ec:58dc:2b5a with SMTP id 00721157ae682-80133fc12bemr107899837b3.38.1782013966050;
        Sat, 20 Jun 2026 20:52:46 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:2de9:628a:4b2:9b39])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025cf61d36sm17155677b3.11.2026.06.20.20.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 20:52:45 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org,
	mic@digikod.net
Cc: m@maowtm.org,
	gnoack@google.com,
	gnoack3000@gmail.com,
	matthieu@buffet.re,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v9 9/9] landlock: Add KUnit tests for LANDLOCK_ADD_RULE_NO_INHERIT
Date: Sat, 20 Jun 2026 23:52:22 -0400
Message-ID: <20260621035223.2651547-10-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260621035223.2651547-1-utilityemal77@gmail.com>
References: <20260621035223.2651547-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the landlock_ruleset KUnit suite with three tests for the
no_inherit handling in landlock_unmask_layers():

- test_unmask_no_inherit_propagates: a rule with no_inherit unmasks
  access and sets the no_inherit bit on the layer mask.
- test_unmask_multilayer_no_inherit: no_inherit on one layer of a
  multi-layer rule only affects that layer.
- test_unmask_no_inherit_sequential: applying a descendant rule
  (no_inherit) followed by an ancestor rule causes the ancestor to be
  skipped, modeling a path walk.  This exercises the same skip branch
  that a pre-set no_inherit mask would, via realistic rule application.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    Changes since v8:
    - Reduced from five tests to three, dropping test_unmask_no_inherit_skip
      and test_unmask_no_inherit_both_set (which set the per-layer no_inherit
      bit synthetically). Kept test_unmask_no_inherit_propagates,
      test_unmask_multilayer_no_inherit, and test_unmask_no_inherit_sequential,
      which exercise the same skip branch through realistic rule application.
    - Rebased onto mic/next.

 security/landlock/ruleset.c | 137 ++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index ca7cfa45c90a..144b6fc19f79 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -6,6 +6,7 @@
  * Copyright © 2018-2020 ANSSI
  */
 
+#include <kunit/test.h>
 #include <linux/bits.h>
 #include <linux/bug.h>
 #include <linux/cleanup.h>
@@ -766,3 +767,139 @@ landlock_init_layer_masks(const struct landlock_ruleset *const domain,
 
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
+static struct kunit_case test_cases[] = {
+	/* clang-format off */
+	KUNIT_CASE(test_unmask_no_inherit_propagates),
+	KUNIT_CASE(test_unmask_multilayer_no_inherit),
+	KUNIT_CASE(test_unmask_no_inherit_sequential),
+	{}
+	/* clang-format on */
+};
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
2.54.0

