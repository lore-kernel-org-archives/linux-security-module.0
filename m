Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D0C42A9D
	for <linux-security-module@vger.kernel.org>; Wed, 27 Nov 2024 03:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732678733; cv=none; b=EJcDy4ztuESL7A4M0WqpKAi4ADDwKGEex2dn2JnhffHNQJMRUAYCAB3//oBmMlMwaw+o7yDOdGCRull7MFchz1ZayM2RqUciJt3UPsFO3CTWSP9LZ7zURU5QNXlC6NvzXxfemHP0IKNjzj7VHEV4nRMlbZOeIffDnUoiPtPadoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732678733; c=relaxed/simple;
	bh=fS8NQOHGJ0ogLcUGas01yt4cIbC36qC1c0kAb7nEjj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdDpNDp3PVPOyfG0WiXjkQYY+wXCoRP251BBgTH2ZvmAwetegujxyCDv/AsNseEm7E/zOs8NNxvtWPEp/lLJ3iJT/JBfxhGDoOlz0b3RXI3i/Ky/wDa9JB/YdzKh/W7mJiKYRl6QNCIBAlE9JS4AAHyt4SgugMvsMR5ovoetW2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cB/dW1Ka; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cB/dW1Ka"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e3908dad395so3672619276.2
        for <linux-security-module@vger.kernel.org>; Tue, 26 Nov 2024 19:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1732678730; x=1733283530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bn2mqiTffvoc/D8+m6E2ss000lrDjRnXwpfuiiix1M4=;
        b=cB/dW1Ka9C9lJ5J9Y8Acsl1+4xWXQWUfM1JTXDvq1vGIkVq46JYtzzWFpWXyG6cBMJ
         SXf678eDjuYbe8GpiNS+Rkxh8s28hQVXIJciGjEH3LpXG3Cp9FmNErUgiNOLvT5vEgei
         Vkj1O680lacSMDB7iq/DsG9vGrpRmX63BNKm8LzF5MBxI5agf0DUrDWE1N/JOKFqcUBw
         IP/LtYHK2sT2xNyvofuP+k7jnDHfaRn5X4HSbQ8FLlyV7KxsqvUnf8J96JUQlfrf16Yr
         I1d5LJlk9kpklPjsjtAzCyfsOPS2XMD8P91q3eEQ434o1FdmK+tRqFNBNdatCuUDHjTM
         vaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732678730; x=1733283530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bn2mqiTffvoc/D8+m6E2ss000lrDjRnXwpfuiiix1M4=;
        b=DGZGwCj/PRoAmfBHb68wcjEI3D4/dmJSLMefmqQJPhXV0F/Nqw3mIjj9FY/13Hr7J0
         H5/htBntBx52Pa0/C09gd7wLXd8zwPuAP9Zmn23aG+Zh1F2w1UsR2HceHwb/g9+IPPC5
         sMDWr0j5t59n/zRw69966GKhmVHkYMl563jZiJSapV3alD4PhPJnSBzewslZw+uVKQwW
         X4iDrIym2WYA3gltYcW3e9teyJFkkwClJsq9wraY9eeA4Hks0hQiRiCdqKa+FRmQkTzD
         GZ/0YTVdv45lsfQIg0E3BcH/LocZjJF7PO576krBO03Fz3bT56k1weCcS1ycjG5xvw37
         QN7w==
X-Forwarded-Encrypted: i=1; AJvYcCXfP3C4N2LgYMePZhpAPceOYSQ4G0gr8hvuMBsWcFCHv/MRAO9O2/vy/Ldb/bteswfYAZoYefXOsl3pz8T3xuDb5BTTUTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaGjSz9bZwvqPSC2ZBzbYKKyqxFsd6a8mt4VISyeo7hEA6mymR
	07KGVoSAr1HTrwMWH3CgBFHdaHXzxy6a8y4QO+Cr129yd2aLtp+cGxJ9SwqGIORlf9uF0Ks6jwl
	V0i0lekrAiKoDquLYwHxIEFZoAT6DNbgKQp83
X-Gm-Gg: ASbGnctqKIkJl9+KfIsbCsHcVwDE4/Jk3dTrLkwTEjhv9/ccHKyH/oK44STLKEI5hxp
	W6XnLcf0Xh4jp1bstdnUU8V3H72Aqig==
X-Google-Smtp-Source: AGHT+IGlxuYZ/LrsjfAgvwWFFpg3oOOBV7K+iujlFrnCdH+8elzoi/D8ZMqcY8qv4XgdvqDdz60wqZKADimRrgR9ovc=
X-Received: by 2002:a05:6902:110b:b0:e30:da65:723c with SMTP id
 3f1490d57ef6-e395b95633amr1331814276.45.1732678730497; Tue, 26 Nov 2024
 19:38:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112182810.24761-1-av2082000@gmail.com> <52cc8e51-9e85-465b-8ee3-63a7a0a42951@linuxfoundation.org>
In-Reply-To: <52cc8e51-9e85-465b-8ee3-63a7a0a42951@linuxfoundation.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 Nov 2024 22:38:39 -0500
Message-ID: <CAHC9VhTJERn54qNDDOwNrJ09VWrmq5Qn+sPQV__LyeEUgSi5pw@mail.gmail.com>
Subject: Re: [PATCH] selftests: lsm: Refactor `flags_overset_lsm_set_self_attr`
 test
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Amit Vadhavana <av2082000@gmail.com>, jmorris@namei.org, serge@hallyn.com, 
	casey@schaufler-ca.com, shuah@kernel.org, ricardo@marliere.net, 
	linux-kernel-mentees@lists.linux.dev, linux-security-module@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 11:25=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.=
org> wrote:
> On 11/12/24 11:28, Amit Vadhavana wrote:
> > - Remove unnecessary `tctx` variable, use `ctx` directly.
> > - Simplified code with no functional changes.
> >
>
> I would rephrase the short to simply say Remove unused variable,
> as refactor implies more extensive changes than what this patch
> is actually doing.
>
> Please write complete sentences instead of bullet points in the
> change log.
>
> How did you find this problem? Do include the details on how
> in the change log.
>
> > Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
> > ---
> >   tools/testing/selftests/lsm/lsm_set_self_attr_test.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c b/too=
ls/testing/selftests/lsm/lsm_set_self_attr_test.c
> > index 66dec47e3ca3..732e89fe99c0 100644
> > --- a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
> > +++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
> > @@ -56,16 +56,15 @@ TEST(flags_zero_lsm_set_self_attr)
> >   TEST(flags_overset_lsm_set_self_attr)
> >   {
> >       const long page_size =3D sysconf(_SC_PAGESIZE);
> > -     char *ctx =3D calloc(page_size, 1);
> > +     struct lsm_ctx *ctx =3D calloc(page_size, 1);
>
> Why not name this tctx and avoid changes to the ASSERT_EQs
> below?
>
> >       __u32 size =3D page_size;
> > -     struct lsm_ctx *tctx =3D (struct lsm_ctx *)ctx;
> >
> >       ASSERT_NE(NULL, ctx);
> >       if (attr_lsm_count()) {
> > -             ASSERT_LE(1, lsm_get_self_attr(LSM_ATTR_CURRENT, tctx, &s=
ize,
> > +             ASSERT_LE(1, lsm_get_self_attr(LSM_ATTR_CURRENT, ctx, &si=
ze,
> >                                              0));
> >       }
> > -     ASSERT_EQ(-1, lsm_set_self_attr(LSM_ATTR_CURRENT | LSM_ATTR_PREV,=
 tctx,
> > +     ASSERT_EQ(-1, lsm_set_self_attr(LSM_ATTR_CURRENT | LSM_ATTR_PREV,=
 ctx,
> >                                       size, 0));
> >
> >       free(ctx);
>
> You have to change this tctx for sure.
>
> With these changes:
>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>
> Paul, James,
>
> Please do let me know if you would me to take this through
> kselftest tree.

Amit has already posted a v2 with the requested changes, but I wanted
to get back to you on this even if this patch is outdated ... Shuah,
what is your preference for things like this?  My general policy is
that patches only affecting one subsystem tree should be taken by the
associated subsystem to minimize merge headaches and other ugliness,
however, the kselftest is an interesting subsystem in that it relies
so heavily on others that I'm not sure my policy makes as much sense
here :)

--=20
paul-moore.com
