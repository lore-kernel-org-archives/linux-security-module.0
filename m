Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB86277009
	for <linux-security-module@vger.kernel.org>; Wed,  9 Apr 2025 18:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224816; cv=none; b=kCEkRiwgxbLrK1GVuUA/2rA66z2tIZgwtq7cp26dwnVkpGIUlbYM5+odiROAAvxNKRtABoV78K/M2MHOXbqMWiC5zgOWVOoMjkajK7I9pNKrf52IPK+u2ncMRTSx1K4ytGNFKQUTGPprYD4vdnQGI9NWDnaiRt8j4wmkELIz1sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224816; c=relaxed/simple;
	bh=r3LlTbBg0v5L6VO7OKEzr0vj9s7D5oPdwgU1H8/sOCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOHaVR6NLtRMnTnw4BG1PU6XqD7v5rGmMinTrboaTuU6b6KaSTO7agIGJe/VmjNErhf4ANKcxnlzdXJwL54OQST4FOcsB5jWQpVa7CR2PGh68vbbyazYHtIaK5zfS/kozW+46ACQshFLbjWAWYHK3bcUkQdccYgK9QPY+lBKBE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TkrT1mAo; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TkrT1mAo"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4767e969b94so120193691cf.2
        for <linux-security-module@vger.kernel.org>; Wed, 09 Apr 2025 11:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224812; x=1744829612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwYwsOs1aQwmbIE5IlUqhyi2oMhQFITmOISMC3oihkg=;
        b=TkrT1mAobwA0EwWotHI5ggIQbNjZ11E6gh/XDtEpsZLIbaMIg9BVsBIe8ZT0Ut2dWd
         ZqTK7YveOBT7fRhY9WRPwJg4ebJkmOKL1MmWWMZECoIr/esRAw4+RBSTEh5LweaQlpKN
         cDNEnGbzD8Xoew0/t/XOfk1RlY54j6eBamctISES/qnEMmPfKimteHOfEusl/ZTAUWde
         9YMp7SRvwD1PVkuJiksLfcxCJ+KJxsjUvS28CME9n+RxOUeDtXaZq9EFIMQhEDvahlI7
         3ycAcqll79im/6WCo1huBJT01RipmWzfa4RIEmkSzdgHA71++4an14N2NC1/JXNcrQc0
         8HNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224812; x=1744829612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwYwsOs1aQwmbIE5IlUqhyi2oMhQFITmOISMC3oihkg=;
        b=rmIHaacpi/3CLgS2DVI3O+vzyBA5gOXboDVl8VTl+XgYLqZrBCbIcmFhEwRA6eS+zn
         5HkyGrd6ZcSG9pDQif8W1ZI39W9sZyqgV17hYSmgfGTszPMt3TEgIYiGeqPhWBp/Y5cz
         NCmogpRCFOQD2HrKR51KIANdqJ1RU17/z29r4VYydhwmhc0wKfu3Ydkvr8FONp//5GyJ
         Pwtkxw9NmRU+FpZSL43L6MmfWhLv9KNYNnMj5FbDbkChHhhQF9BcUGlAQhlWAoqiTjW9
         7GTO2zM3PC4UgSAqHPK/h65mOC6/Cdxm3MvltTDvavu+pRus7l6KAypQsl31tSUM0kHB
         Psvw==
X-Gm-Message-State: AOJu0YxuV7j1AQ6jAiPeBaDb87smmfK14umyoHTLiZA1yArQywZ9dzfh
	ZcyifMDIDVFiViaHYbfdtzNPFnUCbvina09LBBkmHF43MzZmfASoP7Tq/BguYYeZ+uK4dt9fIAY
	=
X-Gm-Gg: ASbGncuTxomLdYgtQyPg1kQqsoIulr/Yaif64ShMQyeJ2a1d7m8eCRU7KsZmzvFpU/9
	MUc9MvM2SooeRmfGvIxYTkr0xEwtd+cOKS6tlu1n+jsCxag+aFZTVeph30e8Y+6w1HmmbV8R3yQ
	fVS6Mro095uumbb+cSsFWpwffI9v/KtPeJjcIBhtUEp8EX5E4I5Ne8uzAohAxDMcyWTuBUTYM+b
	Km8iy2aDteOKj8pLluj88WBQIOaqtSwFOHRETZLhPdE5npXQ+sCzhcl+j+hVrk6HeX2UABTETZR
	wy/he6yay9puXT0P3EzXAd778jgVh0tcdJKhE2IXh5gL6/mPQPcU2FiDGwUH3F4ELL3tx3VKbC6
	MuKpkzDSkEA==
X-Google-Smtp-Source: AGHT+IGaIUi4G/RR3z11v27jpCnKDvarJVjCRYPeih2X67y6Pf/OUnyXfy7M8ebEujGpSfglKywUMw==
X-Received: by 2002:ac8:59cf:0:b0:477:64b0:6a21 with SMTP id d75a77b69052e-479600c1df6mr53978941cf.23.1744224812386;
        Wed, 09 Apr 2025 11:53:32 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47964ef6f58sm10319561cf.74.2025.04.09.11.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:32 -0700 (PDT)
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
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 03/29] lsm: simplify prepare_lsm() and rename to lsm_prep_single()
Date: Wed,  9 Apr 2025 14:49:48 -0400
Message-ID: <20250409185019.238841-34-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5272; i=paul@paul-moore.com; h=from:subject; bh=r3LlTbBg0v5L6VO7OKEzr0vj9s7D5oPdwgU1H8/sOCc=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sF78za+C6z3zkwal2wB33pphGO6OesCpmiai fvw17kIBj2JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bBewAKCRDqIPLalzeJ c+KrD/9sZpUJPcJF/4YweCjxX3p+LcuF9WIqR1Vf1exq1GPMG8u68zsgT9r7swvCbLodkeykLh9 jCgCYykeANDJSosrHm2P+e/VwCNLTDPpwDekROyWO5TBGPUPga2qkSCe6Z7ra+M1BdctfoE5vLo 6yMx/FJFbUBRpAFpxs+5Dhs+tGqr0X90kctubDGqBPURPSn6m8rA9hUgxAZjNieh1wYm/WIUVe1 0YigZPBgYAu9IPgEVGLr7CxLtl+UgsU2/Hql4PQZFR41v5alNZcinqkEETzYDJHu39g0C2Qi4f6 5StGpRdgNJozZkdqHIcOJ2Fd2FCq+QCFix+goiL04reRUzPdq/g9cdyLatW6sjtWFL6cFXNHQD2 HMbqYMunjtk548Xo6byv+aUg7qInIwcXMsMCsVUlnQrqqo7lxKyIQWn2sj6X6slcfUZig3D6DJy O1UDV4JGA1JE58i5y7WK9e/uiJVRo3KPPweqohQE6N/35kmK/YLsTqulwhErkri6VauAa/4glHT el8NcGC1djZZ14Xj0suHceDV1AoaZuy1PavTNpXzKokbAhuPcU1zHwiu3uvZSkFJbnaAreQGbCV FLEHqmk5ajJtxZ//tHyL5lh5xKvU6R1reDvDbNq6BiSnQBUyCTAHL4WG+kw7SPOW5KHmmbx3AUd f8i7W8vkj+8hdoQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

One part of a larger effort to cleanup the LSM framework initialization
code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 103 ++++++++++++++++++--------------------------
 1 file changed, 43 insertions(+), 60 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 70e7d4207dae..dffa8dc2da36 100644
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
+ * lsm_prep_single - Prepare the LSM framework for a new LSM
+ * @lsm: LSM definition
+ */
+static void __init lsm_prep_single(struct lsm_info *lsm)
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
+		lsm_prep_single(*lsm);
 
 	report_lsm_order();
 
@@ -499,7 +482,7 @@ int __init early_security_init(void)
 	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
 		if (!lsm->enabled)
 			lsm->enabled = &lsm_enabled_true;
-		prepare_lsm(lsm);
+		lsm_prep_single(lsm);
 		initialize_lsm(lsm);
 	}
 
-- 
2.49.0

