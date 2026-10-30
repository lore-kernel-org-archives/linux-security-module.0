Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355899;
	b=A5j6IMPIJaXK44UtduKnWKdz1k0Vjg8YGh4D3r1g5wtYbV16Ynu0xL8SbONZjd/G/dQc
	 TyLMklPJ9l23H4m9jvTQ426nsjWc0X/TzMKuJJDjmiTgXLeX5bazhiwzCfe9ASbJJzlTI
	 OzTXpLHsvLdJr1zmr1V3A1/ZgzGHp61MVUdjeupCXryw8VE8RJ1yyZUNbcHCVOCJ7H3lt
	 XOHdNOiZN18puXqyUUTuWjyogvpl4vOxrRnpdaxooggQHy7ybnHn4XP4C6HUzuNOU6XP/
	 C8vwp53WYyvO1jMPYCK6gLy9//Xb9yjoXBWjYmsP8TLVAwYmgqEBQtcIts2Gxg5L79A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=E27f2UiiVBnLmsXITpxqQbgne/YJdYOtatF+X4raNtg=;
	b=SSYvq0MEpPF4Scd3UJnT7UrZe4KXGcxLQpf6TOVfU2m5i4+FuzHY/lCS71r7Ysvr/oed
	 x2CbGCiFjcVCWp/nHBSZmZfN58TntDX54VubdJbyIak3+qNpDx+cyF+lObe8GO1vWzaza
	 TLLl0PnwLmbzC1Ke7DxquLXRF16yq/uJxNZbgtXSxuIOjiwoQwpIbpS9c1MoGUy6+A0lD
	 iK6WQM3n3Dp35jNqnyH/4elu7X7Ap2/J/ycvhRKi1cvU7DVxhmclOKIQwT59I1Big7Qlz
	 hfq7bnb3vKiH1w0ayNoDcCJWk9N42BP6251vC6G8iOVZVSf5oPO4+JJ7cTy4iyKTqMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KXWwTFW2;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E22606A31A
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 10:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03E22606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KXWwTFW2
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so2800775e9.3
        for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 03:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793355897; x=1793960697; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E27f2UiiVBnLmsXITpxqQbgne/YJdYOtatF+X4raNtg=;
        b=KXWwTFW2sNyAhgWCo6u4XOmyZ3XQrfbrvYMa2MjUx1ME2KHTsfUsqND2abprPXFj9t
         PD72/Vm7UkdzqJ6JePdqWCHbJEUmu8pS/dae6HAvwIjB9xgeZ0XjLlZN2rZsortKGPqE
         YgnoDOsha1rBtsOFJhZ1b7WkvILOl7yoJdLyrdKds2FcWcp76wNJmkvL6YH4IptE2mDn
         d3KrE8YaAm4RFMRev2rHVqOVYnAqlQyucLBrtJONEggqHB7+770FTwl8fkkpnaVxaPtt
         7dE9Xi/mIU/WpvSfG73fS9VfOpUJ+qMBvURT58QBmr3pV0xGVLdsiHmYYb3qBOG0ufs9
         6xAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793355897; x=1793960697;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E27f2UiiVBnLmsXITpxqQbgne/YJdYOtatF+X4raNtg=;
        b=u1nqO1lNINMCI3bHWfl3v5KdGX/g8vILvwJDOXLDhBJElHLkhPOJZUJIM41mvoOYP9
         AP7MCx8HHXZzLw5aZL+qZcdt3aqWbYvqH/scc6N1JVpm/qZFuIQ3s2h5ahKXmuMh+Zcd
         OzNN+YwTwDHvBRSRaIC1HZyGcle2xnSfU51+KiDEN4SuV2fKjNQ0U1HNDxRpe1Ssyqx6
         35u2UodZy7KdthTTGmeUss6hS1AcoDOdWnJ9njaTCuRS2w7SF9FWfe+V0r8JmtxTvFT1
         Nx7Fa2Sl6mVIDgHab8rKMkIRZkwwf7wZXN8c15Ex/Em24lbPUOR0Fnia2oftY7HuBjbI
         XAmg==
X-Gm-Message-State: AFq9FYImZ5OMHI6+xntNOftbSYuvSvOMaFxummes7YrIPSR9Il3rt6fD
	x7F65Z4FqPIFIHxOAzUErCD1YqkynCrHRy5rkHH+V1JiGX0eufJPzrQpVOlCAGdS
X-Gm-Gg: AYBFou1z+qOiLA767IdxVcuDT3f2Iy6ep0UtiHu8zkbTsxHPcgkqP9eSLEg/VusytAp
	eHu7hOtpjq2v7RF/p+Fko/THab3vyzKYsmNMrid7rq+ACptPkgUBXdeLKVyV7WNNMUNWulHt4Tk
	u3mqkO0aV5m5BA2S+mjuPeco38vHpHcLu17fNeGlawZv9RdL+mgEtw/15yBGcRoueCqSzlvLRsH
	tqBFqeKLNhLnw3oWRLLGnBM2fFdUWcMAo/6gEUsXYiEm861gDPz4sbF0a5TLoFvhiSrtdcCKd3+
	pAqYjDvj6Ob40m/cNpRbF2yd3bPlPx+i7HR7yxqXibv9S7ImdZHLvf6GyOVGbScX8d00VVO6wPF
	QtV+Q0oET1+J9LkzdIv47LzvbbRQ5st5HvSRknLwMyOce7XfE/L4SHGT5inlwsOF/VvfZzLQ6OV
	qQWRqOXlAlpQdZbHmGDSx3RwVkv/VP0SqI2JfYK1Diy8EUGcuhWR7Fogh2z6tFfY+vZUARbkLZf
	s3JO7AGKQSmsYVZEGDbyiFrQ0xSEgndD8DaXYrSGU4vOmMlAHGMzvV2v3DFps4YMZtJLzB/XWVm
	CLhiSAouGvlFOLeChgSKZ8wfULUzjZd6tyl0iVOIKpl6otKzyoSOuLXtabRmz55r4UNHGXqnYuI
	=
X-Received: by 2002:a05:600c:a49:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4ac17ffb2ffmr37037355e9.9.1793355897042;
        Fri, 30 Oct 2026 03:24:57 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f047bfsm126906595e9.3.2026.10.30.03.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:24:56 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org,
	Dwi Siswanto <me@dw1.io>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Subject: [PATCH 0/3] landlock: Fix REFER in layered domains
Date: Fri, 30 Oct 2026 11:24:07 +0100
Message-ID: <20261030102411.12985-1-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.56.0
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

This patchset fixes a bug in Landlock layering,
reported by Dwi Siswanto in [1] and [2].  (Thanks!)

The bug
=======

When Landlock initializes layer masks for path walk based checks, it
unconditionally adds the LANDLOCK_ACCESS_FS_REFER access right to the
handled access rights.

This leads to a wrong layer composition, in cases where the following
layers are stacked:

1. A FS layer restricting REFER, but also allowing REFER in a rule
   (e.g., handle REFER, but allow REFER on /)
2. A non-FS layer (e.g., networking-only layer)

When these rulesets are enforced **individually**, there are REFER
operations that are allowed in both rulesets -- the ones that 1
allows.

When these rulesets are enforced **on top of each other**, the non-FS
layer starts enforcing REFER implicitly as well, and all REFER
operations are denied.

This patchset
=============

This patchset fixes the issue in three commits:

1) The fix, which should be backportable to older kernels
   and which is CC'd to stable@.
2) Regression selftests.
3) A more elegant fix for newer kernels,
   which is intentionally *not* CC'd to stable@,
   because it would break on older kernels.

   In newer kernels, we already add the "REFER" access right to the
   handled access rights when we merge the ruleset into the new
   domain, so there is no additional calculation to do for it.


Please let me know what you think!

–Günther


[1] https://github.com/landlock-lsm/go-landlock/issues/66
[2] https://github.com/landlock-lsm/linux/issues/67

Günther Noack (3):
  landlock: Fix layer composition of LANDLOCK_ACCESS_FS_REFER
  selftests/landlock: Test that layering does not break refer
  landlock: Simplify landlock_get_fs_access_mask()

 security/landlock/domain.h                 |  9 +++--
 tools/testing/selftests/landlock/fs_test.c | 39 ++++++++++++++++++++++
 2 files changed, 45 insertions(+), 3 deletions(-)

-- 
2.56.0

