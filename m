Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802300;
	b=X0kMDqPE8enl1NYPpUWguuihWzThhDmomBcZkrX3rKLs3NFWtzuW/MkEFh92K+38Eo6t
	 BP1XN8L2vpMy3jp2xK7hxN0wTybuG8Zm2Rb2jN9Xp3iuC17hhzgQyz2ZBXP+0VBd5JpYD
	 QRpPQfFdkWiOVLivG8O447PGH50ZrRgDNbRXln87uvBfRJJk6hYEeoVEUxFiGDTdKBQYZ
	 HWYtYUjn6CfGU78rKKENQJG6nMkuNhupjN21SZGgCjCNQCx+DdjzsI9Vt661d4GMi+sWc
	 mmsboyoNUhyM11GUUpE/UBk/2S+YzRDO4kYp5p+h7czUmCO622L7zNcb5o06ShQ/l7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=VU9CCWMXsMJDGUFdbIvPqLOpKaS0EeCZQGKXkHHjIys=;
	b=yxy6dpvuC/tBxrHCkIv89yVsH+kbsTTgWfe1JzixVVL54qx4n+833LnjbhM2sRik6PdQ
	 P8TB8J2S+QD827KoHTGnBqLO07kUVgWhqM4Io7+7IvxAJ9t5K+smvLaHNpz+QWpDQujNo
	 sR5j0w5BSZMSFtnNLzXCS5E/zrZHO1CXsqUi1s0AMO3h/9gERE7IYlJGJ/oCuwl1a7Z24
	 BxUviu7F1dyVYb75Tag4powf6cTuzAeWQx68wGSyyZuUoy3f1F20dQXm8SSKtT14b5JXx
	 AQ7NSkzl07ddUe3hG8Wvl3LhV2gAd2ZmmpA5yvv5fRbrMzZBzcW4MNSonMo3RF17apw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=kuBN1KIA;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D93606A328
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23D93606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=kuBN1KIA
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91c73c63116so9063366d6.2
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 06:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802299; x=1794407099; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VU9CCWMXsMJDGUFdbIvPqLOpKaS0EeCZQGKXkHHjIys=;
        b=kuBN1KIAIcqWlPpqEM3FPjPIzWg6GGGhqXNWpgSQfbVY2/GpOhV60et09h83Hgzj4n
         08IbbUVbFuLSGT8N5QpxI139QFG8rZBQXOJ4bd6tvTAb2eas3lgjntlJED/6TvJIg5id
         gPWFf6Sqhc8Jy+aBl34beoBYJeP3yzCnoH2W8GL1i3woiSVXrNnxU6b5h+blXqiaGb/j
         RzVWfEVxLp9Tg6l2bcAYDna77PWcIm/gS/mPJjxEgcAf6aaNLKDJkvrFXCUoJ1ZMC+Dg
         LRzvuWDxvjVwKunkJhqjOsO5BGJumAf4WztIa9Ig8UR3NWQd4kO/nnu2xk9o7i2ZuTp6
         COVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802299; x=1794407099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VU9CCWMXsMJDGUFdbIvPqLOpKaS0EeCZQGKXkHHjIys=;
        b=h2g3uS06PAhzIIYcw7RQbJrA7Bm2ED3IQjflUlu26shSeS+4R7QT//uero/S8tbtoh
         er/MP6L9bd959HfEBL0wtw4DWvqDntVQdylf4uRJYHmOgqod3h2M9nOTFcaloCvCz5xc
         tubKS8mV8JvXx+cfd5RgI4q04OFvMzGtt9UtOQSA1iqQY4x030MvOv9f5OYmRKcIbshz
         JR2NogA8MmvqJG/NkoZkgZHpOJEfWLOSP0UC7QG1ZJjozBEQckrW2Lzm+HVgPqT/GLW9
         QRvG6FlVloNZOdIVdjKb3P0cia7uapn0Du7SvORhgma4GQghPdJ1P+xnD4/2W5N508Ib
         RjLA==
X-Forwarded-Encrypted: i=1; AKwUvBydVljo3pHCpfugWSQbAAWiihsUlEtVLfeq5QtszbVSUR4cJ9j8Ea0MQSQKxqPPmSReVyeJR/Z2sIHFZqoOFTQsPI8xI+M=@vger.kernel.org
X-Gm-Message-State: APuU4Z+P6tial6HTdux4jAmISMEWVEL5AOlNECWBY1+OJVPXWdQwT698
	zJK1+rzsBocRJCDZJamFufKZUeTXBfG5W5FWpC49RKkWRiaMFmKygo3frFJiHIaPsc4=
X-Gm-Gg: AYBFou041t1uw61sOyuNo/87TtpqdORg6iodde7DijNlBriEDV9AXc0mibmSiotmj6H
	zwgrq82YGZJb7W3z35mWOWJ2k2PFrWaWdwGq/mDQEPr29HHOACLNfJNgLlMQNcdQeewmzbPBZUV
	uUzUbXKzH9CpczhDHkp1E4eQAPegFRstmnoqx9Rp/qpZRVWUPNrmaMIcdUX0LIgZAywYohlrgFN
	zBDqRocWiFUSAeEhPUG2dfEDc2MF4E7CdhSnYssl4dRxBJA77JLlTjoJJh2puSAQGM07PShz+vW
	jwCgF702tnNLdXclkMUU536JpYB0eZUFmisPNO3gVKYUkK5rG28G4i2b1iUmGyN3ZwtPx/EBf7t
	Ayc+WcQoMwM8Cw5+oCQGN4pHo5A50iQdeAjKiN0kHoGosckstUsUfn5UScnDykKoflE+RqChBx3
	/AymSipAzV4hxcg2/JUTkHDS+5Uwz8yzM0A96moKseiQjrzsNNJ37HDm4ScdH3/wzxCBN3cJHL1
	gwXGkEHR0Azi1n6pNi+U/+zDa4nt2Lngmj6vAPSAy7WoMNyVOcM/wM1VqzKdKrji/jiBQKZAs/P
	DgdHw/e9hj3zJsWMuSAHXDAw3zGWK3pF8DjG1cz8OBH4hQ==
X-Received: by 2002:a05:6214:3017:b0:91b:8272:5157 with SMTP id 6a1803df08f44-91ca4a0c0ecmr246262196d6.2.1793802299117;
        Wed, 04 Nov 2026 06:24:59 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e70f84dsm19893096d6.32.2026.11.04.06.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:24:57 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 14:24:33 +0000
Subject: [PATCH v2 06/13] MIPS: use cred_ids_allow_sched()
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
Message-Id: <20261104-b4-cred-ids-v2-6-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=819;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=rd0qIu3v7XZa7hSGzj4TvDvAs/c98iDo6Z6DNJiUj10=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMBBsZQFNgRQhiNgIbdVe7nyilFEJaLVh1a+7/t9IHd9IVQMoWWgmknUBy9Z8Uk+sq95QEuIDDZ
 DanVJIvIu5QI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The FPU affinity code has a copy of check_same_owner() from the scheduler.
Use the library there as well.

No functional change. Compile tested only.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/mips/kernel/mips-mt-fpaff.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index 4fead87d2f43..1ac86a897956 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -54,8 +54,7 @@ static bool check_same_owner(struct task_struct *p)
 
 	rcu_read_lock();
 	pcred = __task_cred(p);
-	match = (uid_eq(cred->euid, pcred->euid) ||
-		 uid_eq(cred->euid, pcred->uid));
+	match = cred_ids_allow_sched(cred, pcred);
 	rcu_read_unlock();
 	return match;
 }

-- 
2.55.0

