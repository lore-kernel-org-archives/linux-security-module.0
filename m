Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E907820DD75
	for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763566614; cv=none; b=Wgr7GKJ4knjlwdz6qpkiPwxoEvzwndeFy46aM5lhK69etf7jmcfZEZVZJN2EHT1Xs+fhCdZqgJQf2L9i3Cp68sAY4fFUMwr3UfIG/v19NoFRyOqGRAUWeeRKsVf1LPjE1V9dpz58/qKlhEpoljZUfcZ2yy6gYOpM+UYYgaSKOUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763566614; c=relaxed/simple;
	bh=N2xMZeEI9JjPU3/uvR9ELU7litr6QQ8ip7uuV9Vjbug=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LjPMDXIBFNKQMotBH0+s67X379r3Axbcb2D5pkO52CQ4bRZdvhJQ3RoIwkwoUhhpXHFPUcYVmwZdGEdqztXjVGGGn6AQiK5LauuGOeY2tMdha+Cr6rParsYzPQwJr/3Kp15iFwDEgyx8j0I6WlgVh1U5tpbOpm79WWfuFuh0YbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NytC/nZP; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NytC/nZP"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b220ddc189so839141785a.0
        for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 07:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763566611; x=1764171411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mLR4UfqUvV1TY2S4l3Lb/dVz8s2mFGGIh2zq8vbLpz8=;
        b=NytC/nZPiZwzWXz2JvVYvCjkC99rxXx775yLEJzW8VFQ7c53X8dttF0BCXRNjYeZIh
         eXourl+ZOgejpwaoqo+QAqydezt/wonIccbBtZs88hJefvuieOTZ9amCqhL+r9qynUg4
         nKPejpiT+YGvGZmTM7eWmklsIjUzYYTRsJ/XSfB1j1ovrPniKT4qSGZhzru7DqrpoSE7
         8GXlH/C+LFQB9CTKZSO/HL3FNRzqVx6uhhuVTPbSPFI+JQ0V0aobIwkTRBnXzUeQVFRJ
         FpsF6Ly2km5SJgCSy1wr8ocifYOmpLrNSFjhsqmpzNqY0RKV1uN09trzwbp4kzOipFZP
         /trg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763566611; x=1764171411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLR4UfqUvV1TY2S4l3Lb/dVz8s2mFGGIh2zq8vbLpz8=;
        b=l0plBIHDXIzRCDTC2+499EfjmKmZFaN7If1FlVjR/bJiaM3dDKH/f3z25vsjgzFvQX
         DqN/iPi/jjObEqSzlIMbDDllX/X3XQ4lhhUgOlanDreUx6W1JhkQRDOMAY53qA2fBpsL
         WN+ShZkMundAMTctkG2PXCKI5jV2Jsh046+UIILpFr2vWfobwEGUGwFYvwPCZnjBdQqa
         ziwTkqfhQtTdc5GNpwROjhMolsRqThDaOyubVSsKj9MlZXm7oA9nKaQy9NYnYOcuYYYB
         6HIBGRaHZMPnm6pjtFvGH5tAjX42iHZ9ERxAatDAinQhsxtqc4E9icxS4oofI4TjEzgY
         7jYg==
X-Gm-Message-State: AOJu0Ywnufu4vE90qoS6BRU/W04mGX+33t8Hg/Bo66RQGnWOvQvFhfko
	MRgry7sLrInm98nhBfASGxpRjfvEcJCchKuGElpwG1dl0o90xk31YVMYgP58QliK/L9/OoByVEg
	85IA=
X-Gm-Gg: ASbGncvUg+tS9JbaQhfjxCnXero55FMGA2qSF8jZf8TPqO9C6E2AkE+e9T+zF3Pt3vo
	njIW+qRLRRVH2B/UHKvSIb4suj4iioD4Q6A28uxplUil0w7IbY+Z2EEEWDTyHvKqjlHlHw6Y2gr
	VVi5qLbz1AUmyY/kn/cqVMELg17MtvpsGDR/gqojpwMK9rF6aOIjSoGbc7dYP47EgfZpXENPUPa
	J33K9EJSL5ASnyv6dw0Mya7Yi4UH9o/D/tOsHN+qzEk2qFNHRw/YlIG1zcCZzKxwMTjOMpCJ4mE
	IdnOizClNsNsFw2cxZ+NGS2qwbyxjrOnxMHNRXW8dHtX0JlkEQQfYrCLfZZHLNxShzG9CPytblh
	bf9Ft/H3JTPX0/SRt1oKCFuvrnTtc0p64aviXzkB/1Okm4jYBwgoY22m8tqw13ybh9GdgguPVIf
	621NUsR3tOEULWi4sWLZExoGMR450dJ6pMd6MpPGhcDVX4T4h433+W0a/6
X-Google-Smtp-Source: AGHT+IEblDMzniqLjUHwMLprOJbPQ7pWRken9lEdMpvGAacJsfKzsLZymb3iYcHGkKmp3cQpIy7PDQ==
X-Received: by 2002:a05:620a:298a:b0:8b2:efb6:5d07 with SMTP id af79cd13be357-8b2efb660femr1332286385a.48.1763566611402;
        Wed, 19 Nov 2025 07:36:51 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aee9e519sm1456951985a.5.2025.11.19.07.36.50
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:36:50 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org
Subject: [PATCH v2] lsm: use unrcu_pointer() for current->cred in security_init()
Date: Wed, 19 Nov 2025 10:36:37 -0500
Message-ID: <20251119153636.15243-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1075; i=paul@paul-moore.com; h=from:subject; bh=N2xMZeEI9JjPU3/uvR9ELU7litr6QQ8ip7uuV9Vjbug=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBpHeQE4u5DvSvDIuCUo8s4GWBo/4g/VYb6ir8Ih WV73HFZl6WJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaR3kBAAKCRDqIPLalzeJ c8UTD/9Yf9J6+AjczXeqVq6KI9u5NqfvNYWnI12LRkcKPSSdtApAnDzkqW3NQXp3xBA7BGFuApR 9rJLQyyR5DBRS5oROX3XKeDd85rGynGlVwHy2yDxAxsES4JnPLcpSU4Wv6EbhBCsDGCxo3JTIja XJ+K8WN2yjJHmJd5Qa6t78A+QrMtdRAlbS8TUCFSgtQGGYufOavguaXfFDdbAXOulEcmlTwISVG t8gHrXe87s08TczqDa5n56Ym4ZIPq8iDLVo6eaa+aSjz+zK1XtSWVOzx/bmdyZUvpqC2OxoNJ2C lnxQg7CIYrzVOQWuJ5BIJWNibc9b1FDa41RkudXEkEdEqj+QmugFV1ZGwNFny4JWmM1nBBceTQh 6ptRTYLxKtRYX9hnr8YVYy8FwWGeMNxLPE2EzDFBYd4+CYS7wBB18tj1hveGLnfHBffS5qrKd24 fJQAvfnZqRQWD0Vcxvr48Txh0kTA9AaG+yfeFaMP5sy/bXVqwDHTwEHqer5PZX3sFkpGq2mTd02 nmd2nwFE70eI6yEVGu5xnVg4Hc5BPOylt1NYJfNLehmJIDigagiVa7DdJkwR09sp5lZ8YXBTU3o HrctBnj1GsVeAMppgT8pkvLZjLuEPBss99pAzv9tasN5BYZNePR5afV9l8TL4z2SZ6y/AKjqLKV OCd11l63006TLBg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

We need to directly allocate the cred's LSM state for the initial task
when we initialize the LSM framework.  Unfortunately, this results in a
RCU related type mismatch, use the unrcu_pointer() macro to handle this
a bit more elegantly.

The explicit type casting still remains as we need to work around the
constification of current->cred in this particular case.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 6bb67d41ce52..05bd52e6b1f2 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -467,7 +467,8 @@ int __init security_init(void)
 						    blob_sizes.lbs_inode, 0,
 						    SLAB_PANIC, NULL);
 
-	if (lsm_cred_alloc((struct cred __rcu *)current->cred, GFP_KERNEL))
+	if (lsm_cred_alloc((struct cred *)unrcu_pointer(current->cred),
+			   GFP_KERNEL))
 		panic("early LSM cred alloc failed\n");
 	if (lsm_task_alloc(current))
 		panic("early LSM task alloc failed\n");
-- 
2.52.0

