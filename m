Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5D82FF148
	for <linux-security-module@vger.kernel.org>; Sun, 25 Jan 2026 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769371145; cv=none; b=HHRIe9g/FByNwH0oz+L6pgcnKotOwaCyEoJG14eJWfPOKsvKLh+ZL2XweRuGRsA183+BTaJEF7oY1xd+BeHAI+RJba9dfqIoq2DGxM9FsPBP4k2W9lnnyagr+XbC9EqCa0OJN060vSCeldj16+7ylQSoF5MZG7cVFEsu64MbmbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769371145; c=relaxed/simple;
	bh=KUsmezd0HNjZM4SXzc4WY0/IK0Zw9you1m4ax8QYZz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WdYP2jgP1GT259qUmKFnFgdffd2yhFjXxxk+J3p1mS+8IVo8mWuOkgXU4AmlzyYT15URrJ9g2/fhR1zl5ARNHAJX1Y06X2q4LojnGfWfVJO6IcpXLH54Sgxr8livQtyHfHnT2zdfG2fWiBNr7KDVq6CQRooYHUCB3QvGVojhYR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X17PzxXa; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X17PzxXa"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-432755545fcso2764246f8f.1
        for <linux-security-module@vger.kernel.org>; Sun, 25 Jan 2026 11:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769371142; x=1769975942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v81aGgnmujoR7ZjyMQcCM6v+ilk6241fTV6D8s9LU7A=;
        b=X17PzxXaRPL4CnYIFekXsgVK/IKlIDwvkxYnOpUpkTZb1QHoOvyonJkox1T9Jtx7qN
         ZBlXe2tH0TV/CSXMNEkURHZMRBNcZGWvNjCWALlH8/GTITdXOq9beumtpBwzDjLeBeCo
         bd87rfX14fh5dNdo7XS68cdLdqFOgx0PMOEuqAPlA3k/VT8kzLh7hIhRlUQU0P6jFHns
         dJOIY5Pvc1KwyOuMsp6TA4CU+hx7t4md1WQgoZomv+gdfg6t8PgQ8x1sfeJa8Vg0Fnjj
         +L3R/c5h5iBt242hgh9eu0CwA1VzsBP4qZ1tQqo6z2EtY5QCpFz27mR36Cl0T61onZyh
         m/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769371142; x=1769975942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v81aGgnmujoR7ZjyMQcCM6v+ilk6241fTV6D8s9LU7A=;
        b=SawNeAt8J8stI5iAwIRC5FUgJZEM1Ry346h/mAw9+UUSyCb2/aBWuILEEUwGal0KuM
         fzzcZXtkGGpGXhPt02Y9BiHyDT+HsHiuChzg4ABLYGF3aLNYxF/HsZqyRfCXRIBWz/RZ
         EppfKGNoV/BvStliEaHOpCfNDo1K7xJwEJHd1P9TMwWPritgC3GtnrlF2b5jd8i+XIQY
         8gFSW9WZp+Glv+KitcnzXESPnJ82P9pCjDX22U2QeBuzFeHmD+UDtMmspoCn6hwxm6cH
         6vFyvaWLvYrzJAZqUU+e04Nckz0iZGKgxQHW17VGjr2Cf91HKFCAxdCBCu/UzJ+j5EB4
         XSXw==
X-Gm-Message-State: AOJu0YwUmc7wRq8XgKYysNUmatDmG3oWYQ9K1j2Y1ARdA7EzEn9YwZg4
	vHhlbbPo37gduc3V8f4NuefSLYJFmyx0vmWMpSmWZt7wluevww5v+ZyL
X-Gm-Gg: AZuq6aKK6PZD4U2o/7MBicXDAJxzgVkuZoAZYweNrAE0wyIOr6KQphYS31jFu4lRRVt
	NAD94pi+1uiDNJuxDdSFagMEQjWPd3bWm3Fnb914wVMbh5H9K7dekUvVQJoMwayyImRG5h0RMDx
	CjVPL8iY0LQD6vX3hsHv2FTvfrVaQvqCgPU8feTkUoEt3vZwo/Eb5fqVpIizHuszo4MVgkOdLTm
	enskyVCC9ryFdXO9fEfJSFSSc+Ao8L0fcM9r9YrDZMBe+3mov7di5DuUWkbjQ7bceDsY0kUa2DY
	rrvDIyEXwHB0S152K/jDw2uklcCfgCHHDyA22r1KHAjMC5MP51Z5grjZqRj5TdIMtT3Iu62pz27
	nMzruylKKXfLftykedjsOmlbQ00bZK/ekTdIK4KwjhaOrX1x9kY0mtgpAnYvhS3fKERAPECOGjJ
	dtQG+M0kgGvGrcKDoDKJA1tLJu5F7JmrAk760mSpDex1kv3vw=
X-Received: by 2002:a05:6000:430c:b0:435:bbd7:18e1 with SMTP id ffacd0b85a97d-435ca0e1757mr3371494f8f.9.1769371142365;
        Sun, 25 Jan 2026 11:59:02 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02cd8sm23331625f8f.8.2026.01.25.11.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 11:59:02 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Randy Dunlap <rdunlap@infradead.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v2 2/3] landlock: access_mask_subset() helper
Date: Sun, 25 Jan 2026 20:58:52 +0100
Message-ID: <20260125195853.109967-3-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260125195853.109967-1-gnoack3000@gmail.com>
References: <20260125195853.109967-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This helper function checks whether an access_mask_t has a subset of the
bits enabled than another one.  This expresses the intent a bit smoother
in the code and does not cost us anything when it gets inlined.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 security/landlock/access.h | 6 ++++++
 security/landlock/fs.c     | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index 7961c6630a2d..5c0caef9eaf6 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -97,4 +97,10 @@ landlock_upgrade_handled_access_masks(struct access_masks access_masks)
 	return access_masks;
 }
 
+/** access_mask_subset - true iff a has a subset of the bits of b. */
+static inline bool access_mask_subset(access_mask_t a, access_mask_t b)
+{
+	return (a | b) == b;
+}
+
 #endif /* _SECURITY_LANDLOCK_ACCESS_H */
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 8205673c8b1c..bf8e37fcc7c0 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1704,7 +1704,7 @@ static int hook_file_open(struct file *const file)
 		ARRAY_SIZE(layer_masks));
 #endif /* CONFIG_AUDIT */
 
-	if ((open_access_request & allowed_access) == open_access_request)
+	if (access_mask_subset(open_access_request, allowed_access))
 		return 0;
 
 	/* Sets access to reflect the actual request. */
-- 
2.52.0

