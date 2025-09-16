Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EDD2E1C7E
	for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060831; cv=none; b=rE43T3VS8hpBT95u0OcAqC9xbvux5YgDxkvMcpG5agOqY1Gmw0hreKYe0d4nt7nKxqVRfY0rj4anosk6e/LON2RaHHbQh3zzTilgKpvmC0goH/Q7jT0Vo9RBhNljAlp3V9pmjJ1cLu2C/ZO1WuVpRy6b9GLy6nM/OeM4CPFVMo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060831; c=relaxed/simple;
	bh=TzxbWMzJ8IVnloDxfDvAgfdeVprPOL6CVtEZr+w26Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdD/xh/OV7HQ5JYsevXKbV5r4unPrIf1xqvm04PaautjaQBYhdyfjgWLPTJbq+RZuWTHc8NPajFhBsmK1WhY77v5ZNLtYuRcYO5hH7ghz8o3zmKeQXrFYOp+9S4noW9LV6JcSV7IvmC4wLatHZjQDhu7a1Otgui+tQlWkiy2BqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EcuVuFsR; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EcuVuFsR"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-811ab6189cfso570754285a.2
        for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 15:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060828; x=1758665628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7VijEH6O1uxeyoPa4WBGEvDZafel6Lc9vEdN1yelH4=;
        b=EcuVuFsRCUuhX+fG1sRkERvA8f3ftl3WmzmmxtJQ8ymDpjjzX2a1JICwSfrDBM/iKk
         wLjMEjlcnS7guNuxzfQA91C4g1KcvA3eq/Jvk7TypFiAmBKbXDuSqG+8e0Q1qx1igV7y
         7tmkngYFGCLtp5fLnMojlYKlNflpVH3omwqPNjBenpq5UrUwKFPhv/kHmSeCkjFOJIZJ
         ngXUuHSIPKKtTIJfSboJtetRAh+B8jQWYZp20RmiAch2VSU6nYwMqyCaIIHji0X6isZr
         89BIDnyDHOzhp0i2lVGgvLabCRmA5vNrVklwxd6Q6MzjWygAxihClORlilwGlYY1tqoR
         Q9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060828; x=1758665628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7VijEH6O1uxeyoPa4WBGEvDZafel6Lc9vEdN1yelH4=;
        b=Gufq4p+c90Vx7pjwIsCMx8n5K1nuJXMBrFbiNwj3qf2rCvNRsGTJ95As/bLCqTdae2
         QKz78rr5JabgQ/2fDte8hEpWKevw4ele3fvckCI9WR5j0sNRBKbtDSjdSQ1ZlscpvRQ0
         reKCvfZKBohR3tFzbM+PzzLOmpAB/LluLBGPvLTLDgRKfn+Bb4nrlZ4rTx5bcMQXkD6o
         rlHyzcYu2FL4A1aghlMfnj9SmADZesNUAfPh0/r4bDu63SIt1Wdi5ujlO7i12h8YUJOk
         GIfBqcyA0tI2m7aGSBUD06/LNQZhvMc0WXRb/+NdiPP9U1EWECzK1T7OqWVcGU5sDIMO
         iWcA==
X-Gm-Message-State: AOJu0YzurIFZkGTbSUa6mrTzw9RIDWsHRKkqx//vuypec/VxVfr+KIMe
	jGdGgEXtfjQBXrMcLLV9F9G37PeAmj0jWE2RAVROd15/LuRuU7U8ujd6GOw7TyRAUuj3+G3XxMf
	fs94=
X-Gm-Gg: ASbGnctjImp7P8XctFQLzue7EuT8+vg77i1zw0WjEMLzZs6RP7y2n/nY4seKjehsLIS
	JjFGuvgwj7WkIYa5iOgcCDoqK28Ye03rI83qSMdlOUvrEjC6PUv5hD1jwPJd5N3QlpYSStALI9H
	Vs5/LG7J/Bnp+RrsBtdePej3F47XENsBfQmYNCtEnybZ+un83lrOGcL0iB0UfonW5PlA/rIRvDD
	+p6cgnGoWSSWZGqVD4ZJl4V1f1z77aJtNP0+xSdAtp9oJpJYX/u/4j2i0tC0DFddL2fvXMkUJ2y
	3sfKemEgViDO4R5DpbP6fny99OpmI9lcWOtawfKyYsTAXYolmjHPlJJMcBPoVV70shbAKIn+U3w
	q+sG0i/XcVGho9tGvEK/uwonQUZHuWyMWKx6c5zFrMDzpeQtXdlRqu+IFIDuME642fIIA
X-Google-Smtp-Source: AGHT+IE+KYVDJBdEEU6ufIjx3bAoiUKh87hE/SGF39FCtnyEaxhgkXDDoJgJDZaFv9qN9kKYkTO/yw==
X-Received: by 2002:a05:620a:574c:b0:7e8:324e:c7e8 with SMTP id af79cd13be357-823ffcb1bdamr1939521985a.44.1758060827712;
        Tue, 16 Sep 2025 15:13:47 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-82885187d80sm603851185a.8.2025.09.16.15.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:13:46 -0700 (PDT)
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
Subject: [PATCH v4 07/34] lsm: rename ordered_lsm_init() to lsm_init_ordered()
Date: Tue, 16 Sep 2025 18:03:34 -0400
Message-ID: <20250916220355.252592-43-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1468; i=paul@paul-moore.com; h=from:subject; bh=TzxbWMzJ8IVnloDxfDvAgfdeVprPOL6CVtEZr+w26Kg=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd7fyeTtos1GrS53QdVxFHpsUK2UGPsfVutsH iFky9eq/CyJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMne3wAKCRDqIPLalzeJ c6YiEACXRaXzB0N/1Q1WbTE/ZgV4y5FgHVjNCK49/I89+/nEVvK8ssrXC836U8a94gG+OXsPi4v jSpGT80Q4nQUAQGxU8Fh0PKpwORYLEJLqvVyjaHHBss6/F1KEvnBAegIbc5olPDXzXYRAMP+ztk WVURGr2xRpftEhpN7799yIH8B2vrsMOg/03DdIb3ZUZFX0G5c/FGiwQKHM3FT1Gx8zQPeY0Xp4F JOXFOO9qZTAe8vpD3WGc1e6s5rS28nxAWL1yUet059b/agLqVJvhVSso8srMEI5TKl1eMrx3mmn uD5hJrujUAXQreCDVuNBTKTEDc3womP+EBT/kHMVJD5kFlcVAkWY1WJgj6HRPzfn/zIL9lOGTmf /6AoHPYt27c1YlOjXrRfcAehjsL3FvNODWQ91V6EGP13s42qwmWwYkrFtnuZDhcpmYNG/jd5r50 SGVBQ8w42iQcf1t9mNMCCujE7RlqFpiX7dXhTFsarfYetd2ZQuEOBEb+GbLKfCvT+Qs1v5E34n/ jvWHE86U44UsjmGGbrzzbFzxpLFTdzDES7GR+syWjquHC1F2pt9GlJ0BDJZuZ0bkZZEf7Evf4BD wKrtM1jNO9PEeKC/EwVJC2vPO8siqrsZ9Tx5xeherFUY6so7iHdqZ243eO9korFbJa4DTbwWOMe 2LoS4IlcdxaHMQw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The new name more closely fits the rest of the naming scheme in
security/lsm_init.c.  This patch also adds a trivial comment block to
the top of the function.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index a8b82329c76a..4a108b03c23d 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -291,7 +291,10 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	kfree(sep);
 }
 
-static void __init ordered_lsm_init(void)
+/**
+ * lsm_init_ordered - Initialize the ordered LSMs
+ */
+static void __init lsm_init_ordered(void)
 {
 	unsigned int first = 0;
 	struct lsm_info **lsm;
@@ -342,9 +345,6 @@ static void __init ordered_lsm_init(void)
 	init_debug("bpf prog blob size   = %d\n", blob_sizes.lbs_bpf_prog);
 	init_debug("bpf token blob size  = %d\n", blob_sizes.lbs_bpf_token);
 
-	/*
-	 * Create any kmem_caches needed for blobs
-	 */
 	if (blob_sizes.lbs_file)
 		lsm_file_cache = kmem_cache_create("lsm_file_cache",
 						   blob_sizes.lbs_file, 0,
@@ -498,7 +498,7 @@ int __init security_init(void)
 	}
 
 	/* Load LSMs in specified order. */
-	ordered_lsm_init();
+	lsm_init_ordered();
 
 	return 0;
 }
-- 
2.51.0

