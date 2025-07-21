Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046EA246BC6
	for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 23:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140249; cv=none; b=tZOSUerKAGMOY8z4YAbFRvmkCJ5qkvKWdyrNgKvGw2aDFRBr+U6eBaBbYbvtYBtGRG2dH0o4vqsTO45FP2J3audSfPd28pJavauvrEil3nml3/Q+fpRN5X5XMgrwVDHsxCfyussei51fni/A4amXqxvTuk3Kt+x+PFxKUc8CmQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140249; c=relaxed/simple;
	bh=VkDqekEGooACbobTsF+ofijOUXBUL1lObHTgsHIPDUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjChJYABW+zG0eU1THwCHN0fEsH8u3HEGjMKN6xfxsfd/eUG9NfeXX8EBLLVYAu2a7nfDUfjzLuGhZL07x+EPQUOE+/pTVFFO1c5HO1W+RLCujEBEFNJP1j7+TWxkaXKlb2l/ZtXGnBQjeyAm5gkvtoBsJ5qK8zaGw972QwYNSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CkgifJh5; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CkgifJh5"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fd0a7d3949so66144136d6.0
        for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 16:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140247; x=1753745047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uy5IJRaBCCHH5fmqqMmAku9Mm3gK87SrjLXhFK18rJM=;
        b=CkgifJh5HGUyywy0ZakvW+M0Z11fhpnjyy15Ei69onb+IRZV2EIOGFh6ZyWmHpDzZL
         tlf3K0iQq1Q8/KE6otGgA35YBbl3AHxGTnOYapZPY3IWh5BjkYLdC23ymic6AAaFn8pU
         /j18OEFTjVXeCtNO7z1kKc9TP5PnMNU8dQI7tgNo+liU+V2ZtnVXi2jamt9lEJcUROr+
         /RJQp74kz+zPBoBQrpuYTorxjnR0WD7WJuHytclBX+6ClnbByBBsIF1929zT4gxOOyDV
         ko8y+K91E3OajKUGpVHQK3Y+lkr/M+6LtvnU2g9aa6I6YFiLJzAkIwd+/h41F0O4u1QB
         XWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140247; x=1753745047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uy5IJRaBCCHH5fmqqMmAku9Mm3gK87SrjLXhFK18rJM=;
        b=A3KHw5kgN6V5+hVacO3Wb0iLfARbPkxX59s1K1/YX8CHuXpfxzALyF15mcjYq9zVyA
         fsiFr5xQxj6bFRf/BSg4J3KGCdj8Wn2t/rCwsAsh+G2JtWTPTtwQomyqACsvmcJDdmR3
         QuPYkk0q7EyftV1K0QQEUadqeOuGQ3dYRKZ7N6HPE3THAEJHP4iKH2pPhSeePVo+NLWS
         TKNkIo1r8FA5pdZc9E88pQVk1K7RVVXhCaYM3GxDUI/dZsmPKsT00GyskvcF49W5u01h
         2xVkB+teYh5H+j7dzPR7yznVWveiZvokojT0e6uoOPCy6owz2P1OEBBQyrFwhszLOCW9
         p26g==
X-Gm-Message-State: AOJu0YxUc9jltEeohI5xXzZX++bVetdoC3KYLMdtL5VEx3Gljs3DovjB
	P1mWPi/isUkhJmt7qdNJXpZJCU62IfVB7R3grN+SXCapV8/qsDkZ5aTN9oO9wiXKXNvBBHTDbg2
	ueD0=
X-Gm-Gg: ASbGncsJb84QrNtEoT00mX186VhvED/jYMQCdX01r+wIu9MEDA4FNg+F+n5LYyOQnPC
	yjmteH0GtQwkz1tEZtVic+ausWQ+cWbMp5fi5oMh6w1Gi7KNoQ2UUG5TL+Pb1MFvfDaDCrsmpVD
	FCa8G5wxN4al/hdJ+MvMsq0Yyk+DELHS0/TMMbTmUqDQu286ucbpuzCq/qGV0Qz5M1ul+EJD37C
	gwd81dVtjZaNSOEgqGAG1RYUm0/YY9m/d8BT2va1bdIWbIk2HEOn2JwlZWWrxZaJ5TlnNLD367Y
	fUgFV1tUkKxZECNogxVopDjbvHq5+WQereM1v/Qd+ZpzUPlUPjnB7ICR7cyBQMoIRoGZuVzi2ig
	eZLQtpqXTlbLJfKWCLedc8TCBnRp0AkLVH8Ndo3zE673/oeaJQjVGpmINRnpvaeJaSRc=
X-Google-Smtp-Source: AGHT+IEnICSUlfqJ3cELZ4P+O3voqpvhoWJ3CPj++sIhYNyBXHwTOyWdS/DJdQh1lgzBLivqZUv5lQ==
X-Received: by 2002:a05:6214:3bc2:b0:704:f952:1881 with SMTP id 6a1803df08f44-7051a1955femr214146526d6.46.1753140246830;
        Mon, 21 Jul 2025 16:24:06 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7051b9196e7sm45357886d6.48.2025.07.21.16.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:06 -0700 (PDT)
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
Subject: [RFC PATCH v2 07/34] lsm: rename ordered_lsm_init() to lsm_init_ordered()
Date: Mon, 21 Jul 2025 19:21:10 -0400
Message-ID: <20250721232142.77224-43-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352; i=paul@paul-moore.com; h=from:subject; bh=VkDqekEGooACbobTsF+ofijOUXBUL1lObHTgsHIPDUQ=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsuizBpilSTgtAAg2jEdeFOazNsypDwk13CHZ YdeCuv4DUSJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LogAKCRDqIPLalzeJ c1ROD/4xhNOREvykj2e3Vy4j6gClYsRDPmXq1eFmZ7Gs2VmiSVu9To6+Ynlneal5RwPaXkbibCH 1J4t9v6WtgLjXqIolWsdzyw4XNfTvKAUtfhebmLokZoZTfpRvLTOwfKH4LCzcjg0FoppAeCZFTZ r7o1QSPbwR7V8NFNG2fW+osxicyi/eRZkcsSLNLU7MgjEVap+SYZVrdhJVw2KvgWoPsk2qlUTDi 4pL8jaK1MIoyERvxaWWH5HyoEMBsZbOnL+637YjkTroMXVT3KkmFVjfAyANoZEOYZti/SiUrjgB Ly31I1bTb8S2lu+FPDKtEKQmFqmRZkB+gcZl35HAsYSJOT/D3vUgFJqnQbKV9N1w+rhwxszzm40 h8rPJUJUHQZjptwMluPJnB9cU0k5P4reRsiv3KvYC5Lb9xn1qTdqd1oi2tZ87Khl3RBuFEZSbkS qgznvHQCKHp92Avl2ZLmzIwS/9bg6s5jjC8ajF1wN2tjfdZuhKbsCSNBOEPthwQmygO1KFB6NWp tQV8H/yp0HSaQQrNlr6Y00ZggE8tT+uXHtEGXOzpSL6pQg+5s7KFJZT7JchIvLmlolf8ZrgSTxD ZbXaMjMLySO77HUtIM6b9BRbUiFsvjtHhDKIMDY5FlevaJC7Hoqn1l79JUvwF4LtyF2WEjAp1PB ZNWWRBB+bm5Q3sg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The new name more closely fits the rest of the naming scheme in
security/lsm_init.c.  This patch also adds a trivial comment block to
the top of the function.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 7e736c20458a..c8af26a6ce14 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -288,7 +288,10 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
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
@@ -336,9 +339,6 @@ static void __init ordered_lsm_init(void)
 	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
 	init_debug("bdev blob size       = %d\n", blob_sizes.lbs_bdev);
 
-	/*
-	 * Create any kmem_caches needed for blobs
-	 */
 	if (blob_sizes.lbs_file)
 		lsm_file_cache = kmem_cache_create("lsm_file_cache",
 						   blob_sizes.lbs_file, 0,
@@ -492,7 +492,7 @@ int __init security_init(void)
 	}
 
 	/* Load LSMs in specified order. */
-	ordered_lsm_init();
+	lsm_init_ordered();
 
 	return 0;
 }
-- 
2.50.1

