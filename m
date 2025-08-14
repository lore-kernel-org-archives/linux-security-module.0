Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA351139D1B
	for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 22:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212067; cv=none; b=F0PEzklsn3KNNMZ1OwlmeAUHN/22HPEX2+md3YQnnzCuO7NN3FPGvZ66Xg3RZp2flDffBsC81czyUqnW0BpyEurr29AJBRZrynvFkXa3DrtoE0iOG4kzm5xY8uD/5pYShqJBepyqfH2zqDOZkeIcJvEm8sxLAioxUiJ3wWcabAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212067; c=relaxed/simple;
	bh=q047y0ShpGYmoyK6y0ROeoeMV7fMELnql8c2dcedEbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5ZmdFeS1aKmN550d/C83NxblSBF8e7TKUMkwMfOriR/1PpEl/hKNskp7lnKhD8rN4JiDgYYn0wi6Hjy491KVm4SqmwHtGxvxspDrZH9ZYqjEUvI8cuNxYK2RqxRPepkeshiePIYWYEJ1YsEIwMCqOaY665m+mEJpfVWJ7lCtQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IB73Z6cy; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IB73Z6cy"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70a9f5e1c2aso17002666d6.3
        for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 15:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212064; x=1755816864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTXKN/a3AjixUE22sj4/Cm2PIPPoCLCmC47HhyPTM5g=;
        b=IB73Z6cygDemPYN4BjuR9C4QV3n6ZjWllcBgJG3IkrNwU1q0c6tHGZAhsSBOu13+6K
         14JplhnqghOfMqT2KTyMtiTF6crOXtDDtyFeYiiWcUcMaqaLOSwQRN9OtCZ9/P7mbvM/
         y0BUVoFqh3nx93tS5godHFMt6VfUIvMKMqBug5IjrdIk6j/xEZdfeNrpG+OQjasojeX1
         g6FrP9yRgW6c1MG4wv556cJ5oy7iKWNxwGASHVRw4KOxJ3D4u6Cg5MFnABevL+cQvkHs
         gbIPdNoLyZuveXmEIHzV5ZiseFS988tf+eykLzPs7lFtOqwDBhCJWXSAk9xYusADjmN4
         GQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212064; x=1755816864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTXKN/a3AjixUE22sj4/Cm2PIPPoCLCmC47HhyPTM5g=;
        b=lf7Nw+OHknQx3o9lX6kLGXwq0tDf+Uto2khvp5N3iRP5DeN2aPR6ry4k9YDhcLL3UT
         dAQZV8fO47H5vy5JXRhGWyxuFHdPNuwLlycBzJJrZUZcn3wvH3xvqXDV7wOEVWpUXjHo
         7HQHi3CmHL7+9iYI8JopBUmYWWx/nbWP4AF+BTYQ47Rc1cD3J7zHE9DhG7S4jntKEnZk
         RL9puu/wEFOUo9JIuanGXMEYYZB/tjQqrgKzpGwjggobHTFwL0p2XanhUBZo2ZYDANe2
         6PGnNqrVMZ9BsPe4+/GoH2ky4xM7SpgCCkIvZuopSAyA84RWOe3z8dqCHZMZ0Dkz34mx
         4uEg==
X-Gm-Message-State: AOJu0YwjWz90rwXbp0w59UYznK49y6mOQCRrvJpPniDRxWKoTU+o1z0b
	Hx7ymHOsqsuc00H4GLkGwWtDAfR1B9kaGwwYOXsZQH48BnosamVFRd35aQyFaD8xgqNjyvBEbOQ
	zPcY=
X-Gm-Gg: ASbGncsCOYOWPe/9KV8bNI7LZ7e67TtrIZLyuEHMaTbD1DtAUCkXahb/cQYOhlgALAv
	EeE/CE1fSkmH24grUfT8tslaRa1TKL9VwVzbuVXtLjT9ioeM5yqPGKNiwbxP+nudAOUHSXlyrhz
	Sn6xt2DI+QZ7VP7BRMD2YqOzN/Lytix5lsLX4o28sG/KfpXkjORz2aIrEoPWuDNdenWLcHHCy7U
	1aEr1gPkhHMnStvFLqQCVRd2/LPL6n6XfiTPMJ+HCZX/CHukju0fxB3kORVCiBMppMW1dDeKTKt
	1lUI+xVav6LVvJ4lxN0o/rer96AoUbToK57yV3IwhLGoTkLVTuC236ltMFL11dX7STa8Bkvea0k
	ffJsXIIO3DcmF9BqxYDzry8FD6kyxQLmQ9sRxGklJ1YzDl1ELqs5388np4mq8L9h4df8=
X-Google-Smtp-Source: AGHT+IERhNLyoXSRaL4K3g/2LPSpgeU+Wi8hpjOzcQ0enZuZQyecc9fhDh/+/mqyLGJf81vLka1mKg==
X-Received: by 2002:a05:6214:21eb:b0:707:6409:cffd with SMTP id 6a1803df08f44-70ae6def81fmr66666356d6.3.1755212063911;
        Thu, 14 Aug 2025 15:54:23 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70ae6cbb2bdsm19197006d6.20.2025.08.14.15.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:22 -0700 (PDT)
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
Subject: [PATCH v3 12/34] lsm: rework the LSM enable/disable setter/getter functions
Date: Thu, 14 Aug 2025 18:50:21 -0400
Message-ID: <20250814225159.275901-48-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5448; i=paul@paul-moore.com; h=from:subject; bh=q047y0ShpGYmoyK6y0ROeoeMV7fMELnql8c2dcedEbI=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmizA8NgjSJAGcaf2X6UdDv4/GvzWj1nu53t/ 8ziXRjmyvWJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5oswAKCRDqIPLalzeJ c/jdD/sG1wzweRqXluXXp+rcig5mUS4zEXIGKeU7AhonG4zxl5dAYqSEp5sfcgCMGKQG7XCweL6 MCDCZrbXmrL0iYF02oei8S8nVv6qjqNwVfA05k1tewyHpKBnTTzxpNnzggus5WeSsQn5mOcfZNF +qQFysbsUJ+KqgIhNcXf0pKllApNPLOd2dJwy7O7TULe7HD7wrS16g0kcsQcg26f9KpU/CuGzIW xu4PnwHVytATa/shG6+rOqT0wjwBXJQgsNlfI1QFNi20oLk+1d1YIVb/5D9CFUq469ghxFYKFBb ZYmsAYuENMyiBlibHAXN6dETocsc3QtXWPuV2Xctg8Ba4ef6YD2EoS/Ik+PDoLiFp3WLHTYuT90 d9ETdHZg9SFNdUejdtYrzxcFI4rcKklfcFqJM7q6/oDt5u6245yI5UKCSkpsUhnmdn2d5t8ZIre mDdzKUOMNtqk7zh7lT3ONorbkJlnmpGTU1/WA0lPh73cIyEfmqJYW1TRS7mFQe0Vw4ReB7jDMqh iq44qaPQRJxQilQOocLM+7QxxV098rbtzvqWA2eUTGpdblXV9oeL9ns5UXvWYcx8Zt5GxpsY7gc vytcYqnHR2C6bcfLFLhwQG27hL+IdUwY3swPMh9KsKAN6eQd7/agycZvFmpwpeZhvcVB354OAwj klrusepJt4dItkQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

In addition to style changes, rename set_enabled() to lsm_enabled_set()
and is_enabled() to lsm_is_enabled() to better fit within the LSM
initialization code.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 62 ++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 87e2147016b3..2cfd72ade6fb 100644
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
@@ -206,7 +206,7 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 /* Initialize a given LSM, if it is enabled. */
 static void __init initialize_lsm(struct lsm_info *lsm)
 {
-	if (is_enabled(lsm)) {
+	if (lsm_is_enabled(lsm)) {
 		int ret;
 
 		init_debug("initializing %s\n", lsm->id->name);
@@ -240,7 +240,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		lsm_for_each_raw(major) {
 			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
 			    strcmp(major->id->name, lsm_order_legacy) != 0) {
-				set_enabled(major, false);
+				lsm_enabled_set(major, false);
 				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
 					   lsm_order_legacy, major->id->name);
 			}
@@ -286,7 +286,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	lsm_for_each_raw(lsm) {
 		if (exists_ordered_lsm(lsm))
 			continue;
-		set_enabled(lsm, false);
+		lsm_enabled_set(lsm, false);
 		init_debug("%s skipped: %s (not in requested order)\n",
 			   origin, lsm->id->name);
 	}
@@ -319,12 +319,12 @@ static void __init lsm_init_ordered(void)
 
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
@@ -440,7 +440,7 @@ int __init security_init(void)
 	 */
 	lsm_early_for_each_raw(lsm) {
 		init_debug("  early started: %s (%s)\n", lsm->id->name,
-			   is_enabled(lsm) ? "enabled" : "disabled");
+			   lsm_is_enabled(lsm) ? "enabled" : "disabled");
 	}
 
 	/* Load LSMs in specified order. */
-- 
2.50.1

