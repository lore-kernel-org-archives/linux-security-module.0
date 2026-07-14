Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6347367F48
	for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2026 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030100; cv=none; b=TFwnZupY6IncM28FdUGQIV2QKbrfgJqNfs3xrWEYU0JmC9fBZKzocbIvT2b5n7G+wIL4B64lGpJkPiqwvYjmfrervnxT/z5wosZCk1JlZNpQtBf9dkzUOduEdY+K5tXR1bHkGlcWADWZXHFdG8hkmWG5kJ8HrHtAtYswueQuT08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030100; c=relaxed/simple;
	bh=9RRZcFgrtBWsMm88TekPA+n+ES8ipoI28R2xVaJ1owk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtOgphM0K6LAcaYqJcxlCTxFaKkbfzGBljxQG+dgZehslLTVIgQHQXVjPOCxV9wBUShFrcwKuZ2EaCdWYRIzIhgpNsZ+n2wi4tHrOhoQ1X2ln+dfMciGaElaV9EyoqQGRN06R118CDsdKPwyJ7RNRoE696rpPYmfRruLQlLxb7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpClXGEf; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpClXGEf"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso35950106d6.3
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2026 04:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030097; x=1784634897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qTYC4WZ/uNDWSHxkWtJkYAaxtQ+BheOgFcuFhfNnJxk=;
        b=gpClXGEfxfL7j2nFBXqFrw0r99d9aHViGFW9h2OF+0ObBXOMJrajp0tORuZ34Q2iJq
         l6/G99oDTrxrphhEYPQm5kFN8odf8T/9xttT7kjhrqbLqbL/sIQZaK/+gLbYCnCpaQRg
         209Di8tAmiouJhVJBhMzDNGgyaHsXapJ/tuThpLX3QpjJTYZew1vAImSNuyKC9iqf7Ok
         lZt2zoHLiWmZ8YDKbZ8AohszsxwSybYtQQXVVNfeGYUNfOBhXPz9ZGvNhRztkuij5k0U
         y86KLuMhrutMFql276OFQ50pssoM7SLeZG9ndO6TFFQ/qITo7WzPLTHdeSywor7W7n88
         AGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030097; x=1784634897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qTYC4WZ/uNDWSHxkWtJkYAaxtQ+BheOgFcuFhfNnJxk=;
        b=ccQDP7UeKGsCLUpSIGHonqx26W2XLiljxC5WQrM5yVybTjHjYofsWM5xnWSwvF18KJ
         8Zi4Irs1at9kNqzkhyIEqmVRmI3LbtVn/PAoD64PSXjftAL4NZL6XONIVl5g8XzlsGUq
         hyobOLLio+drUeyp8qsNyw1I+2zyacupzoLPzJoZmi591CEVvwqAr2xc47vXn68zVEqQ
         rPk7Zwk0K6vWy4XQmlRD6k0qCRHbJhJ/hhuHuMxnMSSWJCGFU2jka8HlWfvwlN8RzUg/
         wipmM2KrbNavpzj05tgk4g2q+wZchvSSBUUleZIpNP8pRQRImhEAI+Up6iZbggDM/EO2
         Pazg==
X-Forwarded-Encrypted: i=1; AHgh+Ro7i7AhxUBsEdxaGugXv0aCgiIv9Cej32nxo2pnCwnYO5U4jiiVM1doye0mGLEyIy5hslsDdn22+xdNh6s7MVXxX+7g1eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB5tHbL1j2I0/CvxZiB+dXGJQgXtpaeK0TK0kBd+Geszp9rpKw
	98HnOoOuZEweDWiCPeCJB26lA77iT1nR5rgA0GWz4PXfcgyMlST9Er/C
X-Gm-Gg: AfdE7cnSBvFSHuPCOBsWvH99DvOk5tDr9rG6Qpxsujlg6UyeC+MnS7ejmqLml4TCzCv
	AyqwO/fMW0Z761h61dwbD/7N4gqfIy5md4QFWtj9YLfNwCb4a7ow6V74TWIFq9qUk4ls0frjPJ/
	k/mD02wSUTwz8V9I7/a97XU2jkgQAh6DhwwS81NQa3wrMUsj7juBVp4jvWgRRzUjlOYFFGG+G4y
	gwHHtiyXJiSA43l+oOmjEj1kQaTvbcuoJ9ieXf437jtN+1rzjyTeJN4gOIVIm839EGYVFCtlI90
	83ynVXugdOdQc2i9uhT4b402PYwPeFgkE2Kw6Jd0U/rOfIZCsdIfKS4zS4Rj3s1PFvoPet6td7b
	ft/XcDd2St/Gfq9kp2vZ1Dz/doXotLawgCwe8pqYgS8ATuFpgcvfWREb1uQVnnn9ZDVHreN9Dp0
	xr/RzxZUBpzh0Okd8smLSeKX0jh4Vo0MC0my2oU7DK88flB97DZl0iFzSDzciQHsMvQS79/ID53
	FH9lYEc5A==
X-Received: by 2002:a05:6214:21e7:b0:8fd:6de3:dd7d with SMTP id 6a1803df08f44-9074c8b3fbdmr17351196d6.63.1784030097559;
        Tue, 14 Jul 2026 04:54:57 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd80fd492sm185100576d6.34.2026.07.14.04.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:54:57 -0700 (PDT)
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
Subject: [PATCH v2 2/3] keys: make keyring key-chunk byte order agree with keyring_diff_objects()
Date: Tue, 14 Jul 2026 07:54:50 -0400
Message-ID: <20260714115451.3773164-3-michael.bommarito@gmail.com>
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

keyring_get_key_chunk() loads description bytes into the index chunk low
address first, while keyring_diff_objects() numbers the first differing
bit from the low end and folds the absolute byte index into the level
without removing the inline-prefix offset the level already carries.
The two disagree on byte order and bit position, so the array can be
told two keys first differ at a bit that does not differ in the chunk
the walker uses, letting crafted descriptions collide into one node.

Load the chunk in the order keyring_diff_objects() assumes and drop the
inline-prefix length when folding the byte index into the level.  This
only changes the in-memory ordering used to place keys within a keyring;
add, search and read of non-colliding keys are unaffected.

Fixes: f771fde82051 ("keys: Simplify key description management")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 security/keys/keyring.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 1739373172ad5..e7066893e6ffc 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -292,9 +292,10 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
 		desc_len -= offset;
 		if (desc_len > n)
 			desc_len = n;
+		d += desc_len;
 		do {
 			chunk <<= 8;
-			chunk |= *d++;
+			chunk |= *--d;
 		} while (--desc_len > 0);
 		return chunk;
 	}
@@ -375,7 +376,7 @@ static int keyring_diff_objects(const void *object, const void *data)
 	return -1;
 
 differ_plus_i:
-	level += i;
+	level += i - (int)sizeof(a->desc);
 differ:
 	i = level * 8 + __ffs(seg_a ^ seg_b);
 	return i;
-- 
2.53.0

