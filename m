Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B791F94F
	for <linux-security-module@vger.kernel.org>; Fri, 21 Aug 2026 02:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787280817; cv=none; b=gFgXsMsNOgB8XQIdpanF34EclvspNxL9TM0a+YApFVuHVgcfxVKu91oyS/LVIj3K3MBg3QcoOFc/RCmC00dpgKd1Zaa2EvR56faVh8uttVeHB7SdxXvbSsIpb7zJkNywJoCnbEBt3SUJrS/9Hm1mjgRPBRb6SNxN/+lowY/Ej8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787280817; c=relaxed/simple;
	bh=fc/UOG1joBYpH+1V5oaIRdcVOyoy8B87yG2u2Og7z68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gv0GmG0kasK1Jo+Qq09Cv/AaXedAZwYkgfbjfmXB1Tn7CKSo7ZE0wIHHHli4ihxH+E7AKAytGM0foTwfq9WByRahDvPdRyRSVTk02vkdPMOfw3MEueV1b6xwMgV1QJN5DrxUe1WZlH5+aq2EQRBziiyaUS7OuqZye9OPEXWTmlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=slrLyGZX; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slrLyGZX"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso1095745a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 20 Aug 2026 19:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787280813; x=1787885613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8KBiC8cel7Bm6yYFzHAwDueQ4V69k5ZlAn269AvVB4E=;
        b=slrLyGZXRlBjjaAkd0MahHzdCpzet13R3GA5iat/xDHog3lkMRPbZGCTjSGYpjYHtb
         2aUbAEkWsl3mgIMdL8CAxlLZyEPgwmA78s3Zgo4HrMAHw5xIqZuQ8l/sprkv2n/hBGuQ
         k8zT9b/dPgM/zjdodzyNZVFTiHEB+6swEZoDSRrFyJtUuvHCxPsr6USy3+JmEprVe0sY
         nGlcR03kJBSq4uEBOEg5knhLJgulNbeKNajAWBu/46i6xfxG+uhAwcMMT1cyTOly53VX
         4c+QF7Y/TO1xAflw8VXaw7ahC8U+892OibYDWcSBXxR9d3rvUCojZ2xQ61Xu4geFr5/X
         t3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787280813; x=1787885613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8KBiC8cel7Bm6yYFzHAwDueQ4V69k5ZlAn269AvVB4E=;
        b=pe3JMESsE0MC7xLQVKuNWhCokCf3jzr/kezitUToaAcRz4kWTvmBQa+BbifA21spws
         eJYMUOC6VmDOff8thXf4YLbxAdxYQXVDEgfEKtu0UtGNI354j+sHmU+0iVaNV4FMIwZR
         MCSINSgMIQIYab+s/on5lYIMAgawteb4EHYQVG9c8Ua0ukBzyGeOcVoyeFNKO8RuuPRQ
         WYHE6tOEckxwued43PcVrChMzcq53wUQQRopLrKL86N1Yn+XoHEl4KeazJglGrAIZGna
         LFHR11qOwEXY43Bkx65NFB1UnI2OKGTkKF9Nsi5iY3CoEWiggX6/7vrHF2NugWJGzhHf
         wgAw==
X-Forwarded-Encrypted: i=1; AHgh+Rpbt/AHHVihxr3vUE5tXhTOqWFhKS0u2l7oXJVQtOFY5nb168DN3AFBdJSH49Y0iroH9eaVxQBlHx+4YL2PTzbG54qUIEA=@vger.kernel.org
X-Gm-Message-State: AFuF++mldp4a8gDsfzSM/gbv+IRI6DY1WyMkllPBnYGMK9/qeUnmECUd
	1rz7+hFVpsM8L+/mO1tdMttRBNFqNHsrwKtq4X05Usfb2ISB0ENGvA11
X-Gm-Gg: AR+sD10WUL80456At6jOZZSuQKku2bWftg8fkZ9gZKBcMrVNA91WTqwJsZsi6Sy7poN
	2YgG9rvDfiTohFbfdtBoueQwDuoJJuT71jeXBNztfPZBqL2jPEZ4n125edYEyoHGHGVt8d3nUv8
	zsN/5OKnV0s5kDOMwnrlXQxrDJG1ZCvCqLgHwVwf0g7jALbRt2s2ZffxfXWyGRzufg89gUQ7hFT
	65EaI78cotyxRRr+gmbYkCp+S02wsspn2oyEONz8dthYOu/3KPmxTjFzakav4QQFm09W+0sRC8i
	0oWSXlEbUjD7s4WIJb+6W8bi1g2U+gPyVz6w36l0DmH5+NoyC5LERC57tL3Kn1Pbs25i/CxrcQF
	Aysgv7S/RswsWktnRj09f5UutpxBvcXO7mRyMsdCSXAgCfyp9Y9ztqidABkoNMYQKAi3aaX57Fg
	PsHruJVmhARDcHoGt3nwNwNFEWi8J2ZUoW1uGrtl4qQNMRj1zisGX4V4OCebMx1KQhbnqDgZXwh
	zShTn4Y52O05LaMCDAGhtysfWrliecvLPT3SfJEdtpxmARYWLAVn+5ZYeCKOEquniJ3BB5Ahluv
	4cMtG6uIVXX7Os+SQR13i1Zf1a90+ANI/kaAPmbjuxcyk0d67JJWLDCsw/FAmBxyk9HeCkZdEJP
	H04H5R/pqCtWn
X-Received: by 2002:a05:6402:a0d9:b0:6a1:fd14:8832 with SMTP id 4fb4d7f45d1cf-6a42f25843bmr3113530a12.12.1787280813127;
        Thu, 20 Aug 2026 19:53:33 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a103-bf01-4ca5-89c5-9aa3-9754.310.pool.telefonica.de. [2a02:3100:a103:bf01:4ca5:89c5:9aa3:9754])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feeca188sm4214314a12.6.2026.08.20.19.53.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Aug 2026 19:53:31 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] keys: fix lost wakeup when reaping a dead key type
Date: Fri, 21 Aug 2026 04:53:27 +0200
Message-Id: <20260821025327.61488-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clear_bit() is atomic with respect to the word it modifies, but it is
an unordered operation: it implies no memory barrier on either side
(Documentation/atomic_bitops.txt).

key_garbage_collector() clears KEY_GC_REAPING_KEYTYPE with clear_bit()
and calls wake_up_bit() after reaping a dead key type. wake_up_bit()
uses a lockless waitqueue check and requires a full barrier after the
clear.

The existing smp_mb() is before clear_bit(), so nothing orders the clear
against that check. The GC can see an empty waitqueue while
unregister_key_type() still sees the bit set. The final wakeup is then
lost, leaving module unload stuck in wait_on_bit().

Use clear_and_wake_up_bit(). Its clear_bit_unlock() has RELEASE
semantics, so the completed GC work stays ordered before the clear, and
its smp_mb__after_atomic() orders the clear before the waitqueue check.

Fixes: 0c061b5707ab ("KEYS: Correctly destroy key payloads when their keytype is removed")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
v2: open with the ordering semantics of clear_bit(), as suggested by
    Jarkko. No code change.
v1: https://lore.kernel.org/r/20260811173753.67616-1-kmehltretter@gmail.com/

LKMM (herdtools7 7.58). LKMM has no clear_bit*() primitives, so these
tests abstract the bit clear as a store while preserving the ordering
relevant to this race. The fixed test models clear_bit_unlock() with
smp_store_release() and smp_mb__after_atomic() with smp_mb().

  C keys-gc-buggy
  { flag=1; }
  P0(int *flag, int *wq)
  {
  	int r0;
  	smp_mb();
  	WRITE_ONCE(*flag, 0);
  	r0 = READ_ONCE(*wq);
  }
  P1(int *flag, int *wq)
  {
  	int r1;
  	WRITE_ONCE(*wq, 1);
  	smp_mb();
  	r1 = READ_ONCE(*flag);
  }
  exists (0:r0=0 /\ 1:r1=1)

  C keys-gc-fixed
  { flag=1; }
  P0(int *flag, int *wq)
  {
  	int r0;
  	smp_store_release(flag, 0);
  	smp_mb();
  	r0 = READ_ONCE(*wq);
  }
  P1(int *flag, int *wq)
  {
  	int r1;
  	WRITE_ONCE(*wq, 1);
  	smp_mb();
  	r1 = READ_ONCE(*flag);
  }
  exists (0:r0=0 /\ 1:r1=1)

  herd7 -conf linux-kernel.cfg keys-gc-buggy.litmus
  herd7 -conf linux-kernel.cfg keys-gc-fixed.litmus

  pre-fix: Sometimes
  fixed:   Never

 security/keys/gc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/security/keys/gc.c b/security/keys/gc.c
index 748e83818a760..eda445f815d47 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -318,9 +318,7 @@ static void key_garbage_collector(struct work_struct *work)

 	if (unlikely(gc_state & KEY_GC_REAPING_DEAD_3)) {
 		kdebug("dead wake");
-		smp_mb();
-		clear_bit(KEY_GC_REAPING_KEYTYPE, &key_gc_flags);
-		wake_up_bit(&key_gc_flags, KEY_GC_REAPING_KEYTYPE);
+		clear_and_wake_up_bit(KEY_GC_REAPING_KEYTYPE, &key_gc_flags);
 	}

 	if (gc_state & KEY_GC_REAP_AGAIN)
--
2.53.0
