Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719B7363C6F
	for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677453; cv=none; b=dz6GFIhzWr4oSLm7h5mN6On+7c8f9GOyClCHVwQzWrM/02lks73eqULIyQcX+8NT9cZlwC46S7vvhakfMAhB8TxXniYPmCcfwKjarafkL4c2/PMIi7pCjLGvpZpoD2aG1OkzhiXN35RZnBkFOZ2UNgaPFbbyp4QO0zbWU3qiTiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677453; c=relaxed/simple;
	bh=QbCWV7gAquXGhA+abOJbZ6aQK+fnWr5uuin4ZvfEuyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMPJUV1ChBoeRwdiLfG75gClMNwKj3ORgOI7CiFmdcQBqLgSaYtLTzV9oDFwQcl31okAvCl/qK+f33mQjCZZsKRmm7XmB8lhk8alF/KecZlWkgB256JtHEU9Ozb0gCsRaqe8P87jhWjbgWe6gGuO1D544cl3eoBaEGgisDdEQ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKBv79Dz; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKBv79Dz"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-642fcb38f35so719724d50.1
        for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 14:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763677449; x=1764282249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMyaQZDKoox9ul4SZyXwK1m/8meWAecvOqgWgJ0YW/s=;
        b=CKBv79DzxI2KcXW9eZ3Rz2KLQy5jlBKl0+cYt/vP6j6E0YNxnXItDJEE4JcNqtszWc
         mJTPLserfSTwXWfb3jC6G303tzPSuxHPuUHzw2NNlezVNL805E2WAZeyHhvmGk0Ms0yd
         2eGMA3f3VQrRX3Jt9twfhKAA66wiYlmjuXtBGKiazwy7GqDHIGT/mbGESP2gNXsCeVWt
         kJ3pu18MOdn+M2vFdTb7vG4tS47lN468X5BkypYi1gd88wjzbzcPJ0Bz+y3CF3QNrqrt
         Q6/HkMpjPxCC1tCFztD6+Mg8Gs1ffmjFZOmoVS1XGj5uzpsSfz1bl50VyDupmAmWCcOQ
         cfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763677449; x=1764282249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mMyaQZDKoox9ul4SZyXwK1m/8meWAecvOqgWgJ0YW/s=;
        b=OApt85Hd0VEQuDnkv7Rr7cVfDOQ69/qDx8QJyKijvA0nzAqj3t0GwToqXD4Z4wUugP
         psGtpvyY2n9JGlyHydY3dx3ihv93Fgh8SyyE+0XFm0isOmGbxNHzZD4JfWObiRKmTlC6
         Wvj2PyBsNEafWeKr5wT8SjKNi5igVcot7YncyWrgp9UZQ+4QZcqOO2PnPTyobpyCAsBR
         qY/s5gY1tBu3mnjJPW8z9x47W/duGvSdw6JJEjCfa70xSOj2hHToBS77SKshBFxbtHyW
         xm0Hx4XuZSUnYIdL5/j/GUmnXNUdcDRLh/Hjf9J6bs6inBqRZlk44Un/1RnqeajEo4DW
         YPzQ==
X-Gm-Message-State: AOJu0YyqcIbSbuElZYOVBYIvNuGSL0nvCH+2aMBEpKWYFqWLtFaTEv5K
	zX0DhB9Gr/jnB6DkB7bESxe1y6dCXv6v3kyOLlFIcWlRlrc7ffFn6lPnajJJmDaaqJ1cVQ==
X-Gm-Gg: ASbGnctbyH8Y1u2jpT61FfJHx4XjZd+ba+vNZV98vhyxr3N54+c1eA3bX8HOTSTVyQ2
	kDrYjjen9ITsKVJ4l4Epd3oBcCWVYBa1ABADKAoNM9D3/OExMfoXfpDA6FifTrnsACrnBzM5Zyg
	eEeSvsPjOtGFc9x+fJXdgDt55JKkXlqhdh3UdyNVuO8anTO5iNoi4F9fwoBFZpcaBs0vT7gRAYG
	+qZcwr4uBeyt4f8R15+mMDrWFY4BYu1lrfZB5jduEJTZx2qWjaunsC7cckVbaRL/AMHJkONdjaG
	yOZno+K3+Bi16jehD7d6up2gyhcJDNdbb2MuKMSE1/weRFpMoynWDzHo39hN1Pgr75O/ClBQsX+
	sNnNGEapSnhnDQqkfud3NvxIylyuCS0RuQlq+Y2CuIcTOvsUIZfGaDtooFFSQvoaoKK2rJty8fF
	/bfhpU1RJeJ55uD9SCACnMrHvM9EweeOsTM+c1L2DL6alRRBOPKXxPd0PdjwOD
X-Google-Smtp-Source: AGHT+IFzPeJsz3hgkZze8yg+P6fY3PwFLDGInznCKYTeKOZlxGg0frTwao8eUzxMmLt0Fl7N0aZReA==
X-Received: by 2002:a05:690e:108a:b0:640:dda6:e96e with SMTP id 956f58d0204a3-64302a73768mr7043d50.36.1763677449230;
        Thu, 20 Nov 2025 14:24:09 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a7993cedesm10954757b3.41.2025.11.20.14.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 14:24:08 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH 6/6] landlock: Implement KUnit test for LANDLOCK_ADD_RULE_NO_INHERIT
Date: Thu, 20 Nov 2025 17:23:46 -0500
Message-ID: <20251120222346.1157004-7-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251120222346.1157004-1-utilityemal77@gmail.com>
References: <20251120222346.1157004-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a unit test for rule_flag collection, ensuring that access masks are properly
propagated with the flags.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/landlock/ruleset.c | 85 +++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 5d190d6779da..c407ec264207 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -22,6 +22,7 @@
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 #include <uapi/linux/landlock.h>
+#include <kunit/test.h>
 
 #include "access.h"
 #include "audit.h"
@@ -835,3 +836,87 @@ landlock_init_layer_masks(const struct landlock_ruleset *const domain,
 	}
 	return handled_accesses;
 }
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
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
2.51.2

