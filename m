Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0424E2F44
	for <linux-security-module@vger.kernel.org>; Thu, 14 Mar 2024 02:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710382932; cv=none; b=dx/NVmo3L041q6lyCpaCyxA6TImOLI9DbzUWEL0MHjAswzycgPkaAwAcer/LApVIMj0gned/FcNz7a7sWc57SjFCUmadplzuGxGuoGXKAMt+8Q3JQUvqfBa90ZtOgsZgZeltxEJFcqC/QjRCXI1zZYF7JrzrsCbIx3LA+ShxXjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710382932; c=relaxed/simple;
	bh=gzYLYBCSdybiT9TODRS3cYfNT5J5X5hBJJVe866BgtI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NrIPYBvB7Xzfu6blF+w/hHcO3IBpUgzly9mgAl2kZ/7nWZme4UULwCiQbbQqzzrbclE5lXXUidgdM1SDD6OZJ2qXBud+Bqwt9iAifM1dLe7Fc5HRfyAB9iPhtB991Ou/v3T7Y60s95bs0AT7mw9g2ULSSlKEp+l517R5BBJzTz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=C3klgbhZ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="C3klgbhZ"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42a35c720b8so1658311cf.3
        for <linux-security-module@vger.kernel.org>; Wed, 13 Mar 2024 19:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710382930; x=1710987730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=23zcR8XhqYMzCd9qbNO7+cFgnDadD2jo5A7YbVvILRc=;
        b=C3klgbhZXQFAVxMJ5UeoKVMReVDZkyZ93qx2DfolI5iYwU24IGwZYmM2ausHKPE4sD
         4KNbl9i070a22P+YR7wnd2ynC/C+rDL26ldN1OcTuanjusEBf/n3LMcRHXocySb+NnHS
         C0ttNjWN7Lbs9ZdkggPF3tJ7gWfKRvIRqdGdaK7FIv2CdHHE2Dzpaz9NshUTFX6Pqrk6
         CDdPvVHnddY9a1uId+CmUsPzBKfj1vUn0Ps+ucU0cV9NhBdtl1heH4s8hORBCjK3bT0I
         QvcXf3e+4eNcyLH9GW+wD4aoYXQIXM/BoWtfPS4Cr1t7ZHvc8v0jyHjnDzyyJmclLm7E
         WB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710382930; x=1710987730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23zcR8XhqYMzCd9qbNO7+cFgnDadD2jo5A7YbVvILRc=;
        b=vH/E4MF/mwwUzgKfwCbyUUaKEAQH4N7dFpZvunaAGIwp40WXw/TyrB7UQIZifXKpc5
         2DpL5j05qpGaJanxS+O3x9El+te6Mon2QOQtSHhUFUgnSM6IKkgF0VTMWPaub+IrFxkm
         gBa0MmP2ue5ctZK/R5diBJstCaG2bg7ep897TI+3B4NnsGK9gE4gGvgmqJecI1HgOlYM
         9mO0CMOuY2Co9A3JxZnnxUeIAK1rDd433JiaIRW21o5x0sh4+unzMTbN1IqBceUD2ehh
         ayPk4CsIzlRgoc1Assqb9IdhR5PFZyW4ctJeoBpAu0Zuw3Iy3TynStvCHr5+97QFEuMO
         kcyQ==
X-Gm-Message-State: AOJu0YzoyyKmqOES6CYXgv3hDptSPobuEs99cvYhdgC2OlUrlF4HlvRY
	/GXrZf7eUI2axl9+c18HHoA7UiT5a6Sdt8A5xQxaHsO8bg2C9aT8IMxbGBYK1p6oHtMxLJEj4n8
	=
X-Google-Smtp-Source: AGHT+IEddyP0yAEsfZDkLwIUmNbWsdA0yFbr0hY+iNxxr3h9yfYI8bYKFk1NCHovPgL0z9uPJxIwYA==
X-Received: by 2002:a05:622a:20b:b0:42f:30ec:aa36 with SMTP id b11-20020a05622a020b00b0042f30ecaa36mr513268qtx.45.1710382929775;
        Wed, 13 Mar 2024 19:22:09 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id g15-20020ac8774f000000b0042ed9576bcesm206141qtu.11.2024.03.13.19.22.09
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 19:22:09 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org
Subject: [PATCH] lsm: handle the NULL buffer case in lsm_fill_user_ctx()
Date: Wed, 13 Mar 2024 22:22:03 -0400
Message-ID: <20240314022202.599471-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744; i=paul@paul-moore.com; h=from:subject; bh=gzYLYBCSdybiT9TODRS3cYfNT5J5X5hBJJVe866BgtI=; b=kA0DAAgB6iDy2pc3iXMByyZiAGXyX0rI7fOi4Xjup8azpTeJFQqrURDy/918enT1V1KDsSphL okCMwQAAQgAHRYhBEtCqM8H8pnVVJd+7+og8tqXN4lzBQJl8l9KAAoJEOog8tqXN4lzgAUP/1li OsqplmKKhbRpGwE7cUqlp3tEhxaQGOjHD/A7EFkj1LvRS4f0KVagq2DEVKqlcS+rT14oUpbyFJE yHlaXCUzbmQ+kp2/U/jYxIC4zmRHfNSDOdkQOkaDxrObo4i6x56e2j9jyJJmgY+9tVOmK0boiQ5 3YMJ36Smpw+9uleL1FnnAA4Y60ze3r/VZcre5GW7VAG9S3yHfLii9B0mZtIzWNWI8n8nyp2dUCz fa1fGTv17fzyFEgiADUr33zxZdAgjJ2fK1FZbvaO1JGp74z5MeGS7t0OFuzVmtEAjgLltKJzOzl 5zAAWoCXuea/3C6D+cnXtZ5nHyuKta2IV8YZoeBooYNnihXtGXxkAkXqINnkJGfl6xcRK6YPGz9 +hyj7x/SEGx0gA6PNLc72InNuSdWHRGlOYcvY3jRpIAhBrupqBodDYM9hKqlR9+uanPRfSeC8MZ 7qhkOEeFKMZkiedMOvbT95srvW04KD0Ux2zMkQwm4BwBhD+p97vwR/m4qQjFd3rNEiHeqpWhbtW ANd6emK87VH5wdKWrvxNH9cQCcPIjPrcACyUuQGyNicr8/fDTOYqBtYxIWvp6rEUE3CT0Rhn4sc nQpaVUJ6GNZN++g/IyQfyGwonYStD3N0FodN64dYqzFSRkE3kAR/h7Ukh+pden9gnYx3RB/yDM/ 0WCAJ
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Passing a NULL buffer into the lsm_get_self_attr() syscall is a valid
way to quickly determine the minimum size of the buffer needed to for
the syscall to return all of the LSM attributes to the caller.
Unfortunately we/I broke that behavior in commit d7cf3412a9f6
("lsm: consolidate buffer size handling into lsm_fill_user_ctx()")
such that it returned an error to the caller; this patch restores the
original desired behavior of using the NULL buffer as a quick way to
correctly size the attribute buffer.

Cc: stable@vger.kernel.org
Fixes: d7cf3412a9f6 ("lsm: consolidate buffer size handling into lsm_fill_user_ctx()")
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/security.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 5b2e0a15377d..7e118858b545 100644
--- a/security/security.c
+++ b/security/security.c
@@ -780,7 +780,9 @@ static int lsm_superblock_alloc(struct super_block *sb)
  * @id: LSM id
  * @flags: LSM defined flags
  *
- * Fill all of the fields in a userspace lsm_ctx structure.
+ * Fill all of the fields in a userspace lsm_ctx structure.  If @uctx is NULL
+ * simply calculate the required size to output via @utc_len and return
+ * success.
  *
  * Returns 0 on success, -E2BIG if userspace buffer is not large enough,
  * -EFAULT on a copyout error, -ENOMEM if memory can't be allocated.
@@ -799,6 +801,10 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
 		goto out;
 	}
 
+	/* no buffer - return success/0 and set @uctx_len to the req size */
+	if (!uctx)
+		goto out;
+
 	nctx = kzalloc(nctx_len, GFP_KERNEL);
 	if (nctx == NULL) {
 		rc = -ENOMEM;
-- 
2.44.0

