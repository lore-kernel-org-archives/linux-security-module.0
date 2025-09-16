Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA482DAFDD
	for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 22:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060852; cv=none; b=rOsgX8vVmbmax2dD5VkVugMCcTqdeigAMxpNVLRl884MCOm0lQNO31SYja7ee9oZMLj5fTC71HYMx2W6TpL7JRdhrMA2KmXyyycb4Exos3CeLPIUeVPjakHvjRdgRmNNf+FhSXGV9z2M+Q80ek+y55W4qRvjqK9PrmfGVN9VVeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060852; c=relaxed/simple;
	bh=tLoJFCw7JfadycegmqnXVd2NlV4ZkGxb8AQSWuSjTvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=do3q65z8S5D8mLwEI5kct41MCOaEUnndeBM0VDNyLk3dHKT5weFLGkZiGr+i0w4sbdzZdQFVPY632rb9WOoxyDLwVL3xrr10sY8d9Wz+cbTk1BMievAq/IiCVxkFKuxBGIBIXk7Xvu0hT99zSkMbp/xhR92mLecA5Byb7WaLIJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PuFJgnc+; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PuFJgnc+"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-78393b4490cso25832676d6.0
        for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 15:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060849; x=1758665649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKHYNo3Ci8G5hHOk7ZICJNq+WMScmiGRTnqx8FsBePM=;
        b=PuFJgnc+sSdXnI0/Ikz/io9HIiDYMt2NQsPpc5pOK6OxxIiVLfViFka/r04gVDSo/l
         6mPzBlTnQ4UZnr5ouj9zsajUuw5EtCuNQh+0y1ApitDhYYR/K/qIN/MfdBsCocA5Xrn8
         nvwYxODw/1onKBTe1ypxcDVql9YwPln7ZH9K0OySLBC5RKw0xv3b3g7/c1+E/LqUeCx+
         LchhpBZNpV0e7/xjizjDa2qHGbvHDBxqxtc7KdkYuAKDlh6eZH3fxpyBf50oqxkBIWD+
         BZcjy/I+7FZrsGe5YYpTpb73dcqCKVLAiFzcIKngk7RsNWe8QMHu2fQVP/Pb3MqcvJcJ
         2DzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060849; x=1758665649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKHYNo3Ci8G5hHOk7ZICJNq+WMScmiGRTnqx8FsBePM=;
        b=prLP29VTQ06bU8RsKOnDw9S8iK6mdt0HOX2hioqmzGcOR1PRKd2cYg1Zp1ESJ9c1d1
         SBZV/jB+5J5sdPu2U4kjY4sxMIB6X6uDg6t1G/Qd6xaJNWunhiSPKw/gma2tyOQVyo9b
         APvBhHr0Hbt4770XLvU1L3QP436PXmwLaRIsZxMcH4lE7I+o67DT699xDbh4F6w2z3Z+
         ivfI3bm0E+JY33HrebJrZPAm796OEVvYs8UvDHsGa7201o8i5SAO8PV2Z8X8iXbE5zNT
         oFgGgeDrqIY5dQRl7uFGwNAcP79b4g5HwUDlLJcAz1yTtkJfMsThfhq93l9Cb14IPbg5
         JUfg==
X-Gm-Message-State: AOJu0YxtsPx+3loh+fHOICmHVh13qF1QlK/d/eBZHPsvyMfJKHCQSNmw
	rmuol9XPGi8KyX4nWbAlhaBFcny6u9qi1sBlBo1b91aB9VIMoDxhdxwezSzzNevzUC+2uePRxHd
	IGPo=
X-Gm-Gg: ASbGncs5WurAmhpw+FFRp18O4MTkMD6gl2tsuby8NR6QH6DV/0cGIDzfMqB/SGX6YGg
	t2N03WRZ1hXIi+Hh5yimz61YOBFIcvny8lrMVec6YGCOfJc8UYF7c9bKq2PVgP/yWd7BIbIrP0T
	/B7TmrWa2aqtBEM9y/aU9wJrz9OXlPWwsuygKxZILr9K9/EesHcPQCFkRKLKLn7h3x1KT/+/roZ
	WJGiAneRe0CMJUVXBJroS57zmGA6jCF1BwmhvSqnwFPNWU/MthE0cl8ol1gFVdDmQt72+004kKQ
	hlXhWsnBf/pi+NAXAE/xCwoDbxaFtvuHquriSUf6bPmReOgDt1g93D3EvSLcpgjqADBC3yixTee
	riP2JvTPW2jmkXqWzMzo9/bM5JDfizo4cbFOufLMNgAW1Nyzvxp8gVkGaKBL31FD00ejL
X-Google-Smtp-Source: AGHT+IHlc0EEdcjWX8khgEh3VHFEaHOc1Kd+WaBStsOeu9SHlWl7fjmfnfBCR/80xqs5naFK6BbvSg==
X-Received: by 2002:a05:6214:2a87:b0:783:aeed:f591 with SMTP id 6a1803df08f44-783aeedf7abmr90796746d6.11.1758060849134;
        Tue, 16 Sep 2025 15:14:09 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-78903aec245sm32296166d6.23.2025.09.16.15.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:07 -0700 (PDT)
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
Subject: [PATCH v4 18/34] lsm: fold lsm_init_ordered() into security_init()
Date: Tue, 16 Sep 2025 18:03:45 -0400
Message-ID: <20250916220355.252592-54-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6170; i=paul@paul-moore.com; h=from:subject; bh=tLoJFCw7JfadycegmqnXVd2NlV4ZkGxb8AQSWuSjTvQ=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd8EYAcL9V5z5npF0QnHLRIsnnHZ99cHU98Mk XVpLRZ4H1SJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMnfBAAKCRDqIPLalzeJ cwzhD/9JaNJioqMrwdoq6adbq0SGnh/YpAIMMBTDFMkEMuFj2K4xd5hxx4Ywktvjz5GZrXixL1m nWyfhphxtzoX7utQf0cvj1Ginz/NW7vW9V2iz35hj5tBvXhIRTmFZOJtSgKERAPShVc0uVu9WOU nBKN33WVu+TyJqRIpyfGq+nbeaYRSpOaqsg211n+ixLYtfiH2pnBOo5LKpfTIzw27yYMedJ6nMZ r6QdzXGW8zyFmfyutq3KIWn7hDCPZNThs/T0b32xjMOsM7Ney06JTWFuOL7oB4dzNcyVPRVoPjQ T6HQA3S8qFkY95Xq25A9ZCvMZ8OkMxkUB3Dl6ga4j4g9Bfh9RJit+uYhbr5T1Pl8zsnZJPWLDjZ I6JINQd3JS/mg6uSWKH1XIdvyIEcgETJMWAO23UD5d8HG9JkTVSfr6n3taPTaTOv3ULvuam7Yjg wq9euzN0l6cGovrgCGDVsq520hOSH/39zDgmbJ7tmYHYSh3PB1BCNhX1fTVLmpI1IFREwQ9MwRQ 7IlpnBf8hUeG3t2YMS/l5WzXL6DihxIkcX68f4+ApHAhFtTT+AULBmuQ6eGx12hDhalRJ/PyX6V gZZZaiNH50JIfh4dxBuOdApw5fW3I4CPeMCySB763WCF3fdLrj5iMwvhBNq46fNjNwPps+wLeJZ mlWy3i3Wl47z4wA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

With only security_init() calling lsm_init_ordered, it makes little
sense to keep lsm_init_ordered() as a standalone function.  Fold
lsm_init_ordered() into security_init().

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
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
2.51.0

