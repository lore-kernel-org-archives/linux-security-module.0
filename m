Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8CC3CF4B
	for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2024 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515932; cv=none; b=tdpcEgnlmbFZI/1RnhdrYvisKb4HR2WNXcImWVmzjKhEXtIATxOFa44NUV5p1LL77v0W/93dznYKd3QaieKeRe4UdxsadPd4sfrfidzdEkrEd4pLcJ0U+tbnr2JcIZ5cbUqMRWrMtw004RC3dMux6996kbu+AQzhbS8Al1QHbSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515932; c=relaxed/simple;
	bh=1dkgyhgXb2hRIuFKD/Is0ExPnEEbM/gjiWzIuvGxr7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNsutPE5WK4ViBcSSYdbunG+Qv7KJEep42yHU9DuchThCGRXtv9rLlj7Mv07jHFFXgBdPTWi2b4C8EjsvCb1htKBqDhMNMmy/tTROQZsTOidOkWzhxecyZh1T7794Cr6i/6w3zlV0gtG+aotl/8vBRRdvph56DULf4tqPprVb50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WdvpEfFq; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WdvpEfFq"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so1949582276.1
        for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2024 08:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710515930; x=1711120730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhgU2LAsHaTMWktvq7zLR53iJUeP+TxmjW585Viy54I=;
        b=WdvpEfFqhHrElHsRDMt2kGIRWEbj7bW4V34oFlTCHSWH6ghvUxswpOhmUw+QrOCkDX
         VagYdL4GD7E0Nl7/OMaZG+9lJVlC9gcxx3JKGDUHfmKpHkb+fIJEC3R4TjzWo6lJgvx7
         vx9fV3wiaZC91CRX+qZSBFZ3tKqwW+8B5TVhjuR7vJhS9cBXZbesDsM3lFfiO8CqtCKZ
         Hks5nqFkWeZV4Lm6Q+Kn1KnyQziCxE5m1xWM9CrgnCCy4y6xpT2MbMYrgg35CerEZbQv
         soI/mh/J9OMtXnhorZXOam4UMtsKHSWIDCT63t+mNpoiKPmFajTvhBXAnVkMNsL51MHv
         pdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710515930; x=1711120730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhgU2LAsHaTMWktvq7zLR53iJUeP+TxmjW585Viy54I=;
        b=OVQxoLA7URSZ/gXKznT5MCSmp3B+FskJZ8mfyABxnkfsWLyLIWuQFDXg+k4aSd0zup
         ZbpQdIgdvJkwo4GnWFcLbHGmlK+CkvqeaOnfshj4Esp6fCRIXN7aPFCiIJAInTqskKx+
         fkNZHtKjeNV0UoJ9Lmw/M4eeoS5zrLDsWUVpEcwgpOeIbA3LRymYIbwGj8+LhbqC2mo4
         FzX0cxbgeRk52p8LWjBTsQs8OMNEawXfAggnsSrhZf0fOTzSgTPLgo48w7+xCk3N7xbM
         wS8gjLkZ4l9RCux+pR3wnalGw0oo4/vigovJU+NZVNWSlWUaVniGEuXf30ww7Iy+tchB
         npdQ==
X-Gm-Message-State: AOJu0Yz1TcXi4hhWp6zLId5Coij3/I9zTTvDV3+UwaJaeKM1Uaoa/p8O
	R5bLX0bB+iR7RoW4BnNunfjAKEjquhisfvUAnTvMjd8kXv9zrVlMXX3cJpowXjlosPruEXEeBrt
	+ZJ6A4LWLuvMsploKzvssRAiPu51Ls0It2pK9Dsg5NvIT7Dg=
X-Google-Smtp-Source: AGHT+IFR5YbyuMlFhOYnG6YUj/TkPG7HxyxY29c/KbQYcQOt4mGCh2R+jCXtV4mNJeutE64BMkOij2rrHVfkGleTaWI=
X-Received: by 2002:a05:6902:81:b0:dd0:412f:e01f with SMTP id
 h1-20020a056902008100b00dd0412fe01fmr4831352ybs.43.1710515929660; Fri, 15 Mar
 2024 08:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314022202.599471-2-paul@paul-moore.com> <20240315150208.GA307433@mail.hallyn.com>
In-Reply-To: <20240315150208.GA307433@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 15 Mar 2024 11:18:38 -0400
Message-ID: <CAHC9VhRWbiPSrLKaykFJ80p-orvxhifxMvN+emygF6Q2y=hf_A@mail.gmail.com>
Subject: Re: [PATCH] lsm: handle the NULL buffer case in lsm_fill_user_ctx()
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 11:02=E2=80=AFAM Serge E. Hallyn <serge@hallyn.com>=
 wrote:
> On Wed, Mar 13, 2024 at 10:22:03PM -0400, Paul Moore wrote:
> > Passing a NULL buffer into the lsm_get_self_attr() syscall is a valid
> > way to quickly determine the minimum size of the buffer needed to for
> > the syscall to return all of the LSM attributes to the caller.
> > Unfortunately we/I broke that behavior in commit d7cf3412a9f6
> > ("lsm: consolidate buffer size handling into lsm_fill_user_ctx()")
> > such that it returned an error to the caller; this patch restores the
> > original desired behavior of using the NULL buffer as a quick way to
> > correctly size the attribute buffer.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: d7cf3412a9f6 ("lsm: consolidate buffer size handling into lsm_fi=
ll_user_ctx()")
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/security.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/security.c b/security/security.c
> > index 5b2e0a15377d..7e118858b545 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -780,7 +780,9 @@ static int lsm_superblock_alloc(struct super_block =
*sb)
> >   * @id: LSM id
> >   * @flags: LSM defined flags
> >   *
> > - * Fill all of the fields in a userspace lsm_ctx structure.
> > + * Fill all of the fields in a userspace lsm_ctx structure.  If @uctx =
is NULL
> > + * simply calculate the required size to output via @utc_len and retur=
n
> > + * success.
> >   *
> >   * Returns 0 on success, -E2BIG if userspace buffer is not large enoug=
h,
> >   * -EFAULT on a copyout error, -ENOMEM if memory can't be allocated.
> > @@ -799,6 +801,10 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx,=
 u32 *uctx_len,
> >               goto out;
> >       }
> >
> > +     /* no buffer - return success/0 and set @uctx_len to the req size=
 */
> > +     if (!uctx)
> > +             goto out;
>
> If the user just passes in *uctx_len=3D0, then they will get -E2BIG
> but still will get the length in *uctx_len.

Right, which is the desired behavior, this patch allows userspace to
not have to worry about supplying a buffer if they just want to check
the required size, regardless of the value passed in @uctx_len.

> To use it this new way, they have to first set *uctx_len to a
> value larger than nctx_len could possibly be, else they'll...
> still get -E2BIG.

True.

> So I'm not sure this patch has value.

Oh, but it resolves a kselftest failure in a released kernel, that's
worth a *lot* in my mind.

--
paul-moore.com
