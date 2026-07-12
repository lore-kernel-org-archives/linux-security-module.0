Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31E42D1911
	for <linux-security-module@vger.kernel.org>; Sun, 12 Jul 2026 01:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783820722; cv=none; b=aKw0cgzIMFUWSSEXc8DfeVIDqxSuIzdoQpVG6VBfZOefxkKZfA7aUmdQldjr8+YMJihQVGrro4QXL39dWlrpoKjoxynm1vgicOTRY0yRjv3rzXjCyhscON0EwbAo1yUoZlOC6wHnHZKdSjaS8nI4UtWW6KHf+3gHTd6NCrARENQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783820722; c=relaxed/simple;
	bh=9RRZcFgrtBWsMm88TekPA+n+ES8ipoI28R2xVaJ1owk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dt8HI+jjP1kN2ot3pA6WQtG4COidTkxm9/YkIBsDdfrgY6gBf76JFP5jQ76XkFuAiQ4ra+/NsSghcLKXaYYFEKWczsz9tGXzte2cq2KFsyEUlzfMsrYqv4AYUjMrQABV+ZxyCtGYb0khvm96GS8yqS9mE0RxO2vvNo/urFhcGw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOAVqsKn; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOAVqsKn"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e5b048375so103483585a.1
        for <linux-security-module@vger.kernel.org>; Sat, 11 Jul 2026 18:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783820720; x=1784425520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qTYC4WZ/uNDWSHxkWtJkYAaxtQ+BheOgFcuFhfNnJxk=;
        b=mOAVqsKnEXzVNnxxHmtOnBI0O5GwVAAxaZVK2neEQ22cW4OPhl/pI8fMptk0v5l8uM
         JnZcV8o6s4MYNi7VBngU/mTXmbvyi5oFyxFAklEw0+yGsuqt/uW0jnaOt9hT814DCyl/
         ggPNoQIJsgkcDGz7G5qqPI8CEKU3MgjZpddk7OARVTyG5IVSRVTkGTqJiPQNXu63GZE3
         7PelUakgmXfcKg2p6JM5XYugkOjvM1FOGxlo9vYrMRR15c7Ib+KqDe9EMLH68yunftI+
         lp3Xbc0Ax2VW0fTLivoLTFou9uvAj7jDcIBAzUNZX7D56zV/c7yi+ed+oFInuQDsH+Ly
         O6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783820720; x=1784425520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qTYC4WZ/uNDWSHxkWtJkYAaxtQ+BheOgFcuFhfNnJxk=;
        b=nZtmCZz7rvIfcWYsmxGw+qjFrLu4Y5Dj0yFetVwJEHNPzSsJA8ecgcLOlytlUA2b2w
         laStYyv53Vwgyhx1/hqZ5OCM8X2lwY9kD1csIjJrNWLj8fb0rbXxoCSEF1ww89MeVdkJ
         yD5YKuFefW3OMCN6tvQMvI1YqIWckgnbBtPHpuq4j8Au9OlLeyPci9wsZ4kPFl/Zkz5y
         Eio7yOz0oKRj13BGzI1WRnPKfpPbaqLviB1zOiurYYIcYqv16Ce0bBbDBZ0D0X9yA2hk
         MRt+KsG5CNDKxdobcH1PgeOqqyeA0ohITAeUroMztTCJc0M3EXTVYsyQHMKJmit4JNr6
         /5Pw==
X-Forwarded-Encrypted: i=1; AHgh+RoZ3YI8BDheaHIXdbJCBIKFf0HzBZa5QOtWGFfGbic+AnNDvPFs6keS1k6uRZcKOot5nmyLtQMlVVLE1RI+ulddbUKNnJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRkgUoXiGUd2ZIdk5lisrpefmSzJWj6qLqhAUttoH/u96oAaH+
	4Y2Y7+EVHKEMqsQDSUffqbghqjmzMq3MsT7GFdH/curQUgz6nAZZAS8/
X-Gm-Gg: AfdE7cm/7RdYHogW+XoUUInKOf6pZaqvcmGnMv/7QxSLh9szvxty7oIdwOrD83QLGI8
	hzNG8zB4VHbnsy9dqWBmjPRruBZDU8iSVDpcfGcmZ1bpC1RliCbq6AhW99mQehQCRbfGYm3k5a6
	ZKbEyVJIibr6v1eQ98g0WjdkeUe9sgmNDDbwsXpEaNgxB5U/muGHQIrQmx16i9ZyaG/bOZuao2T
	nzahKHPQ3MxIhUrghummLCbqqfDrl7UwB7Rd5EC5xjOI/DEs4c69+CVafOvLOCfKjRF8dOEDAbO
	NGVyzRT5Y7aNsj6B9ro9kk6/TiVDWNE6cGzT19tdVZ4W4FsJNCtXCzkOYdlUc8aYqAd/yufggJ5
	IRlwA6iojZjJFxCxFqhl62pb7DuJ7MUBtYG1lUHVJ2Vt2z76Yu1ZqYhhHKz7fRd4BwLGufn1fvu
	ta8p9bykF4SKmqZ3wl2kqUBDQchUH+kbAq7k6fFdui0vFy9xg2CmUPPhrPbUbUBrVsrrTSD1N0c
	wPQqkDEbg==
X-Received: by 2002:a05:620a:29c7:b0:914:d093:abbe with SMTP id af79cd13be357-92ef2af0f1bmr455686085a.12.1783820719770;
        Sat, 11 Jul 2026 18:45:19 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b492ebsm624902185a.9.2026.07.11.18.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 18:45:19 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] keys: make keyring key-chunk byte order agree with keyring_diff_objects()
Date: Sat, 11 Jul 2026 21:44:59 -0400
Message-ID: <20260712014500.480410-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260712014500.480410-1-michael.bommarito@gmail.com>
References: <20260712014500.480410-1-michael.bommarito@gmail.com>
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

