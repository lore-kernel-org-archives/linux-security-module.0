Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09EC24113D
	for <linux-security-module@vger.kernel.org>; Sun, 14 Dec 2025 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765731964; cv=none; b=sHzsUuI1LZ2pV7eRTrGtpCg6BebKhsylrHlcXxkhmybDXSNK50lkjOiNvh0bqRkBadlR4Aao25UCe+QcnH8bR0GCaaTfaZ8dpw3vaA3AoDWiphQw81tFkqmWLd50ApT69OyBKbyc9npWD2pKWLpCVsuVrk+ZtY9fuBRr0ZxNWIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765731964; c=relaxed/simple;
	bh=9gHR5MifxSTG1kDb/rYlU1y3k6jJ5M4NW6zXBWyBzak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=InVdCaCJXVId72n9U2TunjegQ+YXNwpa9/oeWlTP1jSAAIPELUxn7mK9yY3tx+S1TwHRDMdml/PxTJ727Bf0UMEmhg/G6G8hJMlNlXALjAbEG/IEU+WeOFtqq9JKvZ+N+UYBAPbb84FOBCTDL/MJ6ibhmyPveKRxC2qiuTFTzWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCqKK9xM; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCqKK9xM"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78e7ba9fc29so5781837b3.2
        for <linux-security-module@vger.kernel.org>; Sun, 14 Dec 2025 09:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765731962; x=1766336762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTjCbDGd+KArCRhYR+yHous3AqF0H3plo2tK9tY5urQ=;
        b=OCqKK9xMTwkTgLYzHTMOhtFXmiNJ+/fsZSpCtabsZzagbLPRH5QwMwdYUJYpIjPJ/n
         cDrtOotnLQd6sSNd/+CuEEjefsl+5IQuFIQoIbgQCDLcmZp4WAmWaMimrib6xwjqfzBG
         sSdjg5ilxOje+UcU4Me3sAxryQGr8JNtZgst+H525xZ9AFvBG+fcyhYCosq5d/g9Tg5L
         gaCWAIpXnDQ+MfK5zfO5lylF4a/pf6AFLK3GHV0r/QMy89sTV7nOGfPfoCY6zRvl2UK2
         zuvRCcmNUWyGdWhgaotOWrfE1riZ/Zd+cbdTUNewTsNQtuNPT3kBxXEKp8ABJ0jFQrGI
         K0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765731962; x=1766336762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CTjCbDGd+KArCRhYR+yHous3AqF0H3plo2tK9tY5urQ=;
        b=C3u4n1cvpDUCkQVMdqG/0UbbLw0+RomwTdcdNC9IFIV9o5usdmOBAMViREcI97LbBx
         2vzQe4joHSdwbyiic7yzvB8sRUPhzYTZ7BkQDxecFgWbKr2jhbubL1yxGkUWnyt4/kHS
         Os3VdBAda8xSGteWk74xxIoMkBvEs+VAgJLSiTr+U/7JLohYbFBxBVNHtVCQpm4DfvKG
         tJyOQMl1ecHbn1fyxFF4iykfrp2Gs5089REcxJF65VtinUCoROkfMXEWR1931PDvyCOx
         wkBMbGEBARO+wXdH684hmTgN/Rr5SXVGHfVfIp3DHcp/FkLewhv1Jgefv9WIJkPDStgl
         qdZg==
X-Forwarded-Encrypted: i=1; AJvYcCViOfs3bhOj+0OF8RpAJn2x5Vi89mvHTKbeJ+t6UCj5kNclEAhRJQsnoK78+UJXaWTRGDnQmf3oP3BedCSutTAXTJr+m9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy22byuEEXRfttTsQ1loMNkobytTLGw6y6njEWYt5UY045322WJ
	13nMeWjquNt7PD0YOksYJaJgw2p9jOI1xbtI1sA+eI96ioVjqEKDTbDp
X-Gm-Gg: AY/fxX7gqZnpQc0xHKEAR54lTT9PDu+DUB0eAirT23QEj8tKTOt1lcQuS0paDd0LHL6
	DGAgNFttnuE0xi5ZdjKdPFJBC/1u+/nlq2Qvc7i61U4KWJZOcyEHWgK/DbmM37SHTkgfmmW94M6
	/zXIATOlvyiQHKV375nZIjNhVVXBkInagir3n4Qk0diC2ngVzB1SjL4fKLIRCio0lqc+/X6wyTU
	jP9N4vtAvYGlc/9LdGEXGr6E7GxKiRucaLc5PP1gXHahM74AY+pPNSiy3hBWOqtWrM4C318JeyM
	FP5PVaVTPhhZiAKfjkZSHLX99lD66EUp2FlDE1XBWA7+iKzU+i41RTjXgwT1HwOgRciYLilSejr
	lk6VTo97tQNUpW3MWowjbbKh8lyDSgpMItcoMfKmP9Trs2w26bBU1v62YBhAly2ftVRZyvqsIBo
	WBr0kBkGGUaLQGGva2/pzsSY603VRtoj0LMA98296nzOgWl2ULct0x8Tpi+GTPx1an4xNdz/I=
X-Google-Smtp-Source: AGHT+IEKMTDS7EVQVUAPiipMJsbVImUhGy3bTO+RTn8il5QKFQHMjlEdj/wJzyARatW1FwjC/iRsLw==
X-Received: by 2002:a05:690c:a85:b0:786:449a:176b with SMTP id 00721157ae682-78e66d7e731mr73264407b3.21.1765731961536;
        Sun, 14 Dec 2025 09:06:01 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e749e7683sm19401117b3.32.2025.12.14.09.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 09:06:01 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 5/6] landlock: Implement KUnit test for LANDLOCK_ADD_RULE_NO_INHERIT
Date: Sun, 14 Dec 2025 12:05:45 -0500
Message-ID: <20251214170548.408142-6-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251214170548.408142-1-utilityemal77@gmail.com>
References: <20251214170548.408142-1-utilityemal77@gmail.com>
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

v4..v5 changes:

  * None

v2..v3 changes:

   * Removing erroneously misplaced code and placed in the proper
     patch.

 security/landlock/ruleset.c | 89 +++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 9152a939d79a..8064139fde8f 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -22,6 +22,7 @@
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 #include <uapi/linux/landlock.h>
+#include <kunit/test.h>
 
 #include "access.h"
 #include "audit.h"
@@ -770,3 +771,91 @@ landlock_init_layer_masks(const struct landlock_ruleset *const domain,
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

