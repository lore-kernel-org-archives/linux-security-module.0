Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0673590D8
	for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763558566; cv=none; b=oA4A/liCfqopt2MXqoNmrP8ajhR/IUf/qkmKvX/64AyBnK0h8MKsiZMtqiRUak89jPIy/w7ZXQCxaPnE64eHMdnaXvkUgIGJ0M15aer4BqmhO3WgdoxYFoTehflVN/qRGjxih0x3U+wPL5GlXO46uPKZi3c4CE79LIALUhJkVIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763558566; c=relaxed/simple;
	bh=CyDQpMMrChsKFGiBQUaLKZfJ1Uf2ENbNx6jjSGopG6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iIzQxvIM3nNKKd37+48SHfjYUPVPZt99gWO4p2uUwix9TN46MVNP0ae6GX/uZEIpAg5TQbu4+qMj1QgrewQRENa5XVhzEpnIfxnDrUzv4OqfBm0wM+Nn2CrpW4H8lEo5QmqraidnvtGAXTQilpH3T5qmj3L5NCTiNKGnjplJyWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6cpEzCb; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6cpEzCb"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8824888ce97so95194256d6.2
        for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 05:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763558563; x=1764163363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k4vi9yK5yizRXpBPxgBYi4Z/VhihOx5Z3T7IUgh40iY=;
        b=G6cpEzCbbwujr1VthxKGgmvKT53XFSivn23w7flRINyOK5vtZU81YgXZkpTKTMDqk1
         HX/JiDn/oQa8LNEh9rpOVmX5k8Z5S3RxiecxiRTw3nNO9Opej3OlYgJs+c2Utqr6G4hW
         kJ4jCjHbjW086O3fEXazOmFTWJMHPO6PsJ/CYXpTmNkCVq45X+qPBQ6/JxJhMZ0VUG0B
         jIIUR7KclZ0u2kH9kmB0zL4MzgJRZxyQgswzUBo6LUv7TLXO1eB+uNLyzKOB4Bx0Wsu/
         6m5HLJgyuyTBP9KCZMIGDaYGtnEKSkCsOtxCJJ9MndC43Iktrcd5LyEy+++JOEbVownj
         Zp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763558563; x=1764163363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4vi9yK5yizRXpBPxgBYi4Z/VhihOx5Z3T7IUgh40iY=;
        b=K0lWUxSNa89A13cxnskPa3RHZiF8otJafHJ95qqB5A0DTyj91vOC5hhRwI8PcQ0xFn
         /2GPGopqSpR1wiAY4jbm2rWQ7Xsu7UM+ae8uHnwrrATd5aahNeDpV10Z8ubLyr4JZn9t
         7DksJplkav/GEQgu6alSGh517jpd6SFZvFz4zZcPJglETGC6hREydWopPwHi3r4RiXTo
         Ro6V/+KojPUTUVcdcLe62TH2TQnhimaexOJ7CaP9eHu3HYlnp3zge4y8dJkcrndr3NXy
         hIGwRT4pMPu49XyyMnaFqrBQyV+rbaxNolMSEkcdTrNUAVzhurT50/dQrJ7mm5Ex4T0v
         OCKA==
X-Gm-Message-State: AOJu0Yyh2sE+vO2xGfVaTtyArFtDX/x9FGXUIo9f5hEXA9yKr3ffECrk
	0Vww07o/ySqXseqpdkY32p/zfybgfnKL8e37hQWZc0KuolorTcNLb+9Xg1B22o+l
X-Gm-Gg: ASbGncvVG83Vv4I9XBAF/ppE/EkePzmf6hi7j4TtCfetXbtzXNJpM33221qVDPtI3Zu
	2tTbH1F1o+n2l2kcwOtw+D8Oe1B+XUqjhG6dCy7SsD+s1mMpp0kKdLlCGBBfxb6lk5BovaiU2uR
	v7DQFwlxlZ542c+7vRg6zwTOmjRK8/UYxYHdwV2Vlo0E8wPzadddLjL5NywJmfHsNEsXwHWUXAh
	dmFBB0D2U/Ba1ht33eeCPC82A6iAjPEUKWu7H0XU2ruThQfvlCKGcWp8veUJgfArICByZyfmxSd
	ZWuZ6fTLSEsYWaxRZAdmOhUbBSoXgdKly+jD6xrq9aNWyaqPDU4uh+2aiPrSX9LXyUgxQqj3Onb
	pDxH9j3OIFlT2cfPHo+11MCyGHV/fX1HP4kUcrnCk1DNg/Bohf1HXDBFAu2psQUXLBndFUWE1FJ
	QoUYfU07jBHqAaI3d5c92ftOjaFwoP6ydy/4ziUfukc98=
X-Google-Smtp-Source: AGHT+IF6jCdJHDBv5TAon7JFHpyZlCWG6L4qAwVXiCcVOMpTRcglpISKmV1GmsUY0K0Xh+dbWQekCQ==
X-Received: by 2002:a05:6214:410c:b0:882:49f4:da20 with SMTP id 6a1803df08f44-882926b17ecmr341321446d6.35.1763558563090;
        Wed, 19 Nov 2025 05:22:43 -0800 (PST)
Received: from daniel-desktop3.localnet ([204.48.77.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286314557sm134476556d6.20.2025.11.19.05.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:22:42 -0800 (PST)
From: Daniel Tang <danielzgtg.opensource@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Nathan Lynch <nathanl@linux.ibm.com>,
 Paul Moore <paul@paul-moore.com>, Matthew Garrett <mjg59@google.com>,
 Kees Cook <keescook@chromium.org>, David Howells <dhowells@redhat.com>,
 James Morris <jmorris@namei.org>
Subject: [PATCH] lockdown: Only log restrictions once
Date: Wed, 19 Nov 2025 08:22:40 -0500
Message-ID: <3641397.L58v44csPz@daniel-desktop3>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

KDE's lockscreen causes systemd-logind to spam dmesg about hibernation.
systemd declined to cache /sys/power/state due to runtime changeability.

Link: https://github.com/systemd/systemd/pull/39802
Signed-off-by: Daniel Tang <danielzgtg.opensource@gmail.com>
---
 security/lockdown/lockdown.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index cf83afa1d879..4ced8c76dc6b 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -62,9 +62,11 @@ static int lockdown_is_locked_down(enum lockdown_reason what)
 		 "Invalid lockdown reason"))
 		return -EPERM;
 
+	static volatile unsigned long lockdown_reasons_seen;
+	static_assert(ARRAY_SIZE(lockdown_reasons) < sizeof(lockdown_reasons_seen) * 8);
 	if (kernel_locked_down >= what) {
-		if (lockdown_reasons[what])
-			pr_notice_ratelimited("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
+		if (lockdown_reasons[what] && !test_and_set_bit(what, &lockdown_reasons_seen))
+			pr_notice("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
 				  current->comm, lockdown_reasons[what]);
 		return -EPERM;
 	}
-- 
2.51.0


