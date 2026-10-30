Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355906;
	b=xXlvqQ/Wf5cQLb1U7yJDIO8p31XgDFx2vRLxBGzJpOV7JG9Ch4XLs6uEW6pty+OgXtR/
	 Ls3xDSb7u3Y1vwXLzokFJwxr5V3ddWvRSHyiAFkMd4p22pWvz9qUeTHQgINYGF31lSLXq
	 4pdYnhttFoT+okdCovJN5uld2IyhlSHsL722zy79DLkDNCYF0TUbdfzOLwy0K47fpcqYT
	 njA5cq2Qxo5wM+Vc7Kgph0OQOamA2dBfqGJWFPEmQxDXB6UjZPAvTIF/Bildphj2phV9W
	 ZOR880Qx6393i1EUYxCLXyoMiQaSe5YwNc73jJTgzSCbeTNYD0PsOeC1nICSYT1NaUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=uLzmUNcIQUXf9Z2hqI+SKTVNqVZNs7vU5uqtLnJ2DV4=;
	b=Bu4skC8ntUAjYPUXCdA2PCXT76MjRAmYTQDzqNfliartCtzBRNBo/wLLwSKRgd53rmkB
	 52l8CHDVGvusEU2vc+Jh2NCeADgUtN2ut3NtbynkLOB24rU1ZO+F1xSgMyCARsLuhznoq
	 iwKQA931Y570r73Hu2pkC9ZhrVOH8FvjS/D+ptwi/kHl6Ft9yF+NrPwx/NUB7jE270nSZ
	 ZBrCY0V6DZj9uAD4khg0VTAPovylffly8WMOvby9HgpS17q565hT6pXtqbufPNPwCZL7q
	 1gGOVv0tsnuVNqG+2vMiozkJoAidej80hoGgcZ5mQF6/NMRgMX0M8bHCFkeRxEWscew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="dqww/Fpw";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E016606A32D
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 10:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E016606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dqww/Fpw
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so1917855e9.2
        for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 03:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793355905; x=1793960705; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uLzmUNcIQUXf9Z2hqI+SKTVNqVZNs7vU5uqtLnJ2DV4=;
        b=dqww/FpwZOvCFFAcqraxdEMZH1xUfncj6J6T34h+JxsA4v9HF9xjDhrtF/6dv/aLdq
         lfXfHjayVlhZTYPFZcBADT1Q10tVaz/vqXWtNby6WhqxGp6Oyq6/CojAvxHtElHSR5EP
         8TSdceBW9SLACHLk8pTNEBzprnqhtFTavOUzFb/5iiYXkVAfOZ6Wyyxu5hSYDJvXUl3x
         SCzhNNj99na1zD8KDOTJ8GohndOcGrr80dZFzkWAFbsOUmvXijQASz4ZDm0amCsLHi2S
         k5ULMt/gw25tBfAbmxP+hY1hI18n9+l/9tkZokw1pz45nbqCKdH0eE+R2iAAYdZ5f459
         JjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793355905; x=1793960705;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uLzmUNcIQUXf9Z2hqI+SKTVNqVZNs7vU5uqtLnJ2DV4=;
        b=pXp4C2sFBKDCp55DHe72QCCndJllRgayWCZlAKcYBYz4NNUKCr/Sl67WrTNdqB91WG
         XNhCb3XjDA7zmPfPS8M0Wrsk8x/p9oLsF+AtlrYLczgKhbqHBvINgSuXEbzHRFd7Xfd0
         k47JRPd0dqdGplW6xaA6m3zTNcGhGYWEajne9wQ13sT/3VusMMi8ds8YSpg0C47BF/tv
         H50Osoh1AQy1hVC6H+4A8L4Uk0yZ6YSqqC+RGgn+qb0b5bMzMV0UfjQFi2Zcv92q+dKy
         UnO3VgVb0/fCtDcnAtregux7qDeP4aCU6JtwUXI6tZIIIaZJmmrfhPxyGsKv+16JHomr
         roEA==
X-Gm-Message-State: AFq9FYIx5hem/Gh3MvpFUBRR/HeCH83SgYnTXCJ6gqOGSSH1DONcLRUd
	SmLf77nXZfBjLXfsh2h2jiFaAf90h7tmrel5rKl+gWdUoSPhLT8aUx7O
X-Gm-Gg: AYBFou39P3CjZ9VqQm7DzD3GaA8ETT4YADp+5FHFKXv5nNxe21HkBbQpMPwo+oNtR2z
	teobVpZ8SO8oRn6cth0I2KVudxq7rdIujp9TX+e7PC+5QLOlYe4Uzv8M/U7UJY2akufVRtvzXsm
	0Qeo+C+sPnTBgidhgpvDuItUVJhRb+0K+2xosoKxL+UnBu7nrUFhKseQfN+OqaJtYapaXjVrf6q
	uZKAQK9UqXw/n6agoVILD8+mujDrBxh2SqJpywCjLLF0szr9SH8WQsvKR4cf5xd5ZCSQsa6JBC4
	u3NnwINcSdxHYEIvn9Hx81P2EdlcvLIyIO5zdJtZbfH2lWkMUpRSSO1eDvFw9bNYik+5WOXkLvl
	qYjzfokMUmRJ39ZPU5haWcj1DtREB9AIvEdgkceSloM8mpSjMv7FSjJO2z0fpOY3MIR9HNtieby
	UO+fZDMA8PMSKPpU+Y26tYXy4ponuqL2MvGfLYXGZRacO8gg/d+RvR+abrH733Q4tmEchQ/U/3m
	CgBLDpiiaoukq9rNmw1UVrMUPj2xItfpPL2cay+QzpEj1/Fi1JX3uA9mHSJsoF58U9dGedCMFCS
	d327WyGTYaXHGBc/JV+O36fDUk87E7AugbjLWyqINGEk60eZIX20B9M=
X-Received: by 2002:a05:600c:3b2a:b0:4a2:cbe:bec2 with SMTP id 5b1f17b1804b1-4ac18a8882cmr36468925e9.32.1793355904435;
        Fri, 30 Oct 2026 03:25:04 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba24f6sm2403919f8f.51.2026.10.30.03.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:25:04 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org,
	Dwi Siswanto <me@dw1.io>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] landlock: Simplify landlock_get_fs_access_mask()
Date: Fri, 30 Oct 2026 11:24:10 +0100
Message-ID: <20261030102411.12985-4-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030102411.12985-1-gnoack3000@gmail.com>
References: <20261030102411.12985-1-gnoack3000@gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Return the handled FS access mask as it is, instead of artificially
adding LANDLOCK_ACCESS_FS_REFER to it.

Since commit d6c7cf84a24f ("landlock: Simplify initially denied access
rights"), the merge operation already bakes the initially denied
access rights (LANDLOCK_ACCESS_FS_REFER) into the a layer's handled FS
access rights. -- They don't need to be added explicitly any more.

No functional change.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 security/landlock/domain.h | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 693e569f5387..1aa85c817d0a 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -258,16 +258,12 @@ static inline access_mask_t
 landlock_get_fs_access_mask(const struct landlock_domain *const domain,
 			    const u16 layer_level)
 {
-	access_mask_t handled = domain->handled_masks[layer_level].fs;
-
 	/*
-	 * Handles all initially denied by default access rights, but only for
-	 * layers handling filesystem accesses.
+	 * Initially denied by default access rights are already included for
+	 * layers handling filesystem accesses, see
+	 * landlock_upgrade_handled_access_masks().
 	 */
-	if (handled)
-		handled |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
-
-	return handled;
+	return domain->handled_masks[layer_level].fs;
 }
 
 static inline access_mask_t
-- 
2.56.0

