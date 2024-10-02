Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A462D23CE
	for <linux-security-module@vger.kernel.org>; Wed,  2 Oct 2024 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883387; cv=none; b=u2p4fyHihClq590ZJIFZX6zNGaXQ5ft/IsIVNoI3KgYYqeF+u65ElLRByMUothQ72lMGHXasrxVlELQiAMQk4cKCgIKXHxbjXFeDjwPPmHJvI3OCc1xhLmXVnsulGJJgqitu+fWvJIecCfdwmZcHA/gK7xpU06wPcRV6DgHTW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883387; c=relaxed/simple;
	bh=e6R3fKQVA4eTx/tFf60LK8i+iyLXC7iLPJfmOmSG6aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZp9XC1fqyEspRq4FwdjuEKgtUmq8JDM5zc1JidzxtoAZciT4/b/aAdGJ22J93kgX4MgaMDn4FWBNjHfEjoODN94T6YHxSFsMKiPwJP7JNpcFGFOIFqPj20wqppVdmX7JwBvMSfwd1R6d6iB5ORg1H12gitXOD/Kn0MHK0jYzHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cl3G2+QF; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cl3G2+QF"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e1f48e7c18so58317937b3.3
        for <linux-security-module@vger.kernel.org>; Wed, 02 Oct 2024 08:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727883384; x=1728488184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHqMwCquKshBNzGVhYLKEI6g80zV+cmZ4zBBgER260k=;
        b=cl3G2+QFOUjP1d/A1C6da2TWmr0i7rkGc1HklQa/4mI79CHzkd/pyAxzaO8GSGtyEn
         jQ0HCTX6hlx58sWZIvG0tXKyK+jWExjplW1JSsK6Bz2LKw8FHePKdHsrHaEM72RezEvx
         luWkzYWCXN5g9LD8qe9Xj0/Pq0hvWl2lPz/nhEciXvfSv84RN92m9wi2huG6ltvcjeyr
         82ZSQqDIXiQ8JbqXYoaMRw/h0gM9xasIfykbT0LTLjKgUrw4olzviDTg0D4kgiibveWy
         EuIaUUDaEinlWmrWuxuRX8ZTzS0DfLmBe4joh9JaAt+04S6PgTWQV27CKEWawZdO6RRg
         Hb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727883384; x=1728488184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHqMwCquKshBNzGVhYLKEI6g80zV+cmZ4zBBgER260k=;
        b=EC16j8EfED4mAoLl9ZQMlm88TjeE/ztGuun+1i8e9+GL0Yfee/K5+rrYWr5rpxlZm4
         k/GGXBmtMWhy7UdLmDUSu8Qk/Snlo80KeNvSnlELEajmPeOr2lro0dGDHMNCdDGv+BSo
         ooh1dQceLztscRbq29MgNJT+YGn6zLY5amgdt5kQomREfGHXaN+S8ePzZzabIt9pg3Ki
         9KHqdf8m6UicowjYNa0kkkMVEly1sWsjP+cQXwZWPNi4uJ3O8gMo1YtWjpgwChNyvb0C
         LpWh2sAHVB31bs7dt3pK+hkxX1qSUPW4pP4Dobg4baJbaJeYYKc71SqUCqRXyA8DPq1r
         pZ/g==
X-Forwarded-Encrypted: i=1; AJvYcCVHvaYKnrykNWnSmwQJPEmMnpQMFmUSOIdVLLIGlxczqns9ZIgOUQNWp36jnBrqA1Mc2pdE7xcYwsxXgb0oxxd64RmPIZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWsfn6NFu/kpqT0uBBeD4SzGb3KJr1d+NXO4RynVu+2hFe1Ihn
	0doOZJsApEgRV/D3UwZ418ZUM9HYb+KQgD8ts+OSZSqIgdb8T+MdYAb7+ngxx/5EMFOxr+Cr2VO
	EH+waeGj+aI7mVqMULlwB0NLa/a9hpwsR78nmnY6kQx/X9OU=
X-Google-Smtp-Source: AGHT+IExgl7MyTBDuJs5C1WDeuUIP9rDLQKZEUekfjqmWVKSqFtUSTn77rLik83y2KgTL2PhdryfQLzOiUaHQpxJ+Lo=
X-Received: by 2002:a05:690c:530e:b0:6db:df4d:b7a6 with SMTP id
 00721157ae682-6e2a2b55380mr25110287b3.19.1727883384563; Wed, 02 Oct 2024
 08:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925192018.15290-2-paul@paul-moore.com> <dd386a1f-9245-45ae-b0fe-d07d1dec5100@schaufler-ca.com>
 <20240926131157.GA683524@mail.hallyn.com> <CAHC9VhSyYkq=AxiVkwkuk1jsTTCqt9xypdto5yaX3jdLXy+Xxg@mail.gmail.com>
 <20240926132251.GB683524@mail.hallyn.com> <CAHC9VhRj5BvBBir3_sWo5whbpRVmpppYEqrvgRf17mR2-xHdAQ@mail.gmail.com>
 <20240930210801.GA778168@mail.hallyn.com> <CAHC9VhQZ1wM-pYW5sPEcP9=uKi4sAFR1nEiEXu-tYypy7feHqA@mail.gmail.com>
 <20241001212013.GA801783@mail.hallyn.com>
In-Reply-To: <20241001212013.GA801783@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 2 Oct 2024 11:36:13 -0400
Message-ID: <CAHC9VhSvHq_cxTcAWGtyGXEdiCW0QTNoazhcBAfapnhq4-FbBw@mail.gmail.com>
Subject: Re: [RFC PATCH] capabilities: remove cap_mmap_file()
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 5:20=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> w=
rote:
> On Tue, Oct 01, 2024 at 10:08:04AM -0400, Paul Moore wrote:
> > On Mon, Sep 30, 2024 at 5:08=E2=80=AFPM Serge E. Hallyn <serge@hallyn.c=
om> wrote:
> > > On Thu, Sep 26, 2024 at 09:24:06AM -0400, Paul Moore wrote:
> > > > On Thu, Sep 26, 2024 at 9:22=E2=80=AFAM Serge E. Hallyn <serge@hall=
yn.com> wrote:
> > > > > On Thu, Sep 26, 2024 at 09:16:04AM -0400, Paul Moore wrote:
> > > > > > On Thu, Sep 26, 2024 at 9:11=E2=80=AFAM Serge E. Hallyn <serge@=
hallyn.com> wrote:
> > > > > > > On Wed, Sep 25, 2024 at 12:45:20PM -0700, Casey Schaufler wro=
te:
> > > > > > > > On 9/25/2024 12:20 PM, Paul Moore wrote:

...

> > > Just got access back to my kernel.org account.  Too late for 6.12 cyc=
le, so
> > > I'll keep it ready for 6.13 window.  I suppose I should see about hoo=
king
> > > back into the -next kernel for testing.
> >
> > Sorry for the delay, network access was spotty over the past few days,
> > and what little I did have was just my phone.
> >
> > Anyway, yes, this was intended for v6.13 anyway so no harm there.
> > Glad you're setup again on kernel.org.
> >
> > Hooking up to linux-next is pretty easy, basically just send some
> > mail, but if I can offer a suggestion you might want to make your
> > linux-next branch a automatically generated "composite" branch so you
> > are better able to get both linux-stable and linux-next patches tested
> > via the normal linux-next mechanisms.  I'm sure you've seen this
> > already, but here is the approach I take with the LSM tree:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/tree/RE=
ADME.md#n94
>
> Thanks!  I thought in the past there had been "how to best work with
> linux-next" guides out there, but I spent some time looking through
> linux.git/Documentation, linux-next/, lore.kernel.org, and kernelnewbies
> and google and came up with nothing.

Full disclosure, the guidance above is based simply on WORKSFORME
based on experience and discussions with the linux-next folks, please
don't take it as any official guide, I post it only so that people who
are contributing know what to expect.

--=20
paul-moore.com
