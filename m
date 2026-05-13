Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCCD3B8111
	for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697392; cv=none; b=YnX9GA4N6IX7vfqFKxjEqIN8lMOXpkd02pyz0mObQoKANL+bAJtni60qATRABNmCD9K6/yOGX0pIb/yVcazMkb3Ywim8VbMLFV7mYfnIBiXWf0CX7WR9H5KcqkTWFX0a8d7H8rmiS2ucfPlfcYNQxh/cTAb5DV2uocNUiXNhxjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697392; c=relaxed/simple;
	bh=NXfuPJC4WSBHlTygHezAndhnrlRtJXLP/Fq/2xUcvRE=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=gkT7cOfLnylVKKC0GtaqDKNMgTLOodDV4nsdji/J+/+WYHmVG9AGR8465r+CBrJQFJB5id0cib++Kha0Q2hNCpqfziHnsV1w+wIDlj8wWt27cPkwrGkoTfSUgk35i4niYwKhel2V7zdee25v9GsjmYZFrKfwAMF1LB3UTXxL+6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DSYTfoqs; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DSYTfoqs"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cb40149037so661121385a.2
        for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 11:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778697390; x=1779302190; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOF9niRN6Jvg5hWvhCYadN/BxIKdMgGJZ26cseYyxbc=;
        b=DSYTfoqsiT7AF84hz15ZZiMdeYslCXcIBpkQAP+JPkf4C24XRXdixXbZXftKA1Zv2q
         IRyUf9E0xyDQI92VjhlwvOFE2Kq09cxCGzagVQ7TnKtSLPnJUgsGvGx4SQdVLhJLynTO
         fTveQOWMV2ICb9h/0dBqMqENiXFDWWZvJcH8s2ZOU1+mObl82vfalhoUrPfcoIsogv+E
         KoBYnqOsuhVNJm+bU8H8bH1kpoR4SArDWlkil7yrH/v6lpfHpCjm/nOdEk6JqtxKt34V
         4JzlqsDTFJGYMjvwuWpwTtv10wZVaO1aoS876YgYCyyzNwbC+ouNmliGhzo0jO+RQ5/l
         xrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697390; x=1779302190;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOF9niRN6Jvg5hWvhCYadN/BxIKdMgGJZ26cseYyxbc=;
        b=Adzc4Ar/ynqH8wF8XYM+5bVJifZzUPKqXwgcr3zZjicffnNjNoRCk+ktWvSKCqSH2/
         E8mb+7eTBZaS03JZHkffCuCg4RigGQns4UNdst9seuhcLKXMmwkT6cEOdkVY6EjAFdgs
         Ca85NT6m6RIFZaPArhJAGvJsFfg1/A08Za5YkZTtaytjFjU/UXkzh9W69snnw82bSkh0
         xMYjF6F6QuHfcdqv1iPi8mD4eXC+Vl3Skz+Ik67jR0kAjQ8ux+Z5j2lL4Epr9uXuHROn
         Djnx90epWBBXBqcjQYrlskvsjnlflknyGRRo+/UZTJVzQJkmzxuWQCHyicWlp/Lsfq/u
         vWAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+UVfERxuVataVVv/n1M4q8Qn79P/VsCfKXesvS4CXipNxL3DmtIvv8eejRSFIWqsZSuGliE938HlzBSxF8DdCNDd2wLNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGpNFJvBYkffGQAqkTNnvU/TUCQxTTooeqo97Db4nR8Q4d1yZE
	yba68UR5DFgupc31xegkoidtdxRTvOV0bSwVGS4ofkupZ5NidXBTt7iDclnA6+tjlg==
X-Gm-Gg: Acq92OETQsvyTB2QrZuus9y0AKSrlZRi9N3yED1rSetC4sUKiCN4pU2WVkM5kT4/41D
	x+9uOASkYQ0sCEXv/ssfYEqhyLM296Fdkiq+ytObCkkkxb13lqFkvZqLFtY9qW66B8BN9p8TQ8d
	bVH+J3NlhDEgXJJ9rPMRL7Ur6AsMYm9NX/OoFFrVi8H8eG9hP8FYs8sGruYeXx3s/9sTS/FUF3X
	omM0MwAETcvpPurwje5Ee3o0y30H7YHfpgFoDJMb7NkCKHpvTYdIStUrHjWb5KQ9lQ7Tg4TaSm+
	UlngQ3oWiEwLlXnJuivA2MNRYhQiyyK67pRawkkQ9eB5xOKM+t9XAX3N79YgiFe7X08mjivCQaE
	aAuqJcAgDOVHVSYx/X/h4X0RvlLnpDscAnmwFVL2lF8Dy4yIrH3uWoMvn9qTOyyguLV0M5IROxZ
	N5YTSRgsr8kPr7zNC9k6c+x7tgpXHf412lcJqESAnezuhEp+3YcwdkfvLS+oANXmeFRfxe
X-Received: by 2002:a05:620a:2682:b0:8e8:bedd:14b7 with SMTP id af79cd13be357-90f89668be9mr690867785a.22.1778697389597;
        Wed, 13 May 2026 11:36:29 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bab32bd0sm34033485a.14.2026.05.13.11.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:36:27 -0700 (PDT)
Date: Wed, 13 May 2026 14:36:26 -0400
Message-ID: <c759ac7dd982a61d78078371780bdfac@paul-moore.com>
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
Subject: Re: [PATCH v7 10/10] ipe: Add BPF program load policy enforcement via  Hornet integration
References: <20260507191416.2984054-11-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260507191416.2984054-11-bboscaccy@linux.microsoft.com>

On May  7, 2026 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> Add support for the bpf_prog_load_post_integrity LSM hook, enabling IPE
> to make policy decisions about BPF program loading based on integrity
> verdicts provided by the Hornet LSM.
> 
> New policy operation:
>   op=BPF_PROG_LOAD - Matches BPF program load events
> 
> New policy properties:
>   bpf_signature=NONE      - No Verdict
>   bpf_signature=OK        - Program signature and map hashes verified
>   bpf_signature=UNSIGNED  - No signature provided
>   bpf_signature=PARTIALSIG - Signature OK but no map hash data
>   bpf_signature=UNKNOWNKEY - The keyring requested by the user is invalid
>   bpf_signature=UNEXPECTED - An unexpected hash value was encountered
>   bpf_signature=FAULT 	   - System error during verification
>   bpf_signature=BADSIG    - Signature or map hash verification failed
>   bpf_keyring=BUILTIN     - Program was signed using a builtin keyring
>   bpf_keyring=SECONDARY   - Program was signed using the secondary keyring
>   bpf_keyring=PLATFORM    - Program was signed using the platform keyring
>   bpf_kernel=TRUE         - Program originated from kernelspace
>   bpf_kernel=FALSE        - Program originated from userspace
> 
> These properties map directly to the lsm_integrity_verdict enum values
> provided by the Hornet LSM through security_bpf_prog_load_post_integrity.
> 
> The feature is gated on CONFIG_IPE_PROP_BPF_SIGNATURE which depends on
> CONFIG_SECURITY_HORNET.
> 
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> Acked-by: Fan Wu <wufan@kernel.org>
> ---
>  Documentation/admin-guide/LSM/ipe.rst | 162 +++++++++++++++++++++++++-
>  Documentation/security/ipe.rst        |  68 +++++++++++
>  security/ipe/Kconfig                  |  15 +++
>  security/ipe/audit.c                  |  15 +++
>  security/ipe/eval.c                   |  93 ++++++++++++++-
>  security/ipe/eval.h                   |  11 ++
>  security/ipe/hooks.c                  |  63 ++++++++++
>  security/ipe/hooks.h                  |  15 +++
>  security/ipe/ipe.c                    |  14 +++
>  security/ipe/ipe.h                    |   3 +
>  security/ipe/policy.h                 |  14 +++
>  security/ipe/policy_parser.c          |  27 +++++
>  12 files changed, 498 insertions(+), 2 deletions(-)

Merged into lsm/dev, thanks.

--
paul-moore.com
