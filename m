Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7617367F48
	for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2026 11:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030098; cv=none; b=MQ0ZlCuIV/FRx+7n9/rr1Hzf+LDxh0XQcM6NLx3E6dwOfwfGfbJevldrMgaBlYjc5Y+9ikbbO5t1wTjL31LktMFOPDZa7i9J9l0iXIhB+vBoltu+kgkkx7DXsSvryMuCNjDS5gQz3fLr2JXx/tTewykJxVPnB6N6lXk+35yMVLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030098; c=relaxed/simple;
	bh=4U8q91HPFoRFicOXzoAa63H08lLHbCXfw11y7FazoPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K4Bjx9bNT48+uZcWC+pilfhMPFbye+y18w6HNRwaQyahn9/q/hgKHEXvpIy70sRu7zd5Kc36YiDWDhCM1qYsOp6NIH5bmIJMoicX7/yHBUg0Vs3aSHsUbfZ7Sx8ca729Nej1fjoZlquAhrZB59xr76VyUjySGLpR5T4i8bKQCgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ojC3dWLT; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojC3dWLT"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c2c8f43aaso37914231cf.1
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2026 04:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030096; x=1784634896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l7ADB8De/whZT8e+EWVqNZCd354WcrnrJ/amnwN8jVI=;
        b=ojC3dWLTfIAjG8tQjrw+5rUHqwlVF2Wn7EC3GI6jfsOwfBTgQ5o3k317l1coVsTyn+
         ZM5pwzr9GYSdc3UHrzRMfxnzI9xREvZ5FFY73O+iNZ1y2917uqMi9gK2qk2PXwacz3Bs
         m1LjVgm9upyxV1xt0EgC4WmtUpdPVfHdC/kKd2V3bLuV/8PTLSzeOlrOtGhpUwuVGH8m
         YYN1TbD4f2VP5A3YpOJn8c8FavIIUFz21ZZ3Aae/riqy86av7dS+7xyrQkCrBg61Iack
         2pwPqbPADt3kbaFpBc5FCuaTUmjBBuecAV9pFiyHatiMy72MAq7mhMxvYsJQyQchisuY
         GslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030096; x=1784634896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l7ADB8De/whZT8e+EWVqNZCd354WcrnrJ/amnwN8jVI=;
        b=DZGz9m3q8Diqhja548ZKY2vyp718WKQXfJG/luvZkJhcfJ+hXg7ygnAPH/DyM1VHjs
         hSt7PC6lQq/zLeBYMFyCDCXYr9u8dr/+TLq3lBnuhueGRK3MGC8PBhFTwHgSHj+4JBzv
         hQ7k1ui72b1brjX2+iHqyDYehF+D0gRPy+fHqu1ihr4c2RUjCj1Z+G5kS7qZgMgM3QJE
         +fvKvuWkWkWwEqSnAHkKzDlpbT6tXILohdOtq3/apTJqVsXJO2nOaWZqzQN85I/85pab
         E5G6DJaiEVhQN2DvxJ/KcCjNxPFgBC+zWbRvGka8as+eo6ODI9ZDawVtbYSnd7k1mSvK
         jR/w==
X-Forwarded-Encrypted: i=1; AHgh+Rp9UqMU2wDNzCIaLdLV0Bqig2oMgVcF0hXu9fwKh1qx23jX2gR9iV+MizGPFOF5PIUNQna6w+PgjmWrWCc9kqvXZe/01pY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBniKxkzMw7azC+pV9QUtyj7tTbNIqu5dIQ2rwf5pfbWvtSVqt
	RZ6jQMNUDgcV95Gc/1xRgfkbdioWkXWAK/Xm3XrdEhs2Hhldli8e6BeE
X-Gm-Gg: AfdE7cmjv12axfmY1E/Z0/ymK6CdgCY6cS/mlb1JAuDYPYwBjhEyu3AE/R2RAImlCVg
	hp3kVCzQ78iwNvnRYSCxT2LP2Pg3rHGnR5TZRUbH4Faj9d2yegOqT6z29f5kyFWdOS15G+A4n/+
	vlpHgIkmeTij3EUvDmiA4EzSmzta38wPZAh/4cMQ9U1158oSsEeU208aSRCDAtYaPOY7c158G3l
	21qRCHVe2SqUss88eupaAbwgSB9UNC6n32+frm7mjNGNAXhoZlLw76i2od8QA5C8XRSjvUmRgWP
	17ww71har817MQ3LRK5SwgKOfEeHU5h9+iYT/7GcEbA+nHNKw3rd/ff7YLYL9FxxbrkqaWnGuuX
	4QkZ9q3dVwt0cD770tAvOBicW89+gUKzJjNYOGMw5EJ9x8n1BY8ZNYKM4DREX3GvrknR/vTVdTd
	uljv+cHfGrUzFmxpqAF88Hmoi264sDYlQwodg4ioFzweb+aCBTJWXd7dMbYcYR/Kbw6xN3ItdwO
	UFQX1xStg==
X-Received: by 2002:ac8:5ad2:0:b0:51c:1967:5098 with SMTP id d75a77b69052e-51cbf147113mr127640941cf.38.1784030095442;
        Tue, 14 Jul 2026 04:54:55 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd80fd492sm185100576d6.34.2026.07.14.04.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:54:55 -0700 (PDT)
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
Subject: [PATCH v2 0/3] keys: fix keyring assoc-array out-of-bounds read and index inconsistency
Date: Tue, 14 Jul 2026 07:54:48 -0400
Message-ID: <20260714115451.3773164-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

An unprivileged keyring whose keys collide through the description-chunk
path can drive assoc_array node splitting into an out-of-bounds slot write.
Patch 1 stops the out-of-bounds read in keyring_get_key_chunk(); patch 2
makes the chunk byte order agree with keyring_diff_objects(); patch 3 fixes
the shortcut-walk trim so the walk cannot be steered down the wrong
descendant.

v2 changes (patch 3 only; patches 1 and 2 are unchanged):
As sashiko pointed out, the v1 patch-3 guard (sc_level + CHUNK >
skip_to_level) fixed the word-aligned leak but wrongly fired for an
unaligned first word whose skip_to_level sits on the next chunk
boundary: shift = skip_to_level & CHUNK_MASK is then 0 and the trim clears
the whole dissimilarity word, making a differing shortcut compare equal.  v2
keys the trim on the end of the chunk that contains sc_level,
round_down(sc_level, CHUNK) + CHUNK, which matches a brute-force oracle over
every sc_level/skip_to_level pair; the original round_up guard and the v1
guard each disagree with the oracle in one regime.

v1: https://lore.kernel.org/keyrings/20260712014500.480410-1-michael.bommarito@gmail.com/

Michael Bommarito (3):
  keys: fix out-of-bounds read in keyring_get_key_chunk()
  keys: make keyring key-chunk byte order agree with keyring_diff_objects()
  assoc_array: trim the final shortcut word using the current chunk end

 lib/assoc_array.c       |  3 ++-
 security/keys/keyring.c | 15 ++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.53.0
