Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792816211;
	b=uABQG+bOzpzELA6biuWrlD4dAB2SGpdi9YFS/XJrszE4eRJohyYYWsqe4CsqO2sOQLwQ
	 q4Mi5DikNrO4xOn/su2/AM40tMBNrY1tQysUFWtCoek2G1BGCmGs496f6NheuYu4AhrCN
	 7z/zxhN3jbUr4LyMLIKfiegpUHnxUb9UQH6CIk8n3GJT1h9IZOu5uEt8wW198wltn5sSL
	 ap8WqLSXZAdHtgUaPd3OjW8NPLBKtJAVZnLUesYRz2xOHyhhncJPm78yRgxi1wUtnBz1Q
	 HmOI13ZuDPIWcz04DWlsiV7TPMClGik3U01BnP8Sw6opuojMj2hW9fYtJJWD9WuAGCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792816211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9fTxeCcNNzzF29W6dGmG1z9MBljc31aj3PxIdltLkYA=;
	b=LpcYakSl+ldEUcFHQ+AacFlcpR4MHefRA4glp8wghdeZpCfj++Wkug7EmmhbfFt4ghh9
	 mnuPJB09H8qkCi9IJE7GwLyTqwTcivl0D5I3ksFgc+OeTylTM4eEui1ISZQayDL7VOd7J
	 nN4xu6UTavSMKiKrXVB1SXhm6JIpMu/NNTTxLjlvdk3oGcD7+O1nNbGvFBDA9geH8h+Xs
	 ZhOUYtaeXBRunv11ep3xuFsvwmtdZ2eQG036KMKei/Lln5YA+OyCUm6hB/rh7Li+nrgwp
	 NEP/5pnAyh4nNhub0N3nefSfWrz1wlGzX3UCYM2lhVgmu7oI/kWq/UJCJByzfCrcJ0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hzi8tAPV;
	arc=none smtp.remote-ip=209.85.167.48
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7F8606A31A
	for <linux-security-module@vger.kernel.org>; Sat, 24 Oct 2026 04:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA7F8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hzi8tAPV
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5be3ea5a7adso1118216e87.2
        for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 21:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792816209; x=1793421009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9fTxeCcNNzzF29W6dGmG1z9MBljc31aj3PxIdltLkYA=;
        b=hzi8tAPVKcYUDH8FGM7gnF7SbUQSl1BcNQF2Iwy9MGDSO+BWQ/wJtPW0mA6FPYD2Sx
         Gmy/R8K8ThDhFVVcyg+ltUDc4il8tUuEYs/c7q82vOiVBOE1IoSOjDeYnbRyoCe0c0GM
         GxXvjQKp9XCgpS0g4UD+P5LN/87szacBjzpxVqDfRQkeL/K6hsafKppFaqpZwDgk3to3
         5/iIpo7CTj5UYTxPxFIJHF2S+Tn/W7wPV5r2BnMOTPgozAYvIztDam5qWwC3hj8eca5i
         6Q7+7JktppSrKbdgdPBhswliQ24kuenTkzTu8Zqdv3wewJwd+SWNP/ienz9KVQu8AWth
         O5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792816209; x=1793421009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9fTxeCcNNzzF29W6dGmG1z9MBljc31aj3PxIdltLkYA=;
        b=L8B1230P62po07h0y6UQJ54Dx9e9su/ipPOHY+uIoOXIoFkh4pFiS250rpMeVHZXXl
         6TD8rjgifXFQvSqRP11O3GHcjbB1Uf05H6X9COlIUpsdEZ7ABdi4At0w6wItkigmqZpw
         LwwDe1En8YUA2sL5cA7J/oUVbvYkgymV373jT7kFvosn1CHW6SB9ft4ATS6ip7g63Rpu
         SUAjJO4Iv3OZCHspPRs8wz23o0R46wRuGWQkyhoElI6YZ6pmw/9abIm29flUZQBscd4E
         w8Z3CsyI8h847bLVmBYYGFI23NtcmhNF4MR5FcPDKOvPWDeIOCTDXCdeqt0GFS5pkfaH
         wuLQ==
X-Forwarded-Encrypted: i=1; AKwUvBywKeXeKoM73xsmbrIrRCW2zt4ym+WFztJrhnRmFaFELf79dZprkvEAPrlpzD7buFBLwYttw95Sxx2bfnQlz8Ovnak783M=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEMxCCeRc0RE84E2RklqF+440r8wXecXG4kQrxjKDkSldjktcy
	XIQ0nF8NuBYf+BW0oS8cew166BiwVnyFmd9j+IymgpE0vZZwD0qxM0mi
X-Gm-Gg: AYBFou28KAtESudJxJhd8YfJXs7bppbtYtdMwW7ze7TneOekWGUkZDiVGMwE4gyKg/n
	i9/16Hah2VszCy2kR7JOR2TGqVhoHWhWiMDLiUbfjigGaLhrk3N2fzaqOYkIpZLFt0Ca19pwYI9
	zyE2GoJ7IoGFr/BTjemQ5jEKeuuycvr13iV2moMfcA57OpJlFdLZu0eX62K8igdeq9Qe/2GdA3n
	gHxCOPVa8Advw8M/QCTVBgAaozKguAVWHWWsClM3HliWRe/bB8dDIAfXZZ0es1FpgLRqGDHTfFG
	spNFzgmFLz8a9aGwSTUiwb3k1AX6bnUo+EPf4lLklSQHlfbSycUwwTkqwv9ZNFBVjeSVyl5HNBF
	Hfnd2hErKm0bxISvzHyQYCTcA0RTpF2TRaQi6jTnhz3w/ivVNtq5AhrlUDt6/56hg2yYldKB9gg
	224Ev6F2T65g8GG2uMbhpsUyazVAEeWHpV+/GpEobuIa191R26FCcKRLbJwUP062uvJ/U7pwCpZ
	evWf0U3JL+KpSiETdZmaCAIdNzqtebT3T7CtX6+sc0IlyM1KqfqKtJ9/STH
X-Received: by 2002:a05:6512:6694:20b0:5bf:b7d1:6488 with SMTP id 2adb3069b0e04-5bfb7d16896mr109075e87.52.1792816208523;
        Fri, 23 Oct 2026 21:30:08 -0700 (PDT)
Received: from localhost.net ([196.240.54.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7a6b051sm168295e87.14.2026.10.23.21.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 21:30:08 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Eduard Zateev <hackerowskiy@gmail.com>
Subject: [PATCH] keys: use long workqueue for garbage collection
Date: Sat, 24 Oct 2026 06:29:44 +0200
Message-ID: <20261024042944.52493-1-hackerowskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The key garbage collector can wait for RCU grace periods. This can occupy a
normal events worker for a long time and contribute to workqueue lockups.

Queue key GC on system_long_wq because its work may wait for long periods.

Reported-by: syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=c15de43f1e7fffbb7b9b
Signed-off-by: Eduard Zateev <hackerowskiy@gmail.com>
---
 security/keys/gc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/security/keys/gc.c b/security/keys/gc.c
index eda445f815d..b174b8c511b 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -19,6 +19,7 @@ unsigned key_gc_delay = 5 * 60;
  * Reaper for unused keys.
  */
 static void key_garbage_collector(struct work_struct *work);
+/* Key GC may wait for RCU grace periods, so queue it on system_long_wq. */
 DECLARE_WORK(key_gc_work, key_garbage_collector);
 
 /*
@@ -57,7 +58,7 @@ void key_schedule_gc(time64_t gc_at)
 
 	if (gc_at <= now || test_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags)) {
 		kdebug("IMMEDIATE");
-		schedule_work(&key_gc_work);
+		queue_work(system_long_wq, &key_gc_work);
 	} else if (gc_at < key_gc_next_run) {
 		kdebug("DEFERRED");
 		key_gc_next_run = gc_at;
@@ -85,7 +86,7 @@ void key_set_expiry(struct key *key, time64_t expiry)
 void key_schedule_gc_links(void)
 {
 	set_bit(KEY_GC_KEY_EXPIRED, &key_gc_flags);
-	schedule_work(&key_gc_work);
+	queue_work(system_long_wq, &key_gc_work);
 }
 
 /*
@@ -119,7 +120,7 @@ void key_gc_keytype(struct key_type *ktype)
 	set_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags);
 
 	kdebug("schedule");
-	schedule_work(&key_gc_work);
+	queue_work(system_long_wq, &key_gc_work);
 
 	kdebug("sleep");
 	wait_on_bit(&key_gc_flags, KEY_GC_REAPING_KEYTYPE,
@@ -322,7 +323,7 @@ static void key_garbage_collector(struct work_struct *work)
 	}
 
 	if (gc_state & KEY_GC_REAP_AGAIN)
-		schedule_work(&key_gc_work);
+		queue_work(system_long_wq, &key_gc_work);
 	kleave(" [end %x]", gc_state);
 	return;
 
-- 
2.55.0

