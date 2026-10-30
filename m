Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793331199;
	b=T/weyJrOiXgrjGtMvxMJJ2q+8uVjFKIEU8CuJzFaY7QDt3QH2WYSWFD5raREqZDKlbN1
	 LO0aF4K9SqKt9I2lMgIt6s4V/cAOLuMEMHAf37DplJqnaZMPow2fqFdOVY82Kfn7YS97v
	 9VLa8xIO/7xEPEG8QBvnMR/kpt9T2s1t0KlNjBS7cyFKZ6yX3UJGOTUJHBuxgGT3TbKp+
	 rwYgyBIzp+DHpwSy5tTKcc7jrwUV5Zuz33c6tStI+hfhooFzOi5IA579nh7e1DMhkCCmL
	 to/+yoxEAdBrnInvcFeozmI+cB+0yRkmu6OPv24Em3P4llqGSsz2rUstM3txtD6C2kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793331199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=c1EF8TuhBh0bP0+JMlUsrkZ4srW7BPLAHvin7dAYTws=;
	b=3zMKTVBAnm10PKzLtIspUDbdr0hRG0dF0lMKQe4Ino0UnGmIcydTAthgE3aZ3AgYdmJO
	 vZIvv7vcEGRiFdMzx6ypi9d3/HGqRy9PmsroNdDCnZEQTuMaJGIWB4wVJT7xAou01pAJu
	 ZWMFC8REQhZWtoG4ZgjhOTzhKXdymcVIQwp6wiku+Ixo4rC077jjbBrn/s75cizCJ9gk4
	 tJghj4392z5nDiJHqrBwhkcLLCpAZ2CPGQClMy6TUpefXsFGGdHAKFpxOtDD7BEnvNv5Z
	 kVQGR0BU3l8CUbiCIThVRIZNnN2ZKBXcg3GZfZRFhAbdRAkqS7LL1WcuRoU+r0I6BfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AO6t4VdM;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7877D606A31C
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 03:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7877D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AO6t4VdM
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso200272a91.1
        for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 20:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793331198; x=1793935998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c1EF8TuhBh0bP0+JMlUsrkZ4srW7BPLAHvin7dAYTws=;
        b=AO6t4VdMJzdHRO8xbmcDL8U2gznu11et7yRIZnJzTkzMgZyRKT9b4eWhL7Y6kkgmZh
         K1ZaiVx8HIpuLfHi6KutG/ECRkGOcrSRLfVm1ITWPD0hOlsazLIzMnwxqyeSWoU000Gf
         yfCFkvN+ExIfR65JgHFixRd6kUUEuCbfrVPwLlMLmvTbS68W18LKF/CQf1XiM01r4TiB
         y0dvS0AmlIpRWj9K9TeIP535yAWEIv7lcfEUPqbGILmNxA3075PN47Ci8hlLy9vRxoOk
         5LAn+1J3x9w1AgxftoaFDDVcOevVSEsNSj/vexlfz9cX58lJ70TvtUCjKUaZCT8WMDuq
         Vurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793331198; x=1793935998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c1EF8TuhBh0bP0+JMlUsrkZ4srW7BPLAHvin7dAYTws=;
        b=NZaUJVXHYx05P3mbDIq1dBakzjg/5sCGeAmxPITKH0MH+qGhIlAISW9j1DQ/wtgf7h
         dkhiHjE7531C0gi6e9R1I/vCVnrFiE9FGYAKA7amh9IVhsmCkSRfbkb+P3T6hFRHT870
         guqEWehLzKr2aFlGnOBFVASwHqvXN5DR+hst8S5ElAytPgIfx5lRHtizICnCK+fpviYp
         rrB1ds5+ojrhM47PvaM+2Gs7ShVRvdLFhkul77eG7IbOJB52LEgW+ylVbTM/JJ2iiCoC
         iSetmMAji02fwm+vj8lMCp2ifobKV60mptU+x61jNvOkbuQ71eW01XabzWqFhnTBBhaT
         eWzA==
X-Forwarded-Encrypted: i=1; AKwUvBwxmtvQMkX8+nNSXFuPQWnRDDz6/GPQu49ok09s7EBiYsdUf5AHr8hASueC2XqAcXINMHTeHgrm5Eg+KZvYrG61yuqrwLw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJf+ryBDR/Q4kp9tSWTCQgn1O+L8AVfO+rOmsuitIG+ksbT9Rnq
	Nyf6ccaNFT4Ca4eGJi3S3n81xo5Ohhbb9fvQC8O3zoWRSA/UgGtQie5V
X-Gm-Gg: AYBFou3863AhJneXQbl9OmVs3usi4b173mLDP0msv+JVbTrvDgVxI/mPLfPxiYWRERY
	aacA0Crn1VSJvSORv9so5dW9EsNHq0pAWdBBVT3Q4Rt7i0DCWfEcf7vC3b6Yw5FPhXYkYmdyw4G
	5z8BVzSJIthIrrWITE7wkHgfiNNJs1Ns0tXG06VumR/3th3vVDsNaHxcw+/hMqMN96WohtqiGQ+
	ez4N4CFPKRS+2TN3OxRA4NFvT5380FjqNFt0cCcqQvJnGzMnMklQBPqv/alhkL8jIawWhC1DJhr
	NasbiQIvswqO1HK0z2RDT0IovGFFDLEw9XKMI1GyNE3KWWtljMvgxH5IeIWD6JwGJEh0A+bm0NR
	JX0x0P9FSeRjAXZZzWyXvqOvL6nXiFBbwUJiDxOIJEG9L3cPPYSeCpHAi84SeGQIBAbIzlaKv6n
	uLOZLOri+IRmMFHonpY4D6ec3atTbHEypwlce9fR5A2DJBr6SqixUW2cDRLC+mz0bRoPYHaRHPB
	7DYsnhQTx0hlDqvFi6va6OqE2AjmtKY0IvRYE2x/ZegR1vgDw+orMbec8DNCd+yJaGkzV+/PbIq
	m992RpJ6eLTLexF4cqmsp9KIxpdxM1PhcnA05w8IWDhj+Zs=
X-Received: by 2002:a17:90b:1188:b0:3ad:b7d1:8631 with SMTP id 98e67ed59e1d1-3ae897eb75bmr583318a91.17.1793331197821;
        Thu, 29 Oct 2026 20:33:17 -0700 (PDT)
Received: from kdev.. ([187.15.154.74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845aa27esm1970602a91.11.2026.10.29.20.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 20:33:17 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>,
	syzbot+ee58b040032d8bed63d9@syzkaller.appspotmail.com,
	syzbot+557fdc985d6ac3831e14@syzkaller.appspotmail.com
Subject: [PATCH] cred: mark the copy in prepare_creds() as a data race
Date: Fri, 30 Oct 2026 03:33:08 +0000
Message-ID: <20261030033308.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

prepare_creds() copies the old cred while other tasks may be changing
its refcount. Mark as data race.

Reported-by: syzbot+ee58b040032d8bed63d9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ee58b040032d8bed63d9
Reported-by: syzbot+557fdc985d6ac3831e14@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=557fdc985d6ac3831e14
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
Compile tested with gcc and clang; the KCSAN instrumentation of
kernel/cred.o was checked before and after.
 kernel/cred.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index d01df40a9a386..d212db445c138 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -189,7 +189,7 @@ struct cred *prepare_creds(void)
 	kdebug("prepare_creds() alloc %p", new);
 
 	old = task->cred;
-	memcpy(new, old, sizeof(struct cred));
+	data_race(memcpy(new, old, sizeof(struct cred)));
 
 	new->non_rcu = 0;
 	atomic_long_set(&new->usage, 1);

base-commit: 881f19c2ffbc73f351b257e09c71e6059939b770
-- 
2.43.0

