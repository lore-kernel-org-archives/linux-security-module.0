Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56672836B4
	for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 22:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212079; cv=none; b=WwjBsMyZqeHedyYSIoX5mSPKsY+oMwPF6+7yQHfrtPiWhVP4bifwFK+XrQp/ji//HXhm5JnKzQVITUped5U7IUqatyeUh0XWgnYL/ddBlvkoLj+n4yC77Vo6qQtd5lNoh8wtgCxW3OeXYMdw5DyVMwYMMYHQY+KtmaWS3DYMaac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212079; c=relaxed/simple;
	bh=iuY/CTiTCZravxfCxNBdr1bNO56MCFC+GtQeZhSuXL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYBLlRE1i6MtQsfKwXPb+zGY3f6R5jR/YJVII1fZ3MtvDHLrQneiZOz6jgIqX67nWnFa6tAJiT6fbBYmLPe9n7ifz9ffrIcs3klre1cpI972d4JtWurOCpQ3/cfcauir74wtVwYrGKgmeE9CbhhOSgXzdtoSYcJ5iIEeSdDHxDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QXg8IqCP; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QXg8IqCP"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e87036b8aeso179450985a.0
        for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 15:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212076; x=1755816876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFnLiw/3DwVO4VGcGGoFJ68NpA9R4IDfhD7oxfuCmN4=;
        b=QXg8IqCPvngyyPSdiYPAacZ7Q3eUfjs44WwSdlqaDFZexQ//rI81n18nW4xIiaJA1C
         pOAyDari5hgpdz/afE/+/guIUS+UxO+Iep6mOk8OvM/g17kKeDyFY/lehfvsEygG6pQs
         gRY01+62OYvauoMVMIAFCCgrW4IA2dXKEDoqbO2pMkdx44pVLhSlqIjMFkxJAHTNJSLa
         G+Few5t+IT0tnRQoZrKGaK7gzTtLNmG4ohWsidGdeOIlTSLtot1RwJ/1MlaT71z3Y2Dr
         79ryA3jRrSLo1f3TwqjEaQOuueB+RKKRm6Gt1IJd/VbbMejrAiqnl7kK/EJq3JWwVIGq
         W/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212076; x=1755816876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFnLiw/3DwVO4VGcGGoFJ68NpA9R4IDfhD7oxfuCmN4=;
        b=H0zHtyHiRac9lRGjYIardrc/t5qJCc0ynBurVU6XpGY4KaXITdhY2NiXhmWEdzCf+R
         92s8hOAlfbiuTOywJwS85O9ou6Hb+dyQ+O2+Hxm+Rllg1038cGQi0j6zRJJxPyIO1YN+
         T2OgdUxd1oAVJ+v4ks5zXvIY0/xoc46C6lsvtMG8CH8V+FVSnGHzlRlG2uV0leT+ugYi
         3kw2dm5MdE9quWQan61JeD+Z4CSGx4k/kfhbjOerqs9oJn8yLl98riGNkQHiOpMAnUvD
         E5wCVeki1YPgkd4sMbl/fe3M8zCOWfzUgbIJPSlTeigYZTPuKKRFYCcflzgz5+KSkmLi
         LCHw==
X-Gm-Message-State: AOJu0YwfzgEr3BKt6tPjnMxSNrF/FRLW4x0ENyIV6BQoz1i+Z+OmvnTH
	R1ekgGYH6WWCotOlR3slA9CmsDWD/wonM9t4PGh3PNlhs6S4LSK2ZBDnfMljZQYs980F96gvQBw
	nFVA=
X-Gm-Gg: ASbGncvKn7Q6MQuxn0g/2gFE2EPlAhNeSwidvvX5Ur++5c2rL6iH4dfCoMTrK4sI+qM
	h0oP73mjqF2NNRjl6fKaLmxtNOami3Rkm/tkChcWd2+QR5/GPb10b28BHnBX0KbAajr4LOKN8aQ
	KL3v4ppZPFVwlmzZkC1Bp8lVJ6j34TnAzrkGmS3b9dM1+f6lbilNuiCnGMijOmalnx9aUBWpSOV
	RMSfDZ2yiL9XuvyHzvTeKhkqiNl8WV3nt2pP9HUJtdka3a0YPY2A+2mxRdInCvIivQ0zUVkt8Pg
	BtoWzhQvW8Mlwaq+IUaXQcyLB+DlyO1dNK0n20b4Fxy+k8i6eLN4/Bp+c1s7aKpegBdJuCGfzWT
	I/SjIafDeAPq1+k51fAQkbRi66xGXxoVHjUw7Ejyo5IHL4aCj0R5NvBM5xPFSxf8LpZ51ZWBDE8
	3xfQ==
X-Google-Smtp-Source: AGHT+IEN3R1VEVV3OabrvCfGtRXFTL1tsnquo2bOpLQxt2dOsoTFvHOjUe7NiHb0bGbJwLkNKDL2Hw==
X-Received: by 2002:a05:620a:7113:b0:7e6:50aa:1d96 with SMTP id af79cd13be357-7e87bdb82f1mr116730885a.60.1755212075951;
        Thu, 14 Aug 2025 15:54:35 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b4f6a0fsm43175685a.74.2025.08.14.15.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:34 -0700 (PDT)
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
Subject: [PATCH v3 18/34] lsm: fold lsm_init_ordered() into security_init()
Date: Thu, 14 Aug 2025 18:50:27 -0400
Message-ID: <20250814225159.275901-54-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6111; i=paul@paul-moore.com; h=from:subject; bh=iuY/CTiTCZravxfCxNBdr1bNO56MCFC+GtQeZhSuXL0=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmjHj9acJWmgdcOvrjwlb4LiL2iV7xxKWZTGV r9JNIBAFUaJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5oxwAKCRDqIPLalzeJ cyAdD/9FlnGZ6ORTQWay4GfBfurywkOqg1hT0vvzsDJ/e3BlZU7w7X3zUOAc8ZG+R1OXrkIWbfM LVyA1F66Uooin/cxbqsuPNHBvLG5Pbxb+1T+Qp3WfRDTliJfryHvuPT2yfkUbiNk9e1uUWuqhA2 r+gcufrxcbW/AZEKnYIG9RkbUzcwg2/NhrGDu1ZgBfg+YRzoWxNUeEaUy0hNUtU5onIcBslocT0 MlYujjSWLf2uzVmh8BZMOrNp7Zz1SIXeG2mr3uHmeZH0TB70H6uqFDfT1XUE7IwaYR3nvqrFc3t 0kR2SBbHYnjtUIgb04XFValYlG2fmtJDgzp15qnwKlj9kRsxdXlRGyO0jkgA4qHc6jsiSxHX1O8 pqITJscZdrn+2W57i30iSLkgmfdQJ2KGsHgkYZ09afElOb9Tf8J6FtGWO4bGbehucpdP+QBcHAX ymCqGmfQLVUrx5huhHjpW5gyTN1Lm6ddmldBG7bBwbn5s21Chdutxq6XRNFfLS2njqhBV6Qq4PX zhEVTAhnU2oqCUS7wae6grn0S1j5pPmrygAYAVac/eI3HfNb4gzr3BkWSio0W8Lu3RFv7/GRaU2 8XFeyJgWTb8+YU9/MO6yo+KIA0wVOlg9QvIm2M/fr4eC/5mXNI1Rf4CtA6S9D+Bs54nHEoAh7pY wt+gUEK50AAUL7Q==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

With only security_init() calling lsm_init_ordered, it makes little
sense to keep lsm_init_ordered() as a standalone function.  Fold
lsm_init_ordered() into security_init().

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 159 ++++++++++++++++++++------------------------
 1 file changed, 73 insertions(+), 86 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 1f64222925c1..f87f5441617b 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -18,6 +18,9 @@ static __initdata int lsm_enabled_false = 0;
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
 
+/* Number of "early" LSMs */
+static __initdata unsigned int lsm_count_early;
+
 /* Build and boot-time LSM ordering. */
 static __initconst const char *const lsm_order_builtin = CONFIG_LSM;
 static __initdata const char *lsm_order_cmdline;
@@ -169,7 +172,6 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
 }
 
-
 /**
  * lsm_blob_size_update - Update the LSM blob size and offset information
  * @sz_req: the requested additional blob size
@@ -313,14 +315,74 @@ static void __init lsm_order_parse(const char *list, const char *src)
 	}
 }
 
-/**
- * lsm_init_ordered - Initialize the ordered LSMs
- */
-static void __init lsm_init_ordered(void)
+static void __init lsm_static_call_init(struct security_hook_list *hl)
 {
-	unsigned int first = 0;
+	struct lsm_static_call *scall = hl->scalls;
+	int i;
+
+	for (i = 0; i < MAX_LSM_COUNT; i++) {
+		/* Update the first static call that is not used yet */
+		if (!scall->hl) {
+			__static_call_update(scall->key, scall->trampoline,
+					     hl->hook.lsm_func_addr);
+			scall->hl = hl;
+			static_branch_enable(scall->active);
+			return;
+		}
+		scall++;
+	}
+	panic("%s - Ran out of static slots.\n", __func__);
+}
+
+/**
+ * security_add_hooks - Add a modules hooks to the hook lists.
+ * @hooks: the hooks to add
+ * @count: the number of hooks to add
+ * @lsmid: the identification information for the security module
+ *
+ * Each LSM has to register its hooks with the infrastructure.
+ */
+void __init security_add_hooks(struct security_hook_list *hooks, int count,
+			       const struct lsm_id *lsmid)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		hooks[i].lsmid = lsmid;
+		lsm_static_call_init(&hooks[i]);
+	}
+}
+
+int __init early_security_init(void)
+{
+	struct lsm_info *lsm;
+
+	lsm_early_for_each_raw(lsm) {
+		lsm_enabled_set(lsm, true);
+		lsm_order_append(lsm, "early");
+		lsm_prepare(lsm);
+		lsm_init_single(lsm);
+		lsm_count_early++;
+	}
+
+	return 0;
+}
+
+/**
+ * security_init - Initializes the LSM framework
+ *
+ * This should be called early in the kernel initialization sequence.
+ */
+int __init security_init(void)
+{
+	unsigned int cnt;
 	struct lsm_info **lsm;
 	struct lsm_info *early;
+	unsigned int first = 0;
+
+	init_debug("legacy security=%s\n", lsm_order_legacy ? : " *unspecified*");
+	init_debug("  CONFIG_LSM=%s\n", lsm_order_builtin);
+	init_debug("boot arg lsm=%s\n", lsm_order_cmdline ? : " *unspecified*");
 
 	if (lsm_order_cmdline) {
 		if (lsm_order_legacy) {
@@ -332,9 +394,8 @@ static void __init lsm_init_ordered(void)
 	} else
 		lsm_order_parse(lsm_order_builtin, "builtin");
 
-	lsm_order_for_each(lsm) {
+	lsm_order_for_each(lsm)
 		lsm_prepare(*lsm);
-	}
 
 	pr_info("initializing lsm=");
 	lsm_early_for_each_raw(early) {
@@ -383,87 +444,13 @@ static void __init lsm_init_ordered(void)
 	if (lsm_task_alloc(current))
 		panic("%s: early task alloc failed.\n", __func__);
 
+	cnt = 0;
 	lsm_order_for_each(lsm) {
+		/* skip the "early" LSMs as they have already been setup */
+		if (cnt++ < lsm_count_early)
+			continue;
 		lsm_init_single(*lsm);
 	}
-}
-
-static void __init lsm_static_call_init(struct security_hook_list *hl)
-{
-	struct lsm_static_call *scall = hl->scalls;
-	int i;
-
-	for (i = 0; i < MAX_LSM_COUNT; i++) {
-		/* Update the first static call that is not used yet */
-		if (!scall->hl) {
-			__static_call_update(scall->key, scall->trampoline,
-					     hl->hook.lsm_func_addr);
-			scall->hl = hl;
-			static_branch_enable(scall->active);
-			return;
-		}
-		scall++;
-	}
-	panic("%s - Ran out of static slots.\n", __func__);
-}
-
-/**
- * security_add_hooks - Add a modules hooks to the hook lists.
- * @hooks: the hooks to add
- * @count: the number of hooks to add
- * @lsmid: the identification information for the security module
- *
- * Each LSM has to register its hooks with the infrastructure.
- */
-void __init security_add_hooks(struct security_hook_list *hooks, int count,
-			       const struct lsm_id *lsmid)
-{
-	int i;
-
-	for (i = 0; i < count; i++) {
-		hooks[i].lsmid = lsmid;
-		lsm_static_call_init(&hooks[i]);
-	}
-}
-
-int __init early_security_init(void)
-{
-	struct lsm_info *lsm;
-
-	lsm_early_for_each_raw(lsm) {
-		lsm_enabled_set(lsm, true);
-		lsm_order_append(lsm, "early");
-		lsm_prepare(lsm);
-		lsm_init_single(lsm);
-	}
-
-	return 0;
-}
-
-/**
- * security_init - initializes the security framework
- *
- * This should be called early in the kernel initialization sequence.
- */
-int __init security_init(void)
-{
-	struct lsm_info *lsm;
-
-	init_debug("legacy security=%s\n", lsm_order_legacy ? : " *unspecified*");
-	init_debug("  CONFIG_LSM=%s\n", lsm_order_builtin);
-	init_debug("boot arg lsm=%s\n", lsm_order_cmdline ? : " *unspecified*");
-
-	/*
-	 * Append the names of the early LSM modules now that kmalloc() is
-	 * available
-	 */
-	lsm_early_for_each_raw(lsm) {
-		init_debug("  early started: %s (%s)\n", lsm->id->name,
-			   lsm_is_enabled(lsm) ? "enabled" : "disabled");
-	}
-
-	/* Load LSMs in specified order. */
-	lsm_init_ordered();
 
 	return 0;
 }
-- 
2.50.1

