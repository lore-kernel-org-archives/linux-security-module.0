Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B702325707
	for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764159669; cv=none; b=SIVYoHm9sz7Qm+pzzfxsSrjxv0KcvW/NbEg33fxvK+zcaWDLd8JqMqEZByDhTdYzUcn4mPL7aaQvIR8ek+pri8/nVFSJ8tyfmGOJwFdrZpXw082zis9V6yJlNZJGXluZE5GS8vUTb/XXyxh+vcjCfR+kGoQosVMnpVnCSR0cmk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764159669; c=relaxed/simple;
	bh=HDmmr1IPRNMCl6NXH7ebTWR3pZr+9YvInNSeMIAy9SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0fRb4D/NA9JWfCd9oN1Q+foCGkl8G5mo8Om6NBVFKaCyvRf2BhhRt3h1joSd8V+1usJ97nmPCD/Yh0UDN7YnJrH5C6XLSgWxm4BjD+3XB42QMVyYl6LMZLLTDIprOXxZHsss5mDm0iG7bFSoY7DMuQwQByD++4G7E/fBEafOGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyUuvDJY; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyUuvDJY"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-640f2c9ccbdso5445430d50.1
        for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 04:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764159666; x=1764764466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axhRyg/ZXVYRS6JssWrRfipxfSrH7rpq/tWdb8+j4Vs=;
        b=dyUuvDJYUtaDpxChgb9PhWayMB59qUjL1nzfY4lqKvka3VFcB3UNwiz1qp6GK0GCVy
         wnAYpPFojZ9GZNn434YpgC5cx9mFpjUfmV3+Dc9dJB3hdSb25Y62qaIe9l5NuLaqDft6
         VA93rUZaBfdy43PCkD+ow6qU0LKkALgbxqC/seOI4+tQvPyWspYyY5QYbGq7HuLWaLh0
         IYYvzxvo3i/meZctDjbUku02GDiEvmVHb/TeHlEWWo/j92LB7rWEcKAc9U6s5pVrNX0k
         rctCkdako5q3Q2Lt3jgBLf6wTKQJYxnB00AKZ8OvD3+HbnDDdKz9k+ODZTgXaGoM1oN1
         ZZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764159666; x=1764764466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=axhRyg/ZXVYRS6JssWrRfipxfSrH7rpq/tWdb8+j4Vs=;
        b=xLnv4QaNH3zTSCqTabpRo8BG83scw1BPvzKwC/qNgbogZoFOGBy9X5jvqOtfCtfBmp
         mym7WLUgwUh3Pkg8a50Q4Faidimoi0J7dv60G+Bf4fZmjANDBDuvyIqnpy3au9h/qxK4
         22CpIFYIXvTMUbL/9711qUVb0ifWzkeusDanuOtHSzzbemuCSfyMHgyGkQjgkXotVeEX
         aqJslRhtlocvJ6YKJnbpf7wa9viDry4GU+bDLS+rpgobee5ct6rhqBRcPcFeXfoTRpzB
         j3z7XqqGwNFeH+/cqb//kUfpOWP11esznaPICNUvLzwzTd7lKH9GI4UXRsmpew8vo7mm
         4Qzg==
X-Gm-Message-State: AOJu0YxP7h43fBt9S1Obl8dD6JrOD5m5476TjHfP4L5tDt15bRL6DtUR
	R6MR8PgzMhtgsv4IEBNauorr6ZHN+XkIRUZRSAQWS1sBo5ByHbYvjTJSjUaSH77x
X-Gm-Gg: ASbGncszJCe1OReHGNlQYLMdkgcRxVS7Tr4sOd0/pVONpfEISePIrQZyIXnf2FQJQlG
	mVLwuvDl/SLyPMlQPPqIoyBhPTY2WJXIpwRccJnuHyLQVcXGDNfEo6XuaIA2f59nCU/Z3rilJX1
	3/iU+YYFmRH9nMW3xU3w+AgUHvphxNS+a68A7Su22tRtfKBrWkGdAuL4PghpiZaJlyS05Mhd+VP
	nWmOBZuBw0pYF9et4FSTcMB7FoS4FjMlNOz1/nXvEdvK5DmlaJDYvzraPZp+63WCpDq4oTnU/CW
	yMQ/d+76fBDyjQ33ccOOfbDtUTejSAcz9Boe3US2BIhz/vs4AjdAnQKhsQM7se7NqYNJh0LOgW6
	vatypM6qZfaAAL2SSHZ1HfdhJN//vRfCMmmWElpZtctpVSxBlJ4G2mj7BR4MNdODw1L1OFSIRbb
	RUGE0zKH4Gykd41gpmA/OciE3rbgS8GvK+Jc76ZbkdaKZJOXktjkIhy8oLpIgK
X-Google-Smtp-Source: AGHT+IGHutL7Okds73W5vGqcCqBVHlgihDGeEuuQKl90iC1/lAQyOqyW45mVIbUWVaM9o53xWWvJ5A==
X-Received: by 2002:a05:690e:2ca:b0:640:dd25:d84 with SMTP id 956f58d0204a3-64329399769mr3183937d50.47.1764159666196;
        Wed, 26 Nov 2025 04:21:06 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a7992799dsm66318057b3.33.2025.11.26.04.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 04:21:05 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v3 5/5] landlock: Implement KUnit test for LANDLOCK_ADD_RULE_NO_INHERIT
Date: Wed, 26 Nov 2025 07:20:38 -0500
Message-ID: <20251126122039.3832162-6-utilityemal77@gmail.com>
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

	build.log
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

