Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A750219A97
	for <linux-security-module@vger.kernel.org>; Wed,  6 Aug 2025 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754515569; cv=none; b=MF8Wumlo/zwpzlN0EaxaiaUeREU9UkuhIQm9WOw04kji8PhGbhtS3WSwnYITWghnRlcbz2GHuVJ9nsKkB7Zq6dUGls+29etpJxSjsjzVZbnHOwpOCiKlceCsZbEaBkeybWg0amrwX9w9AJNyFabJ0Dq6tgSrEPjY/HdmYf72F24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754515569; c=relaxed/simple;
	bh=B/1HyqMohEhVEcpgHCE2joPnVv21h8Fy4YZFcb5ogrU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MKV/46O/IQDTQa3oz79OKCDkEobKXGScynLWhSJlft3DxtWGtehnqq9dOTM3RtCwOOaZJK3kkA4Rik4QB1yYcrY5DPuUXmnv2wuI89ha0JfTvtCzcZl4XkjViYJnzHwFGlsWf8U0IqEFTNdy+fHxOB3ZBvtNX5jznTTpcypI0bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TGdGWQ1E; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TGdGWQ1E"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-7075ccb168bso4022256d6.0
        for <linux-security-module@vger.kernel.org>; Wed, 06 Aug 2025 14:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754515563; x=1755120363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ifMYf/ApkIVmFqirWn8rby/JPgVL8u5yA5lMtha/arM=;
        b=TGdGWQ1EGRFJxekH7b4Si6Kag5VDKWOKkAWHeJjRISM5ZlxUXHpDUaJsYO2bEiMbgI
         w3J6k5cGwa8bAI0WE16jXJXXUpNZbL3WWXSg0/Dx0UsbjGltelm++0/UxP2DnOYoUWLa
         w6YtcL3Og3eDcBCQA6WE0VXT9FLVJc0xcYsUlJI9bFY82aEXbtRK/JbD71dPSSK4Qg8g
         9SUfA0/j4LYchREihcQ/iuC6+V0FPMa+yjTferQ8elJIM2Q5lsah+GV7XMwfm9PyWnog
         k3VvT3upu888eP332ft9ZChGL3icjwh8vlD0hq4l3Kz0F/96BIDQsFwEFLjQMt6PCzwW
         Zb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754515563; x=1755120363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifMYf/ApkIVmFqirWn8rby/JPgVL8u5yA5lMtha/arM=;
        b=aeV5lX4GES1JeKbgbjmVQlYUu2nQ3EZO3swRFeBuKuXFvndLl7KUlcxMBCR50uxqc1
         LcFWStTo+RnJuCcH9G1UOCEmvkUHGvzMUlZPtkeeHUbavuRZBDf1Ku1kVPoU6cLZsgeU
         iCOXbjH4wK10a3qwOvl3FdsTKxS4r8e3NIIYr8LlCBSaNNz2H5e2E26NAx2wMrA7F5Dm
         0+G+ac3D5tY5iayazM0WJgQJ3J0Uy+olUJ8P40V3qvaP30KsdAnJqzUYySFM7vbgxhwt
         QHYPlvOZ5t3ysrUdpAt77lfkHlROdKJSyUFaAjVIJT/jkO8oPL7vxV4/HoUoLsEcWbJz
         SA4A==
X-Gm-Message-State: AOJu0Yzy8lwqN0oFBndQr0wt0FEvIAmWvlYVRgOEchqqf6QZ/d7MWnw1
	7fHU8YlMj00+Dmzb4g/6U1gcv/jsTjRBcElq9xxMnkNWZ49qvKK9gZuK5sfA2i95/y52Dy/EPTt
	tt7Q=
X-Gm-Gg: ASbGncvwaEmajidt9eEYkAxl/O1jNnFfhp6DO6xP2AyyG3VQf5Dw/JN9RtInvkJGpLa
	ZwpDzyLKM7cqWHJEBMweA/hyoMlcwafGo4uFfvoo2gXdiuKPKDVcg7DIvniAPW7ag0bgauI4DLg
	WoFV+p7xA5HztAnZ2+dmAjoGdcj0ZpsxpOWDNKXNVuG58IbeRmKqZaURWmkpZELGtZn6py7HgY+
	2XNWIwwad24vZUTNVqqQE/c7tf+cvx9pshUnPoj9uzDDRmofjFly5KuGwpyQQrIyzZ+Phrky4Jj
	/wMsv3K6mzqXC13ezDee/ha8jCZ2EK+/Hi0Yh19a4+aQ2TKAKrwaxd/wGxR+gNySmpgoByDIs+y
	sd7lVXYCMscqau3FH//qf5bWiMQGyrJF+sojvYqCEnKhqXF2UjkIY2b7PM1XBRzvuT/k=
X-Google-Smtp-Source: AGHT+IEGRhi5DShUDOAsRKnMgU26hdVC8TqUZ5Mk/2FHmBAE4JfngCBtmjgGPdsEmdm7GPpj+rS9Nw==
X-Received: by 2002:a05:6214:2c11:b0:707:2ef6:c13e with SMTP id 6a1803df08f44-7097ae11cc1mr67318096d6.1.1754515562899;
        Wed, 06 Aug 2025 14:26:02 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-709610c06d3sm37876806d6.64.2025.08.06.14.26.01
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 14:26:02 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org
Subject: [PATCH] lsm: use lsm_blob_alloc() in lsm_bdev_alloc()
Date: Wed,  6 Aug 2025 17:25:53 -0400
Message-ID: <20250806212552.240730-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=paul@paul-moore.com; h=from:subject; bh=B/1HyqMohEhVEcpgHCE2joPnVv21h8Fy4YZFcb5ogrU=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBok8hg92S+gakREfaWxN2LU0/Q5nuGGGF7OiOz6 M663PpRqDqJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJPIYAAKCRDqIPLalzeJ c9RVD/9Yo6uOw+t2fDga7qgDTm+R5HA4DL3ThxwoB5EgeLIXq4DoXGWJ1KO69GHroQiQxljReEC KJ0axwRxuS89PTAIpNZMS9XrL4iMAZlQCW1EEc5V1shcBktfmjNTOAv9mihehaHDy00bNIxOJS/ tjR0tjLvjOz6kRDqxTsU32RXoYbBzHKicKx5vgILwZXGhPsCgqT92Va5ceSkwCb06rhI0RTd3qU 2Ei99kvJQat6l1B7fJl+gvvHCC4/iHhC+unRdMjNIouhJb5jmHyvcb7uZ/t9D88RjXORxaopxOj S044UX2LCSHVttAVnvxb+Je7u/edmNbyNtR6yO24V35V15Km5K7Sz6SO5qM3Hi3jwlihTzTgQeY pjlegASeJruBajg59uhgLabA3NxbZ2IC29naEho7jmK5GU3UftY7K1o+CjHXrPfAxzOT7MjCoxc 08MjYwn++JK5l6+Aoi/zbsxH6m74A+YDNbf8F/P1uXz9OprLOvIz7v6GIAXzJExjsRVzT1/Pq3s tq1qlSJgYD//nuIkI+SMzBAoZtunbj0+Om5GWWAgd0TvatvJi7ixiAFF0+BaMBVy+TyK4wunarI jSdF5DdE9CM8jgy/EFgRPhRvlwNnXM6WFJj3cz9KQXzIfGi6Rl0WhATJsujfyq/HQsMSkhDg9kH vkasrAv2CHYtpdg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Convert the lsm_bdev_alloc() function to use the lsm_blob_alloc() helper
like all of the other LSM security blob allocators.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/security.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/security/security.c b/security/security.c
index ad163f06bf7a..a88ebfca3224 100644
--- a/security/security.c
+++ b/security/security.c
@@ -823,16 +823,8 @@ static int lsm_msg_msg_alloc(struct msg_msg *mp)
  */
 static int lsm_bdev_alloc(struct block_device *bdev)
 {
-	if (blob_sizes.lbs_bdev == 0) {
-		bdev->bd_security = NULL;
-		return 0;
-	}
-
-	bdev->bd_security = kzalloc(blob_sizes.lbs_bdev, GFP_KERNEL);
-	if (!bdev->bd_security)
-		return -ENOMEM;
-
-	return 0;
+	return lsm_blob_alloc(&bdev->bd_security, blob_sizes.lbs_bdev,
+			      GFP_KERNEL);
 }
 
 /**
-- 
2.50.1

