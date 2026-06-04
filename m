Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F252247B43B
	for <linux-security-module@vger.kernel.org>; Thu,  4 Jun 2026 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577448; cv=none; b=oU5ENNciJbC0Pj9OYMsUqgFYrGRLPx312Qlcz/leiMuFHRQqwPuQIIUH9d8+hB+kAZqtDlrk8/E3XNoYTkv6NVfaXIVXbUxLEgpL1nuSbyBjEE9ZUXeuXexfuCRbk6N1+eFB3tiPCao3xKMEuZb7HexipRnyE1m9VHccgLCeGEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577448; c=relaxed/simple;
	bh=lbWaJXCgqnU/VgUH+gDEW7qnj7gIAwhY6UiysV4cJx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EKO55ZF0SNOEdSNSTKPfqDCCKnXytJ+vks5m8WZX9uL35WAYN+0GYYlLnauxE7j6yEBwFcy5+3EH/za7SZ3CHFG7QnjVx+o9qu/06G0rgHUnbQtOMGsEHjUazAU3BeB+JxE3dG6LU4Ck1nNNYbeY3jFZCf07pkhPUhLWTIXNGs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSt/cjYD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSt/cjYD"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490bb83a3f6so5945065e9.0
        for <linux-security-module@vger.kernel.org>; Thu, 04 Jun 2026 05:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780577439; x=1781182239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yJUnjTUV8BBZlgR8+Wodn126IIs4cN704iHM3h+CNdk=;
        b=hSt/cjYDrt0VUY0x8IFugiSHQesyJJpVAl1T18S5ylZRJj3qjV5UU9oRYfBFxBvX+3
         Qog0d8Ft6nXAh5nPnUf9515yyNySi3ZJOE6AJx7/ko8KZH7DzP2FsqX6Dlu9EJ0mGx+Y
         1qeQk/vB/0C0mtIXx2uorWG9q6Bfuc/1rkKzzVzC4I8RESGqfqUNYj1v/e5Zsqn2q0fB
         B2iN9qcR00JS0iSAuRsk/kpn6Sp8C9aBP/HwLyzdhXePrB/bYYZAtT4JLpRza7C8KiEz
         TdKPwfuxg1bimXLoBmibiksQegVNLLEVgAwXb97rOcYK7N2C9ycRlNacOhBtZG6DVQrw
         n/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780577439; x=1781182239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJUnjTUV8BBZlgR8+Wodn126IIs4cN704iHM3h+CNdk=;
        b=aK6ACMlyPdZ9CvbrMxm9xFGDtCq/RJtYVJMja+CfzB/i+qfUqrBvsIbFsgS9KD3J2V
         qv9hKfDSnATvPPt2KnFrVPjNMEkG4FdcMPcBxFKU0yt+aII8KvgFmBTA7bc+ZzuD2k4B
         TRFSYr9yplJ8+feIiNcTVhUmaZU436/f+bsoy0tykNN4ZVRVuYAqWVaYfWGKzJs0Yxxt
         ME+xPEUSixRHTxHMCa+B9rlEkHRJ75FaIoVg0QkW6ttlr28Z+ESRHzaZQA0UBtd2DT68
         rdsmsVy8JMY7KWzaydrks98rwNFo0xXPv06hkjLmp8wotw8X5tR3vYHUJfr2O4FdFT3w
         A6RA==
X-Forwarded-Encrypted: i=1; AFNElJ+9ABM81ndBmpJmAwQI/HsPeEQ6WYdmCAwQDW1NXTlaYhzLAJWv1LrePZlt/Hfrm5CwnoKOH/fFgYbc7opDLnV3BkVkiW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLpYK8p5VAMi6+vby4WGBGRWTg+yHtpK8cg58+cv95JNwS9O8R
	xRLsI/Z63f/iij5H1cwatS5Yx/KTwWN/3q4Mo+T5TrbaIYl+jzMp438=
X-Gm-Gg: Acq92OEqoecsDZvf8T+u3F5D3CTLjQhasM/6hw4NfVmoW60yT+EMBw5Nvam6LuefPFg
	LMNEBwV+N6KBzbUsosRy2/ExWbRT21ndjO1eI3tMUGx3QxIkGEXndns3wNTH62PYqOmxdTP4yC6
	7WDrwbEzJvUcvoPvNdKKJt3vcGg2HeTNBtEwmobhqEoT1+0dEYFp1g9S7+Y5X95xS1zLn3iIJkH
	z9VY7//mhYhtFfcvtpjuL/aAxKqppjBYCxJOfyInIsUgTt0tHhZzQvTxCJ8U/yX8aFid60mnqfy
	HRBvdn1vd1dGYmABxvBoUwlejBaqhu8xOc1eLvNGHhavgIBjddgumil5fuDqCJfz2y7Oi+gJEyQ
	DDVckaQCxb8xkQnX1+N14QW49A7Xcmpn2w2GJVZXvYOyYlYODdghiWnvjG/0XtRCCti+SxeuqCT
	wUrrpfzwvS4hSH9BT1kZxxMNwuMF3OYhjmV07RuAGouPw8l99Lwdr7hfq1wzU9h/spFp+/dSyEJ
	2In0/QjVZ1ZDHuHgxueOSOeLzdqL1/a+Eyrr0+nmQ==
X-Received: by 2002:a05:600c:3487:b0:490:b6a4:9f43 with SMTP id 5b1f17b1804b1-490b6a4a040mr116278425e9.7.1780577439015;
        Thu, 04 Jun 2026 05:50:39 -0700 (PDT)
Received: from hp-ubuntu.. ([196.119.187.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3b59f0sm79430055e9.2.2026.06.04.05.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:50:38 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Kees Cook <kees@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: [PATCH] keys: prevent slab cache merging for key_jar
Date: Thu,  4 Jun 2026 13:50:34 +0100
Message-ID: <20260604125034.13757-1-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The key_jar slab cache holds struct key objects containing cryptographic
keys, authentication tokens, and keyring linkage. This cache currently
lacks merge prevention, allowing the SLUB allocator to merge it with
other similarly-sized caches.

On a default Ubuntu 6.17.0-23-generic system, key_jar has 5 aliases,
meaning 5 unrelated object types share its slab pages. struct key is
224 bytes, placed in 256-byte slabs alongside biovec-16, maple_node,
ip6_dst_cache, task_delay_info, and kmalloc-256 users.

Cross-cache heap exploitation is a well-documented attack class
(CVE-2022-29582, CVE-2022-2588, CVE-2021-22555) where slab cache
merging enables type confusion between unrelated kernel objects. A
use-after-free in any subsystem sharing slab pages with key_jar could
allow an attacker to reclaim a freed slot as a struct key, or corrupt
an existing key through a dangling pointer to a different type.

Add SLAB_NO_MERGE to ensure key_jar receives dedicated slab pages,
eliminating cross-cache attacks targeting struct key. The memory
overhead is minimal: with 32 objects per slab page and typical key
usage bounded by system keyring size, the cost of dedicated pages is
negligible. There is zero performance impact on the allocation hot
path.

This follows the precedent set by skbuff_head_cache (net/core/skbuff.c)
which uses SLAB_NO_MERGE for similar isolation requirements.

Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---
 security/keys/key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index 3bbdde778631..592b65cf8539 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -1275,7 +1275,7 @@ void __init key_init(void)
 {
 	/* allocate a slab in which we can store keys */
 	key_jar = kmem_cache_create("key_jar", sizeof(struct key),
-			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL);
+			0, SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_NO_MERGE, NULL);
 
 	/* add the special key types */
 	list_add_tail(&key_type_keyring.link, &key_types_list);
-- 
2.43.0

