Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CBC5464B
	for <linux-security-module@vger.kernel.org>; Fri, 20 Sep 2024 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726818860; cv=none; b=tAomzVDuegjmDbbz1hBsGPE3IPb2Oi5sb1Ceyf6q4KDy7uTZyifi30kt7IfTVppadFpXelBM03okX8Q/LUfdqlXOObQipLW4GEoXX0lHIV9JndxMlIobeRUPvDDz/EMd8Z+L9/ZLcqLmwtgMRKHN7MnZZkvEKifkNtQSULG0Pow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726818860; c=relaxed/simple;
	bh=8cP/ZUx0o0i7arwABc7hgQxZCaOFCR5RjWEmy90POE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYNFT5hY7VFnqK3qiko2WwlnsWFhpdBmc/XizoUIJYZdPvZjU+m1e752kWz19EC66LTawzj7DRWKG2ljitRnmPVH/I+drdgYmUYTkg0QLoNeMgCfruIXPF8HwlGPVDluDtzhYbbj5cBmKGw6wud/6GArK/Qvzx9I9MDFtg/bxTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7/icToK; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7/icToK"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ddcce88701so17221367b3.1
        for <linux-security-module@vger.kernel.org>; Fri, 20 Sep 2024 00:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726818858; x=1727423658; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CzmNTRggHjGYli4sS3RvOX1k75D24oG4W7IsT2FIbis=;
        b=T7/icToK3oAHLqg4NbveRixGns4KmQbF19lDmAEEhEOKZwYUO1500EomIggnNt9PoE
         wgq9BFJbGdgUkNZeGTc57xfLoWluX5+AeODJb/PXSQ4BoCJJAngSfnmuXjEcnIwfW8aL
         +auWFbf063Jyc4krF+niqEgig1qSayXwf2/Y4ykNI5nPR+GjgkrBaKMGQxWcnra3IjzX
         +M17Si+yhbelzp9G/CeKtM6M2F5lZ5AiIcC3lQcG1EndxmQdBcnGYh8AZdrqTYCxR9BK
         s6FZ+FTAFzxfYfTjsLS8wjyr+vgz4HKFtGBUsD0uUlXD0BMZbuOFrV4O2PG+JnmtEHKC
         ko5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726818858; x=1727423658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CzmNTRggHjGYli4sS3RvOX1k75D24oG4W7IsT2FIbis=;
        b=h0YDiWhrsfQ6r9axJxObvGm6P0U7qvVUjxUHCEFdw0cMt1Cr+nQ6OuQgOUacVoJvQn
         ExDgz50UiCSwTfsaZLbXWuOy7GjttTNbkMIbJ503laecU9G1HuUjt8hiTBAQXKYA+zgQ
         j+mZmfgrcNCxbdWF4rgfjklv0aV2iS0rheFGjHTbEli77AJ3waxqkuB2zFMsB12raaC0
         OyqVM4aq7IueVOpdEWzxKjhYKL1d+dSHxQsFjDyO+m5jstrVzj+y1MItI1/B4K3UH6gv
         iMein4J5eRKvYyALpkKagLgJNUZrjJKiKdsSNiXaJpvMnhGQbqkgBQr8OaGfGY8LItQQ
         9vqA==
X-Gm-Message-State: AOJu0YyrvKFJFnmAzdchz6waXynwipWia7HIMExAZyCHoT0lNEuPAtrf
	DAJnUKeRUyD8nxko7vFOT3YH4HmbBOtr1oZ8Vpt54V8SA9pT1qyn+2yQZasxXWuuuSO8Q/o6ytJ
	75kjKwBalAYWsxNmAssAnejv9fxhTzr9t
X-Google-Smtp-Source: AGHT+IHE6bcNuIahViSfA/c801HF6WABu3NS40y97srUFu57aHjyII4ZAmTJDOZ+v+vbRhX5Z7T+iXlHBXXPhuUAxgY=
X-Received: by 2002:a05:690c:f14:b0:6de:1e2:d65b with SMTP id
 00721157ae682-6dff280c8c3mr12649407b3.8.1726818857685; Fri, 20 Sep 2024
 00:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913234840.1318655-1-luca.boccassi@gmail.com>
 <20240915091119.1916049-1-luca.boccassi@gmail.com> <20240920020217.GA528455@mail.hallyn.com>
In-Reply-To: <20240920020217.GA528455@mail.hallyn.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Fri, 20 Sep 2024 09:54:06 +0200
Message-ID: <CAMw=ZnTWHkOnz5ZHg69WAfygkvpiHkSsUyHVu2fbqJ_E9inNUw@mail.gmail.com>
Subject: Re: [PATCH v2] ipe: allow secondary and platform keyrings to
 install/update policies
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, wufan@linux.microsoft.com, 
	paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Sept 2024 at 04:02, Serge E. Hallyn <serge@hallyn.com> wrote:
>
> On Sun, Sep 15, 2024 at 11:11:19AM +0200, luca.boccassi@gmail.com wrote:
> > From: Luca Boccassi <bluca@debian.org>
> >
> > The current policy management makes it impossible to use IPE
> > in a general purpose distribution. In such cases the users are not
> > building the kernel, the distribution is, and access to the private
> > key included in the trusted keyring is, for obvious reason, not
> > available.
> > This means that users have no way to enable IPE, since there will
> > be no built-in generic policy, and no access to the key to sign
> > updates validated by the trusted keyring.
> >
> > Just as we do for dm-verity, kernel modules and more, allow the
> > secondary and platform keyrings to also validate policies. This
> > allows users enrolling their own keys in UEFI db or MOK to also
> > sign policies, and enroll them. This makes it sensible to enable
> > IPE in general purpose distributions, as it becomes usable by
> > any user wishing to do so. Keys in these keyrings can already
> > load kernels and kernel modules, so there is no security
> > downgrade.
> >
> > Add a kconfig each, like dm-verity does, but default to enabled if
> > the dependencies are available.
> >
> > Signed-off-by: Luca Boccassi <bluca@debian.org>
> > ---
> > v2: add Kconfig entries following the dm-verity model
> >     update documentation
> >
> >  Documentation/admin-guide/LSM/ipe.rst |  5 ++++-
> >  security/ipe/Kconfig                  | 19 +++++++++++++++++++
> >  security/ipe/policy.c                 | 14 +++++++++++++-
> >  3 files changed, 36 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/ipe/policy.c b/security/ipe/policy.c
> > index d8e7db857a2e..bf5aa97911e1 100644
> > --- a/security/ipe/policy.c
> > +++ b/security/ipe/policy.c
> > @@ -169,9 +169,21 @@ struct ipe_policy *ipe_new_policy(const char *text, size_t textlen,
> >                       goto err;
> >               }
> >
> > -             rc = verify_pkcs7_signature(NULL, 0, new->pkcs7, pkcs7len, NULL,
> > +             rc = verify_pkcs7_signature(NULL, 0, new->pkcs7, pkcs7len,
> > +#ifdef CONFIG_IPE_POLICY_SIG_SECONDARY_KEYRING
> > +                                         VERIFY_USE_SECONDARY_KEYRING,
> > +#else
> > +                                         NULL,
> > +#endif
> >                                           VERIFYING_UNSPECIFIED_SIGNATURE,
> >                                           set_pkcs7_data, new);
> > +#ifdef CONFIG_IPE_POLICY_SIG_PLATFORM_KEYRING
> > +             if (rc == -ENOKEY)
>
> If the secondary key *is* there, but returns -EKEYREJECTED,
> do you want to fall back to trying the platform keyring, or not?

I like the idea in principle, however for ease of use personally I'd
prefer if the behaviour was the same as dm-verity, given the close
relationship - maybe we can start with this version, then I can
propose the same change in a single series for both components later,
so that we either change it in both or neither. Would that work?
