Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8D7126BF1
	for <linux-security-module@vger.kernel.org>; Sun, 19 Jul 2026 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784477719; cv=none; b=XS9pG8SjPIfbimLeyQDHxIeNjEe0b79Hwsvfz2PYhZF0HjlbD5VCzzV9ESycBWHMxG58GaesmA6i5kQbX80KrCDdExHqedqQhIxEb2QFYM3hSxZuNhpzn9vB6lzGQ2XCrRHXkd5NLcSWlxBYsLnqBpq7bCeKGATLYR817logdYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784477719; c=relaxed/simple;
	bh=Yvse8VC1UYLx9y86Yf8NbIWA81h7Jj4tNdZnPVJqC/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GqYQuWZEXCdRBCmIe4Od9gOObLE7hvBXLT8+XIbI32jeqgbLD+UINNcTWgjhFovwcgPBcW9Lwt/XsgQCU8ciI4MbY02atW4eHSeSy9UwfQ2M4llV7fNKOKeH9YMMwj7WwJrg91PDZATOeIKD8XGXE18MSdvybNErK02ehxWK1MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhdWTf1P; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhdWTf1P"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e5d50b0dbso455515985a.1
        for <linux-security-module@vger.kernel.org>; Sun, 19 Jul 2026 09:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784477716; x=1785082516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5cILNu4i+m7g0yLV7J3HcTDkOZjWz0qa1KZvBiPAHsc=;
        b=QhdWTf1PZ5bTH1iQfK/l/BKmidcts0aKyOxHXCEZ5xjmDOjAgi869nDD6nhfPGeAbN
         qLag9UNy76SSgIATdY6624ngSQ7X2r7S8m/LdxwWpcXtM78EOdnAqScVKN88l8kQaAu2
         6qCaFwOdHB12lxJiueDITARqWkjJMlpjZbrlx6YkQGh5j9EwxU64m7r0zOsWzt2hxsMO
         SCvY8xB23t3VGXKu86SR+vnCKkS9sDjXS5DVYlf9lel74o2901/R7a4yML4GrLMbiZxz
         ASBizNuJk638/S7rwqMd0VLcxfeeB5zSxFoCtOgzmFoimUQpmi5kbXi6cGc2n2XzZhGL
         8RCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784477716; x=1785082516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5cILNu4i+m7g0yLV7J3HcTDkOZjWz0qa1KZvBiPAHsc=;
        b=XDst8h+3SfK/LyOPUJcP8v5DlBs8kGtH3ngyb1IHORhDdXIAjvBpxUrV/T4G+q0Rtw
         QO2sbyG2ExwzR1vij71GofsaRVc6nUaPFYNuutcMVZ3nk7iYs5rmhNrQCooZpP1zSkl8
         sJO/JlAG+u1KiWQ0qZ5O6c9WhaweFtrTEpJ0dbUP0qEDQR0Cv6Vvx3UZ+SB5SbTEUhKY
         yNZ5acdDJMCQM5QvGufKTw7YCVNLIapVr7jhn6DFX7Y+g8gMkUNmfngQyB/3wYcECChY
         gtvubFSVBISxzY/bSgRfv2a/ibGSMropmN1G6+wZ6mlvGBx9plrmL7dDg13pC72TX5vy
         +/aw==
X-Forwarded-Encrypted: i=1; AHgh+RpzqIy5GHNM79ajAs9V0jYiFPe2wff7nB8n46l6NQDL9AtxeLKmhszRtlHKwl0m/S60I2qxJV2XtA0eIYMtYBeXZwxmNHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN3IjfIz3Xje9If3E/5Kgwrdez/g2pTzzzK7oLrrePlo7NFzLf
	cSOmUX3qTA93gz+VvhUyimlOqk7RIE4hsZfkRLYRlkSnARQaGt4beYXc
X-Gm-Gg: AfdE7cmu7ekRLpsf3egE0nY0yOM4/uBK8WLRF8oNKMemjU6kiUCHBydIE1q40sG5UUj
	cNm3DYP7JHvxHIyyqYSoL40/aKSR9xA40hiS1rrRV1JPWXG0CPscpxZROAixxvkrbP8LNbKEWwq
	y7BhFuc8gz9CDpyLfgLcfhd7CELABrSxkYyQE2o5Dzkd/fmVysBROnWXwQk/Y+Sv8B467Ct1WO6
	K6HZt9xP5wUfWYWy2xL+4zzLAF5sPBUoxqMSdHLlJQLyFhxMeRKX7OiDdI7RZdmT2nbBToKo+yh
	u+k5u27AsPGWDaMB6dPYYQ1PE2Ap3wTjKwbfQFmvhoI558oa2N/3U9pSclN4dj+dooBlWSlaMpl
	lL4bODZdY0mIgRiYfSRaICvIjxRStqhWoW9a6/N5RbENxQZIfjl9yXaIOUvaKt6tq2koHQZbpbg
	3Pp2I4UvRTGDaIge0VKmuU0ygtQL1vf1Sfh3K6KQ7w2dHmmP1Ordm/ztxRLoy3+Zgm8v29XubZQ
	Kx/Mpd2lILNDgNnkv+NqA==
X-Received: by 2002:a05:620a:2585:b0:92b:6805:917e with SMTP id af79cd13be357-930b41f9bcamr1041279485a.70.1784477716549;
        Sun, 19 Jul 2026 09:15:16 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b52fe271sm672374185a.16.2026.07.19.09.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 09:15:13 -0700 (PDT)
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
Subject: [PATCH v3 0/3] keys: fix keyring assoc-array out-of-bounds read and index inconsistency
Date: Sun, 19 Jul 2026 12:15:02 -0400
Message-ID: <20260719161505.2423935-1-michael.bommarito@gmail.com>
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

v3 changes (patch 1 only; patches 2 and 3 are unchanged):
Per Jarkko's review, patch 1 no longer extends the existing
keyring_get_key_chunk() declaration line; the new offset is declared on its
own line as unsigned int.  No functional change.

Patches 2 and 3 are unchanged from v2 and carry Jarkko's Reviewed-by.

v2: https://lore.kernel.org/keyrings/20260714115451.3773164-1-michael.bommarito@gmail.com/
v1: https://lore.kernel.org/keyrings/20260712014500.480410-1-michael.bommarito@gmail.com/

Michael Bommarito (3):
  keys: fix out-of-bounds read in keyring_get_key_chunk()
  keys: make keyring key-chunk byte order agree with
    keyring_diff_objects()
  assoc_array: trim the final shortcut word using the current chunk end

 lib/assoc_array.c       |  3 ++-
 security/keys/keyring.c | 14 ++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)


base-commit: 2c7c88a412aa6d09cd04b414211b4ef8553b5309
-- 
2.53.0

