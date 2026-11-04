Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802293;
	b=k6DOUA/nQbm9xzknrDSToRErhoUc5GgPiD6EDhxAEG6fN9JZs5iUkzblgNnBxEEfyxa2
	 u5jSSEbfDb56yfB2cYrJPtoD+rmuM7sRJQOK/HseqGDfl9rXPCZ9jd/QveZ7byMyBwV98
	 qypci8In1IF0YO64DAkcsSJKe4JhET+GqJih1i3QZs0ueYl+b5HZcpoX+KX0idcC5jSkC
	 5dYA7GEcl3vu3/LlirFzJXXGwUYquJ64JwvRCG+XIMH1MO4z0FrsrHe4k6uokjbEdDGTe
	 1MN178NeIfa/QtXocWROTKTQmejOgL23MdtRzKiVDdlVjR63vwS8wrdJE93i1ErbAIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=tbK0DxpI15F/xzj0V+jS3/ZkehU3GJ2IwlLX3CKVARI=;
	b=dQC0lYuRwN6xG9EirTqRobbY1WKo7kkmertAIxoGVXKav38U+P2Imnzslx3GpUZRQTNH
	 IkVUK+VhymtgzU0O0o7ss9NdVfmaojPhvFkBvX4QgU/j5uNmRS81l7/b4lksCf7nDnJ7V
	 maTam2RUGp9vRxUKROWX2W+vhCPqV+WHBPbbI53jjfrAPUDGeDdcOf+TGvrJ8VtWxQ6sJ
	 h1KSeYxftnAcpSAkIEgkYBAPLbcTo/Ceg/1CqC6TKkcnrguVdkB9eDxmtWkL7JuWw8u5w
	 0CwPh0zbjn5Adi0BfZbiI9UXXHTAM7Ypx/KjP8dNw0/jOnDio8+PJUkpU2dAMpRK3QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=hMF6SFKg;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AEC606A31B
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82AEC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=hMF6SFKg
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91e8938fd01so4616046d6.3
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 06:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802292; x=1794407092; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tbK0DxpI15F/xzj0V+jS3/ZkehU3GJ2IwlLX3CKVARI=;
        b=hMF6SFKgupujfQgIUunwc+ZsV+p7K5wU8YosMroXObR35CdjvQXy8TREQemqOnJYtY
         1dCDkZ59HfFzF4mcvyuc2vuzGU4MAueWV6R276BSN9mRHbUpSiEnKJJRFunpET976eYp
         aCqD0EH1qrZUmBMPW2kMFOy0VwSlYpi2e+6aHCBsXpiJSOcCwrzugFVt00x9D8pFQJjp
         u6PSEwFVESyp1u8hUFqDeQQPa6Np6c1wfahQt9Vx2LNr/aUxZURb552+ZlVDiEd+EExc
         4Y1i3zRV3SrKOC5QavSyPSEWBlG5PShSRafzWs2C9SWPOvNaoO4fLIsKjpx469FtbXpG
         +g4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802292; x=1794407092;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tbK0DxpI15F/xzj0V+jS3/ZkehU3GJ2IwlLX3CKVARI=;
        b=cvWDXHvFI8MWdtF/6/6H8lukHf1RJoFooHWS+vDoUFzRkjKXyfetlaHvzdY8iMIezg
         DuELJjFTmLUtdW2Cq6iDn4hwqBucKLM00a/eBdRdis8ZZv6014H8C7fdYIcZsy38O1zt
         WeMhjTFxvhSMo0NcVpVAd/qPbqKZJRh6pv1IYTuRzg9DBcCOH0O1ZBoozPisHCFwNnxh
         ULQ9FcjQZIt4i2wa/CkbOvXgd7/DYyjJl4kjmbYFQE8LGDGiQJSiEbOPWpV3nGoKdiES
         HAMx4yQ5gdTAWzNjMRmGgUmhq9Agx593r+MbkGNJyrrw/hbh11YIz0iPyKdWGFsD8vyC
         ARgA==
X-Forwarded-Encrypted: i=1; AKwUvBxCMzUkOypQKNDPjAidI2OhLCQpTPeCWQDu7BlB6jt/MEcZhCpaCXHHbPK6IgtMChWpoN4CNxlgkQK8fOHwJusdzv/UOK0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SLMKE/kMZNamc0vthuTNOmDjhO4Makza5xbOkwHVxzXyBaFTz
	v5rTXv1GoDgLWCL4nxM47EV+ezAxsJPlewycAodpeRE3vqX+3OJ2ndxK7/SMDYUXDPM=
X-Gm-Gg: AYBFou2rg1k0JtVhmAFOaVp7r6ruDnit95qTjnpoouqaQ0OzAiwDNWx832LC4+Gmv80
	oKvzkcfTbFHboPxyG2sW2vv07lTZUVJRM5HkBEtOPyo2rXZvcY2ak8m9U+bIJDZmpVDQIrB5DEk
	C6aot/U2BAsf7iYdqrMj/zSSV7ry5AkPPGGflqHUpi/mCFq+nSbUt2yvqXDwnZYG/hLUBoHk3Bd
	cZxU0dVl4i5R9jNCM1qMOIDKtsAaFTmLv+kRa597zdzejszPeV6XeSVQeZEwMZDQVPxCNVuIX6L
	lIA3Y5SvkGw/XLbpNl2YucvnhuYrppJ0VE7CrB+6b9HNgfveQTCvhoxTKP65QRk6FHuYo9XMehJ
	aetYXO4FMAFJeJRDpgEHhqHPNVAAvABoE/U+QrMibaMA5jGD1Nx1IlGhc6uWUMRghu8k8h6B2Lk
	8sw/RSZND5oy9MMCkK3XMYH9ew3U15uw5ltY2c+gonxfqm75RvDYUeIAS7f9msrTGrYEQdOZLZi
	sr4JjqG1SMm0ycWb4zpxvwomMluT6lAn4qxHmSvxGsOM1zan7iqiJh8+HgFJb6TP/w+48019ECr
	TRoRkIXJkBPKIGWt88UzN5tplTBzQCLqwsudSH8vx9NKwJo=
X-Received: by 2002:a05:620a:801c:b0:93c:5958:9de9 with SMTP id af79cd13be357-94421737389mr2553014385a.33.1793802292436;
        Wed, 04 Nov 2026 06:24:52 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d488f183sm211426985a.39.2026.11.04.06.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:24:49 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 14:24:30 +0000
Subject: [PATCH v2 03/13] signal: use cred_ids_allow_signal()
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-b4-cred-ids-v2-3-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=1239;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Tajos9jUkUopMDG175sSHwK/Ywn+i8f+s1b0fUOz6cY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKanLLbz8uAHSqS+hoNQ15sAnZXqr62P0wBayqZOWM2lg1Lh6ILOa7XTVDHuSJ+CfNbTfgJ4vNO
 0K9D8AzOMhQA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

kill_ok_by_cred() and kill_as_cred_perm() have the same four comparisons
each. Use the library.

No functional change.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/signal.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index dd770e68faee..aba93b99adb6 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -792,10 +792,7 @@ static bool kill_ok_by_cred(struct task_struct *t)
 	const struct cred *cred = current_cred();
 	const struct cred *tcred = __task_cred(t);
 
-	return uid_eq(cred->euid, tcred->suid) ||
-	       uid_eq(cred->euid, tcred->uid) ||
-	       uid_eq(cred->uid, tcred->suid) ||
-	       uid_eq(cred->uid, tcred->uid) ||
+	return cred_ids_allow_signal(cred, tcred) ||
 	       ns_capable(tcred->user_ns, CAP_KILL);
 }
 
@@ -1531,10 +1528,7 @@ static inline bool kill_as_cred_perm(const struct cred *cred,
 {
 	const struct cred *pcred = __task_cred(target);
 
-	return uid_eq(cred->euid, pcred->suid) ||
-	       uid_eq(cred->euid, pcred->uid) ||
-	       uid_eq(cred->uid, pcred->suid) ||
-	       uid_eq(cred->uid, pcred->uid);
+	return cred_ids_allow_signal(cred, pcred);
 }
 
 /*

-- 
2.55.0

