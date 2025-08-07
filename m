Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA213FB31
	for <linux-security-module@vger.kernel.org>; Thu,  7 Aug 2025 01:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531068; cv=none; b=EIKeuGV499PMMRFP1W1B1hksMGBdLQHCGi0s3eDhLokzHYRHYctq5s6DASVZ+RyIkxC0fbWICXS/97yTgkfHT5vain5lEpVvyU5KCW+ENJ6Pu32B6CsrPGSlSDhSK1kwAX0OBQ7sxsn8mOgii4A5JXRtmjlxjWMcsoJbLGKgOxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531068; c=relaxed/simple;
	bh=2mkVdtlCixWWJ//o7YVUSuqsmwIk1v/nc9pdkOIaeBE=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=QkAtKOtf+hEtea6nKlu0GPg38XW/C5slKx1pEHYlb+yfAYGzL4y2fu0xe73JcsnGxEKbWHR4XZezdAcwnXkokNKBcRPHyGKIxp81FnWWboR6zAGOmIR4DtSI/bpzFO+Cwptl7nZfDuwVJxn/r1mLGLEDptZZVH+ENJYIVdj6JIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BDzrGpvf; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BDzrGpvf"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e691926a6aso59303685a.3
        for <linux-security-module@vger.kernel.org>; Wed, 06 Aug 2025 18:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754531066; x=1755135866; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9dw5aKL3fdIEzWNyCmsONRucRn9UMVk2LBQjL3Huq8=;
        b=BDzrGpvfRyj2nJDgOl1Qa96hxvlbXWL/l+zf+F/d0yMJ2JoD2kGlPQQcyx+gwno8/Q
         wsS83h3AnJ30S76IzQHJe2Tgdz5WYfyPXjBQUqTlCRHeY5W2AiGrz5QGhnN/k7ZG9aOp
         vZ/Ttmf2DV5mTIH6fbJhX3+LA+MDEz8jnHSr5O38Eo/XUJyh8k+T9IrXKfsQT+nDpNjp
         XHsQF/MLObAznWijZEEdwPPS0NGqZbJuJROB10zBe/+qip6OA7IT21RekwDbRCniD9iL
         vwJLor5UJugW7C8XNa3HiJ85O8KVuP5p9rAiJUgvqg957EjPlFmeT5hSAYlfZ9AmT8Il
         WuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531066; x=1755135866;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y9dw5aKL3fdIEzWNyCmsONRucRn9UMVk2LBQjL3Huq8=;
        b=Wp0aut+VgkAQClanOKKTl/wt6WNG0beLZudTAME4i2YiKLxLpvEIdWSUIZlR37CC8Q
         9m9W1OnVllrvIwJy7RHZfL9/x4flT1IMiGxNWC4fr72lR6UavGgRgPEQAVFexAyEGSSJ
         YJyDqxFQ9nAfb43cz2Sa02GBmXDAOmuFEehQpWCnflQpWKM+eZCsaJF+IRJlbqXvSI+g
         P7MjApQ5gN8dbRULo1HFR/EoJ69e/2cb+ouip6cJrWVj0VyjgfR+Ped20V+G/941aeCO
         OW3godSG1s9GA+gVsmL5YKDsMG95WkVVtaodT68LyJoTaVqEPSntQrFtP6+YQTAbHwga
         rWCA==
X-Forwarded-Encrypted: i=1; AJvYcCUnBt1yLxOj8D4sm6pRUEcNEYmX4i6Vfhh7dqVAm8NzYLDiGrK1g67z4reE054Q6lem0A+ykftSKV85ITNhIKYz964sh5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyevm1vg2bib08Afmn0hAzv3LIH3YOaO28i2Ag8tikY6F/pmX8V
	ndFmFKusnwbofCkV0BdqSxcSNDJgbnwuCQlN7NhoinbpvHcT15voJeTY4SKEho1DVw==
X-Gm-Gg: ASbGncsMNmJ3TL6yQw2qn4qV8puBXGgZtRsEFa7ii9d9zyKagDj7w6f1b0a3s85Y/ds
	MIYZghIln4JlzSEgMhoaANVWC2aDyUMJ/Qhx/W5mgB2GChDLyu16qJZiBzWcrtzQARCRAxcgsqp
	Fr74EfuHmGQEmxL6Eh2znpriSz4N8mlQu5XYrlZ22ZKBCPorxApSXCpnVukubcitoeG4X33FAN7
	lOKR4SgmpN5UdRL1EAqCWYdLuZQtN0dQu85l6wuA5qfgE3DfN0i+qdo4DW1vMqBwXW+U/tMPkmX
	pDoC3aBs2yemljG4ctz6PL5yuKIMpMSqbB1hBlbMLF7Owy8cxhUHJ9iXxOcSZv8PgzrWcFHZW2+
	eVnwcSyT3v2MtwcLVFFKbKd5fScqsy/ZH/YsIjApjYEq7w8VrYAAJzAgM0wR3hzI4+2EcpsVtW4
	bK1w==
X-Google-Smtp-Source: AGHT+IFQqik3VoMmOjFgbgtVaSo3JrVORZjIHKYevZqqyzR5Qtzz+l4dS+IoKGuxupght4GYwl3SoA==
X-Received: by 2002:a05:620a:4055:b0:7e3:4678:aae with SMTP id af79cd13be357-7e814e4c2a5mr787904685a.41.1754531064023;
        Wed, 06 Aug 2025 18:44:24 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e67f7045a9sm890330285a.44.2025.08.06.18.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:44:23 -0700 (PDT)
Date: Wed, 06 Aug 2025 21:44:22 -0400
Message-ID: <8d6e0d9d4bb99481d01500a7211e5119@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250806_1659/pstg-lib:20250806_1657/pstg-pwork:20250806_1659
From: Paul Moore <paul@paul-moore.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2] lsm,selinux: Add LSM blob support for BPF objects
References: <20250722212139.1666060-1-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250722212139.1666060-1-bboscaccy@linux.microsoft.com>

On Jul 22, 2025 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> This patch introduces LSM blob support for BPF maps, programs, and
> tokens to enable LSM stacking and multiplexing of LSM modules that
> govern BPF objects. Additionally, the existing BPF hooks used by
> SELinux have been updated to utilize the new blob infrastructure,
> removing the assumption of exclusive ownership of the security
> pointer.
> 
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
> v2:
> - Use lsm_blob_alloc
> - Remove unneded null check
> - ifdef guard bpf alloc helpers
> ---
>  include/linux/lsm_hooks.h         |  3 ++
>  security/security.c               | 86 +++++++++++++++++++++++++++++--
>  security/selinux/hooks.c          | 56 ++++----------------
>  security/selinux/include/objsec.h | 17 ++++++
>  4 files changed, 113 insertions(+), 49 deletions(-)

This looks good to me, one nit/question below ...

> @@ -5684,7 +5731,16 @@ int security_bpf_prog(struct bpf_prog *prog)
>  int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
>  			    struct bpf_token *token, bool kernel)
>  {
> -	return call_int_hook(bpf_map_create, map, attr, token, kernel);
> +	int rc = 0;

I understand the motivation behind initializing @rc to zero, but to be
honest it is redundant and will surely result in a follow on patch from
someone to remove the initialization.

Do you have any objection to me removing the initialization during the
merge?  This would obviously apply to the other two as well.

> +	rc = lsm_bpf_map_alloc(map);
> +	if (unlikely(rc))
> +		return rc;
> +
> +	rc = call_int_hook(bpf_map_create, map, attr, token, kernel);
> +	if (unlikely(rc))
> +		security_bpf_map_free(map);
> +	return rc;
>  }

--
paul-moore.com
