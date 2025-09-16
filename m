Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3B62BE7D6
	for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060844; cv=none; b=tS0XyPbKdb4kWUgea2i4cSl2H14GiXy45o2uz+mJdfuobK+aiB7JaLev5UVY7QhjCepbFzcKwuNoddX6d/ZQDOA06XAewduq58atfY9SJnv3sJI8n2H84kMtT2dEBAwwTIgJr0VUzNWnjIubPSMHPnTmNuADB3lLmMxQ3A2Dj/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060844; c=relaxed/simple;
	bh=aoJzL0zvwesCTIvlX/F9QZwoHp4U+tIMCWP4GVn5BuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Arsf3lNCnlCGg62OM3VnV+AIvBHFAyyv8JzN2w5b0SvWoDjTFm8ubC+jeZxkKCte3GvmAtXAc0YpREBovinf76x8Zvwmph/3HTyi5CCm6WuknLCUWpmTwu849KrPyPmsvYpXMnXkDaDHv//jRzV8gSAHEzXjaEJo7IbwWZ4GVK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d7mPqEgE; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d7mPqEgE"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-71b9d805f2fso56031816d6.0
        for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 15:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060840; x=1758665640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IpXPIJ+QtsWyxw0RIg3MqwBgOomzYRXuOxvS3I0TZ0=;
        b=d7mPqEgEYbDN5A0Qd1dviHtjFh3IfiL/zlgE/PYnyJ1tAmyN1AYTAX58YUJxwypZnW
         iT/GkcI1nM4advVpP6+Zl9hOf03HqCqbuTAe+d62CQQglYXLArRPjbQl5Fuw4rvJhpes
         bpw3lIQvUYLtnFIT9q+nd0k1SuaqzETjgB482QPcYm9LmqndlwQoQyDRuPIbWR3y8hDl
         yImiVQ5cpi6HjqAJK45JDCIfouPCme0jl4qLcJEGq6C1fTGOn5fxQuhQZct1V2RYIFIJ
         V/mQdwhRbqCg+LVS+o1ym0sQEXmbVv/wZnnM9wGCEDJnotRBP3YqNNAb41lspzNl0kZo
         h0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060840; x=1758665640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IpXPIJ+QtsWyxw0RIg3MqwBgOomzYRXuOxvS3I0TZ0=;
        b=G0Es7wESo+1+033TMlYVwOP2KQ/c2PtEDSueKktKtsFZUf0LBM9y2SySrpvW6Cwm57
         EFxgaINFYvyF16KFJrjiv8tpifQ7UY7bOV/oj/QC873Xasmi78dBW2NE8v6yWhifGjfy
         OG+sO4dGBgZ8iN61FC1JHqXcy2vQK3zAym8ehXwHwXsyeB4qZskxVjM1J+fGF0+6d90c
         nr5b7V9QhG/PbnGfMc7FwUsvhLlN3J+66XOjbHpwST1eWjf85OjjQVOIDO/0unadiAqs
         xU84CT2NsYZpkEb5OArwaWqqe7p0wPo84A9POOAE9bM4dQBgvc1Imef5xHIZLPrXhPpU
         r9yg==
X-Gm-Message-State: AOJu0YxZb8vCERsiTA/f7TKOeaMu5BfILDIZGoiHiBYAMek/94eU7Awh
	5zR4fOYqkqYsU7pjqP/9lTYqkHWE0a4fiwYF2BTZlnh8ekiwsmvIlADTw+nOhC0H64gNe4r96Uw
	gDcM=
X-Gm-Gg: ASbGncsUtNEkExO59vNXPVBZJWMGkQo8pRSIe12BEtYJTZmXz7+HRaB2nVY5vXbxda2
	oTtCM/+PDf4IhtHnWdmBa6l/xl38wVi/RXXqGY0NhkqLnfcy5Dd1yw9L1xCcxdfhxkT7cMS+TlJ
	ahNe3ZqjQqTQfp3zYXsa7kUh04tDr+F9hF9VYoIWHOA0yL//PhShhoiPzBejROUS6TH7fj/QOMM
	D6/BxmyF6Q717PjdiaMsCRQrJ3qIWEoIy9TIQyaWK3eyUsU/2wKpUtN1jUe1ky/k+WJksxz1ryP
	mY+XodNPfq0hZX2PXMtu35X79VLDVs1TfXIhYIwiVyy+CMtR3ef+qU4CoD433yfOj1NQdkoLK1R
	9icw4h68ts+Y9ew4cA+DGUnxkspF55OI4Q1mXgRosQ6hT8Qs5mlYlJNDONliIeKuGG+Xk
X-Google-Smtp-Source: AGHT+IGvipOQUpMR75ywkJ1ouJNB/HrssBSg7L2LeZFx0VYdbO4zeO2N2UoJ6qWuyv+mvBKsYV3AAQ==
X-Received: by 2002:a05:620a:c54:b0:810:3637:a176 with SMTP id af79cd13be357-823fbde8c1dmr2123218785a.2.1758060839829;
        Tue, 16 Sep 2025 15:13:59 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b639dc8d9bsm92201681cf.38.2025.09.16.15.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:13:57 -0700 (PDT)
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
Subject: [PATCH v4 13/34] lsm: rename exists_ordered_lsm() to lsm_order_exists()
Date: Tue, 16 Sep 2025 18:03:40 -0400
Message-ID: <20250916220355.252592-49-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1992; i=paul@paul-moore.com; h=from:subject; bh=aoJzL0zvwesCTIvlX/F9QZwoHp4U+tIMCWP4GVn5BuA=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd7z4BBrHd0T5+XEuc9rvyp8s0RjkxImmq0uX noAe4j1YQyJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMne8wAKCRDqIPLalzeJ c0XMD/0ScZ9SexhYgqYSU3iyQfX9YFV9DVDfBJiJxrw8pToTEaPl8m1Slk+Y+3xpzpi+7tBUT9D QYUcHmH/bvam4no4+oSuUh3aDm88k5AACJg5hQDj5MjuWyP1Vc8ghTdPB6KORJhhKS0KC4AdAO5 2Ce0S7SkQeygLbKvD4daR04sVSInprsHXmKBKVovtk+Co64RhcG5DOwZAQAx6gMUxGZM7fFA8cK 8Gde1t8XpED6zEIkEowRWrRtUZpycLIkYcb/FgyKODlE8Kr+KIoBS1OtMnUUjEBJa+OSqe3EkMm X/vbYggTQeFMzNKOJmNGWeLrukGLqvCz7H6kSaF++FyOGdmI9aEc51faXuo89uD5b4/fpRRWZlt nqG1PZxme5Lh4vPG7EiURFz1x2/LDonlINv6K81us7xBGs7xxynSuWWiQIo1ITjGBgkxjIImeEl tdvFk7jZKhov2GkpXQM/lJqog8uFHCIX82f+TxC5Y38Ua+N+ns2hhkhgDHCZSKIoYodNwOlnULr 5Fp9fyHhPLoCMTRy4V1ju6cEzz+FOOTSqHYGxrDEbAnNbIyWkCyGP6QdObvlAknJMdB6oD7Fi/v ZP1QakAbY7Y1i0kn/iyRltqYjIdX/TeQuwMoowU2oa/JYIFpCq5EJFQkD+PYY2a5NglljeMP5/K cJS2AT3JTMfvltQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Also add a header comment block to the function.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 2cfd72ade6fb..ec46ddb18e1e 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -108,8 +108,11 @@ static inline bool lsm_is_enabled(struct lsm_info *lsm)
 	return (lsm->enabled ? *lsm->enabled : false);
 }
 
-/* Is an LSM already listed in the ordered LSMs list? */
-static bool __init exists_ordered_lsm(struct lsm_info *lsm)
+/**
+ * lsm_order_exists - Determine if a LSM exists in the ordered list
+ * @lsm: LSM definition
+ */
+static bool __init lsm_order_exists(struct lsm_info *lsm)
 {
 	struct lsm_info **check;
 
@@ -126,7 +129,7 @@ static int last_lsm __initdata;
 static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 {
 	/* Ignore duplicate selections. */
-	if (exists_ordered_lsm(lsm))
+	if (lsm_order_exists(lsm))
 		return;
 
 	if (WARN(last_lsm == MAX_LSM_COUNT, "%s: out of LSM static calls!?\n", from))
@@ -269,7 +272,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	/* Process "security=", if given. */
 	if (lsm_order_legacy) {
 		lsm_for_each_raw(lsm) {
-			if (exists_ordered_lsm(lsm))
+			if (lsm_order_exists(lsm))
 				continue;
 			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
 				append_ordered_lsm(lsm, "security=");
@@ -284,7 +287,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 
 	/* Disable all LSMs not in the ordered list. */
 	lsm_for_each_raw(lsm) {
-		if (exists_ordered_lsm(lsm))
+		if (lsm_order_exists(lsm))
 			continue;
 		lsm_enabled_set(lsm, false);
 		init_debug("%s skipped: %s (not in requested order)\n",
-- 
2.51.0

