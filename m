Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D6C405FF
	for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2024 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710518454; cv=none; b=eurv2RZUNWELUXy07C/99rGNbsEPAjXuik9r8G7EMp8fsx2zGa4gakp/2803waDJTV7t0Ict4AJO50DZnPXZdAghMFqNtiDfvl1mHkC9NECJwwf0gtdEFDAWkytH6+KNpHcpxjcTLCjtC7HeYyA/rP6rPd0gUX0xU7EJJfo4x+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710518454; c=relaxed/simple;
	bh=ecPlRL97OUgOgxR7OiN3bfDXlzQ7vo6lhDVcumlwDAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PV9ZGXUcUAiKE5NrV5Tc8oYxuVNHWaVTCaY2Vl0Cc3kJjbrbzAE4pybVsch+jRXYbntq0Fhx99agNQy4/dGKVyu1uT7tvhoZkYwJpYU7De7Z3lNIWcOvJDrSeGkU183p2RdU3mS6mRv/CVrGj57DvRRmWu0c6Qn7AeF8yIgyjdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QGVOOMog; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QGVOOMog"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcbc00f6c04so2057036276.3
        for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2024 09:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710518450; x=1711123250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+cekDmiLY+n1DHCPsZTl/AJQ3vneAn6yYmSnb2YfxM=;
        b=QGVOOMogu0uE0KWkItDQLViXJUfAG+zF6iYL+dlZnxYdfwBLczGEcQpwJSCnOocd8g
         iMwzBirODozEpI2EEhsH4kT3Gsv67ZkOISeBCTlzs+UcQce/PHqFmA28pypa37fVUyAU
         jhj6Byt+ssrgnXFMkjsmN6vrw9Gun1xPksOnNLWMO4wWZyIjrLqsZvsrxbpkYN8aGjRc
         y1UZysTay7jbikhxdYhkwPmAtTSt+wJyKWy83JoGSDD8sqyADq90UYOgkXgKtsgkGDRy
         77TRJrOthp7QzDcLCRZjMv2/q8La9TNtim/wFF7gZYm/iu+vDE0n3w3QUJqvMdH/Zfa6
         Q2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710518450; x=1711123250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+cekDmiLY+n1DHCPsZTl/AJQ3vneAn6yYmSnb2YfxM=;
        b=vpSpbvzl3lLj0FCaMV7AIE4KUCbXNY7j1/J/BoaN6lCC2WSzfxavE9V4W7dXkzNin3
         /7cHkxiEvT1aYxYyiDFfk2QWISatpn50EyqK/WOfzMdy/bg0qWCRFJ+vWUXpJOmuEwgg
         mMdgir4Ci2i5WWsH0cirKwuVCIXb+PXMh6N7l9sVYcgkOdh9aIUho/vPlBXJKtpsDBab
         fhs0C8sMI9n2AVvRa/gXaDyETPacxIO4t0T30pQMcoiDocAUud7G+HAcvFs+8Jh4jjlu
         ZXbxkkuccKxBaStcPuFHODkMQZOc6h7dTEnjJjZVkL4e0Ubp8SPqkwU4K1lByuRA1zc3
         77UQ==
X-Gm-Message-State: AOJu0YxOD9cwFdFOBSvewT9U5Ec4a7auJG0bwEngcAqU+QTzpPmC716H
	gMz9nars5T/ZtmBYoq6yhp1eiQQ1tn/tb+gn8RVPCmMqBuJkt+taAM2h8jWK/Yb9zwHF6nG82KA
	YQPuB+wpTjTlGwUA6xdYltYKR5TzhO+jYjmLZ
X-Google-Smtp-Source: AGHT+IFk1aOhHz84e4nvZ8TlT8KZm6Dwj/Gso92SHq02SxqRE8q+9ehiafo0rdjVKI014DuM2uJGLm+DuEvZojisSok=
X-Received: by 2002:a05:6902:389:b0:dc7:4b43:db3f with SMTP id
 f9-20020a056902038900b00dc74b43db3fmr2451997ybs.21.1710518447862; Fri, 15 Mar
 2024 09:00:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314022202.599471-2-paul@paul-moore.com> <20240315150208.GA307433@mail.hallyn.com>
 <CAHC9VhRWbiPSrLKaykFJ80p-orvxhifxMvN+emygF6Q2y=hf_A@mail.gmail.com> <20240315155503.GA308713@mail.hallyn.com>
In-Reply-To: <20240315155503.GA308713@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 15 Mar 2024 12:00:36 -0400
Message-ID: <CAHC9VhT3OuEgViyUD+HJ7S1JfO3qDorWsLR0mYm+RFYDMht-Og@mail.gmail.com>
Subject: Re: [PATCH] lsm: handle the NULL buffer case in lsm_fill_user_ctx()
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 11:55=E2=80=AFAM Serge E. Hallyn <serge@hallyn.com>=
 wrote:
> On Fri, Mar 15, 2024 at 11:18:38AM -0400, Paul Moore wrote:
> > On Fri, Mar 15, 2024 at 11:02=E2=80=AFAM Serge E. Hallyn <serge@hallyn.=
com> wrote:
> > > On Wed, Mar 13, 2024 at 10:22:03PM -0400, Paul Moore wrote:
> > > > Passing a NULL buffer into the lsm_get_self_attr() syscall is a val=
id
> > > > way to quickly determine the minimum size of the buffer needed to f=
or
> > > > the syscall to return all of the LSM attributes to the caller.
> > > > Unfortunately we/I broke that behavior in commit d7cf3412a9f6
> > > > ("lsm: consolidate buffer size handling into lsm_fill_user_ctx()")
> > > > such that it returned an error to the caller; this patch restores t=
he
> > > > original desired behavior of using the NULL buffer as a quick way t=
o
> > > > correctly size the attribute buffer.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: d7cf3412a9f6 ("lsm: consolidate buffer size handling into ls=
m_fill_user_ctx()")
> > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > > ---
> > > >  security/security.c | 8 +++++++-
> > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/security/security.c b/security/security.c
> > > > index 5b2e0a15377d..7e118858b545 100644
> > > > --- a/security/security.c
> > > > +++ b/security/security.c
> > > > @@ -780,7 +780,9 @@ static int lsm_superblock_alloc(struct super_bl=
ock *sb)
> > > >   * @id: LSM id
> > > >   * @flags: LSM defined flags
> > > >   *
> > > > - * Fill all of the fields in a userspace lsm_ctx structure.
> > > > + * Fill all of the fields in a userspace lsm_ctx structure.  If @u=
ctx is NULL
> > > > + * simply calculate the required size to output via @utc_len and r=
eturn
> > > > + * success.
> > > >   *
> > > >   * Returns 0 on success, -E2BIG if userspace buffer is not large e=
nough,
> > > >   * -EFAULT on a copyout error, -ENOMEM if memory can't be allocate=
d.
> > > > @@ -799,6 +801,10 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *u=
ctx, u32 *uctx_len,
> > > >               goto out;
> > > >       }
> > > >
> > > > +     /* no buffer - return success/0 and set @uctx_len to the req =
size */
> > > > +     if (!uctx)
> > > > +             goto out;
> > >
> > > If the user just passes in *uctx_len=3D0, then they will get -E2BIG
> > > but still will get the length in *uctx_len.
> >
> > Right, which is the desired behavior, this patch allows userspace to
> > not have to worry about supplying a buffer if they just want to check
> > the required size, regardless of the value passed in @uctx_len.
>
> To be clear - I was saying that is the behavior before your patch.
>
> (If I'm not wrong)
>
> This patch changes behavior as follows:
>
> Before this patch, there was one way for the user to query the required
> size: send in a length of 0, get back E2BIG and check the *uctx_len you
> had passed in for the required value.
>
> After this patch, there are two ways - one resulting in -E2BIG as before,
> and one requiring uctx_len to be set to a large value *and* uctx to be
> NULL, getting rc=3D0 and taking that to mean look at the new uctx_len val=
ue.

Yes, agreed, no notes.

> > > To use it this new way, they have to first set *uctx_len to a
> > > value larger than nctx_len could possibly be, else they'll...
> > > still get -E2BIG.
> >
> > True.
> >
> > > So I'm not sure this patch has value.
> >
> > Oh, but it resolves a kselftest failure in a released kernel, that's
> > worth a *lot* in my mind.
>
> Sorry, you didn't mention the test in the commit message.  Which testcase=
?

See the tools/testing/selftests/lsm/lsm_get_self_attr_test.c tests.

--=20
paul-moore.com
