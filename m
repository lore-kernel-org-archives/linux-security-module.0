Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F29459AF9
	for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2026 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469884; cv=none; b=YkIZ8bCZ6Gwuq56x5SkBRboLLdfb32+YBQfbAdJpoXmM1zcca98vLtnTfkhPQumRSfPtwWWAsZNCvD1Nk3iUtJTQvmogd2NHNCIAx6OTmhrKjGJaZ45+KXWxG8RcNVxnOZ3kcDqcTByslJgtYjFNX1kMtbB9F7xk2bjGSk2hz0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469884; c=relaxed/simple;
	bh=Wx+Lw1mWnP0vMT3xO2mP96AGSIGJljennZAA0N/aXaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gs+/ekJ2IbJtsmwML4/1ZkMmVGLr/MRx9lEqZ8ZG6X6q2N7IfzPBrXcYBN4klbweANHhqJeKAXiVGYFi2kqSvgrLrzq8VsngFDCU/7p/MwYaguW8hylh1ZKd8n89u/0QKomqmnhNyBVHrynq/6UPRRJ2H1J9+rl8g9JE7IEJT7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEFd0FjT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEFd0FjT"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso331385e9.3
        for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2026 10:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786469880; x=1787074680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=J040IJ4YuazKH3F6B7O8n/Q7U453GJeDkkhgsQhCUds=;
        b=EEFd0FjTDluKEVPlVwGBFbxvzM+/hOlL6RKB62cwdvVjumPkV5SSbyVdYdmTHBSJpw
         BJb8NTxYHPe9pgQqMk9MCX9kuLC8wAamHab2deFpx/CSRKpNRlIEDQtOnl4+Uee+VM6t
         oUip7vPp+ZNI9aAyD05oBOkwfnqVUnylwsTgMTeFwoU+kTUzmHpOSB7MLOQs84bVYzwm
         LMN1JrcDNoRMBQ3Kp8j143zfFy8bKQBPn7zK/ChUCZQnq6HevzFX/fk/P4vF/Xg60rAD
         PbcjbkE8TzvyUiJc1o0BAlMy08KFKxEKe01MIoAuhEP/6F/bRoRO0WgB0WIFNdYKIMIc
         M8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786469880; x=1787074680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J040IJ4YuazKH3F6B7O8n/Q7U453GJeDkkhgsQhCUds=;
        b=oZkWnKEtB/LT2+DT3i/R25j+6gilNCr5gMnod9IcVcHT5e/y3HYXvo2V+1jjzyhPTu
         l/x3/kzIjyf1CdNsUa3AM7CK96q+ZxLwYZk9z3h0kfo6AUA6Z1ZGTmYl2eTC0s3Q8bN/
         UM/5cNBEkuCMUWcv7SqMOc3oodHOkB/FuueAhn/MBuLiNmHIALUoAUu1jo3MvW0I373z
         t+CBFn3c5P/4zOcOr6cU3YqDsi7PjJMGDvVzqU+ndMU+3ua2XRdN5nruG9tr0HnhoHgr
         7xaM/nXYTT6Z/czN9t7XcYCREKU+M0e5VT7P/lb6ovVhWlhvcKeZmxqW+ghlVWM09pxb
         rZ5w==
X-Forwarded-Encrypted: i=1; AHgh+Ro4x0e2WPgdK1gz2RhjDASE12XRCXraqx+/n+YTtO6GUQccJv1vfWtuplIyNKYaMwI+OsUnI2OhSv+0Kc4Yz4H2k3grW5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDo2igRkK3h2onQ5ERoGwlBMlOF/BdgKbYevia6qxTRJl8+hVc
	KNzPxHImfwrfkgcl7X6PLADucgPIiRlMNEGSjE7yZXh8228FiKggFQCE
X-Gm-Gg: AR+sD13iI/+H97MXq6TyM9h0Kcy8Zlllfego8vNvMKl4jvEirSkkVP7qPPd492T7jT3
	trckSafKQFq27mPMCu/L4hLyRzb7gI5I3ueFVN1e4BfMLPLDqqIXHicSH0C7kMq5cDtgtSohvsd
	OuKAso8rhrxAhbmX65yoQYM1eWsSAoOzd2i5otYnsVDL1Qs/M4UBaVV2rJZ9IAo3rgRisNQVBnF
	cdjY9io3l3fCqb32j5AJx1CSCkbTTYy6So1w5R0REOpZ8GC7v/kAPKeWnE0zUy2lQJy0c1JgNZd
	sZj+0WH3Ozxqwkb1RWVa27ycSNsG10EIBE239WwxCx8N9kB3DMu2WsDA7Iq3AZK/8OwJpTvuDQ3
	WB71gRmupydi/eltPRvTXrb/sc7mV8ycM0xP/95QiY7VTMvxrdG356rxFD0VS4z6N3zlN4keJoO
	S1lTun1ghNd0DXogPZy2OzShnypOKlMgC+Xv0UD9mvlrvaUePKbD3ZSVGL1/1b5jzQ1eQET9Hcc
	MXPF95Rogxi/eow38OqdDCV+KZysMP3cRX7xVUbay8TXKEec5XVIjqSypIEnpAa8K9RBFxhNloX
	8HnQVjR5iwXSwcZ/4xvabq+wMS94SgBDLAToWum2s0my95WiC8BGwHVCN6pskT3IUquH
X-Received: by 2002:a05:600c:4ecc:b0:493:cefc:d113 with SMTP id 5b1f17b1804b1-499784297e8mr70560745e9.5.1786469880221;
        Tue, 11 Aug 2026 10:38:00 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a133-e401-bc8e-d36c-2d08-c5e0.310.pool.telefonica.de. [2a02:3100:a133:e401:bc8e:d36c:2d08:c5e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997aabf134sm7815485e9.12.2026.08.11.10.37.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 10:37:59 -0700 (PDT)
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
Subject: [PATCH] keys: fix lost wakeup when reaping a dead key type
Date: Tue, 11 Aug 2026 19:37:53 +0200
Message-Id: <20260811173753.67616-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

key_garbage_collector() clears KEY_GC_REAPING_KEYTYPE and calls
wake_up_bit() after reaping a dead key type. wake_up_bit() uses a
lockless waitqueue check and requires a full barrier after the clear.

The existing smp_mb() is before clear_bit(), so the GC can see an empty
waitqueue while unregister_key_type() still sees the bit set. The final
wakeup can then be lost, leaving module unload stuck in wait_on_bit().

Use clear_and_wake_up_bit(). Its clear_bit_unlock() preserves the
ordering of the completed GC work, and its smp_mb__after_atomic()
orders the clear before the waitqueue check.

Fixes: 0c061b5707ab ("KEYS: Correctly destroy key payloads when their keytype is removed")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
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
