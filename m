Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE2B14AD3F
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738350182; cv=none; b=uZ+8SWIthTvjE20bwdglVqrjG7g/SIn344825PcmVG4q5/qvhWOm/mK/HX2y5gAiOT7Msn9XBGQO7EqXYtzQxNEWBncv4OiIsFxQiFYfrpUJGufXzndxc8b9YxyHN9JoPaDFgPbGewpGxxAacOrd1RhOgeku4tAA2xpV39uiUO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738350182; c=relaxed/simple;
	bh=KYUdDDp7B+41NEBevjLT8AokSqULN4fTewr/DdTNftA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGnzAgvnx0WjiT/ohZSSxE8K8UaAzOoQAbtCUXZE3yEwYeqo91rj2ys+gMjtZ8Qr6EAvVRjUEMHSfEesGtvmepsYf9csZLDdx0zas5vXT/qorHitxtI3xaA9dDO+WDF7OWaAXtpukgPEEYejDs5xGtgzXntYL0q/vVvY9KehhlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Jzx2aTg1; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Jzx2aTg1"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ef6ffcc2dcso9465157b3.1
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 11:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738350180; x=1738954980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoIGWtRqEVyajH3f896IzB04/manMNgSXSEcwi7G77E=;
        b=Jzx2aTg1SJ8ueGrtDQ1lMtdPRlv+v8c5XHHWziD7rkIuCTXZeH6n1QNFqpAuRBBZ70
         VYZipf197fywlnoAEAhKv6FVzlP94OiKkqA1Au7TMy8logxgu8tmVrwrWPrvPNsl0YVy
         Y2sOCzY4dqYkZ9kc49sme5BnywtXMPtRN7kcZaf1LYSdcYIVJN2G8h7NlJwvWHFGa+78
         Y7Xklfj46gEU7P629aThuuARsQbud4IXG4XBz15tKQ9T8zGMhU4/CRV9IXQJ4zKNG6cP
         IHQvSGFY8rANL+/6LkBH2jX+DSEOGZJVoyzD2IFdLeYDcFvLhG+hh50b7sJATsgiGUpY
         htZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738350180; x=1738954980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VoIGWtRqEVyajH3f896IzB04/manMNgSXSEcwi7G77E=;
        b=Xp97GgbGcA6k2e7gtjr71cmXfjYgOq2idWrnTVcAP7oTdGWNJ/JwlaNEWtkHO6T+K+
         lB15UC/D5H0zhrbGDTKQn52Vp2qZK3iJec4mZgJHXIthrgWKIMP+flJ+ZjOaxnx0Liia
         wW+hE5IOy2kvDzavf2xn+8/8vwTV5h2i63PzRTwFBBw2Tx0olf3rcmFYnG0QmkVLvL2C
         RLk5HFX+ViKKVMCgyI/JoGycZkj3dZcmD+2rF6ulcJNaI2Ns6L5x0njf+w+t0/K/HusP
         e2V9xsljm6DniXr0Y7mAJedtqOCgw0WowMU4qRyw+pmjDO4+xLD3eITlxKP7N4gJPM82
         X4kA==
X-Forwarded-Encrypted: i=1; AJvYcCXWtzx6d3LczF5GRpwko6jlqU/34Ktrij2hbJ2dRkLlV/L/d15KcM/9vrdYfo6R0LwaoLWlsPdOW2GQ/9dmrz98fy+eamQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHAypO1Jwt5976KFrILMtLnAkgF/nJSgEuMuYAcCaCyhvpqHAh
	CYbJO7Zy1Y9ChGkZRyBtjUu9qIzsKgqqrIKvjeZUWNhoJQOJ3uiQDeBLNNYYcnB28GnHbMLrBAH
	EtrgfbFzcXhrGHnauCN6Bg8a2zNvuIWvI6ZFg
X-Gm-Gg: ASbGncuWO5auSYwzHWaMBnVlWs3XaXOnT+KlkuI3zKPdNlqFQsrGzQfni92U3PRys7N
	eEuYiMfHS8bH2X0xeypAt2CJOHANa/CduYf8pFX9SvgPzOMRkuVqPTYBXTKG5zi5/ZV6BPsw=
X-Google-Smtp-Source: AGHT+IE7GEaXmmXiIFe8GxBwPy/s3HOncT3YGCvQL+c/XKAg8Vmw0EZTzAO1gE1HEcsIMlSZ8M2sv6qQS1XKJQ1fBIk=
X-Received: by 2002:a05:690c:630c:b0:6ee:4855:45de with SMTP id
 00721157ae682-6f8cf78bf6amr39511667b3.9.1738350179711; Fri, 31 Jan 2025
 11:02:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131163447.1140564-1-mic@digikod.net> <20250131163447.1140564-3-mic@digikod.net>
In-Reply-To: <20250131163447.1140564-3-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jan 2025 14:02:49 -0500
X-Gm-Features: AWEUYZlDZc48KHvWERwbMa-E2dllbHHqaA9ZtvhM-icKEMVlKsL0AzDCCJFAC_g
Message-ID: <CAHC9VhS=mMH9s2KUc2kSK7pW1yG8RB58hyJjW5oWsCK=i-1PdA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/3] pidfd: Extend PIDFD_GET_INFO with PIDFD_INFO_LANDLOCK_*_DOMAIN
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Charles Zaffery <czaffery@roblox.com>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Kees Cook <kees@kernel.org>, 
	Luca Boccassi <luca.boccassi@gmail.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Tyler Hicks <code@tyhicks.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 11:43=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
>
> Because Landlock enables users to create nested sandboxes (i.e.
> domains), we might need to identify the domain with all restrictions
> (latest), or the domain we created (i.e. closest domain).  Indeed,
> because any process can create its own domain, the latest domain may not
> be known by the requester.
>
> The PIDFD_INFO_LANDLOCK_LAST_DOMAIN flag enables user space to get the
> latest (i.e. most nested) Landlock domain ID related to a sandboxed
> task, if any.  The domain ID is set in the pidfd_info's
> landlock_last_domain field according to the related mask.
>
> The PIDFD_INFO_LANDLOCK_FIRST_DOMAIN flag enables user space to get the
> closest (i.e. first hierarchy relative to the pidfd's credentials)
> Landlock domain ID related to a sandboxed task, if any.  The domain ID
> is set in the pidfd_info's landlock_first_domain field according to the
> related mask.
>
> It is only allowed to get information about a Landlock domain if the
> task's domain that created the pidfd is a parent of the PID's domain.
> Following the object-capability model, the pidfd's credentials are used
> instead of the caller's credentials.  This makes this command
> idenmpotent wrt the referenced process's state.
>
> If Landlock is not supported or if access to this information is denied,
> then the IOCTL does not set the PIDFD_INFO_LANDLOCK_*_DOMAIN flag in the
> returned mask.
>
> If PIDFD_INFO_LANDLOCK_LAST_DOMAIN or PIDFD_INFO_LANDLOCK_FIRST_DOMAIN
> is specified but the provided struct pidfd_info is not large enough to
> contain the related field, then -EINVAL is returned.
>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Luca Boccassi <luca.boccassi@gmail.com>
> Cc: Praveen K Paladugu <prapal@linux.microsoft.com>
> Closes: https://github.com/landlock-lsm/linux/issues/26
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20250131163447.1140564-3-mic@digikod.net
> ---
>  fs/pidfs.c                 | 24 ++++++++++++++++++++++--
>  include/uapi/linux/pidfd.h |  4 ++++
>  2 files changed, 26 insertions(+), 2 deletions(-)

While there are exceptions, mostly for legacy things, we try very hard
to avoid having the kernel call directly into a specific LSM,
preferring to use LSM interfaces, both so that all LSMs can benefit
from the change and also so that we can avoid having a lot of very
similar, but LSM-specific, calls in various parts in the kernel.

There is an effort, albeit a slowly moving effort due to interrupts,
to add LSM support via a PIDFS_GET_SECURITY API:

https://lore.kernel.org/linux-security-module/CAHC9VhRV3KcNGRw6_c-97G6w=3DH=
KNuEQoUGrfKhsQdWywzDDnBQ@mail.gmail.com/

I don't see any reason why we couldn't support Landlock's domain info
as part of that, the lsm_ctx struct was created to support various
different LSM contexts/attributes.  You could either add multiple
lsm_ctx array entries for Landlock, one for each of the domain IDs, or
you could place all of the domain IDs in an expanded lsm_ctx.
Remember the lsm_ctx->ctx field can hold binary blobs and/or you can
expand past the end of lsm_ctx->ctx so long as lsm_ctx->{len,ctx_len}
are set accordingly.

If you want to work on the PIDFS_GET_SECURITY patch(set) as a means to
add Landlock domain ID support, I think that would be great.  Luca
provided a basic skeleton in the link above, and I expect you would
have no issue adding the missing LSM bits.

--=20
paul-moore.com
