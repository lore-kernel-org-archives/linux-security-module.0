Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4399383305
	for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2026 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030099; cv=none; b=vGvQR627rD+Fm4ofblXodTnb6uARRD4l+AOHdZS7+YHRHU0OKrYLCVN2FuKynW0jVh+/R0GmXDqe7+ck1QE0BvgtXBf2uJy4Ghk6Gv5A3DJ/O0KojSEJte9CVscBzzagybVP8IBamedsOczZIuCOay/Cg7x2jkGaRj2IlnW8/Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030099; c=relaxed/simple;
	bh=8zs0bohkqz5AHgWLOAdTFJ4eY64BQy7weh3GYB3lFvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcoyiZw0LJoUiuPhLyb17BVEADM5SsoOGDNso4yW4nkDO9Tzp1Y0oNYHJY9A/TnWsJUl7FudFEM/9UtHmCW1YZHs0Ez1XIkv97wzKMrA5CEjzumRMB64OpB1xVF+aJX8Nx4R2kXRFuwLHUCjWv4kvvzvK1TBR4fEIqT0ltDYiQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rAXfcIR2; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAXfcIR2"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8eeb4508f29so41214186d6.0
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2026 04:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030096; x=1784634896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=suF5ptZtpi7RCzW0/i+xzlbJ6znA4LVm3BIxn07HFo4=;
        b=rAXfcIR2zHh3aG5qw7wuYEVjK+UcuYnVTWmpBsZyQWU8+yhhkrSrXIJbpnTdJt2SXd
         44kvuSitJ3hFdCyqc2eGnh40hdYIXQ5k2nFpTZQPQxnfiPGw0QlfLSfHZ3WTf8WpgU+m
         cv2aHpMRg0/1ql96evQPZYPntLmQ8YQuvNWSyWPunGX5Fu5nUdPfxzT/Hv5WJon73QpI
         qoXuyHdoXmn7AxYaz6buXJC61lBdMn0qD+da4sPgQQo+J/xMQB/308BFNo5H0FJoR9NZ
         8zjnMwLCK0znYJzrUI7Dr4rnr8lti463QPtH6ERAi+rPc0jvCFUv3F6o+NKpd5mgNJar
         gkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030096; x=1784634896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=suF5ptZtpi7RCzW0/i+xzlbJ6znA4LVm3BIxn07HFo4=;
        b=noYFAvyWQUOvLd/8D9TvLVcg/8pZraEOWDq1f5tOfpYfChd8hz3Eby6iPrB3MY7LNo
         WC4klgahL/fpBTS4oyLtXtG5K0DQgnIMTwU/Unw4P3bWJv5VhLYY60AuRYnHdYTUiGu+
         73o3QQihLXUNbBxIUSxx19Sozc3NyhqE0a+xXl5OsYxAx45F4F64v30ps33HVbyN0788
         pFxMWvekL+HTQ4USbjRfxAFKZaVo3UHWQ8wzgR3QQbzQKZXf0zV36XKaY8zM0tpLc0eu
         quVrkaI96FPfDuVrQsBo0i+RgUIGc4NtO5jXnEYOOyLKj0j2CBWYTSAxUu3YCI76teYx
         aU4w==
X-Forwarded-Encrypted: i=1; AHgh+RrLv7gXY5ZVn+NfAXKuZPP9omJkLkYCr2ESQF/2zxi+i4ZS6NVKBKANKcE00HZ2z2ZeXQtEh2hLAO+yGilZFxIQ+i2bBuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi6MKIwCTLte++4RT9jtpkh6YcvpdJ4X6WTMwcmUMWUwVOQDFg
	7LC/nFbESGniQOlWelCvQ2VfYs3YuE7JnGA0l9ZsjyfzVj13hjlzzOu6mV7ec63zDPE=
X-Gm-Gg: AfdE7ckQatyLSElFHHlXqphENq6H1B7vDG2rZM9g+s51aRwANXjG+uBkRZA9ts8hilv
	m9tomekU+yy2AX4FbrjOI63cz9Ij2WSohtZj4NweyZ5w3ly0Y7+r4/sc+tTEJbKRuxtpu0WOquJ
	4DyUOHVaSwdKe1a5N64OQGyxk3wRDqkaR4/i43R8BPs1EXKmZeycW0Q2cosEG+aK8ma4yTGRDBn
	VsVgYKEJybXC7atvGa9dOtwW6snWTBNV7RgIE4f8W/Xt7ALDGJ+wY81ILY2wkgxXbNNQfHJBQeZ
	26AgnVniNXMRX6UUuAcBvfUCQ62G/Oq2BzRIhmzYT2Z0Bwnt/tWYHn+HgnwYEyVwkyWwlLwTlU6
	Hut4Dhz3txVDyBsiry2K9hGK2Qttilu5ZpUko9o2PcgtWrNqUy1D5o621O9e8XgDsrOA15wY/K+
	YCWHN04MLivhApuEltVXn/ZPXCWfZOrNf2Wq5URHkfzuDAF8cXFO0ERGddFNjveuPy61168evYT
	AjtmGv2Uw==
X-Received: by 2002:a05:6214:2b8c:b0:8ed:a980:6b29 with SMTP id 6a1803df08f44-90403a6103amr144551036d6.32.1784030096456;
        Tue, 14 Jul 2026 04:54:56 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd80fd492sm185100576d6.34.2026.07.14.04.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:54:56 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] keys: fix out-of-bounds read in keyring_get_key_chunk()
Date: Tue, 14 Jul 2026 07:54:49 -0400
Message-ID: <20260714115451.3773164-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714115451.3773164-1-michael.bommarito@gmail.com>
References: <20260714115451.3773164-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

For description-level chunks keyring_get_key_chunk() advances the read
pointer by level * sizeof(long) past the inline prefix but only
bounds-checks the prefix, so a long enough key description is read past
its kmemdup(desc, desc_len + 1) allocation.  Compute the full byte
offset and bounds-check the description against it before reading.

The walk only reaches a description-level chunk when two keys collide
through the hash, x, type and domain_tag chunks, so this is reached from
an unprivileged add_key(2) with a crafted pair of same-type keys whose
index hashes collide; KASAN reports a slab-out-of-bounds read.

Fixes: f771fde82051 ("keys: Simplify key description management")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 security/keys/keyring.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

KASAN, x86_64: add_key(2) of a crafted hash-colliding "user"-key pair
(~63-byte descriptions) reports

  BUG: KASAN: slab-out-of-bounds in keyring_get_key_chunk
  keyring_get_key_chunk <- assoc_array_insert <- __key_link_begin
    <- __do_sys_add_key

reading one byte past the description allocation; the same trigger is
KASAN-clean with this patch.  On a kernel built without init-on-alloc,
reading the colliding keyring back with KEYCTL_READ returns
uninitialized slab until patches 2 and 3 are applied too.  Trigger
available off-list.

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 7a2ee0ded7c93..1739373172ad5 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -270,7 +270,7 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
 	const struct keyring_index_key *index_key = data;
 	unsigned long chunk = 0;
 	const u8 *d;
-	int desc_len = index_key->desc_len, n = sizeof(chunk);
+	int desc_len = index_key->desc_len, n = sizeof(chunk), offset;
 
 	level /= ASSOC_ARRAY_KEY_CHUNK_SIZE;
 	switch (level) {
@@ -284,12 +284,12 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
 		return (unsigned long)index_key->domain_tag;
 	default:
 		level -= 4;
-		if (desc_len <= sizeof(index_key->desc))
+		offset = sizeof(index_key->desc) + level * sizeof(long);
+		if (desc_len <= offset)
 			return 0;
 
-		d = index_key->description + sizeof(index_key->desc);
-		d += level * sizeof(long);
-		desc_len -= sizeof(index_key->desc);
+		d = index_key->description + offset;
+		desc_len -= offset;
 		if (desc_len > n)
 			desc_len = n;
 		do {
-- 
2.53.0

