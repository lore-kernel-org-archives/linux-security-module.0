Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826544;
	b=qcsg1CFdJxqCC7dqpNiaSjnj2Qjc8XxNGVgQcSiTDFWlRsRaGyXv79wd0ItjK+M35lHz
	 n8UEYiGTyxe/kL2zJy0HW+cTCfWBbmCQSYs52kly4pfuP4a9wsBGZAvedHogeu1JeFF4l
	 ep+Odlu2gWTFa40IPSGTIjjwQ2CjC8kWqzWvS+UK70ivkENytTWyqWsDbqz2eVBBa4Hw6
	 npm2Jtd4Oe0ZSAPYJBQrbWvAt+jbPCdYSROKAYti8wMYmLW/FYIHZ3oyDMwtuqAgVXCZ/
	 qKUxRdr6Bd7IWpbxekK4o/tPnZZV92z4j6Tgxqwt9kpboES83E4IRASvCQ8rpusgwkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826544;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=KJjJiozm3d0rM1mQcNRsH5gFVPVJYU6IQSIk1eq0QT0=;
	b=3TwVNv4PowhGzp9xT8jX2Y3iIb09/660G3ninQK7bNS8xNBVvjVT4hH33yM3yxbCb0pM
	 ZxWqmeNY0HBDXS3FCdY134Y2PSP8iW3G5+tyMjvTmPMUaPWefse6ST2jA96ihPky6ONRc
	 YthG84tw6Bg7FptP0oYyOYZRtTq57LDquUGpJoiW32eTaUcGpIqLL39zIOBVl60be/gUB
	 AVph2HhdDNf/auRBy2lpZwQ7TzSMrhXyN3jJkUgHk/HTLnLO7qAEiCFLKZmEZ6qxMEVeH
	 aRi5sfjlHJW73TjM3uWDX3yhKrPPoGKw67jV/K14QSIUwy+RqzlhTJGhTmee+mcptIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AyYn8msc;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E71607E73F
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4E71607E73F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AyYn8msc
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e46e449e8so726507f8f.3
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826542; x=1794431342; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KJjJiozm3d0rM1mQcNRsH5gFVPVJYU6IQSIk1eq0QT0=;
        b=AyYn8mscU8vUqS3lRk7C3LFoBrszPG9ICQkVOCkMxJXvaekNRR0xpbc6+vCL1FQJKa
         Cz+4cqtqSgh3cEVlOxS7KLGNTKMlEaZfTflp4mjNKTaufuYIEmE7GilVQThsmTHxsdw8
         mR9aOEDFEm3mHx8fKOxslo1wiESEmEcRbupWQvwldeiSdUIaZwY3jMUz25D9W491wcWg
         igeGPpMojr0XznbN3znlufssneYVn87FqDrH+aWxEjsqoD4rEGUC+5ph3HuH5cDFb55i
         TJ0QQZeRltXKxKCBn/17WGHGB21CigXEXoHSIeJk7OhjzwGP/VJpEFaf8MduY/QcRZgo
         5O8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826542; x=1794431342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KJjJiozm3d0rM1mQcNRsH5gFVPVJYU6IQSIk1eq0QT0=;
        b=qTxNM3RedaYQYZWrzHUOuAXsiF+zLRt4JdElfyx4OVVKbf5WovuNQxZe9lyU9y6K8r
         IGfn7b/m1n/DSKtBAUKQDksYvNat8dFMFWAgDPRLnIZ7zzmeEAf9+p5JNKtAGEuffDjq
         Fb88VVHHrQKOc4e3y/L/nQ+ckB+aTwBsP9oejgjYtwVBEuw8DVHdTKl3F9kbSFvlRRWK
         ir9XRebKyE+yTJPQ7m2zXnwIVxkXQ1om/R8KkMbuelvFrmZN6dKzwGjSChjTi7G4pNAm
         Jo7qbe3CJA7i3+1UHes1ZefrSDKZaZ1o3mZjwdICwD7Dhz7EHqytyVBWw3JbrBUhm6/C
         Rjbw==
X-Gm-Message-State: APuU4Z9UJAmA8O4b1c2/XtRvJuVWeDflc16uTrbjx/s/cnHFl9hCsHux
	ZmDxWc6NiG3vHcYhlGvcIko0grAcNOAsJfo+WB21lGIPb+vnKLQ1PAcx
X-Gm-Gg: AYBFou1j3PTsOtYXHAulcPMCvHiIsuxHz34PcY7vhWID+P3CdKkazgrqA9wCY/XRnUN
	Pay7OYyJPJarUltEJFVxAMMlCcWyhoFxh805rGokTSKrm2ud/HIv+tjkKip2lXynS0shD22zkEW
	ZrGUFh4Xhs+fLBvlP6MQzYEFgJRGjk3uaTIVLTmHvAEK2MmeRcxMdtz1q+R1f6JV9Gms2kBrhmv
	IKY4wDTSm0i/3UVgHW3H0Y35bzK3AigGRCfR5wuRMFV4oMiJdFGIVYCSW0WpyrNrWOA81LsqXz0
	2zLz/XUxXtGCAquA/HorETxvfCAL7cOYdtzgMw1pmKFYS2PAbCC2vRM7SvUZt6OgNAR0LC0Hw76
	vhjPDepqU+MwUkoH3QLtmLBc38eQic/YAB9lv4V+FjjBdWVi3NUBRHyzB9k4ayG/5BHP4Lz9/9U
	1lNexyGtYhGAB4E6AD/kRtkIe8DH1bNZ79WFEzp6puM27fX05+R6CVGbImfFYjunGmO6bbZRUsL
	tZVnycJn77QKQa8Zwdmy3urSBgDp8h8rhAx3OSZuScpVWyo6iXxeoHBtWLjlAHXwDkBZUwQlBll
	u4u31MTAuI4RoQP6EvORbAUTgR22hmJjJ8dcT6CqADP63I0J5/QGCw==
X-Received: by 2002:a05:6000:2504:b0:48e:5df9:1ec9 with SMTP id ffacd0b85a97d-48e6e500979mr42439584f8f.24.1793826542329;
        Wed, 04 Nov 2026 13:09:02 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fece99d67sm5897273f8f.24.2026.11.04.13.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:09:01 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:08:51 +0100
Subject: [PATCH v2 05/27] selftests/landlock: Fix the openat() success
 check in fs_bench
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261104-selftests-refactor-v2-5-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

fs_bench expects openat() to be denied when Landlock is enabled, but
only treats a returned FD of 0 as success.  Any other valid FD falls
through to the errno check, which then reports a stale errno value.

Check for any non-negative FD instead.

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

