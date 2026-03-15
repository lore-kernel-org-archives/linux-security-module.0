Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAACE37BE8B
	for <linux-security-module@vger.kernel.org>; Sun, 15 Mar 2026 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773613376; cv=none; b=pAhAjNucnoNF2oEzh7BcqI/vqWkPGZ+a1++3xx2y68LgHmQeXNYe/g7RC2RkiAE47cv+uBuBG6xBxiTUYhgOtfkRFcjw+G1vrvbi3Ra4g70OWFONR6nqkm1V2IDQaPeyD/CeHDUvqTJbUlt/E3Bfe+5qGhZ2FTI18rN8mm9wQqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773613376; c=relaxed/simple;
	bh=OhXXG2xIldVvbJF1GHdQoasLmdqqVTz3GR7wBlfcQIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDDOp4E+lNvJBcr6iegyLkkG/ImdfZiUIKoJEFshp+ys4xStg6pG7D2JsINPuPIiB4rpR2B9hMaERYRquFSBoVkcb1Gcl8i7pt2VeOAuK/c1U1jJdMACnx0mzQ8/XUFnHzcVd/IEnVqSSnIe5z++UtXVam6oyNCGSgZ/qnSu51c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=carD7uki; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="carD7uki"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so35830995e9.2
        for <linux-security-module@vger.kernel.org>; Sun, 15 Mar 2026 15:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773613373; x=1774218173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJshHyAlu0Amwsqvbh39fSwfWMmGLorddxfy+zZs6KE=;
        b=carD7ukiQAeEUK5kw/bDllmMUMnpVxPCGrE2dGu8UGDPkVbmjM0My1jTxDaJqM9Mbq
         0dc86mG6HsHmd2+Yn/OhRHAXuTWrN+sNwklwfFKlVPS8rTie5n2tHUXZW5TP0ePnynRZ
         dUIRmu5Do0fqSE+jGmZt5q659zDK3rDVTBcMTx0L+L7u+ZLH4s7l5dB17swqEFJgmOTX
         o8G+XWs32WaqTxOtVI/HP2ULtPha4yz/xZyxil1z7HE95sOiKyjmvNcHQ+YDZjrCIMZK
         yuuyYxdjWAHqM7apeWn3AfgflZoCsveIJ0oCQhdqqws3EuUrmy6+rqTgIcPu4trrZkCY
         0Oeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773613373; x=1774218173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rJshHyAlu0Amwsqvbh39fSwfWMmGLorddxfy+zZs6KE=;
        b=ZA22VeDjEDUKprwjmLVtGVan8xjJJvKgJSneQUc3CdSPh5DOUT4mYDYhpWFncapm20
         jLfPY2wh4MwYXPPlaEE8kzClpNzqRn9F1pEe31+vzGkavEFmJprzeZHUnJMpxcjYT4b4
         YxSXxJyZwNDSK0GUvP9oz0DWWszVOwTXdDtp6koVIzXVtVOpdtJ01WV2eFe8ahu9C/WI
         rqxgVtk2OcZsSMbELmkXGOA6e2gxyQgKu6tDfvP1EVfZJR9c0f+2sdmCe6R+XM0FV0dJ
         3b0iL/ViQPeWBZOEvwvB6yJ1Ka/maRQa6aT8tM1H48MOafRfgG1Bcchdpn+kzYES99ab
         4F3g==
X-Forwarded-Encrypted: i=1; AJvYcCXWj2UWORnMGXgeEyzq3d7lUPrX0WMtdVnwBv0YPwBSa2L0y27WbS1Aa/Y5cJE5e84vm3uNhmfQ041/BnkZIyfmN5jg8is=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNgZfXhve21h9d42cMVZyXOToC3rJmbGKlKQfccDoywE45FyTt
	0d80ZuzPmUpy2O+BhGI3Ult+v+d8VT85rexgE9sW6POnK9iUAQGXrN7t
X-Gm-Gg: ATEYQzz+AKYPM/hzg/FYExJP5oO25xJ59+JaAOpYIPuUtpI0M2rZ6roYVB71v/wls2g
	cnKJzYvyYPbcsHh8IGA5gIi1Ckkm7YzW2JCBKI0JOsVYn0BU0iPZTaDxgCyu2DtH0k1OxVE88xB
	Mga/pcz/EIeV8F43NSenDYnGZbJQu3ZPBtu0kB9QXa+2foNAl9DArV11+ZuJeKdMYCjeEdIKCLw
	BcsQK3nspFKhyp84RSrt5eFisMC5L/fDz7+doTDy08d11DTQu/XkiY9/tI10dnFRxM1e7o/W8N6
	lrLKfgDpOvRNalXQQL2rXbMe1h8GTLxUR9x6TdvtyVVQduGD+B2/8U0Dei86SUx1vtMwyutIjoE
	qhucgYmE22OLOqRKckZfBW99Eu8eQVr1NQvhnm0HOc0mYJtRR3E1WFd73ufiZWwX3TxRZ1/bq9c
	L4eW9i+VHHwyANoJjFx69c+9xWQfiqXoF6lHcBZXoCT83dF/Kc
X-Received: by 2002:a05:600c:3588:b0:485:5d25:81a9 with SMTP id 5b1f17b1804b1-4855d258656mr144677545e9.14.1773613373038;
        Sun, 15 Mar 2026 15:22:53 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c7c514sm77865015e9.32.2026.03.15.15.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 15:22:52 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	linux-security-module@vger.kernel.org,
	"Tingmao Wang" <m@maowtm.org>,
	"Justin Suess" <utilityemal77@gmail.com>,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Jann Horn" <jannh@google.com>,
	"Tahera Fahimi" <fahimitahera@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Kuniyuki Iwashima" <kuniyu@google.com>
Subject: [PATCH v6 2/9] landlock: use mem_is_zero() in is_layer_masks_allowed()
Date: Sun, 15 Mar 2026 23:21:43 +0100
Message-ID: <20260315222150.121952-3-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260315222150.121952-1-gnoack3000@gmail.com>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is equivalent, but expresses the intent a bit clearer.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 security/landlock/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index a03ec664c78e..97065d51685a 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -564,7 +564,7 @@ static void test_no_more_access(struct kunit *const test)
 
 static bool is_layer_masks_allowed(const struct layer_access_masks *masks)
 {
-	return !memchr_inv(&masks->access, 0, sizeof(masks->access));
+	return mem_is_zero(&masks->access, sizeof(masks->access));
 }
 
 /*
-- 
2.53.0

