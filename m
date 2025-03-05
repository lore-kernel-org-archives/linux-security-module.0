Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0526282EE
	for <linux-security-module@vger.kernel.org>; Wed,  5 Mar 2025 00:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741135635; cv=none; b=XpiK4Cd//g60PgcRpgNsfW/zQzINQqu7PS8dMFhVLP2QcDrp5alkJ1hl3RxMYaKPcjv5bAlAPVPxKn2EjZNV+gmlFeGTKhKYKvZzWZRgfmOI9QFnRNDtzvRW1fShHKUs61RGBYkhBPw0ZcZf32sPwqENIImf72odlf95e4s3smI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741135635; c=relaxed/simple;
	bh=KrZPhWHQh1C/FXJrXVtu/3D6Cl4fRehYGt6yzWML13w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBuMwFBbnPABKxioubzikf+rOlmZhUOEdP9kMcSs/o/KrUebxI3Ikn0IJ/fLdQj07XzRm8hYihJJlDjnPAfqjXU6AAsJgCDOUIIi1UCVbE0517vLRrftA5Nqnnz96il61yJKIVoOCriXDBZcxPOJ/Jfct4YmK2gbFVwpp7GPewI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HXB4NY93; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HXB4NY93"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e549be93d5eso6752518276.1
        for <linux-security-module@vger.kernel.org>; Tue, 04 Mar 2025 16:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741135632; x=1741740432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0JWW3fTWBnh7K7+SqgqWW2WjvJa1HaPLK+y4schvYw=;
        b=HXB4NY93Mv1adQF0nefzgX5in0YyUQcM/o+PkBcaO7bqYOxJV/KVJFxA+mvnP2H7bX
         VbKy8zMjropMV2M/CPD5wR5DrGxGM/Wu3ZIleI2llwqDr1hz+mTSTmwAqEZgsfUGt6vN
         uHb8/+P6o6TyY+jexQQgFVBWgfxCuU59AwEo6C5f5obqM/StUqEYlSsrxVIwhm5pQvXJ
         xFbpa7Wb2BDwK/JrutICXsHbEnbUKUPWOhUoCg78SuLFB1GN02/Q+4wlN3MUiAEOs13D
         ioHwP8xsFgI7jqstQXGv66HiJSczlVm8cOAXeP8fKGqAmLXcgYWuC5wE2q1wn73fTD5K
         b/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741135632; x=1741740432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0JWW3fTWBnh7K7+SqgqWW2WjvJa1HaPLK+y4schvYw=;
        b=rZgmmBgRXr36BijG16wm9YlBzXzk6t6mg7B16JUhk6ctPzreLC8WBVRW8JKHls3NZO
         A/mM6FfxZFRCbKzv+PY0/88NCwLnIGF1wtLWo+RU1Jhv/5AMNgfUxn7VitN/q31MtVxX
         qIGgRdiRa1Be6QxvACQEob1itV3fb4AsY5pUl0N+qP88ZyGgXQ5KSChfdX/ugExErC41
         f6RLGeKU4Mw9ccQhSasbOalChRqs7CIMLKc2Y2iWarzySniUoRAJePVeLzJVsKdqYcfn
         E+ziQFWPR1xQKAy1se2r5PQ0+PlqmBd7VkObb4ONQUO0iV1EHYTbeY9ojgA+HbBNgS6h
         pwbw==
X-Forwarded-Encrypted: i=1; AJvYcCWmkRJfpfd4QxupkKLdQaEXAzB0XCO0rxrt8InpdDP6Ir3n9fXICGwfb4qgzvj0YfqnFNyLVZSF7wb6SGZDLP0AyV95rAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZY1LXY24zI+for6vfotzSdWCwez/J1tefCvdDO/uBh3Tv9opP
	Ofuaec19LWRi7Ud0bDl1/XZAvTSATWm6S+zki3IKb0F28Z7BvMXtmGp7KgrEqsaVDY68Hlj2JXA
	r318MBbahnT6+o0JJfk1l81tfX6de5emY8aVL
X-Gm-Gg: ASbGnct04g/YMWy5bnvfk/YYTt/fqh5LKLeGJ7nzt2OAWLJZzf2Nv0pmtYfYQjp4PcE
	rTwXJ/al35sykjSGGgjVsTsz2C7Fg2kwL/6QSeuo0UR6dsV1Hunpy7qmwozd0xGGV+chnr/8lE6
	agO33ZWdUU7DnakKA18uoz8AGIXA==
X-Google-Smtp-Source: AGHT+IFsin2dnAoII47KpfiYxuCKNvaOHTWGt38UM0/AeWRCKVn6GpsI/Mpf2AghCcvXGb4Vk3GRSbaU2mFwSKGkBmg=
X-Received: by 2002:a05:6902:124c:b0:e5b:248a:bf3a with SMTP id
 3f1490d57ef6-e611e305897mr1727393276.30.1741135629678; Tue, 04 Mar 2025
 16:47:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304203123.3935371-1-bboscaccy@linux.microsoft.com> <20250304203123.3935371-2-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250304203123.3935371-2-bboscaccy@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Mar 2025 19:46:58 -0500
X-Gm-Features: AQ5f1JpLlLzJjcKMPOWcUJShk8j8ocFRlSTUH6_R8CutO6bLPL3P9GSwEAw9ZLk
Message-ID: <CAHC9VhQ+R1nxsp6aPDqH9trjcPadb6yPsj+fEv47mYQqZ50yeQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/2] security: Propagate caller information in
 bpf hooks
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 3:31=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> Certain bpf syscall subcommands are available for usage from both
> userspace and the kernel. LSM modules or eBPF gatekeeper programs may
> need to take a different course of action depending on whether or not
> a BPF syscall originated from the kernel or userspace.
>
> Additionally, some of the bpf_attr struct fields contain pointers to
> arbitrary memory. Currently the functionality to determine whether or
> not a pointer refers to kernel memory or userspace memory is exposed
> to the bpf verifier, but that information is missing from various LSM
> hooks.
>
> Here we augment the LSM hooks to provide this data, by simply passing
> a boolean flag indicating whether or not the call originated in the
> kernel, in any hook that contains a bpf_attr struct that corresponds
> to a subcommand that may be called from the kernel.
>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> Acked-by: Song Liu <song@kernel.org>
> ---
>  include/linux/lsm_hook_defs.h |  6 +++---
>  include/linux/security.h      | 12 ++++++------
>  kernel/bpf/syscall.c          | 10 +++++-----
>  security/security.c           | 15 +++++++++------
>  security/selinux/hooks.c      |  6 +++---
>  5 files changed, 26 insertions(+), 23 deletions(-)

...

> diff --git a/security/security.c b/security/security.c
> index 143561ebc3e89..38c977091a7fd 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5627,6 +5627,7 @@ int security_audit_rule_match(struct lsm_prop *prop=
, u32 field, u32 op,
>   * @cmd: command
>   * @attr: bpf attribute
>   * @size: size
> + * @is_kernel: whether or not call originated from kernel

This is really nitpicky so please only make this change if you are
respinning the patchset for another reason (it looks like you may need
to do so for other reasons, so I mentioning it), but please change
"is_kernel" to just "kernel" in all the LSM hooks you're updating so
it is more consistent with the other LSM hook boolean parameter flags.

Regardless of the above, this looks good to me.  My ACK is below in
case the BPF folks want to merge this, but I'm also happy to take this
via the LSM tree once the selftest changes are resolved and ACK'd.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
