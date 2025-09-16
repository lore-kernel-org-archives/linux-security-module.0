Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8695F305051
	for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 22:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060846; cv=none; b=j77rsuwJNGQ55SiJN8xiz8NP6G0oKtLYSl8WRev05dqm0Q+c0mHSbrMc0ROlnbcvuQsm+X67jdI8JuJvbbCklMmHmL9wEHGEuB5nAja4keAfn6wqOg3AaFDUslwUADYNMKRdnLWGuBM0LXw6ZJpWDXoX8v2TChtnyiFQ0mhv6FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060846; c=relaxed/simple;
	bh=rjn2ffjd4ifcuufei25Ylxlmb0K5Nl9bGbQJG2/I+fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buhpTlV+ZHbvFkFqA90THTstdB8jF3yqrrzYzKYd3PR41YiO00+uY1Igkv+0sG3AqncW4DgLW2wwJh7ApKflvixssZ/86EpO7W6hIduoptyvfjWN1AtA7TncxrPkAG+tEn+OFXxR9eZt+GSt0Ln6bgtqIMCKcvOdl9uLLZLKucE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WyXm4pzm; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WyXm4pzm"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b7abed161bso25393131cf.3
        for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 15:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060842; x=1758665642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQMUld4u+e4WeW6bejoEvG5qUwMCp/YRRFxPQyzYnh8=;
        b=WyXm4pzm579fwoltHgNG9Ped4/T0hNiBw+pa9ddj5nVQOJdOk7gsHvUXg+tXfjdU0f
         WHzqVYQjL2H9BHHXPmr2Kn2UxI4w1IgRKUJu+TSzvNiFp8ZWyRYCtbntc7n4CgkxJG0e
         X9a9tkJFYpD0ZoXcq5ZBtZ6Cb2tkUTj5EMdw0GBHG574d0P1Ln22q0UHzcwmmNiv0vRi
         xXOqw9IG+r8kxNtxmAyPdTAjb5zbkAwzTcGLpJHjz4vQ0dAYuaTy9L7fPrLJr4EZsftu
         JDUcQntZxGwkC9WLmDLfm5qbhWELiRQzMAj2K//zz+nmF6M0l2VEmlFMR0Bv8nzqY+gH
         MyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060842; x=1758665642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQMUld4u+e4WeW6bejoEvG5qUwMCp/YRRFxPQyzYnh8=;
        b=nwlwarCN6IzcLMzVq2H9y3lfoe+hJXt1kM1dJePn2kcmc5RJJEK5cxbJ3+pdIGn8TN
         zLZTWIQ/kkxDPbpmK4t6N356scPCVpRrD3joDRsCNX1Cg9zT5ncdrjrlSsS5qBjYroX8
         7WRvwwCnF1yE+i2ssA1zpp8ePZBVyHyVcgPJYgY5TXMJerxROS76dvyTD+NxRAfjrdXQ
         VEk574KJAhC/hHvP/Kt2Dn8iMsWUlP50jaQl/WoPYyBxReULTFvTSZ/XURDXJ30BUAIq
         Mknh/GXhcn5UjwhnObmGOcngsxZhexd2T8FFJ07Qu4M/3zylpoqF7WuFEoElU0DqhrYs
         dv7g==
X-Gm-Message-State: AOJu0Yw53cJ5FExFS0KhRWB38xC0HE+l5YSjSPFuBrWsnTCXQ1B1aE3p
	AnbIJg0DMePbl04KRsy8+5HLd27FhUx1rkVSmSVpqydiC1psw+59fBItXkp/8SvXHBGeC/Qmri1
	cVGw=
X-Gm-Gg: ASbGncuAb+6uwu82kxzhowZOjroisBJvf3lAeS1zMZGBZo+STZ98u7f9qSUadHHZFnN
	FrwNl9IUfbYP+1uDZldzO1IyVTagOnUrvSyoEqhOpaEOoGawZVQPC8vEN9JhMmrEJ97TGZoiwjB
	5/HElMimxhEyYZX4Ok+LgeS8bdvIzquVDxSqWKoynNg7/2HjtmupP6sJ2Xn74AV9Jst/CB4Nf6z
	98iY7XOMD8qTVMS+Q3oAkoST/b9yl1gPF07J1ktPy/WJrzDJ0YiASpw1hu9Zy+E5OFQQZnJKl9T
	s96JtqoXMQahxqAvuZa/8kYQn3QLVoysjL0uJ00uBfvZ4hzTCSo5qTx+l/BQ4xFehorD3XF3xFE
	CLFuQ2QTqn21xZ1Be9z9XdYKS6NjIn+RHtE1yyDSUtGLTU0CBEo3q1R6jowFobFmThn7/
X-Google-Smtp-Source: AGHT+IGW7cn57f1ygyww7b7WKh/wgetiJnHeAfExk6/1SlD9D8BgILc+YwfD4/6SexqTLRGG2HFd1g==
X-Received: by 2002:a05:622a:210:b0:4b5:e644:67e with SMTP id d75a77b69052e-4ba6799d534mr1289281cf.16.1758060841964;
        Tue, 16 Sep 2025 15:14:01 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-820c8bb8f46sm1010494385a.10.2025.09.16.15.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:00 -0700 (PDT)
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
Subject: [PATCH v4 14/34] lsm: rename/rework append_ordered_lsm() into lsm_order_append()
Date: Tue, 16 Sep 2025 18:03:41 -0400
Message-ID: <20250916220355.252592-50-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5153; i=paul@paul-moore.com; h=from:subject; bh=rjn2ffjd4ifcuufei25Ylxlmb0K5Nl9bGbQJG2/I+fg=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd723J2kDVo3hNuerInCeaVsrStTGdkecTqQM 8v4q4dSS6KJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMne9gAKCRDqIPLalzeJ c6C7D/0a50k/6uv74qgqHxTzifQuVENfe3axM6opzc5qGK8yDL2uFBzcaXeeehNaydXkRiSd+Hf ejMttnvwj/NaJ/vWO4Hpef19y7r1o1NS8DowAoYpzZKU9EXHJOV/HCe4J6vFuTtJfqo6kw0zf3z mB6rbjvVen5q04Vtupay94fB4suXZVBgjiRg+8uFU6BQsRhtPStOJG09/ulmD2MLv78TINx2HIx LK0u5yIAzvhxtXtXBnXMCiGXLYbzk0zLxzCmc040MXv/24Xn5Wib/Wyd1ve2VFOvqkjP1Gm7Sch PtcSbWIKEPVR2tmHmxYOgCKmmQWnnpU1HKvSaLHmu8pcQrbn9oG9w6P6CjAmQyx3hNIUjMU4y98 a+tFdzxN0vD5MzLIxZJeUA+mEB3zIQaf3tDWW/axHZj0TL/n1Vc5V2C/qTcxBsGmPS6hkuPbsP2 gYfc/FspNUKkI7pGIe/5mMJmAnfnaC8GT8bnUDY4iCM4PMgvuQJZI7ngKd8Pl1yLE7mN16V8LlT lnDiw0Kq2nxrCNrf4Z8Qw+VQcUXbPw/xcX+EZ20idSwI1nVV/t6B8oLXRrhnnjwALAtRf7hOg91 sFrAH62Ph6nOxUZ3FCT+zqlt/2l4aGbyWYzJyX7TgpErIPDclz7Fc7k5eLNoHRK7wW0dQbWJnxC f9ptOvY4uDN7poA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Rename append_ordered_lsm() to lsm_order_append() to better match
convention and do some rework.  The rework includes moving the
LSM_FLAG_EXCLUSIVE logic from lsm_prepare() to lsm_order_append()
in order to consolidate the individual LSM append/activation code,
and adding logic to skip appending explicitly disabled LSMs to the
active LSM list.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 76 +++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 33 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index ec46ddb18e1e..a314484d7c2f 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -124,24 +124,48 @@ static bool __init lsm_order_exists(struct lsm_info *lsm)
 	return false;
 }
 
-/* Append an LSM to the list of ordered LSMs to initialize. */
-static int last_lsm __initdata;
-static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
+/**
+ * lsm_order_append - Append a LSM to the ordered list
+ * @lsm: LSM definition
+ * @src: source of the addition
+ *
+ * Append @lsm to the enabled LSM array after ensuring that it hasn't been
+ * explicitly disabled, is a duplicate entry, or would run afoul of the
+ * LSM_FLAG_EXCLUSIVE logic.
+ */
+static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 {
 	/* Ignore duplicate selections. */
 	if (lsm_order_exists(lsm))
 		return;
 
-	if (WARN(last_lsm == MAX_LSM_COUNT, "%s: out of LSM static calls!?\n", from))
-		return;
+	/* Skip explicitly disabled LSMs. */
+	if (lsm->enabled && !lsm_is_enabled(lsm))
+		goto out;
 
-	/* Enable this LSM, if it is not already set. */
-	if (!lsm->enabled)
-		lsm->enabled = &lsm_enabled_true;
-	lsm_order[last_lsm] = lsm;
-	lsm_idlist[last_lsm++] = lsm->id;
+	if (WARN(lsm_active_cnt == MAX_LSM_COUNT,
+		 "%s: out of LSM static calls!?\n", src)) {
+		lsm_enabled_set(lsm, false);
+		goto out;
+	}
 
-	init_debug("%s ordered: %s (%s)\n", from, lsm->id->name,
+	if (lsm->flags & LSM_FLAG_EXCLUSIVE) {
+		if (lsm_exclusive) {
+			init_debug("exclusive disabled: %s\n", lsm->id->name);
+			lsm_enabled_set(lsm, false);
+			goto out;
+		} else {
+			init_debug("exclusive chosen:   %s\n", lsm->id->name);
+			lsm_exclusive = lsm;
+		}
+	}
+
+	lsm_enabled_set(lsm, true);
+	lsm_order[lsm_active_cnt] = lsm;
+	lsm_idlist[lsm_active_cnt++] = lsm->id;
+
+out:
+	init_debug("%s ordered: %s (%s)\n", src, lsm->id->name,
 		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
 }
 
@@ -163,26 +187,12 @@ static void __init lsm_set_blob_size(int *need, int *lbs)
  */
 static void __init lsm_prepare(struct lsm_info *lsm)
 {
-	struct lsm_blob_sizes *blobs;
+	struct lsm_blob_sizes *blobs = lsm->blobs;
 
-	if (!lsm_is_enabled(lsm)) {
-		lsm_enabled_set(lsm, false);
+	if (!blobs)
 		return;
-	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && lsm_exclusive) {
-		init_debug("exclusive disabled: %s\n", lsm->id->name);
-		lsm_enabled_set(lsm, false);
-		return;
-	}
-
-	/* Mark the LSM as enabled. */
-	lsm_enabled_set(lsm, true);
-	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !lsm_exclusive) {
-		init_debug("exclusive chosen:   %s\n", lsm->id->name);
-		lsm_exclusive = lsm;
-	}
 
 	/* Register the LSM blob sizes. */
-	blobs = lsm->blobs;
 	lsm_set_blob_size(&blobs->lbs_cred, &blob_sizes.lbs_cred);
 	lsm_set_blob_size(&blobs->lbs_file, &blob_sizes.lbs_file);
 	lsm_set_blob_size(&blobs->lbs_ib, &blob_sizes.lbs_ib);
@@ -227,7 +237,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	/* LSM_ORDER_FIRST is always first. */
 	lsm_for_each_raw(lsm) {
 		if (lsm->order == LSM_ORDER_FIRST)
-			append_ordered_lsm(lsm, "  first");
+			lsm_order_append(lsm, "  first");
 	}
 
 	/* Process "security=", if given. */
@@ -259,7 +269,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		lsm_for_each_raw(lsm) {
 			if (strcmp(lsm->id->name, name) == 0) {
 				if (lsm->order == LSM_ORDER_MUTABLE)
-					append_ordered_lsm(lsm, origin);
+					lsm_order_append(lsm, origin);
 				found = true;
 			}
 		}
@@ -275,14 +285,14 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 			if (lsm_order_exists(lsm))
 				continue;
 			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
-				append_ordered_lsm(lsm, "security=");
+				lsm_order_append(lsm, "security=");
 		}
 	}
 
 	/* LSM_ORDER_LAST is always last. */
 	lsm_for_each_raw(lsm) {
 		if (lsm->order == LSM_ORDER_LAST)
-			append_ordered_lsm(lsm, "   last");
+			lsm_order_append(lsm, "   last");
 	}
 
 	/* Disable all LSMs not in the ordered list. */
@@ -415,8 +425,8 @@ int __init early_security_init(void)
 	struct lsm_info *lsm;
 
 	lsm_early_for_each_raw(lsm) {
-		if (!lsm->enabled)
-			lsm->enabled = &lsm_enabled_true;
+		lsm_enabled_set(lsm, true);
+		lsm_order_append(lsm, "early");
 		lsm_prepare(lsm);
 		initialize_lsm(lsm);
 	}
-- 
2.51.0

