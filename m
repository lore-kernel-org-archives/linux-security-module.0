Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88C534EF07
	for <linux-security-module@vger.kernel.org>; Thu, 11 Jun 2026 07:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161372; cv=none; b=VNfcW13AK5bHccyhYf6ne9jV9oq8yftU47ApfMeBRUcrJbtjWTg+x0EEU/voXwcZiNfTuLjZDt18FEzwwibIQPq7KiZMSF+a01xgirUcBnmXKoKj6tA2eJE7gvpZh8RDUXOLMb7PQ8L/UZW4kUJeFGz6e/C9GHn1a9TjU3IEROo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161372; c=relaxed/simple;
	bh=yiDYo3uXjyQYEP8qg92do+PKxEnqD4etbAOSczuXrvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MGKUvNTEAlEIIJQ/1f7wjgkwqWSpTNFhOcvzNm75q7FSO0U2NwbtkupCqTvOWmhmiBUdEhS5Vr2C9KavvRBhybttIX9V2y1p8EzyA65lbBgPZJOpLgp0V8jH8taTrHbVTRcFtDhSA5D9a5L2pEGbtg7J/0eMOadh+FDQZgOxyQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GccVdRT+; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GccVdRT+"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45fd464d51fso4168598f8f.3
        for <linux-security-module@vger.kernel.org>; Thu, 11 Jun 2026 00:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781161369; x=1781766169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ktJHYJQkk8yoVHrYe038VfAc/S/hFzjEvTGu3j4TfPs=;
        b=GccVdRT+kCgaCnYjV/i/sQPp+svexE3XaAS7FYOA+n0Tgn73UnvEPY9wqGxyy19Hkt
         Mc6ITjeHBvXV4f5k034xzaNyuN/JMycnQmRtLNqVhUBsabMi0stma0BYkChK9RsfHFfj
         C209z5u3/BNhyV6JBQo/rQhc9SglenhM9HIldtjtR196E7pp9Ip0jJ89JW2H7CA+YvHf
         04ktPE3D0acu5YGIUf1C3cnrplirpQBH0w/ehcyvj2If0VS5X492N9j82hKZwDWP9cdM
         Zg0roPbvmduY0UygJcJkiO1Yhrs7/vMZET2io0O8dbQvGy9lSD0nHGd6Hag+qkQzVz1M
         d+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781161369; x=1781766169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktJHYJQkk8yoVHrYe038VfAc/S/hFzjEvTGu3j4TfPs=;
        b=exfyKtS2YEEedvtIY0kChAIHHzVOQOWbUQ2ADZ/LvirLSod7FLH3oYPe3EpL84moFu
         TF5jrcvjqKfUtCNT90gjLeXVcNuj+Y1AhGNKEg5O0P00mnOH8ne0piQVmTdOsZLpKQLz
         8jF4asnrpwjwywVaPwnTgm0OAv+sUQGkGZMwZ36DBlW3lxal01Nr8fuGKeto4qTdU2M/
         opjcJxVhnbDiXGUGyBMYKN3b9GyFiYU+HJ/0jG1489UA28Moh7lGYtdIABgXp3EHYAlA
         ID7fU/8jdBVRw4IUHGFP/23rkkmS90WgmPvAqCmKwEkFUcoPRjjx7nw2c9Heel2xSjUA
         6AmQ==
X-Forwarded-Encrypted: i=1; AFNElJ88kpd+mXKXHBbwt94Bl7YPfdhZn/WXnca4x73qNA4uj/sZKjwYw0GCuBpq6T+OacpCIP1YsVhHxuvtxYexYsKbufaMxDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTPZkhPsrWFEqa48XzPlPDMB7ht32a5qL0uCQjo5+ZyNnawJGH
	WzOAvHL1u4iCux+4/82DrvI03Kred0hGA2WZvFnDhq2eouY+Q5+kiuukNuSTQOnnJw==
X-Gm-Gg: Acq92OFJb4+/taJDwI6mfsGXmthX2kKZ5EcEhTi5GmiNxy1wOsjdu3bMVJEOvbnQd+p
	xbIxw6avbnlN/EaibaCWlfZHGL/ztJQe6flD4+VIN07m7xcRoY/n5/Y6edu84Lvc5MJXAm/Rpjc
	cSVcrO1GCD/8jh2mo9ShBm8uHLEa0cm7TccbGWTkb4gnMzGyHkJDfdwk3J18jbqy0gNj8dDig92
	EFLtw4musjxiYqIdY1Xd33tX3GtsO8a4zno9FLIkTZ8EpasA0GBo3pGwpt7aErKmSJTme2+V7eh
	HdzjxZYXdUyOIUvaDE8Xdm+fZAVwjAEgWXlP9x+c2aITwJ9OaeLtrytNALSkKJPu+qUNDtEq+rL
	j9pK+o/kRO1S0d8kiJwgNwXY2/f1qlVutRvLPX5gTeW3Fuv/VebA5coxjL/b+Umx+s1Do4zuBLk
	2f9iYM3gZxYeDsVI9BKuCuXylaBXCHpVopnjWTzB/vYAWlskYRSdc7UADMv8bH7XtMG4cbDaObT
	F9eCbYjAgmT21RWObc61AvdK+EfkHlTEG6eP2kl
X-Received: by 2002:a05:6000:1842:b0:45e:f3b1:52d1 with SMTP id ffacd0b85a97d-46067576bfemr1862316f8f.9.1781161261836;
        Thu, 11 Jun 2026 00:01:01 -0700 (PDT)
Received: from hp-ubuntu.. ([41.249.138.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f5612sm76550344f8f.15.2026.06.11.00.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:01:01 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <serge@hallyn.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: [PATCH v2] cred: prevent slab cache merging for cred_jar
Date: Thu, 11 Jun 2026 08:00:54 +0100
Message-ID: <20260611070054.6550-1-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SLAB_NO_MERGE to cred_jar to ensure struct cred objects get
dedicated slab pages, preventing the allocator from merging this
cache with other similarly-sized caches. This is a hardening measure
to provide type isolation for credential objects.

Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---

Changes in v2:
  - Collected Reviewed-by tag from Kees Cook.
  - No code changes from v1.

 kernel/cred.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index 9676965c0981..0e4ee60a5acd 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -557,7 +557,7 @@ void __init cred_init(void)
 {
 	/* allocate a slab in which we can store credentials */
 	cred_jar = KMEM_CACHE(cred,
-			      SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
+			      SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT | SLAB_NO_MERGE);
 }
 
 /**
-- 
2.43.0

