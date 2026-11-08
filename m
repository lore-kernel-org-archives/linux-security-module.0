Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169465;
	b=LTs1EmgX9kX7z7XVgQaROr/9taiSKPy+BEXLABCHJ1EM/YbnQeHAkGpO7maAgzAPdSyW
	 9Qwt3n2+A67y7klc4oaOGzwovwirjitldeB3ZfnN56E2KGT00+EWr5vDWORczuNAkm+d6
	 YGeyWPNhnAr/GAw1jEYf3ZGUG7TcHSjRq1jE/XC+XazjKrfRPfm3jOHVTwgCXk5QHTWOt
	 KPgkyIcwQAAf4uF2yn39u9LNjq77m5AfIMJewIrqY7GrxqKB2QgwWouF2lLzNky2yNpg2
	 r+P+Tmtpj800lylTyRapsnz5oSUi4fma7srTEm2afAvxzOV+o64JUQp+b0BU8ueaZfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=LVXPEVlyVhyUrhrzslMzMs3XMd5k7yY1+/ztFUw4sp0=;
	b=t2Qxw9owSVCyt9VZH/jUnASaZCt6v9heTNl4mqD6fodIOJZTMOIzMKXmMzULqmDiYr87
	 7NFod2LtlUWTdeU0jPHn/YekCzljgCobyIW2Tp3Qm0/tBu6Ula0pAkb8YlZCiE9QupilM
	 6UkSpH37pghusISb+1F4rhT6CMDP5PK9hhruWYHy+Y/dEaDLLG9zZeua4SZjhq5TB18fd
	 zORJJ5HA2CG5/HWkCtvTbst/vR+dfnWQvs1LefGQ0le+KVFn7dq49kJgjSFiASGSE1HAk
	 1+xPsNBOpDJ2WMheLsohsFwb+KRx1vmsG231cHv8LdzZJhk5Fbm3mY4Q3QG9riSm06Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="hRiL58/C";
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484996079DBF
	for <linux-security-module@vger.kernel.org>; Sun,  8 Nov 2026 20:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 484996079DBF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hRiL58/C
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so1844655e9.2
        for <linux-security-module@vger.kernel.org>; Sun, 08 Nov 2026 12:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794169464; x=1794774264; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LVXPEVlyVhyUrhrzslMzMs3XMd5k7yY1+/ztFUw4sp0=;
        b=hRiL58/C+yEOjBcUCIMc4lrMyeaY3yRbL5vApL5nAobdmxS7c6/W8bhLRKoH51w17s
         iSdfLvaRR2EE4/PYFxX3MzoPef/OExTG/rX9WeGaV77qJeusrE7ZlaML/f8nghZVZQNz
         ZpwhUMXEjxc/6lMJ1Z6zrCTcSN3ssP4p9fOO1jZ1et+YmgEb7YQELg8tWFZHSNO8KOZ8
         QALJHTS8mqg9tHpUgCYle1S7va8g2yW4OSQYEP6cnum6tXtzaEZJAgbvTguwDZkcZzCh
         hZfOk6Bv03aF58fjMhgpT9Mx+h7JU8sxpk6Ht2rhHOALGZ+Q8M6RwoHHBJuU+BcXn0sr
         GZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794169464; x=1794774264;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LVXPEVlyVhyUrhrzslMzMs3XMd5k7yY1+/ztFUw4sp0=;
        b=pAuh747fyPNqxyQ3xTfXGMAAk7tSisMTecOtUhJ9z8IbiQufBE1LuONPPA+uEAFBe3
         MA/lQ4k19EElu+x1xKc8GW/5UxYNvLuuwdsnbXJQxY87gH2xThsBk419DwRH+fsJ8RXM
         2xfXDKBAy/m+7jHU/xpSmwjvNaVzwqCgaO79xJHvfXlbbllSJx+6yui10JF6fUPMWXkJ
         OqI5hRaJ04ToeUrHX7bI5FTTxLEv5sPL2MbLLT3hQmT99x9KGZAT6sEr/789GKuY20Vv
         9eHfhMgcAKkJF+I0oyESsIJiFRZynsguuguGixMmEsOqa06vAFiIIw9BDfXFwhYGGrgs
         QGWA==
X-Forwarded-Encrypted: i=1; AL+hErFNjw2sVkSWSApxqv/48CP3E+Fq4kXc6mteAYt6Lwr3Qy+JyQ5MKlLQeULeUf0Y9wrt51LmrhsrAR1lSrnMSxuexEosmIE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+8B8QsapUR2GwGwrEuneCVshbpfRMaDkBVD2DaDN4Lpg1YQWQ
	LbUFd9ppmciNSzrGH/LwgK97O0cWeIjgYZnX8v+Qhsa6ZnWKy4f6xfyB
X-Gm-Gg: AYBFou3BxPvaaS1ir2t1unhvAk++etFPT2kRFQuUrG3OSWOgjExEpSO9Ecw/XGKRhP+
	0aofFo0isqJ/EESoCQRkunwsxpiTJaQONlsa1qsTAHoGS4KWv/Gw9ggmgk0lgUsjAzeMHIs8CkO
	ABT1eQeftfAoAu/QV2N810k72E02gwz/GJj4uZsjrKNCqedKcNb/ianLouOz2HcJR19DraTKUuU
	sfRbU6ORIX+/33UgFsAhfaMTDoKZVt8kEirzNecIlTkUt+cgOMDxGTOT/bvauEqimD54/Bpxdmf
	Gpgnb4gRsLVBuw4pAYtRghizVrtyP4HyxIN/xex0aVcEsJR2iWkzAZ+ial1fEQ9fFdsvIQxHMzp
	D8QmHzfER2bR4ioR+q6hugrVm5LMg9MqBxQ9KvIPfi/sh8N+zZxtEavo5Y6p9SlnnMwqXH6f6Uy
	ns93+Wkx8IONrsT2J+PfmbeXYeZgcH6hxiLtwt2pPhbtHj+Na9y9oq01IaaTpBeqr/NMCbKMSG0
	ILPeyfCVYRdKX/7fcWwgePeKXMDibGJ/5EIgZNdc0+/BvPuMerqC1RsGwAIIRfWIKZL1rwu6mOD
	uUBjrWLCq1xQHKjBhGqhndeRzEOuFBK7J2QA8wsbdb1WNPVr3xhX9g==
X-Received: by 2002:a05:600c:3113:b0:4a1:f720:74cd with SMTP id 5b1f17b1804b1-4b963c91d7fmr43603045e9.24.1794169463555;
        Sun, 08 Nov 2026 12:24:23 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597748acbsm5733788f8f.44.2026.11.08.12.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 12:24:23 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Sun, 08 Nov 2026 21:23:48 +0100
Subject: [PATCH v2 1/4] landlock: Fix layer composition of
 LANDLOCK_ACCESS_FS_REFER
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
Message-Id: <20261108-b4-landlock-refer-nonfs-layer-v2-1-2b405fc1b3aa@gmail.com>
References: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
In-Reply-To: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
 Shuah Khan <shuah@kernel.org>, Dwi Siswanto <me@dw1.io>, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

In landlock_get_fs_access_mask(), only add the
LANDLOCK_ACCESS_FS_REFER right if any filesystem access rights are
handled at all.  This prevents us from accidentally treating
non-filesystem layers as if they handled LANDLOCK_ACCESS_FS_REFER.

landlock_get_fs_access_mask() is used when initializing the layer
masks for doing access right checks, so this bug meant that we
unintentionally denied "refer" (e.g., link, rename) operations in
layered cases, where the same operation would have been accepted if
only either one of the two layers had been enforced.  If the rulesets
individually allow an operation, the composition of these rulesets
should also allow it.

The bug only manifests as soon as one other layer handles filesystem
access rights.  Otherwise, Landlock filesystem path walk is guarded by
an early exit for the case that no filesystem-enforcing layer exists.

Reported-by: Dwi Siswanto <me@dw1.io>
Link: https://github.com/landlock-lsm/linux/issues/67
Link: https://github.com/landlock-lsm/go-landlock/issues/66
Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
Cc: stable@vger.kernel.org
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 security/landlock/domain.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 935e18b12b3c..d9ebf4857fce 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -262,9 +262,16 @@ static inline access_mask_t
 landlock_get_fs_access_mask(const struct landlock_domain *const domain,
 			    const u16 layer_level)
 {
-	/* Handles all initially denied by default access rights. */
-	return domain->layers[layer_level].handled.fs |
-	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
+	access_mask_t handled = domain->layers[layer_level].handled.fs;
+
+	/*
+	 * Handles all initially denied by default access rights, but only for
+	 * layers handling filesystem accesses.
+	 */
+	if (handled)
+		handled |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
+
+	return handled;
 }
 
 static inline access_mask_t

-- 
2.56.0

