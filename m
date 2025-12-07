Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794DF2236FC
	for <linux-security-module@vger.kernel.org>; Sun,  7 Dec 2025 01:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765072338; cv=none; b=K7FyRfk7Zcug72oU08zk6H5U9YGEExrwomTz4jt95yfaBqDUg8aP2nJrBstuBAozHKJ+o6/lAqUsvdspGaSiIlwDBWE+SZ3qldzTGN1lRp524Abu77WGUH0e4g7cFK2gV2JwUeu7sOy5KHXGXYKUXMZGP8qoXmFQb7NJCUCWIf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765072338; c=relaxed/simple;
	bh=Zk7QdZiRFGC5664RUPySlBQu0D+Ntp+eFxGK3ZZaKrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naT1bqN0gIoQGfgYHrB3G+C7+LPChHReJYJdHOn8yaEalwTmCGE9NN0TBAVp+sSfPQ1uwWiBuz5k6wwlX8JtSUNONFlUxHoHHkRdtU1xpUczFwqNTjTTXLZlQljglNmh4fmAKo4UvAWkt8MMg5ZMKM0bkovmdOi81Sy5pxuJeoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cnb9537w; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cnb9537w"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-786943affbaso25173607b3.0
        for <linux-security-module@vger.kernel.org>; Sat, 06 Dec 2025 17:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765072335; x=1765677135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkzZXD11P4T7op8fvo+e4/R+Yiu/kgVuG7tG7Rcswo0=;
        b=Cnb9537wfYwKBv0rojo3sIw9bKSXlPTRJYvJZ+Rtq3bnE7w3dkshW8uGGGpjWxHcSa
         AJ/OwEuVUD0epn/Flos2LEwBPE58Vox5nMuhw3tuZSUtKGfBCbx8atlCiu6Z0vVu0bkk
         bcf07bFZVhw28R7asLlx7vm5uv0SbbQB6InmpNlprnuo/caxTTQVxTLBskfrva4tTgTA
         tcEtnWUYBbAjdOojE9r4BtA3hYxmHaLuWsJBjyQeOrEUjEYT6qj3hhMgazvXHK30K6Lf
         IOEX5T9cIe3YIlDiOWLlHbmvb5AL36hSu6Wf4iIksvIUJLr5jHfWMu+AB/jXctFq/vZC
         FucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765072335; x=1765677135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WkzZXD11P4T7op8fvo+e4/R+Yiu/kgVuG7tG7Rcswo0=;
        b=oVSYDHguY3dw+aPqNSOdapla18HMekjNM7bYX4AvAyVFLTMnwtcSnbTslUZGq2Mw2C
         LaPrCJz0B4jQ4xxfgYNrf5RKynMfhb6msYUvMkRuIT4++GCvhEZECoyvkcik44TPWtlB
         wQ30GfUUJGjMR6TJu5NulOOG06rOxzIWGVAl95OcQxFO1map925tdryv0t1o4UcBikA1
         OGWf3daeCiOm3ZtcWIOQ1X/0l6QImwG86/D3Id2R46jwBH1JO/0u5DlzpBDyoQ3wrI3l
         zBGEYvAJYut3iE+aa7FV1s1JQ2uRgwUSlXNlvSHZ8Pwt7yjynUWF5fbneMdcQMmv2X7I
         mpGw==
X-Forwarded-Encrypted: i=1; AJvYcCW/aZ/K8XbBu1/+8DbRbZykBpTdFROveKyI4VnjElGJYKZ7hwOVRJDEJh+WNifgCGBnI1cBnqHDrP2X1BlpVjq9m7OnEZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8noNeoYNEKwEN0l+rhNPE/7lEXY7pPJ8h4WbfL2hThfrELjTF
	u4eE6uf+nZBzJb5YWB3gZ8kdGebxSmc3roFUKNXcWRgmjd+BjpUfGDtW
X-Gm-Gg: ASbGnctHQT/yUl0QecCOqG76/22simCsaqRJp7//2klUfRAkGW4Mlui2wfqc9Yj2LdV
	1VygIFCE/YeHUxskNCM4pGPETvOSd9e9cdJqfaUrSLyAm2aXlSd/yzrNTJUOKS9LahWmmp46+sb
	a8Ff4nB8mgyZqEnaW/o+DlPiKo5EhKAcovpmd4eo2HZn1hrEt/zvwgfYXfF9A5O66B1G42b0oBX
	fZgFfPAOPVEUar8F+YGmgUgFtb4JCzgfWVn3Hfs7GdxWOudumjx4/l1VZC239lIR6U2hEHJARPi
	SZ6DWPCrWnnt0JOuk157awBc9ByURYpyQNr2NxLqzbbuq9BMHH3i4EcZ/GKsATRXyKGK70LwOoS
	J14p4SWvCYcoybuCK0BxcMzhw1xY5B0dnzwS5Mz38cnrJHQ4VWtL51sq0CfLzIhHHOsYL3wePMV
	t4HKq8ZMGj40gd15WQJ9pU657/YvYqp+LlHlA1gQC8oyswvTbnIT2pBJaChsBO
X-Google-Smtp-Source: AGHT+IHi+686Cxb/tx2sRSgZIMff8un8UsYlznqICPSllBuHqkiayLh31dXXqWmwYId2+san0IKU7w==
X-Received: by 2002:a05:690c:6607:b0:785:fe77:ccce with SMTP id 00721157ae682-78c33c2aa0emr36007027b3.44.1765072335365;
        Sat, 06 Dec 2025 17:52:15 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b4ae534sm33158417b3.3.2025.12.06.17.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 17:52:15 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 5/5] landlock: Implement KUnit test for LANDLOCK_ADD_RULE_NO_INHERIT
Date: Sat,  6 Dec 2025 20:51:31 -0500
Message-ID: <20251207015132.800576-6-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251207015132.800576-1-utilityemal77@gmail.com>
References: <20251207015132.800576-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a unit test for rule_flag collection, ensuring that access masks
are properly propagated with the flags.

No changes in v4.

changes v2..v3:

   * Removing erroneously misplaced code and placed in the proper
     patch.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
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

