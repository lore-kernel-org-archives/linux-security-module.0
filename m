Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1550B1CA81
	for <linux-security-module@vger.kernel.org>; Fri,  1 Nov 2024 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479978; cv=none; b=SkckswS/xl9eueORyZJPcU3KB84NOxTmM3d/HCJ2U5UNCYhW1RoZRBjnuR3zey+cxLHT/4CVeIspUXpUXwJmyJ8mPBib4lVaYJ4M2txXw2YK9ZOvG2tYV0UP1zF6CDO6z3Fd7l1A7viT0QFO0BTFwOuzSrhoiqS2lL1krW+Tzcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479978; c=relaxed/simple;
	bh=NV0lZsmdBRff0dguOgfQcvcQNTlN8QeO+n94mtctPwU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PCZepYRPBw6z5vJuvS5OHGi4lYAT282Lqs++PZprZEHzEyeCfJPrIvlYbL1+lQFmDDk8pISxM3wj/N1jjwwkT199Mxsgm2QzlBIYhfO2MAqmhiScD/EY1JAWBM6w5DlCrq10ybsHMTly0V8IQCQ0I+tCEfpD64WOcoYEbfYC27Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=e0s9lPhp; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="e0s9lPhp"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71815313303so1169443a34.1
        for <linux-security-module@vger.kernel.org>; Fri, 01 Nov 2024 09:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730479976; x=1731084776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+3ygkqdGxg83D5e6rrGBxV+j6uXECqqZZ6Nma7RiOT0=;
        b=e0s9lPhp6g4cHPRqg7r25gpr2y08cz0bM9WEvsbWgmZKRSW1wzmaJgGi0FutdeqLyO
         sWvqQDuMZrmo+6bj4j9BYWFHi4X6eSKkGQvmXBBAV9fxwfxa1yEHvRWsx7xIaCSrkgYo
         tYHwjx5OtxydQZMWyX7IXDv+t5T2/VCvMGCragOFejrPpLAM3ko9IjwrLDxKua+GLUYB
         zbQu4fGXFsTLGSjx9Klxq3tJicDeiovM3ddp/uPbHa8o5DxXV1gR7pZEgbiz6HPN7YLe
         pYO5SwTe+n/vOJRjxAMHLcZ4VGHIZvl+nDkAPu49hb4BulSaB3eHcR2LWWt5ipl58RCE
         MhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730479976; x=1731084776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+3ygkqdGxg83D5e6rrGBxV+j6uXECqqZZ6Nma7RiOT0=;
        b=jPKn7e9tFYxYFgWhByMYKJp/Rxd/qrjgGccMknxMeyH37yhZrxq20DmqtXUtieg+SC
         ueD6FeE05H9837Ev9qHBCiPaOxgjx1EVhHd3k9bwNw4eLLpadmz9VTApYnoMbcm8HGb9
         nSlHlASdzcTCDLpsc8pt/9sI9m7Gje1mH3eo67RDp7dMhaZGTj9zr6CSh9zz5oAq+93G
         0hzlyxiVsVj6bI+SpeUPGgXBUqYmQpKzJRKf5OlSWelpfScH5WJO+/sqTQllinmlhPTI
         h80UVb3C/PWXFi2OGR59q5rSth7FjAIFXdvV/H6DhmIgPK6bQHHlDoxmeM21oOYHP1/4
         +ZrQ==
X-Gm-Message-State: AOJu0YwW9V+ANj7u5ZfdD8GUg97jfREtkxacZ/bbcDrF5eKHzYmMqDdJ
	Jeb1gyHMr74MaaCl+q0kP+D6i4MKe+G74hMTuwe9e3THDCwpjgkJJUdsXGz/58xAbof8YnXji5A
	=
X-Google-Smtp-Source: AGHT+IHAAto/xQsFZe1BDywut3aaicGD5whr46UtNlQFXGHMmzuk9E7qLVU7jFy1/StChGrktCqiBg==
X-Received: by 2002:a05:6358:d5a2:b0:1c5:e2f3:b9f8 with SMTP id e5c5f4694b2df-1c5e2f3ba33mr836991755d.4.1730479975912;
        Fri, 01 Nov 2024 09:52:55 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353e7a24asm21009356d6.0.2024.11.01.09.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 09:52:55 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH] smack: fix the smack_lsmprop_to_secctx() kdoc
Date: Fri,  1 Nov 2024 12:52:44 -0400
Message-ID: <20241101165243.159021-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=888; i=paul@paul-moore.com; h=from:subject; bh=NV0lZsmdBRff0dguOgfQcvcQNTlN8QeO+n94mtctPwU=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBnJQdcQ28iuYoBpM9ScISB5NiMd0noc0DCe9rx9 lxX5oEdWnqJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZyUHXAAKCRDqIPLalzeJ c9ToEADQ12wuuy8QvsztqlMyw2eHonuxra59SGOlqWJHzyT+6hl6clE5hxKtT157Mu+s8N2P4tD R5mnehQozvufUJlN3KK2LEgjUfXoSsPLN6V7epffDn2ixJJDALtCD28vFb2Hdm2lb4vdMqP3nIa 3sozWljQUnkW6NTzNw3V9kcqGoISBIgvDXHLzeqU9hfd4irukgwJXgwizZEkgM2aJVmbHWdEVQX zlAlIFdlKcjdatm/YWEymrCRi5fQB6Xc0NtJyRVa8mOG2Id9e2CZE0BbtcVSk8InOS+kTdx6nSk KJaJaTbTocLW4Q0+rKt66FxaSmbLtmtvGAmmFE1XOZoiuApkpaXmboXmOS99p6WcFdWoF2fQ6/K 7flcQ8PDrelq29vYW3g+dgUXMcqIp+xpCuJQIfhaidBPMSakIVMhik0x0eqS8w0A5oKT8LKGFSL OjW0ltl7880hdsXGd1XSHN2S+nsALwQ4rJMSgnD212UZi707p/i1awCVm8+p1oni5c3VB3B22Ms voVvCcBoCn2jS25WL5CRc3vWehdSGtLOSHLK72+Cn3QDM5XcjfAUc2XCKx+M5oKQIVC6cm2oReS m0X8rRJP3yIOmvn7Hx3y8gB+kblOWKbKmCiN3tDA3GRYX9HhIFLjWeO3n4mnI6/+vSE44d3jjO6 neOvsaO57d+NkLg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Trivial kdoc fix to correct a fixup omission when converting to the
lsm_context struct in the LSM and Smack.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411011723.I59qZ7Ke-lkp@intel.com/
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/smack/smack_lsm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index c9ec4d93fb13..55a556f17ade 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4851,8 +4851,7 @@ static int smack_secid_to_secctx(u32 secid, struct lsm_context *cp)
 /**
  * smack_lsmprop_to_secctx - return the smack label
  * @prop: includes incoming Smack data
- * @secdata: destination
- * @seclen: how long it is
+ * @cp: destination
  *
  * Exists for audit code.
  */
-- 
2.47.0

