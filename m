Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6475435B632
	for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 19:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776022365; cv=none; b=WLQ14gDvFWeU3GrfH4OVkTsuYwabMSFG2NHAsGBj9fOx0veOSZcedM2tSKnexn9HtHjrHbh74hcitN45AdoB3QIiuS5oH0TgtVhdmDvhoE/6vEVcDikN+unGHFXGLsuwcIVy/v8hPtgxkiZtVm3rAaYQhQY88NXIaV769471LpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776022365; c=relaxed/simple;
	bh=bV9tDu2COpdVbB+g1jFivb+kFEiZqx7j7uHHcowumOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKf+MDaB1SIngWra4aY1BV+z+QOe6bTzveqFbG48pzHmJpglCSD9mP8Q/ULuJPyNL8CMoPxnIT/LLvEXML8Xf0yy8MLqb6y4hc1CUe6DdPIk9Rt3wM6EGifxYh4towSRa2pDGWu9u++c4cR4Q76NAfRBNlcGY7KZAQ7bjYZi3pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ru5j0F2w; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ru5j0F2w"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79cd8f8e261so22667177b3.3
        for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 12:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776022363; x=1776627163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJrzbAcV4tZ+Y5JYo3cqWHbnzjSD2sgwXS2NXsSWyi4=;
        b=ru5j0F2wr7WvKNwYi9VHfOZdYMs3KxGiKxdiWKR5C/OhrgTAiq7pnnGJo1tGcmTGIT
         BFT+mxLY8gL67PWMego4y3Gtt+IQ3BXp/m+Hhj1tim25JZkTIHNaiz6Tq1L3xbCfjByE
         bWvehcj7mymsjoLn+231sBRj1R5my1UMk2WB5hYb46p3JekJlaXPMb3V5sr/PTMGoViA
         BXR6ridRmneBlNwiRrwWsVxwYSzBp+1tCRa575V2YITt+ZB+3A+uKHZp476JQHIOH2fD
         u35PHNZ/Jc4vCSR0f/5iLshHvAzVNTdm0avTvPc6vdXUP+ofCFlG9+6kvtXrpj6sKlEz
         TRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776022363; x=1776627163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SJrzbAcV4tZ+Y5JYo3cqWHbnzjSD2sgwXS2NXsSWyi4=;
        b=byBVpaR21DQWuZsjFTph14fIxyzOLrh5XlUxVmj+VIo6atE76ik6PbwzM9FEYLUIlg
         ZGwOj5pc4/amHxDsxK9CJR3h/Y5kZuuA5MVe0IafODJBgfAmokXboH313i9TrVYVz7KU
         sujzXeEzR8cOmluxhgJqrbtkLP2hN8mS84iC+AViHiIojQKFnjprjNbXkjDXe1bFWmbm
         /lfbyGzme7ePgJWPBLFil7UFVUfn8OCe6x3uLxHi/pyE2d/YSnZ3bos29ZLaTJjaZOjM
         grQB3hxs/MdDl1LtgND+X8976BfKVf8gkqoPGCWAYNS/Vy01ThdpcoJ+ZqoMZYBpJZLT
         DoUA==
X-Forwarded-Encrypted: i=1; AFNElJ84qrQaj9R8CIVCq527Ya2AGqG5MrVETslzWh7oA16KAAYnFyp+8V9/iwShWIH/8ArMSvApOfntG/IrLokTbC82OZYxr+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCx7/p+xQLNHnxOtFvmfw7j/kRLMZ88sL8j0r80XTnlrsrAnGl
	2qKxmStIYjmmcv//rsyEXUKTeXlee5KJiNUIAdtSa7wf5Pgdt+QyTqiV
X-Gm-Gg: AeBDievGRxGZ8upWpTvv95Mf7bHjVxrVr4sHeaAXKiVXejGLw63/XZslh0TcvdPOX27
	SXi0ySU078ReWIxCdGbf6VMq/yfcKE2Jm8Bpvszy3UNHuwpshS7Et02h8VhTqqN+qxhCYuI4Iaf
	yC79ZpjqCjzIH9mlOLcmQwW8SzyYoG6edDEjE/zofLfzZzDra9BoLjtfiEQNNmDqel09AJwft2g
	uBi6KkH3wOX3+c8GOOzEmus7yP6hrS7RDRNNAtUAl+jydTGFGlvWUzcJGQNIpWpVVG7IAyTjGg2
	OZQjPOyE1er6UoWhXYYYz7s2Ur1ACIc0PJt+SKg3PeYHenbnoIh8Oa1amOrkn+X694JjT2z5vVn
	lUEEbVxrzOk+0w78Ul8IH90ImVpm3RrPB6jGrNagtfcbEIlEDtZpMHAS9kurnu7P5pT2Bx28ZCi
	Lxs5n4REkBCvFJ2kgPd1ORFXoWxOtUIlEzmt1cadt/5Lbf4zHpAAZiJ7qHf8hs4KC8LMUP7mWC
X-Received: by 2002:a05:690c:dc3:b0:79a:cc64:886e with SMTP id 00721157ae682-7af7282b96bmr120604627b3.52.1776022363613;
        Sun, 12 Apr 2026 12:32:43 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:1192:20dc:2cb3:dcdc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3c8decbfsm42395807b3.8.2026.04.12.12.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 12:32:43 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 10/10] landlock: Implement KUnit test for LANDLOCK_ADD_RULE_NO_INHERIT
Date: Sun, 12 Apr 2026 15:32:01 -0400
Message-ID: <20260412193214.87072-11-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412193214.87072-1-utilityemal77@gmail.com>
References: <20260412193214.87072-1-utilityemal77@gmail.com>
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
    v6..v7 changes:
    
      * None
    
    v4..v6 changes:
    
      * None
    
    v2..v3 changes:
    
      * Removed erroneously misplaced code and placed it in the proper
        patch.

 security/landlock/ruleset.c | 85 +++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 8fdba3a7f983..7bc5000e7485 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -22,6 +22,7 @@
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 #include <uapi/linux/landlock.h>
+#include <kunit/test.h>
 
 #include "access.h"
 #include "domain.h"
@@ -753,3 +754,87 @@ landlock_init_layer_masks(const struct landlock_ruleset *const domain,
 
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
+	struct layer_access_masks layer_masks = {};
+	struct collected_rule_flags rule_flags;
+	const access_mask_t access_request = BIT_ULL(0) | BIT_ULL(1);
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
+	for (i = 0; i < ARRAY_SIZE(layer_masks.access); i++)
+		layer_masks.access[i] = access_request;
+
+	landlock_unmask_layers(rule, &layer_masks, NULL);
+
+	/* Access 0 should be unmasked by layer 1 */
+	KUNIT_EXPECT_EQ(test, layer_masks.access[0], access_request & ~BIT_ULL(0));
+	/* Access 1 should be unmasked by layer 2 */
+	KUNIT_EXPECT_EQ(test, layer_masks.access[1], access_request & ~BIT_ULL(1));
+
+	/* Case 2: rule_flags provided, no existing no_inherit_masks */
+	for (i = 0; i < ARRAY_SIZE(layer_masks.access); i++)
+		layer_masks.access[i] = access_request;
+	memset(&rule_flags, 0, sizeof(rule_flags));
+
+	landlock_unmask_layers(rule, &layer_masks, &rule_flags);
+
+	/* Access 0 should be unmasked by layer 1 */
+	KUNIT_EXPECT_EQ(test, layer_masks.access[0], access_request & ~BIT_ULL(0));
+	/* Access 1 should be unmasked by layer 2 */
+	KUNIT_EXPECT_EQ(test, layer_masks.access[1], access_request & ~BIT_ULL(1));
+
+	/* rule_flags should collect no_inherit from layer 1 */
+	KUNIT_EXPECT_EQ(test, rule_flags.no_inherit_masks, (layer_mask_t)BIT_ULL(0));
+
+	/* Case 3: rule_flags provided, layer 1 is masked by no_inherit_masks */
+	for (i = 0; i < ARRAY_SIZE(layer_masks.access); i++)
+		layer_masks.access[i] = access_request;
+	memset(&rule_flags, 0, sizeof(rule_flags));
+	rule_flags.no_inherit_masks = BIT_ULL(0); /* Mask layer 1 */
+
+	landlock_unmask_layers(rule, &layer_masks, &rule_flags);
+
+	/* Access 0 should NOT be unmasked by layer 1 because it is skipped */
+	KUNIT_EXPECT_EQ(test, layer_masks.access[0], access_request);
+	/* Access 1 should be unmasked by layer 2 */
+	KUNIT_EXPECT_EQ(test, layer_masks.access[1], access_request & ~BIT_ULL(1));
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
2.53.0

