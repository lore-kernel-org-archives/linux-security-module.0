Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3973ACF17
	for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697376; cv=none; b=RaCMnpTugiBUk/0Dl/JV8OnAw3K64uGMVZ+x3FSHKCxlJh/8CwNxIgsMox/GZZRLlV5qL7yZKzJ4Hb7VmIkAMHKu1JHTmUG9PAwrxA+QcXvgKvDVeyGjQ9xQjFEwmvREv3UW6r7Z4qTLN5OU33uyklBqMc/ARLHZ9ToERtfv3fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697376; c=relaxed/simple;
	bh=rO3h1Z0IMdUe40XbniH7Syeq4c4URoeuKQNA3ehrqjo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=kzIMa8O3msZ062JWB8fVBo0YSomcyPTNK9v2PWJ62JoXAqqOj3yLUCPWDAeR971lNjtirZJp2P257kZJMZN0PYNWS6Eyst61tGAmQh31TvN0Fr3ijdpUxSAgUaqk96L82wZ1DHLHSL3OJSQwB83nXmj5pJjfSC9gaL0i00FzpfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=L+JVn93l; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="L+JVn93l"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50e5c7eb565so68834761cf.3
        for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 11:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778697373; x=1779302173; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P2T1YkP403+tJ+X3WhxlPcahyNJiY7q6QXlcKSX4nKU=;
        b=L+JVn93ljCggkMDRrMmIQOy+ciQrWxjROtkJXOeNISU2XT6bdwnTLW9cnFpAOCb3qW
         hj7l6kus1Tg5JCyvFnieHdneRhoG0MZZiR8Gg6MYf6IUkX+C1oI7ex3/+pl6lwYz762+
         0dZ29t1CW5vj79bKQsDAn96DY9FuVB0+jfEh696a39fkEwg1Q1Gd6kGZ2LwZrSX5ZjT9
         YEbdx8lvyMeF8EtQer+i20Xj4UYzmDU59TcYoOCR1y693DT9Vy0Hsw2jGIPh5ZRR1gNG
         V+Xdy8dBcmPk9EYc6uZL73a38kbvOgELR9YtJrKFI1hs8qF+b+mDxrjAepdXSbimsOmX
         Cw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697373; x=1779302173;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2T1YkP403+tJ+X3WhxlPcahyNJiY7q6QXlcKSX4nKU=;
        b=fYjmirpCNZxXB1eGojlPcRDHXjGgYcMkiHcejm4AWnDnpxq8PrcI/0YrbpnUY4BxqN
         yUel9IXKVsuU2EpmOY08OeQQu26psBF6SCbl63kM4FixF2HfLR9A1SG1RrP0dzFs1/Jv
         ndmTr99WBjssLXFv4G6FW/wOQ60318iA6fRSe8HFtkmUwxkGlyRKYpqvoTsbynnL7P9p
         /i2jdmXEL+M98Cn82AVqEaAHD/CM/no/Mn3/Zn8uC+1OUTTyqQj52CCU3oYB8Q45FX3N
         Pv96euZBfrm0spBZOMMftiL3ackM/QZXPIGI8YdVXtyM/LFUy5w/G6pWobdyKY7ddIdW
         NJBQ==
X-Forwarded-Encrypted: i=1; AFNElJ/iO1z8x2ekY9XLiLebBeQuSphdAMydCod63qw20VrWHRjwU3IzrX3zIPZsNI8GhQMZTOD4xJGJRWi8GvtNaLXF0lIXB+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEdGu2Sge/c6ewpv3XSK7utvfgIxZ0IC35QjkfepvMWAdjYLDT
	krkNoxIVovdUCqBIZ3kNkOz0Q9P73VNZI/XhRvPZLMN9Dz5+4DsF3yHDi1IIZRABpg==
X-Gm-Gg: Acq92OERji4NL2VbKCWtmn1qQwEShwhVAOc9JocQMxbjpTLKRUffWplqcAcgFM+pl1q
	Q6fOBBk5asiEcK/2jQEsE+siYAINSGrA16eMmSsatVk8rlECDeoY2Kx8QAyJFz+A27OmAv/FUUa
	oJVO7ZjiYSg2c5rz9mVUd2uFtOBZ5CE6f20DJH4xz78KHsh4vp8Ytrn8ehITsPIrF6HdiTrGjMh
	S0nnUPOcz/vhY4O8ycR4h1PdFRQZYtX6dMBpKwSmj3ZCRVFVSEZSGULUjLoEvYCbx+qxUuGUvzG
	qjL60g4PVU5JH2zLctboG4zx8AZ6o4Q2tALFBBh8CHJ8CCRAlvJvU5q3XlxzW0t/r/k38p833F4
	qCfKMrnT39Zb+VftRzSR1P68yZN3HxC6+cGk7/qm8rsyhFLFb1bNYGIixu1m5rZXa0qrnLXsOL5
	v0XF4oFN8LK45jlWWaL1Ebl9Ze1HzraOgm+wFF42ISD20IKQirLhQhnnOUh+4qHi0TS2c/nSReg
	RtvOQM=
X-Received: by 2002:a05:622a:6d06:20b0:516:3183:c1fc with SMTP id d75a77b69052e-5163183cb11mr38795191cf.50.1778697373350;
        Wed, 13 May 2026 11:36:13 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90bb82a7asm2888936d6.37.2026.05.13.11.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:36:10 -0700 (PDT)
Date: Wed, 13 May 2026 14:36:09 -0400
Message-ID: <f367fe9b2695df27e47f4836d0f51fbf@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260512_1604/pstg-lib:20260513_1343/pstg-pwork:20260512_1604
From: Paul Moore <paul@paul-moore.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>, "Jonathan Corbet" <corbet@lwn.net>, "" , "James Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, "Andrew Morton" <akpm@linux-foundation.org>, James.Bottomley@HansenPartnership.com, dhowells@redhat.com, "Fan Wu" <wufan@kernel.org>, "Ryan Foster" <foster.ryan.r@gmail.com>, "Randy Dunlap" <rdunlap@infradead.org>, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, "Song Liu" <song@kernel.org>
Subject: Re: [PATCH v7 5/10] lsm: security: Add additional enum values for bpf  integrity checks
References: <20260507191416.2984054-6-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260507191416.2984054-6-bboscaccy@linux.microsoft.com>

On May  7, 2026 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> First add a generic LSM_INT_VERDICT_FAULT value to indicate a system
> failure during checking. Second, add a LSM_INT_VERDICT_UNKNOWNKEY to
> signal that the payload was signed with a key other than one that
> exists in the secondary keyring. And finally add an
> LSM_INT_VERDICT_UNEXPECTED enum value to indicate that a unexpected
> hash value was encountered at some stage of verification.
> 
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  include/linux/security.h | 3 +++
>  1 file changed, 3 insertions(+)

Merged into lsm/dev, thanks.

--
paul-moore.com
