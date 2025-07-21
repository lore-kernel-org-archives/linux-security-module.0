Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C9D252286
	for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 23:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140266; cv=none; b=oBTlBcy0DmvhdKGgLYpQbnYCySOVzkYFps3hU+fseMXg5gLk4zwtrwZo9S9YCtr6Mvn/OcpFkRjE/xWPccsS58AoMzhFqYzKmajQuRxqMpcFVtr1OhdSqVUVb1jLMgHDki4YoUwAg9/lORAC1sYi8hk8l90jgx9Yt9cy0CtaGCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140266; c=relaxed/simple;
	bh=WSFQcReLl+OPzggh2cY0LOy0pKk2jNaGavlYZBSCkII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeUvW9YR6yMxppgNmMqWh29AnvF0U5S58U2batZXrKLe7gthcvMZMIHyBvvesuimcrSFRUKtTsARg5TOAQnQ9gUwtbH73uqCa6U/0l/8IMWR2ZgDLcQKll8IC1/4gvKXk7jacvWI0ho4rRYidx9GOIkjIpG/0/4QB2kNdDecZGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VTQN0gJe; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VTQN0gJe"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fa980d05a8so30812606d6.2
        for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 16:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140263; x=1753745063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWwo3Pyn1Obu8i1T6iZxNyPaRY7Y7daG6XlIgDuFoCE=;
        b=VTQN0gJeCfdwDbfIrydQHS7KSnN6TgwVmaoYYb/7eWm+a/oDjdvQYKTrrp0a1iwoRh
         BELqclL5nCTyhzSes72hKwVDY5NJsMsfj5ys4vfHZijp0783pJJ1G1IgK+UATSi+8RlU
         l3jUURShhl1yqk6xMaHGqsSQydKgbPcC2kXOLtlMY2j2h+MfbW6F6i9KYAKY1T7KkBfB
         a8YdIi7ve+Q0WMf2hsivUK3C1pWQZkDXPbFYA1a58Plc6dgcMFInFD48XvOxuoE8bzJ2
         3R4GKtAdwC7/BDx7sZjBqV6NA1coqpW1g+5QANDFXj0GQ7TLRZYw/bsyKZD3y+MeZ0+V
         /Jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140263; x=1753745063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWwo3Pyn1Obu8i1T6iZxNyPaRY7Y7daG6XlIgDuFoCE=;
        b=T24y9zgYDN7H/AbPF5D8BmFvWzL4/Te11nujcENTL7Xx8Us6wcsoBk5MY9sGZ6MlBm
         b1tKYXoHPp5HnMVMWbv66N6EhxhExC1ar1MDWphRlHbQgnmVnsK+T6hIuOCSh361brIN
         TAOrfkH3xGM+oHihe9OJVHVPqgNycPLazRClwbiLBmkqIr0rcijRZVSeTiaXC81lP5Ci
         dsDUUej7l+1P1ZaJ17nhZBBfT6lmk7b0f1/eLJ5Z0PZY6D9EW2UYnqfmPcEVkTQPd+GC
         7yUFuZ/CZuUSf5zK/VgGHx165C2EWptg3XYj1vQhBDGK10118B2o8Gugy/y7abTyY3JQ
         Z2Mw==
X-Gm-Message-State: AOJu0YxPN1RYGKOxjzjCeKZ8bLu509lwdzSoXNsf+2V70YWV6Y7XpQzp
	kcHOQh0m/AZx6JywOO7oxU492nwMqqWXBoKUL4yAfDzWNugp/35mHpOdDrq6pJyb6UiuSGYAFMY
	xP+E=
X-Gm-Gg: ASbGnctCjPTPllkQQyWxtwOJybour213b9N/0hFW2CyBLaYIalVmlvPJLnIHXBWdqEy
	ZSEZPuh5cugBp0MZevG6b0xqd8F7AOggO4ZYZKOTSWDfHIQ5fnpbR2wO4y6bG6g2u2ccTgi2bqz
	wVo3G9Rkn+toNaCd7cr9j/kZssY0m1MhUduZxZuVt/ieBmC0H2wcwZ1vfkZzTO//rm+KSBb+SVH
	zuUbtSUHsugaUzKBOVWn7KpVpcsBBhmxA/PDsh/VnihSJlcoxyiLywXZQ3i5dbS1hfknVarRR1R
	nqNMhtSnDmb/Ath5I2U+D5nawTYDk0HOvya6lHGZeiCYE203z88xAoZMRLajdn4rYgZd/kSftqk
	R8Z0ql96NN05L8SzsLOKkhEDlLl/fe1ddq9PscLqho6obTe8PhVQREzKy6TAXQXbiCc4=
X-Google-Smtp-Source: AGHT+IG3UFDrpCOBI2Ms+vimDLG0HrZzk0Lt5smD05hyCeJdZmmVE15i2yBWY1wz/ro0OnFxdFjmCg==
X-Received: by 2002:a05:6214:3bc3:b0:6fd:61b6:3360 with SMTP id 6a1803df08f44-704f47fa19dmr352358286d6.5.1753140263409;
        Mon, 21 Jul 2025 16:24:23 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7051bad4f60sm45211846d6.111.2025.07.21.16.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:23 -0700 (PDT)
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
Subject: [RFC PATCH v2 22/34] lsm: group lsm_order_parse() with the other lsm_order_*() functions
Date: Mon, 21 Jul 2025 19:21:25 -0400
Message-ID: <20250721232142.77224-58-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5402; i=paul@paul-moore.com; h=from:subject; bh=WSFQcReLl+OPzggh2cY0LOy0pKk2jNaGavlYZBSCkII=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsvWkUxzxcJNCyt8bA2QTl2uqx+OL204p15WE 7NzmrlVcMaJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7L1gAKCRDqIPLalzeJ cztHD/0ZnYYgD41QmOgtMjwMBOHzbmiN58yZi/Hhewxjuvyhon0W/6acsMK164+HAjmESAwWi2b zyig3Biav8xQgFTEHFk2JsNcCQVOsdd+JH20Czpq+6pzQTjYmacGlvdog5butHaH0GReGf4XlWF ExwJh7z2OWK+akhQgKrJJCNpxJz7DPECuGNQ0cJTqLU5elhnHpr+hyqPeiPpvjQXoUd/jbu/0M+ xrYohs1SyZI2xUOblJk4ejpwOuNM3o/xh/uq9yRCT5ZzUL/63Ylddli48KHy9b6iwQrdR1q25XR DisySSOyZudOHk9dYBG1R7/Vx1mwWlcPZAsqJBu3sbefigcXa6CwW5DUuxrs3mSGi8ci9GMF4mk IhDLOwDKYoty4DhnaWSI/XZWHvSkfRPGCP6VOPL5Z653Lb1ptVSyky0yNHJ94/f3Kym0bV+DAqb HMeybKuyCAY+nGvFlZbVRiEFnfCzgmpwziABR6WZKbR+/oOZ5wJACJ20n4tiR1GPsaBtiYWG7Fi utEDXr4aImBKL8aYXkL0th7ue2zbX8kootmqcOYTEQ+YS2fCJ2hotFZ5F/Rt8MPirip8iUhgaqy up9e9YM5JdwxjEB3e5jxz+10/BG24phGY/5hLLhTGYVybiYogQ8Wf1takRw9uIWPdp0xU4oIuRq Mky3fEmBxmcReqQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Move the lsm_order_parse() function near the other lsm_order_*()
functions to improve readability.

No code changes.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 138 ++++++++++++++++++++++----------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 7e794f4515ea..ada9b5448409 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -169,75 +169,6 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 	lsm_pr_dbg("enabling LSM %s:%s\n", src, lsm->id->name);
 }
 
-/**
- * lsm_blob_size_update - Update the LSM blob size and offset information
- * @sz_req: the requested additional blob size
- * @sz_cur: the existing blob size
- */
-static void __init lsm_blob_size_update(unsigned int *sz_req,
-					unsigned int *sz_cur)
-{
-	unsigned int offset;
-
-	if (*sz_req == 0)
-		return;
-
-	offset = ALIGN(*sz_cur, sizeof(void *));
-	*sz_cur = offset + *sz_req;
-	*sz_req = offset;
-}
-
-/**
- * lsm_prepare - Prepare the LSM framework for a new LSM
- * @lsm: LSM definition
- */
-static void __init lsm_prepare(struct lsm_info *lsm)
-{
-	struct lsm_blob_sizes *blobs = lsm->blobs;
-
-	if (!blobs)
-		return;
-
-	/* Register the LSM blob sizes. */
-	blobs = lsm->blobs;
-	lsm_blob_size_update(&blobs->lbs_cred, &blob_sizes.lbs_cred);
-	lsm_blob_size_update(&blobs->lbs_file, &blob_sizes.lbs_file);
-	lsm_blob_size_update(&blobs->lbs_ib, &blob_sizes.lbs_ib);
-	/* inode blob gets an rcu_head in addition to LSM blobs. */
-	if (blobs->lbs_inode && blob_sizes.lbs_inode == 0)
-		blob_sizes.lbs_inode = sizeof(struct rcu_head);
-	lsm_blob_size_update(&blobs->lbs_inode, &blob_sizes.lbs_inode);
-	lsm_blob_size_update(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
-	lsm_blob_size_update(&blobs->lbs_key, &blob_sizes.lbs_key);
-	lsm_blob_size_update(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
-	lsm_blob_size_update(&blobs->lbs_perf_event,
-			     &blob_sizes.lbs_perf_event);
-	lsm_blob_size_update(&blobs->lbs_sock, &blob_sizes.lbs_sock);
-	lsm_blob_size_update(&blobs->lbs_superblock,
-			     &blob_sizes.lbs_superblock);
-	lsm_blob_size_update(&blobs->lbs_task, &blob_sizes.lbs_task);
-	lsm_blob_size_update(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
-	lsm_blob_size_update(&blobs->lbs_xattr_count,
-			     &blob_sizes.lbs_xattr_count);
-	lsm_blob_size_update(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
-}
-
-/**
- * lsm_init_single - Initialize a given LSM
- * @lsm: LSM definition
- */
-static void __init lsm_init_single(struct lsm_info *lsm)
-{
-	int ret;
-
-	if (!lsm_is_enabled(lsm))
-		return;
-
-	lsm_pr_dbg("initializing %s\n", lsm->id->name);
-	ret = lsm->init();
-	WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
-}
-
 /**
  * lsm_order_parse - Parse the comma delimited LSM list
  * @list: LSM list
@@ -308,6 +239,75 @@ static void __init lsm_order_parse(const char *list, const char *src)
 	}
 }
 
+/**
+ * lsm_blob_size_update - Update the LSM blob size and offset information
+ * @sz_req: the requested additional blob size
+ * @sz_cur: the existing blob size
+ */
+static void __init lsm_blob_size_update(unsigned int *sz_req,
+					unsigned int *sz_cur)
+{
+	unsigned int offset;
+
+	if (*sz_req == 0)
+		return;
+
+	offset = ALIGN(*sz_cur, sizeof(void *));
+	*sz_cur = offset + *sz_req;
+	*sz_req = offset;
+}
+
+/**
+ * lsm_prepare - Prepare the LSM framework for a new LSM
+ * @lsm: LSM definition
+ */
+static void __init lsm_prepare(struct lsm_info *lsm)
+{
+	struct lsm_blob_sizes *blobs = lsm->blobs;
+
+	if (!blobs)
+		return;
+
+	/* Register the LSM blob sizes. */
+	blobs = lsm->blobs;
+	lsm_blob_size_update(&blobs->lbs_cred, &blob_sizes.lbs_cred);
+	lsm_blob_size_update(&blobs->lbs_file, &blob_sizes.lbs_file);
+	lsm_blob_size_update(&blobs->lbs_ib, &blob_sizes.lbs_ib);
+	/* inode blob gets an rcu_head in addition to LSM blobs. */
+	if (blobs->lbs_inode && blob_sizes.lbs_inode == 0)
+		blob_sizes.lbs_inode = sizeof(struct rcu_head);
+	lsm_blob_size_update(&blobs->lbs_inode, &blob_sizes.lbs_inode);
+	lsm_blob_size_update(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
+	lsm_blob_size_update(&blobs->lbs_key, &blob_sizes.lbs_key);
+	lsm_blob_size_update(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
+	lsm_blob_size_update(&blobs->lbs_perf_event,
+			     &blob_sizes.lbs_perf_event);
+	lsm_blob_size_update(&blobs->lbs_sock, &blob_sizes.lbs_sock);
+	lsm_blob_size_update(&blobs->lbs_superblock,
+			     &blob_sizes.lbs_superblock);
+	lsm_blob_size_update(&blobs->lbs_task, &blob_sizes.lbs_task);
+	lsm_blob_size_update(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
+	lsm_blob_size_update(&blobs->lbs_xattr_count,
+			     &blob_sizes.lbs_xattr_count);
+	lsm_blob_size_update(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
+}
+
+/**
+ * lsm_init_single - Initialize a given LSM
+ * @lsm: LSM definition
+ */
+static void __init lsm_init_single(struct lsm_info *lsm)
+{
+	int ret;
+
+	if (!lsm_is_enabled(lsm))
+		return;
+
+	lsm_pr_dbg("initializing %s\n", lsm->id->name);
+	ret = lsm->init();
+	WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
+}
+
 /**
  * lsm_static_call_init - Initialize a LSM's static calls
  * @hl: LSM hook list
-- 
2.50.1

