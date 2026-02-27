Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CAE4611EA
	for <linux-security-module@vger.kernel.org>; Fri, 27 Feb 2026 20:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772225392; cv=pass; b=N1ynFrR2DYWUkfytgj4D+kpseQAjo38WtdK1cNZr+6pa3UIVL67ztwiXTDRjekhpSGDyNePbmkUmN2h8sKuBgfcq1q0rSizFXwAfsDEOO6dj9xp0t3FyzKLpNmhULUpPpR/NDDRA2zL7uszOB035HhQpX7qS2eDzA7ITdp35lqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772225392; c=relaxed/simple;
	bh=9+tQJOz6sr+GSDuw1tQ0T3DGmK188Nr3gpQ0oRaBT0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2TrJrCDKIuVbCGxA4EsKm/VB1yxnyq3D2+YPAJb0ESpCqSCIWk8OVZoOLj4cVElY70GSyeWJfyKrux7J5humvZgzJssFu6IY9menW1VOis17v2GLSniMlldhKN3XyUfgOsLo2mXjLOPAYLknhKcaDL8pCHzYkivIrJ+j40yqk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fBhWfTUa; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fBhWfTUa"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82747396358so1085147b3a.0
        for <linux-security-module@vger.kernel.org>; Fri, 27 Feb 2026 12:49:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772225388; cv=none;
        d=google.com; s=arc-20240605;
        b=YYCFsVh/59wNvzn4vlQh0hOsAZQn7LtjNp+IMHLz3gmqdWzcJFEWQqTIedhTGzLcT2
         m6b9hStYVVQdyvyA8iu4kgW08mh6AQW87jCNmvT9QcFLUUtphMGZ/oAMsaYQm9z/8TQy
         WDEaFKeAjrVwsG5mV1qugWa5KJEvnmTTeyLzMF46he9tw7EZif3oZ/Mwcnp6aM6w65Zu
         IgfL0a9kgYZVMkdS2KI4e023AMkheqNUmqs5ih3Yv5J3QlQfTjR3M0WZyUfbFfTAPIRH
         RGHMq3bsVwEULngOYTjIuSZs9OXu49Lesp0u1+3gKE7giW0HJaj7h5pxAE/uq3LQSeYp
         cIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cVCD+8zzQgJuvfw/BgjROykWvz9HB1TUc6TbGvOKlQk=;
        fh=enLYcUQu+9XJca2mDpj1Ncury73kTCrluARE0SmrG4M=;
        b=KU0qsp2S5tgFk+4NeejeN7K+HOmb5gJfBYbFbOl/68iTSUfYuz6oqoglbc6kVjjHEt
         4hU3YAHgEgECOslB0VtMOx0ANqjUUSWKyRMAn27bHZzT7VqlbETwK3PBJOm9Qp5PqIkD
         uwznqEMFJXsIsEvsL0OCgeFt1Nf1qIxuNA30jL04D/sPYuFWDAQ6E25l3jrQRgj3Hv/6
         dPr3aHoKbSa3/SE/MXM8PfGzUH5YHS39FebqN0+air32vVHA8M1IIaqlxOoDOLzWIreu
         WTOJvRi63m1wp87rSfmC8xSXwJN7zRfVnpnatqLbyVPRbbq+8njp6Rct6lIODfAOQlBj
         0k7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1772225388; x=1772830188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVCD+8zzQgJuvfw/BgjROykWvz9HB1TUc6TbGvOKlQk=;
        b=fBhWfTUanf//uykae6RURS77pDOFJ2ziqjxtWyzQmw+rAe+KphWIvOd6Jp/TNw4o4g
         xwgeUn5SqzhWHXEzYI4DwS1tZYnzXmIhWrz+g8UX9mo86IkTOJfDxd4xc5xitBAt9zUG
         BR9szL6zedlTEVW6VmWn0yVGChhuPtpyg9srKlIl8zxG2dgg8fB6ZjVL2M8r6ZeiJ9lN
         SnSO1oewp0P9UCy/dmt5D3UA/Jp364pRmcx6cUJWEaW5AKBncYM4AZJqr2mFbRvcB1ol
         o0MMvC+gKMEoSD9EaSDAJJ6K6NoT+7JXRrTpcCV8XFsR1c6AmHB0fj3caw6b/ISrUTh6
         rRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772225388; x=1772830188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cVCD+8zzQgJuvfw/BgjROykWvz9HB1TUc6TbGvOKlQk=;
        b=lTiKkaviQJE6b2NDVKyY9snFdZgVR5dKwRdGL+4wsJ0nO3dJTjIicAywJNPB0pRxp4
         zBxLLOZMpj5i/zSUE8LflfKvSfRUrt2Rz0z89ofAp87WC76UMptSMPNr5Uz74ti/bQ8w
         7dkh3zdstMhkgkinzACfug8yzFKiHPU9XFqTzU48UH3Vg66Z6G9ifrJgFfdXAxObsubT
         +x8d6JFnsYFa4saWFtqoqYRgF1spTaTC1/iJXIoZK6gbrcdpg/g2dN7BBqzPJdvSmOZS
         M4NJi/aAT1L+bX/TVTDv5VeUvNcR2zELc7+KjW89e0UDa6M55WUZ4noCMwggGPYCuTjT
         Q1BA==
X-Forwarded-Encrypted: i=1; AJvYcCUmDCqp0y107bMfqwEdFG9bFURt+DQC/mgX4WujvMUiDPVrxC7y3cviYsbkrvjgCVdZ/xFBOFszJ3jGqXbO3w+8YZJVecQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrUb4zy2RRwDTsQzts3WKZpQc+NUnakl9n2lEBzT8NLTixVDCz
	jWL+CMTxFQvpgsihVxQ0rXg/b9anecwxuhRrYpVF6tuLnPj0GyFuGwhzX5zdJjQGsYLEFAOtRsB
	dqJhYtGHF4OLy607MmNx2kscCBv1ZiV31ccq82Q/e
X-Gm-Gg: ATEYQzzlIzMstk2+BMNejGT7S4jXzSlUK1tyxS0oSrsrUQDJ3iYO9A0HPp/T+VslcU1
	K256GjDeMbtexAyjjtAPdaDv/wp6ZVr+/GFO+mbCybYc3lx7Hjs9nid15uf+XTMlHIL2tb+GzUp
	VRwtrDxiencgfIxPVbLyTC4qJl/Lo7cdEGfm3dSBqBVjprc6zS+rJ9nol4heHu5bN5FeJxNOMvY
	4BuyPnU2wBBh+qUMC5K44F75TU9Mfb4UMMCFI1Ozq4WmVD8ep5AziFxAGHXk1ehKJ24UaYU1qAX
	j/lOc5A=
X-Received: by 2002:a17:90b:43:b0:34c:2f3f:d27e with SMTP id
 98e67ed59e1d1-35965c17ea9mr3911139a91.3.1772225388113; Fri, 27 Feb 2026
 12:49:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220091941.1520313-1-aliceryhl@google.com>
 <CAHC9VhTwJbuXrdUFxWLVWfgk45hLScPgaC9Xb+R2NH6NGdaMZQ@mail.gmail.com> <aaFsRbMZl2OIlSCg@google.com>
In-Reply-To: <aaFsRbMZl2OIlSCg@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 27 Feb 2026 15:49:36 -0500
X-Gm-Features: AaiRm537LXvoiNCE51p23bTNfx0GnbeUEbCIUXhfKBy9fta2bariW3IulnltfY0
Message-ID: <CAHC9VhTrTxKYO-yjR0hFmfjMTOyVaR-UpkEigu21Lm76jRuZfg@mail.gmail.com>
Subject: Re: [PATCH] cred: clarify usage of get_cred_rcu()
To: Alice Ryhl <aliceryhl@google.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 5:04=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
> On Thu, Feb 26, 2026 at 09:18:29PM -0500, Paul Moore wrote:
> > On Fri, Feb 20, 2026 at 4:19=E2=80=AFAM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> > >
> > > After being confused by looking at get_cred() and get_cred_rcu(), I
> > > figured out what's going on. Thus, add some comments to clarify how
> > > get_cred_rcu() works for the benefit of others looking in the future.
> > >
> > > Note that in principle we could add an assertion that non_rcu is zero=
 in
> > > the failure path of atomic_long_inc_not_zero().
> >
> > That would be interesting to add a WARN_ON() there and see what
> > happens.  Hopefully nothing, but one never knows ;)  Have you tried
> > this?
>
> I tried just now. I put it on an Android phone, and it did not seem to
> be triggered after a few minute of usage.
>
> I can send a patch adding it if you would like?

It would need much more testing than running it on Android for a few
minutes before I would consider merging it :)  I suspect it's probably
not worth the effort, I just thought it would be mildly interesting to
see if anything tripped the assertion.

> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > ---
> > >  include/linux/cred.h | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> >
> > ...
> >
> > > +/*
> > > + * get_cred_rcu - Get a reference on a set of credentials under rcu
> >
> > I agree this is a bit pedantic, but it looks like the bulk of the file
> > capitalizes RCU and technically that is correct as it is an acronym.
>
> Will do.
>
> > > + * @cred: The credentials to reference
> > > + *
> > > + * Get a reference on the specified set of credentials, or %NULL if =
the last
> > > + * refcount has already been put.
> > > + *
> > > + * This is used to obtain a reference under an rcu read lock.
> >
> > I would suggest a different description:
> >
> > "Get a reference to the specified set of credentials and return a
> > pointer to the cred struct, or %NULL if it is not possible to obtain a
> > new reference.  After successfully taking a new reference to the
> > specified credentials, the cred struct will be marked for free'ing via
> > RCU."
>
> I actually think it's confusing to include
>
>         After successfully taking a new reference to the specified
>         credentials, the cred struct will be marked for free'ing via
>         RCU.
>
> in the documentation, because it makes it sounds like this method has
> the _rcu() suffix because it marks the struct for free'ing via RCU. But
> that is not the case. After all, get_cred() also marks it for free'ing
> via RCU.
>
> It has the _rcu() suffix because - if the cred struct is *already*
> marked for free'ing via RCU, then you are allowed to do this:
>
>         rcu_read_lock();
>         cred =3D get_cred_rcu(&foo->my_cred);
>         rcu_read_unlock();
>
> even if another thread might put foo->my_cred in parallel with the above
> piece of code.

To be really nit picky, the code doesn't actually enforce these usage
guidelines, so both are "allowed" in that sense.  The key difference
is that the rcu variant checks if the refcount is zero (the cred has
had its last ref dropped, but has not yet been free'd via rcu),
whereas the non-rcu variant always assumes the refcount is greater
than zero.

If you want to add a description/comment to the functions, I'd focus on tha=
t.

> > I suppose we could consider adding the zero check in the get_cred()
> > case, but even if we ignore the KCSAN barrier, it looks like the arch
> > support for the inc_not_zero() case isn't nearly as good, likely
> > resulting in more code to execute.
>
> I don't think that's necessary ...

I didn't say it was, in fact I was trying to dissuade anyone from
trying that because it will likely negatively impact performance for
minimal, if any, benefit.

--=20
paul-moore.com
