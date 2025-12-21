Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3C328750B
	for <linux-security-module@vger.kernel.org>; Sun, 21 Dec 2025 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766346202; cv=none; b=SX6uEdB8vA83waNYTHGruUEiywXx5cYi/QefGmG4FKbPqBGqry9VLmsSLJRIGbjxNyOPZgTYO09ysNQtJ7v4637gba6svpGXxSoAXwrWDEEitHT/9nI56PzQAp5KLTdZN3rgo084fJoukA4uwL6YTpCRnRCYyN+ADy57mIKsuHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766346202; c=relaxed/simple;
	bh=PjhN5VPfcabDTrvxXPI2oLESI7cvpD0MPjAzNJ954AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DeuXMf75B4VJoK6IXtDwd3HU/u95mNQ/hJO97U9XW4eDl3LwgdGbqci4SKfvjz/hpen95qcJBHLO9D/iNyvOCYjFC4d/viOBlr0PocxNrpqH81BmSg7Ukhr3/B/kJMzshiaxnk+NVBnoq9CAt/u/XplCIEL6rLCVIcpmKNNnzlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOCu33c8; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOCu33c8"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78a712cfbc0so30790397b3.1
        for <linux-security-module@vger.kernel.org>; Sun, 21 Dec 2025 11:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766346199; x=1766950999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATJoXSeF0h/amZ8/FNkEKf+tpsnwFPA3FmFWjmeHeJ0=;
        b=KOCu33c84Afdl18T8aNCwh16aiB6Gm31+3QL4jesO+cjrBFr8pvFUGlXrVGEYzYPap
         Y7mB31CvdqmbnmJGIjIPYimr6aMtsNmay3/i0nbLk7o2H1lk5jtG5xvQagN0c8LEs9Ys
         MkgFBWC/KhJQPQXTzW/qwvhMtDY7RHZ0dp8oam+2hEyKCjI7uwok4vFo5MIuzmELpQW/
         w7K6EtTW/P6AVsZafRgb9609jfFOQLoOGM+mosfGMZ/KnySgWYdRvmxaxwtGvRHThlCS
         NpLqiU5T2z7rVuv20XoBckcMN5dA5JUypq0tfNMnBMoixVaxT+efNqKfaSP/vWUKS2ME
         7Lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766346199; x=1766950999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ATJoXSeF0h/amZ8/FNkEKf+tpsnwFPA3FmFWjmeHeJ0=;
        b=l3l9C+/A/oN374mqIgRJth4kLiqcoDwHYzW1/eyUUe2KDwJrze29Hf2i+/kKDk0KTA
         46Aee2WGz58bn7ArFksCqz7t1M4wwbDzhn/klCn9DTqEoNV1ugYecFxj5iI7g85PXPgT
         zbYwMat9+xD3LnzXeBGxEZo/C/v4/HFvm9QC/YtX9B5gWjDwtNy8FspBr9kJqNaUslDm
         OVvzkhh61le1Apst6a3DPY7GHrzNyMYP+FZLksw1Kh7j8gScfrCTYB072yPOkUN48wr/
         FXposikOUMEr+MVMrKc3GpAziXNcBySkazDNec9KFDJ3KxfS0X48J7K8sxh/ZKkKh83y
         HDwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ9/wzkyD3kyLcoGqAaOggXh7fuLZSOA7scEdWjPlrshneBCKsIdDODfaZ93928ObrUNFx4Emc8I4Gv3mKCJD5ZwYHrTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5JHPCXiBCswR9NqcVx24SUD1zTgSuPSyUKPf6JjU/091Tjf9l
	OMYe+1sBN1lfkf+t7r4988YEIoORU8g7Dmi3jI57hFCQuvQJEXWsMKAo
X-Gm-Gg: AY/fxX61S8hLciL7ihgCYRwmk+62+BK8WXL04VNIG1rSyTiGGcynr/VwtjaoRETOVzA
	7wt1g8RnnnzaIqIisc4xU4+gKNdg8wS1Wb2ozPjemknGb73tq4DvcL+Q6hh5d00vNEIKtNllihr
	6zVxRKkpDXeMkqDaOr8mPiV+iztTFdPQeycs/rvaaA4jVcoUKx9EGit3AcN55HJoiNGcpZmGVRv
	WQWHDSWo/9Q/TIhb9mUjk3lXwYa5f+9kjxfdPX4gAo5TTOq7D4na+zEM+S5ok1wKpbyqdHrQU7+
	Fa+XaMctneRxbuhAiA3MtuO6589bMpxK7uP4Bg77hRG9BM5Imhi0mEcSiC7ub0VA/bsqQi6Tkjj
	nu+q0ZmZ4KyqHQoicpiaZ6GSUxkYQ8Bk5PBFu1P6a6gcSVVJuLRtsZizkv/JYxASb/Hog/J3xq2
	l69HDcgG8ZAugk4Px65OiKjGQOV5yOTI7DJiE+ft8cpZauAPxqezdSNTbpdDQd
X-Google-Smtp-Source: AGHT+IFlFF3V+YE/1dIQt73YfqE17CrmC3Y/7cuxeorlf6mEveHzx59vZ0eTt6BHzp2saeqiVo0jmQ==
X-Received: by 2002:a05:690c:fc2:b0:78f:bceb:e565 with SMTP id 00721157ae682-78fbcebea8cmr79387997b3.50.1766346199430;
        Sun, 21 Dec 2025 11:43:19 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb43701c7sm35628707b3.8.2025.12.21.11.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 11:43:19 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 5/6] landlock: Implement KUnit test for LANDLOCK_ADD_RULE_NO_INHERIT
Date: Sun, 21 Dec 2025 14:43:00 -0500
Message-ID: <20251221194301.247484-6-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251221194301.247484-1-utilityemal77@gmail.com>
References: <20251221194301.247484-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a unit test for rule_flag collection, ensuring that access masks
are properly propagated with the flags.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v4..v6 changes:
    
      * None
    
    v2..v3 changes:
    
       * Removing erroneously misplaced code and placed in the proper
         patch.

 security/landlock/ruleset.c | 89 +++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index adc965de8e4e..5855d8617ab3 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -22,6 +22,7 @@
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 #include <uapi/linux/landlock.h>
+#include <kunit/test.h>
 
 #include "access.h"
 #include "domain.h"
@@ -769,3 +770,91 @@ landlock_init_layer_masks(const struct landlock_ruleset *const domain,
 	}
 	return handled_accesses;
 }
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+/**
+ * test_unmask_layers_no_inherit - Test landlock_unmask_layers() with no_inherit
+ * @test: The KUnit test context.
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

