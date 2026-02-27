Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BE33806B3
	for <linux-security-module@vger.kernel.org>; Fri, 27 Feb 2026 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186697; cv=none; b=gRfqM9Y242776RHmyIBqVtA+U7SORfI+D2Ivs3vzpuowQjiw18H3l1oeVnwkn5YSx68P/KM5V6kLsi9HxmqEm1o2QTAAjIBv+A+TbI0mLD/i1R3cesvStGPlWrStwKQLWn0oHcX5ut16rmQrizPC3u8+P5ZtVeMefRXOuE38J+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186697; c=relaxed/simple;
	bh=z9EzPHA+NrwIqxY1i0bwhqHm9BaXQE+2YeADLd6o+Vc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bxr0+A+kROnDQPUuGz8tZjcC4zMBPHFskN0v9QAo4MScpBjD95Vee1XAKbpCUUyks/hTnIeh9lUAv76MO1/qORv7KXH2lSugv7ZYtjcgRZYM5j8Wg346CWrxUMTgRwPENI+yPcei+p6d1wK7d8DOiubxDE63vRJ5WL6jK8rAKqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y/N76+ad; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y/N76+ad"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4836b7c302fso17296225e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 27 Feb 2026 02:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772186695; x=1772791495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xiiteIElczGI7veZ0Js5HxCGupAoberKcQazgwE/ZEU=;
        b=y/N76+aduv8+lIUi4zMQun8zM7EnVMwiYxTcXjZTWMl6/I2tjXMBvkS6wPHctKfSSX
         fxfJtscwJRgJeGI60Qk89wvc5OTfK5eXHgTYPW4HwoSgEyJPgIk4Z+pTCMCtHFQqUhWa
         wNjeHPRyxB881JE1g/va8WTY3bnQBLOpnHceeIROznJ92hN7tpA+5I8HCeMQxfq5j58m
         rb7z9CDHnIERiZ2Eef5if9foujTVoZ4EneaPCu6oPh8Z/h2Ed57ljGyodypeUfNHLPx8
         KaLDJoL/Ft6TNPYw/+gkAu6jAuZSnBf3TGqPKpykKzIKnyOuqBU3ewPpCHI64c8ZosWZ
         z28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772186695; x=1772791495;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xiiteIElczGI7veZ0Js5HxCGupAoberKcQazgwE/ZEU=;
        b=FMz4+nP3AixUrsDLOhW6heRZq9zAijTNdDdC5LKWYDwhQZzoK6bwdQFT4SWcBcHSLL
         BFIWkfeo4PI/mebtXHKq+OxqXsFCF6QB42rVdsoOStOUMo6Xb8nCvD92ucodC71+Sc1m
         dp3JtsIlAZCu3e7hZYDuOKUW+I5S4Q8Y/ileqLRMyUlFCXM4LVK+fvjIvGped9L7dbL6
         fAss7RIPsWYEbKmiS4/RgWOsuDsjGAxI+xMLL6gILr77lB2yjHcQDTEYeEq7NyPhxDKt
         0qLeyCuMw/RdV8kwhUIwveEyiZtKDJJeJaXFXSekb9yScfH0Vbu01ansUF1h+pd7jrpA
         QNxA==
X-Forwarded-Encrypted: i=1; AJvYcCUE4bhZCsNE94FCn6cYeHrN43k/NgkYF/dr8lPOKJGZJVKGEuCGUNliU4L9N3OrMyYvnazsF8hKDqNC90OYoUcRphux43E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgVVZq70NP/z8RSnsAV+TUmGCWNLi9Pkuc/Qu0rxoDc9g4w5Xn
	BYPkGPYfuRNDcGIWopjs1sA2i2rqtD7WRcnkgkS66DTjtLhwjrUGFB3Aes3LCEYjdhUD0zpbiu3
	zZcxNDkp9eJsRjlCkcQ==
X-Received: from wmbjs11.prod.google.com ([2002:a05:600c:564b:b0:483:6e1b:21ab])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a47:b0:475:da1a:53f9 with SMTP id 5b1f17b1804b1-483c9be2ab1mr31623285e9.14.1772186694560;
 Fri, 27 Feb 2026 02:04:54 -0800 (PST)
Date: Fri, 27 Feb 2026 10:04:53 +0000
In-Reply-To: <CAHC9VhTwJbuXrdUFxWLVWfgk45hLScPgaC9Xb+R2NH6NGdaMZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260220091941.1520313-1-aliceryhl@google.com> <CAHC9VhTwJbuXrdUFxWLVWfgk45hLScPgaC9Xb+R2NH6NGdaMZQ@mail.gmail.com>
Message-ID: <aaFsRbMZl2OIlSCg@google.com>
Subject: Re: [PATCH] cred: clarify usage of get_cred_rcu()
From: Alice Ryhl <aliceryhl@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 09:18:29PM -0500, Paul Moore wrote:
> On Fri, Feb 20, 2026 at 4:19=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > After being confused by looking at get_cred() and get_cred_rcu(), I
> > figured out what's going on. Thus, add some comments to clarify how
> > get_cred_rcu() works for the benefit of others looking in the future.
> >
> > Note that in principle we could add an assertion that non_rcu is zero i=
n
> > the failure path of atomic_long_inc_not_zero().
>=20
> That would be interesting to add a WARN_ON() there and see what
> happens.  Hopefully nothing, but one never knows ;)  Have you tried
> this?

I tried just now. I put it on an Android phone, and it did not seem to
be triggered after a few minute of usage.

I can send a patch adding it if you would like?

> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  include/linux/cred.h | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
>=20
> ...
>=20
> > +/*
> > + * get_cred_rcu - Get a reference on a set of credentials under rcu
>=20
> I agree this is a bit pedantic, but it looks like the bulk of the file
> capitalizes RCU and technically that is correct as it is an acronym.

Will do.

> > + * @cred: The credentials to reference
> > + *
> > + * Get a reference on the specified set of credentials, or %NULL if th=
e last
> > + * refcount has already been put.
> > + *
> > + * This is used to obtain a reference under an rcu read lock.
>=20
> I would suggest a different description:
>=20
> "Get a reference to the specified set of credentials and return a
> pointer to the cred struct, or %NULL if it is not possible to obtain a
> new reference.  After successfully taking a new reference to the
> specified credentials, the cred struct will be marked for free'ing via
> RCU."

I actually think it's confusing to include

	After successfully taking a new reference to the specified
	credentials, the cred struct will be marked for free'ing via
	RCU.

in the documentation, because it makes it sounds like this method has
the _rcu() suffix because it marks the struct for free'ing via RCU. But
that is not the case. After all, get_cred() also marks it for free'ing
via RCU.

It has the _rcu() suffix because - if the cred struct is *already*
marked for free'ing via RCU, then you are allowed to do this:

	rcu_read_lock();
	cred =3D get_cred_rcu(&foo->my_cred);
	rcu_read_unlock();

even if another thread might put foo->my_cred in parallel with the above
piece of code.

> > + */
> >  static inline const struct cred *get_cred_rcu(const struct cred *cred)
> >  {
> >         struct cred *nonconst_cred =3D (struct cred *) cred;
> >         if (!cred)
> >                 return NULL;
> >         if (!atomic_long_inc_not_zero(&nonconst_cred->usage))
> >                 return NULL;
> > +       /*
> > +        * If non_rcu is not already zero, then this call to get_cred_r=
cu() is
> > +        * probably wrong because if 'usage' goes to zero prior to this=
 call,
> > +        * then get_cred_rcu() assumes it is freed with rcu.
> > +        *
> > +        * However, an exception to this is using get_cred_rcu() in cas=
es where
> > +        * get_cred() would have been okay. To support that case, we do=
 not
> > +        * check non_rcu and set it to zero regardless.
> > +        */
>=20
> This is surely a matter of perspective, but the above seems a bit
> wordy, and doesn't address what I believe is the important part:
> setting non_rcu to zero means this credential will be freed
> asynchronously via RCU.  Both get_cred_rcu() and get_cred() set
> non_rcu to 0/false ... although get_cred() doesn't do the non-zero
> check before bumping the refcount.

I think that would be a good comment to add to get_cred(), but in the
case of get_cred_rcu(), it really should already be set to zero, because
otherwise

	rcu_read_lock();
	cred =3D get_cred_rcu(&foo->my_cred);
	rcu_read_unlock();

is illegal.

> I suppose we could consider adding the zero check in the get_cred()
> case, but even if we ignore the KCSAN barrier, it looks like the arch
> support for the inc_not_zero() case isn't nearly as good, likely
> resulting in more code to execute.

I don't think that's necessary. If you use get_cred() in a scenario
where it might be zero, you have a bug.

Alice
