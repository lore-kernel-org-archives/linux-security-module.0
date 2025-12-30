Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD981E1C02
	for <linux-security-module@vger.kernel.org>; Tue, 30 Dec 2025 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767091215; cv=none; b=dEg95z42gu0nD3QiqMqM/x79J+lJj9l5cLvZ9xTDkGUU6iRXm1ADD8tKHpc1ajLS7D4FrZcnajCsAjzQSOYCa/EPALJQsWMJbjoaxA2lf73s7C/vioKomQTwXFaSg8zUKPyk8/C/3zvwpS26wlE+gKMVylPOJjrfRUKE/IZvi/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767091215; c=relaxed/simple;
	bh=4kFq18rebY14zFLa3ePJf4ysof8L7F+WOcjw4oljcsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLSJPB7MYn9hEv646NRA0NUBQNAWNkTn6zkmFbh3XspAJ25V3BuMV7V1/OK8F1cC5P1R/+Ra6ixhNgT1eOvq3TpYqmJfDUHOgZ+qKobGnysDGPjL2x7ihNh+jg/t5SD1gklXN9VA5XNxTWA6PWNWr73DKT3hAeWi4mt/xnNFCFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2V/qDLN; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2V/qDLN"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64b560e425eso12885892a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 30 Dec 2025 02:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767091210; x=1767696010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqCGUKj5t6LFkwvoK7A8Lonc757G4l19WHQNyCiJpqk=;
        b=W2V/qDLNFpgLZf7odKv7hRGKmkm8dniMM4wsNgKoqbcxw5bIOZQYypK26N3RkxmUhG
         AqmDlNV9i5xeF7McthlZ2PVZeT2TzvfTAyFufJbYlYZYBRR+RJ7k8/x1CExO1BaKnkjC
         4OIYxBIKp6dQsIfRqR4pp6aGydz3tUx4vxrhwM+wqsnXI/fJM3MKKAkgHXBk3t2rkU5T
         46OfSehnJlD5UotZGaAf8ChhxDQKztRKnEQtKk/LY1iyZUxoz+8FHJi1iFRLn8dgurL9
         WRO80CSFfxzhcTamXUaSawWNUCENQFgT1Z9GeECOSE/8I88Y6Rqmsebxlbh7Jj5I8ihH
         IHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767091210; x=1767696010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XqCGUKj5t6LFkwvoK7A8Lonc757G4l19WHQNyCiJpqk=;
        b=XfbZHl1iTgXyU8ZNVkoy855tsu/Z5SMllhZ7zexCkJ9EZXpgBIK0P2ykpDeosfVH39
         wz9m0rIgqFWpLfUk7YcV9iOV4F2S1+Ceb70Wup5CqWwpt289GaIHA8EI8om1bGIEmeqG
         c+Qwj/bPxUrR8VCTnlKTDH5vDBzJF6x0QretBMKjUgn3+JqjcyiBpfJ6nCXrQDuhI18w
         5SJd8pPcdQJQgMPQsUgGIObQU1G2Z7PJ+invaqftl5v9LRMozhWgPMWzFNS3sBi/1oWL
         40RVzS3/gNNFfoKySirelg8Vppx3VqVG1hvvsXADvfWF2aMyQfHVHlwkQ4U/8/Ti64th
         2fOg==
X-Gm-Message-State: AOJu0YybrGjRI1s7NfRYvmi57m/BkFbiUJISocSv5pjNbP6OuQUA2H43
	xZygOZCDtLURZ1U5WkBmP4We3BgDsnt5LxqeepGYaGtNileqexOEQ1v9
X-Gm-Gg: AY/fxX6lQg+bobpKbu7fl+00QzQMLvFZdWY1T92x6VqJa06Su/W8gDGK8hVW5WPdgW0
	2hNU58n0Zm0Tz1it/JeoV5MpG58bJ6UXOqAy+1vCwKqRgHhwnTvMIGZqkFu8cODyvkK6l0JQ97z
	+I0QSCnWK3w9ylRph9TF/oWgBVrtHYzrYbAVK2XdQeFUcWQHWcfQS6SOMdEgMzQeJzW+MYkuEmi
	z/elHXvH4HYbsU+RbyBgxaBr0St4VgSsyt7rZJJKeN770hT74DF1fjelyHumUQ8aWnMqnRAGX1T
	nGwtcAs+ANt3hst/C8ewgIRI+Mz2y7q5b3XteEEbcBV12zeBWSNBi9SzYXvY9Zx5+GgRvtIz1Nw
	cbOZFbA1rduPrRuec0uFAG7SxO60J3mu7ddzGiwzlaf9/m8fvVTMgrfEEgISA5lKdA5YM/WP7UB
	CmbyNEQQ+PZOp18zLgpq7fX/4tjHX8ARfANRvi
X-Google-Smtp-Source: AGHT+IHVC3sFiKDVRx6FvzZbrTAK1U6+jYR2KXIoEENhpIlnlcm0dQTnsyQZfKejzSyWfUzPCbWpPw==
X-Received: by 2002:a05:6402:1e90:b0:64d:4894:776b with SMTP id 4fb4d7f45d1cf-64d48947948mr24517649a12.27.1767091209772;
        Tue, 30 Dec 2025 02:40:09 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9105b31esm33873278a12.13.2025.12.30.02.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:40:09 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [RFC PATCH 1/2] landlock: access_mask_subset() helper
Date: Tue, 30 Dec 2025 11:39:19 +0100
Message-ID: <20251230103917.10549-5-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230103917.10549-3-gnoack3000@gmail.com>
References: <20251230103917.10549-3-gnoack3000@gmail.com>
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
 security/landlock/fs.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index fe794875ad461..b4ce03bef4b8e 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -398,6 +398,15 @@ static const struct access_masks any_fs = {
 	.fs = ~0,
 };
 
+/*
+ * Returns true iff a has a subset of the bits of b.
+ * It helps readability and gets inlined.
+ */
+static bool access_mask_subset(access_mask_t a, access_mask_t b)
+{
+	return (a | b) == b;
+}
+
 /*
  * Check that a destination file hierarchy has more restrictions than a source
  * file hierarchy.  This is only used for link and rename actions.
@@ -1696,7 +1705,7 @@ static int hook_file_open(struct file *const file)
 		ARRAY_SIZE(layer_masks));
 #endif /* CONFIG_AUDIT */
 
-	if ((open_access_request & allowed_access) == open_access_request)
+	if (access_mask_subset(open_access_request, allowed_access))
 		return 0;
 
 	/* Sets access to reflect the actual request. */
-- 
2.52.0

