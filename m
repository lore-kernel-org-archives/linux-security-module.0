Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C5339184B
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469619; cv=none; b=fyscLjomfhTD6hFboNQlI/RvS20y5iEiXLvN5MDLJuzTfzcAQR8ShUsc4gzJBVH9csxE0hZzs3gq+oY0/9ztm+o7jCuSPZPCF6Sr/1tHtt0Q5GNKYLeEVh+nCWpIfuIQCYvZsfARTHpLL8W07E950wLPt95au1e345BMZehWavk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469619; c=relaxed/simple;
	bh=HppsflGCCIwHAx6XULz7fkX0Pj1rxIwOFobuHbNL0oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OZmp22J4u4IVdvxKxSFidwPHLymbpBPKGvvq5yGGZ+cMw6FcQ1fqZBUI6WEwojnquiAyNSmnGRCFrQBr57d0vLM9Y6z1gIHxSdQYlTmkB3/v4kqLpfY+kEoSb15N1gtA0h7OGZ0GvI8lUzY6CQX4+Z4beS4xXPStOY56WMexhws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtFvMoML; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtFvMoML"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a020e65269so23756745e9.2
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 07:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469616; x=1792074416; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/WxZM0oXdnrLJmi3l6rXqt6NynxCjaquqKrnBDeaKe0=;
        b=PtFvMoML1Ifw17kN2WCECf6uQh+YxPnrmqi2UW4LynPdhMvyBj0JiLWqZLPHdjOrdQ
         l0yhfODtFAHDbgJqxItOXvLD/udWT2R4UhtifkvGnoPwkJ5kH7gLHdBm2zrbPkHo/lbS
         Voly42BMLbPPeP9aIiCXvU6zuR0Xr0ov2shOTsUmCbx4aebXTr/SLspQ/oAZ4NWQvL+N
         C3ugJ5gHVeekdJUSO2LissZzywg2cF9gUIqtlLFj7ZdMqLgHH46H1bD3lNQj7zfI0j/s
         bF88MIuMczHNVekG9yNm8jXT2+96+0SoqY6uyBapFJfNqvxbne81URrK4Q7CLsF5NYuG
         iR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469616; x=1792074416;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/WxZM0oXdnrLJmi3l6rXqt6NynxCjaquqKrnBDeaKe0=;
        b=C0fASwIexR1QG+ebxshgJR1NPZIq6yQRMr1n11TqKD/9vPyZmqvhC9KMPxs0gNv/Rt
         hwdF7nyatHs/sFd4J4Bo2AduhdMVebG6GpxWkthhFBv7j9PqI2Snmxdm/Lhu20NDAFJU
         Ok/JwdJ98tKffEz4QaDmehWQ1xUWf2zXCnf8K/vBk7sp+AeYU5M03Nfevi+WYeKt6l9L
         xzYZlNNTqsBXS8hN/j769RSyDYx5ageLMj1W9n/awZigCDbod1j9VCJjUhd06SvzFlcx
         DnRpAhwRnBMkoLuShMGFtOQaXJr4neXhEraN5W1MyoybF51c7S7sqsvFjcr9MN1yqKdm
         Wv6A==
X-Forwarded-Encrypted: i=1; AKwUvByC9aCPhw7AjDckWOYwMndn2pnHApqj2nTDPC5l6dZ64ASrSq6lcvR8otOnXdkRVEqskgwJJw9xS2Z45b5vCvd7532xlmc=@vger.kernel.org
X-Gm-Message-State: AFuF++lH5X7QuL0WWG18iDakqKEP1gUWMuJx1exDoLJuWxdYMKoyUz9D
	iVjpscmeOc++wu5KR6zUxtj/yydcBMLgjfNczy4Tuf53kAg1XODc6tO6
X-Gm-Gg: AYBFou3hX1ZUVtRE86F6YmbK5wSUhr69d52h5XwEixhXHLNvDrmJAIh3LZzaXF03rGv
	O2eE6ox+7WE37tx57/6zCrYhdB/t+rbMW/k0oKoCKdC4Z+uFxhlXmbZaKSHEZTkRcc54qsBzo21
	gwrBdk1kTyvhePDwFd1J5KipVhwYxYzR/zFa5yQzTLlMjgqXKiQeNsyRbFVEOUtiOZT+NlIQXeM
	bdZatdfr0mB+UuV7pLQyyRGLI4xnCqt6rn1F5EyY5txV9UiGoCPQvByYkNkgbQNIOSFjPcO3S7h
	FvyVdbsE963fZQDxOSV+NNLxwiHoneEOIkZCzDlDkx1wYnk3k5HZrPuc4Cw7SWoaQBW+WDiW7ug
	sdHHd+4XGQl6tRYKUGmPBfpDyoUTrUBBY1N3+o0e2kiICFjy6nzzqsTdRxmt6z7UWytP1yhpIOv
	Sf8UlNtwu49uMOTfvPOJ+SD1nMaaqZGJpmjHSI17IX4pwkOZoYQ7Jp79r/cWdkhAYX2eycFYAFS
	NCjyFyISRNbiopHeg5wQx0=
X-Received: by 2002:a05:600c:8b63:b0:4a1:7f8e:6e5d with SMTP id 5b1f17b1804b1-4a180310d16mr101781145e9.6.1791469616201;
        Thu, 08 Oct 2026 07:26:56 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1842a3f55sm77439155e9.2.2026.10.08.07.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:26:55 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Wang Yan <wangyan01@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/27] selftests/landlock: Fix the openat() success check in fs_bench
Date: Thu,  8 Oct 2026 16:25:34 +0200
Message-ID: <20261008142604.39107-7-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261008142604.39107-2-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fs_bench expects openat() to be denied when Landlock is enabled, but
only treats a returned FD of 0 as success.  Any other valid FD falls
through to the errno check, which then reports a stale errno value.

Check for any non-negative FD instead.

Assisted-by: LLM
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_bench.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_bench.c b/tools/testing/selftests/landlock/fs_bench.c
index d13a88dcd1ed..78d1efcb2d20 100644
--- a/tools/testing/selftests/landlock/fs_bench.c
+++ b/tools/testing/selftests/landlock/fs_bench.c
@@ -189,7 +189,7 @@ int main(int argc, char *argv[])
 		fd = openat(curr, "file.txt", O_CREAT | O_TRUNC | O_WRONLY,
 			    0600);
 		if (use_landlock) {
-			if (fd == 0)
+			if (fd >= 0)
 				errx(1, "openat succeeded, expected EACCES");
 			if (errno != EACCES)
 				err(1, "openat expected EACCES, but got");
-- 
2.56.0

