Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795260566;
	b=iEH6yoxvtSt87ScZshQbv0RkiUiUgDu4OJ1esbhJ5OYLHBjQL7LafNp+O9Ozfcihki2/
	 c3nOsyP1rz/K9u9zC6/dNfNtp99WjPovL4IMxDeRwGRgY7kbIXuOis14wZkf7sEkaLbnW
	 Bh1eWkbIkOY3s9U50A2z9U9NalOebTocRlQXK2pZ0C1fDhEsw44KmV3CufSqK3wIGChWR
	 m7dMH1zkq3An22ZfaKrkQTPLF8pH+5PXALc86ZV69p0OlN5YTuBM8CjIkrX0f5z4B/cWL
	 I8svLpkjvqCEuVQ9cJwEB0ey13rErjIJXzh9nD3FBvPjr9/oczngQ0zkSPdPtXzJShA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795260566;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=umQx8DxNkvnGJlvvds4sRbKDPuEqjAlh1ZTdHWdFhho=;
	b=mHQBI1QLqS3s2hJcW4dfP/3QFNxJfnlY7Y1zyNVfgg8gY/cJLs7rWTWRhH5iiwPbFoLX
	 M0z2p54c5+z8aBV+LBuA6b2+BUjixFKz/Eouj7MVgnmn1+V0ylzbm+QGSqveYM+6IY8Lk
	 hD5/KxzwRrjYE0ba1dDKtrgG3j+3Gr5/SKf7UyYJy/FNjcNuWErhA978SC0fAg7koUCdS
	 nX6Z5cviclssSOqRvsb9rTjCgY5RtCaXPfUeA35u2iD/hJQY/EijpnSeUG0F3gzbpKdWg
	 CO8sAo/Aiqc9YEYv0bStfd6aUnmkpy6HnilMoiLTC2ip+dpMdG+EpAV4z7tI2BrWkKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wndv97v0;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1838606A325
	for <linux-security-module@vger.kernel.org>; Sat, 21 Nov 2026 11:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1838606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wndv97v0
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso18043945e9.3
        for <linux-security-module@vger.kernel.org>; Sat, 21 Nov 2026 03:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795260564; x=1795865364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=umQx8DxNkvnGJlvvds4sRbKDPuEqjAlh1ZTdHWdFhho=;
        b=Wndv97v0xNPaFveqPJE73z2hBy2mVbS4EQLfhSu3Qr/NEtlcenEomJW44MLGRSN0NK
         4ebXbUWqFYFshtpdLkIu4G+V+8BBmM4hyxvT3t8kA+Oxvm2IVXPxSvGwwul3fcxE0VQq
         HIs2yWfKLdXI7nxF4IPMSF/TR+8a3cnWWtx2k85gPjqLFLunNFD8vv9NlusF/pG0iaq7
         +VRUjMsc2SpfichnmWjWT5E+IL35HOomym2W//nn2utskrI50B/79Ztt9kmhc4C+HvIe
         4sGG3nqOPrBEJuFMaS80zwwswZrzMx4Wr0D9XlEh+IYg6SwXxZju8DRH6xr/BPT7Vemr
         9ahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795260564; x=1795865364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=umQx8DxNkvnGJlvvds4sRbKDPuEqjAlh1ZTdHWdFhho=;
        b=b7Se2WriqjGSrJOSX9Ruy1rgZ10ToQE0Fhq8Vfu1dA6JhmEgDm4UoYRHDwh0VyASWj
         ZhHmDRJ6o7Lk5atghtffPwG0iitTdSNO/MICLQOLUNkt95ToECA4/dvWaEBbJciwtQmG
         77A3Ev0zrulLUt55SgoZPkowinshWvU96B+VgLP/gq1csfJNAnxdMzGFrBj/D6s9neRH
         uL03f12bh6BZGUHCElKDbQpt/cL/UvikylIJ5ejeTIvXnB6xb3gb/z2PtLRqL5NCyo+t
         9X5SukYJvkPt6jd5rMjwN0edCuW+aexS0HKqoEA7SI28QeYHmpotMhQPpdKECOPoBL5E
         eJzQ==
X-Forwarded-Encrypted: i=1; AL+hErHHKjQK3iEnbKkrgF07hVA4xTuK05Scs98zeS6Py1ZacdS1j0vNpEXhFb3CDvuHFrw6hWzuZKm+v/co24pny2+EwKN3G/Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/bwnmXTPFHJ0PyC5PNVPUFfbgKgUBc5ge/41fO8/BSJAdgYAJQ
	ZEG648/QuO+Svd1JLH3i7ufoYf9pCWe39OWTZBsQDy2QiTrVfkLgEHU=
X-Gm-Gg: AZFdTZf/kyV9KnevfW7FnKED03hm6/0MpPnrM8BmiE5ntEjHIQbvbx9ClTcph0BTK4+
	9jdyP2fVLBfkOb2KviITbQaT9TXouzpEV3Mr8ZkL4K1N7STDyeSlVqaqYze84PT6BOHJGWMlwaR
	QmUbCqNZZnQ53BISbE+hci2RqSP+pZTlZU+FjsT/e+6unbESsXl/ESGPLFbQGwW/Rhi/bqkVpc/
	spP2I20KxdVG5ws6hNHsk8le3XkZIshadCHbduT/nurVpafraUcNJe/Aabf2NC81bSeXItuyu8Z
	R73jBL5AboKvovI2v0qgEURq7jCqjtMAmwfXlVXowUfRc5w+HO1IK7Qhulw/1Jf7QZ06lQyB3BM
	+PuUidc6FiK8rgZL+uPcxdDde6YqSjg34sc9nUuASxsevhbIATC3XGtGEuB/HsNONmkLqBWHny0
	n0UJgqhv9e8GnxqQRQ4U0FhdG00Sr/4Ew4/UivaLC7IGMNhWmy7yicCRaW/4kBhtDVEnoD40HsZ
	hOBS2J5EPy1BbvvFleut7wbnrA8RAD6o7qVlD3umSyR9IYLk7UzZDALucDKmE5xNUxeKtYOcDcf
	+58OfmzH/LdxjmdaAjKgGlo9ZukZSeqd2dD2bQ==
X-Received: by 2002:a05:600c:3511:b0:4ba:73f:ef5 with SMTP id 5b1f17b1804b1-4bb88828304mr137787085e9.34.1795260564182;
        Sat, 21 Nov 2026 03:29:24 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9066f6e6sm37210385e9.3.2026.11.21.03.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 03:29:23 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] KEYS: protect construct_key type dereference with key semaphore
Date: Sat, 21 Nov 2026 11:28:53 +0000
Message-ID: <20261121112853.2175119-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

construct_key() reads key->type->request_key without holding key->sem.
A key reference keeps the key alive but does not pin the module that
provides its type. If the module is unloaded concurrently, the key GC
retypes the key to key_type_dead under key->sem, and the module text is
freed. Without the lock, construct_key can read a stale type pointer
after the method has been unmapped.

This is the same class of issue fixed for other key type methods in
commits 925c84e3cc21 ("KEYS: Protect the read method check against type
removal"), 51bcd09b9ffca ("KEYS: Protect the update method check against
type removal"), and bab48a1044475 ("KEYS: Protect the pkey method checks
against type removal"). construct_key was missed because request_key is
less commonly used than read/update/asym operations.

Take key->sem for reading around the key->type->request_key access to
prevent the type from changing while the method pointer is read.

Fixes: b5f545c880a2 ("[PATCH] keys: Permit running process to instantiate keys")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 security/keys/request_key.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 22cd66a44da56..eff67c5fb9015 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -241,8 +241,10 @@ static int construct_key(struct key *key, const void *callout_info,
 
 	/* Make the call */
 	actor = call_sbin_request_key;
+	down_read(&key->sem);
 	if (key->type->request_key)
 		actor = key->type->request_key;
+	up_read(&key->sem);
 
 	ret = actor(authkey, aux);
 
-- 
2.47.3

