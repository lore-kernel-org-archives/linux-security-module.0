Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B9820E6
	for <linux-security-module@vger.kernel.org>; Wed, 23 Oct 2024 00:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729642034; cv=none; b=YDqqpIcWMPjzFLclucW/IA749xLAG9tdFHDwSxRX1aKws+Pi+jcelAzen57FnHqGCNwsTFZgeJLIyEBDoS2swo3QRBDLpkZTLumvioCJqNC2rY6jTAxhmnPXQ1KZP4e5R04cqGQ4gX0HjTRY2loMP7Ha0exvYs6XUPYGo4tRKno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729642034; c=relaxed/simple;
	bh=jnkmrhzcYEBP1z5umBcm+wct455Zpt09cYoU6UgmM44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CoPTaAhZzToxkIBiaGr5rT3KEddTc+uMbzHo+Yez0AKNuPPV7Mqp6MT72LU25uZwVNN6oUpuR7NQAgRAH3vkU3O2MqHBD/uxwIUM1BKkdUd/W+wniJ2QZsfAZeXBNKMru2U0nq7daSEV6pFri8xNwHf84GaTIMxI6tnCyY57SDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eRUJwDjH; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eRUJwDjH"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e291f1d659aso5751451276.3
        for <linux-security-module@vger.kernel.org>; Tue, 22 Oct 2024 17:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729642032; x=1730246832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQ1cEM3+cfdDVolwI+TVxmBRgBuH+HcUtwUKGDw1jOg=;
        b=eRUJwDjHS+L1w2jAhHi2l3HJk9EkcEPSCmNPnOH5vPZ5UcUqCXPvrCoibUBIaixzKA
         Cjz7XVOAsiReOXyh0GKicCeDjTAGyuzZ00syFzef9ZZqlhFRb2xKoQXdZ/2jv3HUM7V/
         Gzy1vV3mTBGZLvAncXl1yr8OF1NV4mIOEO71qMzLI2JwvT1qdnhjiLRxTIsjPkJJUBjP
         IY2gF18i7wFB2A8BJ8PACuthgYRQMjfwNqpcp5it5iNv5nfIJ6XUFoOrBUbFjGXdNQ0c
         SmKoWl7LeeLg57q9UrZhlXLWSsRyOsDbmmnKuD9+LaBSnERvfIK3EADUvVmdo+K43NqN
         QD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729642032; x=1730246832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQ1cEM3+cfdDVolwI+TVxmBRgBuH+HcUtwUKGDw1jOg=;
        b=Y8+t0dcnuGJHofngslSa9Fns/a0HDIJNN430kM0wZwQ+i4GFpIKMU5LowRpmbh1hRt
         jXRB1TnT25A4K4bL32MABvgNyHg89+u9lgNjb/KOUSODSY2OiHKsEt7J3vS4CJaH7NCA
         lMfpKOni/SJd8mOn32J7qJbt6RW9DA3OOE/GErnJfjQbC8NvMDPNdyyrNTGbZ3cMBXZO
         BZCW8gNAC28De1XR2F6AUjcUH32yqWgSEgBGjeERR82YSxzt81//71CONR/KL5eoRtjv
         jWS9X5VWTS6raFpvb95wEjaoebCoQrX+Qb/JnPeir3oQ8kPrbIbRSNqGplWAdu0HttEA
         QVkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXthVOgyqAW1Y+E5F8E/hAW7cVcBiFxfzMqTAcNX783lmALq8hYRbOj/SxEs3ZZ6g6T4R9GhNhLRu3ilajWqVyzXgW7nYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcql5xWkheEzeJXLrabRAlun678ckYXE8K2l66wR95aEmHfLOY
	KgcEFRaH9vtDXLATNqIOWBJbpNU+G0SHIyubfYUfKDSlSAQk6R72WoNWVbiRSjkXrL7LNIJ+dFZ
	wicVe5OJkxJwwRkdaU0l054nCpQxBl7HRCzIkdrPd5jEWAspVMA==
X-Google-Smtp-Source: AGHT+IGRQVLuzK/6CI72ZCGfa+itwlB7gy9YsYEKhzbjk3Wk8pfQGvbN/bdOxVk2v0pzUnLnPXZpycf7NH1xudzUmus=
X-Received: by 2002:a05:690c:6c8b:b0:6d4:4a0c:fcf0 with SMTP id
 00721157ae682-6e7f0e30a3fmr9811487b3.20.1729642031640; Tue, 22 Oct 2024
 17:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022161009.982584-1-mic@digikod.net> <20241022161009.982584-2-mic@digikod.net>
In-Reply-To: <20241022161009.982584-2-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 22 Oct 2024 20:07:00 -0400
Message-ID: <CAHC9VhShPEpM4_fPoTSqStMnMB0-n1m6scS5b0Syj5V4RvrFOA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/14] lsm: Only build lsm_audit.c if CONFIG_AUDIT
 is set
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Eric Paris <eparis@redhat.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 12:10=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
>
> When CONFIG_AUDIT is set, its CONFIG_NET dependency is also set, and the
> dev_get_by_index and init_net symbols (used by dump_common_audit_data)
> are found by the linker.  dump_common_audit_data() should then failed to
> build when CONFIG_NET is not set. However, because the compiler is
> smart, it knows that audit_log_start() always return NULL when
> !CONFIG_AUDIT, and it doesn't build the body of common_lsm_audit().  As
> a side effect, dump_common_audit_data() is not built and the linker
> doesn't error out because of missing symbols.
>
> Let's only build lsm_audit.o when CONFIG_AUDIT is set.
>
> ipv4_skb_to_auditdata() and ipv6_skb_to_auditdata() are only used by
> Smack if CONFIG_AUDIT is set, so they don't need fake implementations.
>
> Because common_lsm_audit() is used in multiple places without
> CONFIG_AUDIT checks, add a fake implementation.
>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241022161009.982584-2-mic@digikod.net
> ---
>  include/linux/lsm_audit.h | 14 ++++++++++++++
>  security/Makefile         |  2 +-
>  2 files changed, 15 insertions(+), 1 deletion(-)

I think this fix is the right thing to do regardless of the rest of
the patchset so I've merged it into lsm/dev, if anyone objects please
speak up.

Thanks!

--=20
paul-moore.com
