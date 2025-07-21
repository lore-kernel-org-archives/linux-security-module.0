Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA4D248F60
	for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 23:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140254; cv=none; b=LapAvAl+6OrMBXHr1SJMxrP2RdTNl9YSFhS7Ke1gOKQZ67dR8Tx9tb9hQPyo2Z29c53eOM/aLp+Il/5K8QW8gYQUlm/wPzD1JDQ2FOCANAYT4pY0ioVpe5vVZgNAIwFhBamrBMOw7UgOYSUwO2H1BhKMhbnKMryATm7DQl0cUFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140254; c=relaxed/simple;
	bh=dDWn24cZyUi9JnbWBGS2C7LUE2XR1x1LRHF03pvYjOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i61/j8K3whjjhP6uOJRuMBk09x9QL3R2uR7Qxb6+dT4+N8fWiNoQj0ITDYhlA3QVzmqZbkg0HXu5hA1T0sfrnSjAKg7n1m6mmqxq5x7Oef/8xwLX4Q1PVUgoTYJTfY5rMA/3B1JPiwcMiwF3tE7D4z3p/boM+XdPTwwXC+VXKak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=L9OIy80/; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="L9OIy80/"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ab6e66ea68so66215611cf.1
        for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 16:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140252; x=1753745052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FA50GcEGSyH1UNl+CqjT/GLUvFmvsqBBOlxaomN9nM=;
        b=L9OIy80/39DgKzbl0tBB/8eJ2RKC+GRMRaAP1mQxCwyOUbVbbH6hh4419cfY2lNWLa
         H4gCY+SHgXyPBmFQ6IxA59KgiQydhTynQdYv75sxy9TzeM309xfJLIyx5lmd7fI+Cjox
         UahCbUkcB+lWfCKHM8YEsfAHyyKuVX6WZGFExwkLT7umCdpLy45p7+NwAYBdJJJ8nYZx
         Q4inqfj7e0eX+VPzsU5IAW1Ctudz2a82kVaWr/5Or84193NOKJFdcmB6R/4JQ5bP5vMZ
         YGiNNaDWzwwjZR4Bnsyhhz4ei0Bukucg76GH7pgx9Iio27Th2hhTTPXWWPDYcfOEJmKu
         phYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140252; x=1753745052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FA50GcEGSyH1UNl+CqjT/GLUvFmvsqBBOlxaomN9nM=;
        b=v0ktruZNvHNQNpDp74l9+FIqG8W+zSsgLgHK2kiPbkGUBU6Cy9KYvbFZh53Yw7l2az
         tfC5whjGEK3Fvja6qzdtnoqasgXLLjpdwKAIo84+u4Kf3pJ4QxDiBJGKfBGeH6vFSXjC
         75e9igGuoUOkXT9VZ0Jst4A+buFHlFLXpUCL8G7Z7OCrH8fOYTCMDBtv5Xy2t8tifXKf
         W/w7fWfYSyGS6uvaM9M72zri8NLUtJWDrk7qGLjoCOsru6qpIK4WqhwXasV96AtvB5Is
         DRtshXGh8gKX+R3xhZ2k7A56ISF0lPoKk2dtd/iqxaNxsLe2/TfRMNSYDKw1+MSkImTT
         e6hw==
X-Gm-Message-State: AOJu0Yxpc6SGE1zcsldp+D9M9W5Md/HC/5iu3BvlZy3HTL85NfOnL1LY
	LNAqmRw99gjQunEGdvLLYXcvLzx0g5+dJXoERYxCr6TRjbwvZgUhOLaTKKcpyVni1rTEOMXKXpF
	gvcg=
X-Gm-Gg: ASbGncuQfMZgRi+ktVPBv8/3JZf5uIVZhTZ44Fz7d1IOtNSgWESyJ/xd38i09ls8PRF
	4OPbNsKip8RfZ2MVy5zivy0Im0kc1KJ+hBfz+RT9fQqPSJ0XxtuyBBcja2O6EuhMhNwSc0m3ZjG
	M9UsCc6bP4idYIdy+dQEgAZ5TInRyd8laVD6LMtRKz+hF1mhOjhp4ypw/T37j0XtUYpUEidklm6
	jNQigAwBYWkQT7MDRBTe0TxiYSJpFLo/BYk6oTAlyxyIqTIq5Wc0tJojjDp9PBhAIyTXUtz84lP
	glNN5heFfyQv5BB7hicAFVtx5BM3S0uD/drcX5StbvVNpVB2+ZEyws7DkUrLDMQiQBcRG70n5lA
	nr688so/bTX8GodV9oioMZo0hHIATIZywob3vRtYJjuhj/dfsbJAQCuT5QZElpLqzVfs=
X-Google-Smtp-Source: AGHT+IFHtPsuqZyIB7FvQKJy/1Wdp3vL+L4If5vFUvxbCS4uKzuJ0UfiU2O5k5+RVYwGRSFmViZLJw==
X-Received: by 2002:a05:622a:1905:b0:4ab:5f47:da5b with SMTP id d75a77b69052e-4aba3c48896mr201000671cf.8.1753140252090;
        Mon, 21 Jul 2025 16:24:12 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4abb4b1e6f1sm47056091cf.49.2025.07.21.16.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:11 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [RFC PATCH v2 12/34] lsm: rework the LSM enable/disable setter/getter functions
Date: Mon, 21 Jul 2025 19:21:15 -0400
Message-ID: <20250721232142.77224-48-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5393; i=paul@paul-moore.com; h=from:subject; bh=dDWn24cZyUi9JnbWBGS2C7LUE2XR1x1LRHF03pvYjOE=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsu0rfuE6yAisPDjQn1ohkt3erxRtPUZve9tv H8K9eAScPWJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LtAAKCRDqIPLalzeJ c2DfD/9y4jn9z/WniWAUZU/aWqcBnCXHSBcSM8fqRCkItawOcNyN3D8EyPRVypBZ/3vrlfN7QhF +UtK230i0oxVfuQ4IUGSvwV39ErUuGcuGAypb1e/gE8sk14Scpo0M19AuiL0JF5LzBISngfi+U+ zOnJ3R8NaTs/+obVA2JMoEApS5TMujrFwgH9xKlGRGZW6ZOUK7xWNPiElwEuRO+ZYVwrSxAGmtu gKtAZJC+IwfGJiRTo9BJZDg+vQwUfjjBk6953wa2GDV68S5RCYq3Imverlj6ccnitJKaayXkgxx VbM09rqM0wvNpsEJ13tsrZ7PxluCORx7W9aXNq5DVly7EEloTwO5ilniRrU9lSw/Yx2L9Xiwm20 SZpRT50PLw0z4OaFBb+MxT9WXfWj62VWLSV8/MIc/o2xAVQDfE7VTaznU5EssrP17GQoBq4cYaR ed6fSRhEH8uF2wwYhlHkWbqO6nedB8SbMbgWLfefByeNr7mVnM4zURnMZ4zkPjKFkkKo/lVw3ku Jf1XfISkOj8ke8txta4lptQz2b0v2HC8hxY7iuzdh1xO08VLVqKuBszQsG9baZ/WhvVoKZKV7DV NSPBwNVm47Th5SWcK9YIfJYwet7PQr7CTMvwWKrh3Ji1DZkywe2AIHY0kHy+GKE7oEWHY7TcgS3 LARXRWeuDIfoVew==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

In addition to style changes, rename set_enabled() to lsm_enabled_set()
and is_enabled() to lsm_is_enabled() to better fit within the LSM
initialization code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 62 ++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 80b57aef38a0..14bb6f4b4628 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -10,6 +10,10 @@
 
 #include "lsm.h"
 
+/* LSM enabled constants. */
+static __initdata int lsm_enabled_true = 1;
+static __initdata int lsm_enabled_false = 0;
+
 /* Pointers to LSM sections defined in include/asm-generic/vmlinux.lds.h */
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
@@ -75,37 +79,33 @@ static int __init lsm_debug_enable(char *str)
 }
 __setup("lsm.debug", lsm_debug_enable);
 
-/* Mark an LSM's enabled flag. */
-static int lsm_enabled_true __initdata = 1;
-static int lsm_enabled_false __initdata = 0;
-static void __init set_enabled(struct lsm_info *lsm, bool enabled)
+/**
+ * lsm_enabled_set - Mark a LSM as enabled
+ * @lsm: LSM definition
+ * @enabled: enabled flag
+ */
+static void __init lsm_enabled_set(struct lsm_info *lsm, bool enabled)
 {
 	/*
 	 * When an LSM hasn't configured an enable variable, we can use
 	 * a hard-coded location for storing the default enabled state.
 	 */
-	if (!lsm->enabled) {
-		if (enabled)
-			lsm->enabled = &lsm_enabled_true;
-		else
-			lsm->enabled = &lsm_enabled_false;
-	} else if (lsm->enabled == &lsm_enabled_true) {
-		if (!enabled)
-			lsm->enabled = &lsm_enabled_false;
-	} else if (lsm->enabled == &lsm_enabled_false) {
-		if (enabled)
-			lsm->enabled = &lsm_enabled_true;
+	if (!lsm->enabled ||
+	    lsm->enabled == &lsm_enabled_true ||
+	    lsm->enabled == &lsm_enabled_false) {
+		lsm->enabled = enabled ? &lsm_enabled_true : &lsm_enabled_false;
 	} else {
 		*lsm->enabled = enabled;
 	}
 }
 
-static inline bool is_enabled(struct lsm_info *lsm)
+/**
+ * lsm_is_enabled - Determine if a LSM is enabled
+ * @lsm: LSM definition
+ */
+static inline bool lsm_is_enabled(struct lsm_info *lsm)
 {
-	if (!lsm->enabled)
-		return false;
-
-	return *lsm->enabled;
+	return (lsm->enabled ? *lsm->enabled : false);
 }
 
 /* Is an LSM already listed in the ordered LSMs list? */
@@ -139,7 +139,7 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 	lsm_idlist[last_lsm++] = lsm->id;
 
 	init_debug("%s ordered: %s (%s)\n", from, lsm->id->name,
-		   is_enabled(lsm) ? "enabled" : "disabled");
+		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
 }
 
 static void __init lsm_set_blob_size(int *need, int *lbs)
@@ -162,17 +162,17 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 {
 	struct lsm_blob_sizes *blobs;
 
-	if (!is_enabled(lsm)) {
-		set_enabled(lsm, false);
+	if (!lsm_is_enabled(lsm)) {
+		lsm_enabled_set(lsm, false);
 		return;
 	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && lsm_exclusive) {
 		init_debug("exclusive disabled: %s\n", lsm->id->name);
-		set_enabled(lsm, false);
+		lsm_enabled_set(lsm, false);
 		return;
 	}
 
 	/* Mark the LSM as enabled. */
-	set_enabled(lsm, true);
+	lsm_enabled_set(lsm, true);
 	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !lsm_exclusive) {
 		init_debug("exclusive chosen:   %s\n", lsm->id->name);
 		lsm_exclusive = lsm;
@@ -203,7 +203,7 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 /* Initialize a given LSM, if it is enabled. */
 static void __init initialize_lsm(struct lsm_info *lsm)
 {
-	if (is_enabled(lsm)) {
+	if (lsm_is_enabled(lsm)) {
 		int ret;
 
 		init_debug("initializing %s\n", lsm->id->name);
@@ -237,7 +237,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		lsm_for_each_raw(major) {
 			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
 			    strcmp(major->id->name, lsm_order_legacy) != 0) {
-				set_enabled(major, false);
+				lsm_enabled_set(major, false);
 				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
 					   lsm_order_legacy, major->id->name);
 			}
@@ -283,7 +283,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	lsm_for_each_raw(lsm) {
 		if (exists_ordered_lsm(lsm))
 			continue;
-		set_enabled(lsm, false);
+		lsm_enabled_set(lsm, false);
 		init_debug("%s skipped: %s (not in requested order)\n",
 			   origin, lsm->id->name);
 	}
@@ -316,12 +316,12 @@ static void __init lsm_init_ordered(void)
 
 	pr_info("initializing lsm=");
 	lsm_early_for_each_raw(early) {
-		if (is_enabled(early))
+		if (lsm_is_enabled(early))
 			pr_cont("%s%s",
 				first++ == 0 ? "" : ",", early->id->name);
 	}
 	lsm_order_for_each(lsm) {
-		if (is_enabled(*lsm))
+		if (lsm_is_enabled(*lsm))
 			pr_cont("%s%s",
 				first++ == 0 ? "" : ",", (*lsm)->id->name);
 	}
@@ -434,7 +434,7 @@ int __init security_init(void)
 	 */
 	lsm_early_for_each_raw(lsm) {
 		init_debug("  early started: %s (%s)\n", lsm->id->name,
-			   is_enabled(lsm) ? "enabled" : "disabled");
+			   lsm_is_enabled(lsm) ? "enabled" : "disabled");
 	}
 
 	/* Load LSMs in specified order. */
-- 
2.50.1

