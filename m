Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B482459ED
	for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 23:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140245; cv=none; b=Muxue+gcHz+zOGt7izNu20NLXLL5dHC9e7JR/VEzhAAQQXWoyR+dZgwMTWIqCE2t5KX+7uz4Hp2jyH20oAVzwR+UVQo287n2Xhf1b8icbuN8lv0/gHTGSMCxbiACRYLrNrrlXnW0uBRNn/qM1MZt6vWCVKhGdG/zPIoCHzy41CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140245; c=relaxed/simple;
	bh=IXZL6iKye20cMj7BJY1Cb1q+IqpBbd6p2s74MS91eyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDcPb1UHARN3ERQnutpvkQ1RhRsqtVnbrdf/a+uJsKyO21SRW2dIk0AFBKhphkuBBOOP6i/jvq2/3h99Ctz0Wd/nkZW7NvZgruC5UO2QvEt3VuwIrpc2C5AoDkEaBpniyhhxicFPb3K636lcdEfuGW9fRdbda9QXgSC/5T/l77c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=R8+JZ9tC; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="R8+JZ9tC"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6facacf521eso45062046d6.3
        for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 16:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140242; x=1753745042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EglQhOwVkJKXKDnyzCJih3LbAejwHGlfpZ656+/i/w=;
        b=R8+JZ9tCpQ5PtyF4XlFZY0cGuFEGWBKsYDzHDBe5h9bbQYcLl5U4NV5S5CRglpEJTh
         O4N11IzGfHkaBQSYePiXFxr0VyFdxXYsQA8NbhzxPT0k58fMB6BeEI523c03RWY84oh+
         ZvD+ibRg2kzFbGLGkFgCpiaLjac0ExFH976gpb9hRnGtLptsZyZFgtQks1MfOe78e8/M
         vlp/nKE4pm40PT0nnANQ1KFG+x+GrDCZQtfpdCRQ3H8yPzTq0OcLrbnB0uRWGTScZoSy
         xh7nu7a9xXZafhdOAbtazPrY5xkOjohJemqaRYoDF59w5tB1dBz/y3fr9r5/xrqr6KQD
         xhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140242; x=1753745042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EglQhOwVkJKXKDnyzCJih3LbAejwHGlfpZ656+/i/w=;
        b=ZafDWdNOEkkZWgqVp2tsjyCdrhI8cZJTe9m9shGf025txIgDIARXm/0H8lXxgOUhLd
         uW1w9nXqqFdbLwuulbOj9X+egD6Rajoz8UWP42iGw+q8atK5BMl+wh84nwAgH5JsloXJ
         5Ethcv3B3DAcx+rFlrtLzwowkhvxrKoV1Eodf47DxssXeeSnTk7a8Hln9jGXYGDhcjyj
         /iw0CB6nLuWbtSnppQDH9wu0nceO0LnhJxfNHMku1vh1SPFurjM1n4F/T2V1em9PIUII
         QpNx0LIqBErysZ3dtL6UrVkHZLDyECYUXy4i/1j4lPzY9XYs1HekSmkov4A4kI4duOYJ
         DqCg==
X-Gm-Message-State: AOJu0YygH4jGwRJBzSlOz21soanhlxGwajFob728XPStcLLRAQNnc141
	WvLu97IYZFV4shBKeo7gzySZXSi4hdcEykiFAkTCrRtGzyXhVC0K1pvL6Y8ImGM89Nv/o2J1rCH
	UC9Y=
X-Gm-Gg: ASbGncuzIHwDExf+9OfjC7XoxUT+Ac6Yp4eYjqaj72TLsQtO377H7g8I74eLNY/0Vkd
	wl5uxypO5mQv/V9GkrBhBBZVcDx4Nmtv/bMbM5GSzZqfup990GQ1hrxnZzSmhxFHIpuWoBVEx8x
	I1TmCJfTzibdYvMkZm0hQ7I9ueh5KOXyI5g5o8gIBkM0Xgaqt1G6MKXjfiVWm49uDhs4yvvYk0r
	3E9OtFu5hPOorfHP/ceWzEgypK8cvk1XgX+llRJDM4aIgJfI/xyeb9SglOAd1LImRAIlTBm0Y9E
	XEq4sUZjssTxwWEvQuEARuEbwNG6mEp8iOEQ87rWcyZVvrUz47t1hi/pnHbZS1iSCuw8E6d3nX+
	hSzMiCvlgQVv2GE4QInJhUdzukCemsfAMy8emtXmyyABEHnhqhk/gnpx8BUElUVxCuL0=
X-Google-Smtp-Source: AGHT+IG040ezfwkH740S6YajZYWPmpi9wI8uXgRxyuNMWS6eUKgzMyr07cwK8w8Hcl+18TnbvenK7A==
X-Received: by 2002:a05:6214:6210:b0:706:dcab:a94d with SMTP id 6a1803df08f44-706dcaba9cdmr54588646d6.51.1753140242451;
        Mon, 21 Jul 2025 16:24:02 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4abb49a0ab8sm48263971cf.28.2025.07.21.16.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:02 -0700 (PDT)
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
Subject: [RFC PATCH v2 03/34] lsm: consolidate lsm_allowed() and prepare_lsm() into lsm_prepare()
Date: Mon, 21 Jul 2025 19:21:06 -0400
Message-ID: <20250721232142.77224-39-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5285; i=paul@paul-moore.com; h=from:subject; bh=IXZL6iKye20cMj7BJY1Cb1q+IqpBbd6p2s74MS91eyI=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsuUN1OiYz/phHW1CqOrrQTMeI3wlWIXLLOFl SZUTAcY18yJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LlAAKCRDqIPLalzeJ c7UZEADK1oQVGOe0u59nB01nyMZFTfMAw84CF8dD7SzdYZZ3VQRkXZYddjqEvsxFsxiHr3zKe3k Omvy4my+ZYuMtAIBWwwKO8L6CJGJ/UkD7GLHm3GgjFTWrteK5JfyvgkMeKH2mbhai3gEXddPFl5 48anD2L2jcchKhdapgaikeO9DXq34c0FJBMvtRyrlfnIWc/JwmWj7CME7wrVF3cSHDpoY2xVfUv FTqfD53ev7jeBY6KPDIQbowtb9P5tmnVQHjh9oPTv3LUGaCTdWgnicOOuDTqcmJ06RRZ/ePifZk ZaMKkh1l4y1jwaGIVwY31BJPp9jL/r5B7mlRp/wL4DxhmZzqGgrqVfbXysFBuRhaEUgYDHNR4MA 0BHyAtyCsAwCZ0+Uh2i5mkjyZuAnmK5NwQzHzOnR8VhpBIFQQizPq8im+PBBXod/wzNg/geobiJ 6m8MyAWnuQUAqsb3xIKGICMMED2us82/gQ1I6Dr8ibkmF860YyGO31OSJwdfRP6Vy0Kmsom4Vd5 ghK0gW0eWTEf69x0kZMqOmG4TbTlHOXIc7FLALTT4FZqozTZb301JRuuGmJUgayIs5SNZib2cLe gFKx24jljj5491WcLJucN7AAvRMpLoRPFkpHmMKVN0oSX3xFAdjs7McwLPSV2kjlLOkY23oG91Z DAJOUKYuURS3emQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Simplify and consolidate the lsm_allowed() and prepare_lsm() functions
into a new function, lsm_prepare().

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 103 ++++++++++++++++++--------------------------
 1 file changed, 43 insertions(+), 60 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 70e7d4207dae..7beb028a507b 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -123,22 +123,6 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 		   is_enabled(lsm) ? "enabled" : "disabled");
 }
 
-/* Is an LSM allowed to be initialized? */
-static bool __init lsm_allowed(struct lsm_info *lsm)
-{
-	/* Skip if the LSM is disabled. */
-	if (!is_enabled(lsm))
-		return false;
-
-	/* Not allowed if another exclusive LSM already initialized. */
-	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
-		init_debug("exclusive disabled: %s\n", lsm->name);
-		return false;
-	}
-
-	return true;
-}
-
 static void __init lsm_set_blob_size(int *need, int *lbs)
 {
 	int offset;
@@ -151,51 +135,50 @@ static void __init lsm_set_blob_size(int *need, int *lbs)
 	*need = offset;
 }
 
-static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
+/**
+ * lsm_prepare - Prepare the LSM framework for a new LSM
+ * @lsm: LSM definition
+ */
+static void __init lsm_prepare(struct lsm_info *lsm)
 {
-	if (!needed)
+	struct lsm_blob_sizes *blobs;
+
+	if (!is_enabled(lsm)) {
+		set_enabled(lsm, false);
+		return;
+	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
+		init_debug("exclusive disabled: %s\n", lsm->name);
+		set_enabled(lsm, false);
 		return;
-
-	lsm_set_blob_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
-	lsm_set_blob_size(&needed->lbs_file, &blob_sizes.lbs_file);
-	lsm_set_blob_size(&needed->lbs_ib, &blob_sizes.lbs_ib);
-	/*
-	 * The inode blob gets an rcu_head in addition to
-	 * what the modules might need.
-	 */
-	if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
-		blob_sizes.lbs_inode = sizeof(struct rcu_head);
-	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
-	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
-	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
-	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
-	lsm_set_blob_size(&needed->lbs_perf_event, &blob_sizes.lbs_perf_event);
-	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
-	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
-	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
-	lsm_set_blob_size(&needed->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
-	lsm_set_blob_size(&needed->lbs_xattr_count,
-			  &blob_sizes.lbs_xattr_count);
-	lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
-}
-
-/* Prepare LSM for initialization. */
-static void __init prepare_lsm(struct lsm_info *lsm)
-{
-	int enabled = lsm_allowed(lsm);
-
-	/* Record enablement (to handle any following exclusive LSMs). */
-	set_enabled(lsm, enabled);
-
-	/* If enabled, do pre-initialization work. */
-	if (enabled) {
-		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
-			exclusive = lsm;
-			init_debug("exclusive chosen:   %s\n", lsm->name);
-		}
-
-		lsm_set_blob_sizes(lsm->blobs);
 	}
+
+	/* Mark the LSM as enabled. */
+	set_enabled(lsm, true);
+	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
+		init_debug("exclusive chosen:   %s\n", lsm->name);
+		exclusive = lsm;
+	}
+
+	/* Register the LSM blob sizes. */
+	blobs = lsm->blobs;
+	lsm_set_blob_size(&blobs->lbs_cred, &blob_sizes.lbs_cred);
+	lsm_set_blob_size(&blobs->lbs_file, &blob_sizes.lbs_file);
+	lsm_set_blob_size(&blobs->lbs_ib, &blob_sizes.lbs_ib);
+	/* inode blob gets an rcu_head in addition to LSM blobs. */
+	if (blobs->lbs_inode && blob_sizes.lbs_inode == 0)
+		blob_sizes.lbs_inode = sizeof(struct rcu_head);
+	lsm_set_blob_size(&blobs->lbs_inode, &blob_sizes.lbs_inode);
+	lsm_set_blob_size(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
+	lsm_set_blob_size(&blobs->lbs_key, &blob_sizes.lbs_key);
+	lsm_set_blob_size(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
+	lsm_set_blob_size(&blobs->lbs_perf_event, &blob_sizes.lbs_perf_event);
+	lsm_set_blob_size(&blobs->lbs_sock, &blob_sizes.lbs_sock);
+	lsm_set_blob_size(&blobs->lbs_superblock, &blob_sizes.lbs_superblock);
+	lsm_set_blob_size(&blobs->lbs_task, &blob_sizes.lbs_task);
+	lsm_set_blob_size(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
+	lsm_set_blob_size(&blobs->lbs_xattr_count,
+			  &blob_sizes.lbs_xattr_count);
+	lsm_set_blob_size(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
 }
 
 /* Initialize a given LSM, if it is enabled. */
@@ -358,7 +341,7 @@ static void __init ordered_lsm_init(void)
 		ordered_lsm_parse(builtin_lsm_order, "builtin");
 
 	for (lsm = ordered_lsms; *lsm; lsm++)
-		prepare_lsm(*lsm);
+		lsm_prepare(*lsm);
 
 	report_lsm_order();
 
@@ -499,7 +482,7 @@ int __init early_security_init(void)
 	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
 		if (!lsm->enabled)
 			lsm->enabled = &lsm_enabled_true;
-		prepare_lsm(lsm);
+		lsm_prepare(lsm);
 		initialize_lsm(lsm);
 	}
 
-- 
2.50.1

