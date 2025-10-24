Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1762FFFB2
	for <linux-security-module@vger.kernel.org>; Fri, 24 Oct 2025 21:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761340759; cv=none; b=WCwMQ99Ym0vTGVQkrEd4Gbjtya8YaqXNHzaRSK1gkCgqxjsCy+njexJw3CGGEaGaC4T3UOoZf27KXWjryEqXCRRjMpm+EIfYmNYkdijNOuJTgY/dg/nhMslOkzwUeQY46MyIegTanSSqdlEM1YWM1C8YwVMgFNOP3VenQ/1VQ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761340759; c=relaxed/simple;
	bh=Q5/wEJ5gjWMJYpVKrI/TR93gpL8YjJvzBHdOx3GYBb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nob0Vrb7LJKwcYRgtPdO4f8ENS/depnMDkJFZghwOzxAwW/Tt1OKLCZrmkC95D68r/wC1AjGBm6Fr4NhfEGdnuFg0c8TOSf/ivlvzngsAq4NB5aDJ8G3CQGlav0RF2B8BsLThBMjXaX6za4UXvKUDe7eXU57AKUZj4sCBLK+44I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b1li+BXq; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b1li+BXq"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c167b70f9so2948a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 24 Oct 2025 14:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761340755; x=1761945555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ly9jwlM2gBwuCjx1Gq4+QRffP8sFGZ+fNZzj9gTQP4I=;
        b=b1li+BXqDop7YChRoUhzFFCTpEMC35zs+cRXzZxlnt+SxAnMBmBhZfKVYWrlO/Oomf
         bbmzFVf9Ae/sxeytknnfQGS7LJhsRqQHP30iISIxxszsh7hm6e6nOTdHH4obfnPEnBGL
         BY1E6BkSXgMWZvYcmE3tk0+dQATIglAC1qONK9khHmmOTJqyb4Fc+3cRiqyWP2sL34kq
         3UViUQZ/E2hwqVeGXvMfzsT4QbcilBrHTtgnS3tOLcDFThprjrF8mTrygDvlIL1DcXqN
         xgUeDvsSm2khkdgAuYrlc9Vt3qluYUxIlJeLW+fkw6Jm1oK4Xt8pBHbBzobd/j3J2a0d
         LIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761340755; x=1761945555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ly9jwlM2gBwuCjx1Gq4+QRffP8sFGZ+fNZzj9gTQP4I=;
        b=VUeLlvHPtp2RYj7UJX4H8e9CTbqxCs83h8r3FzHAu6ovVs/UGk+3tCaXM8iADtwLzu
         Jcjm4adCcRKW4s9tBwrupee6nu7mNrB2nruF37ehmd7HUMM33rMGgHLEBq6W344Sey5H
         ODow/mcIrlWeqOE1qkv0FibKsk1iQ1QqkpPmX2CDLU4eedgCpQsDxU2tOcTI9gQ7Ib1h
         Vl0BvjqCLiJwnZkXoXLw2JeZRiofc5Rtjz0YhJT5fb0FhoazzkZYvN2Msh2GI/E2kcmq
         Q0BQtFbBDEIleJRmXXFTRv88ewKgJ6jrMFE6EISX5uKSjY5SD6OBQXdXTayvfsRw/MTr
         BPbw==
X-Forwarded-Encrypted: i=1; AJvYcCXj8I30ozrrGDZV5yNkt+D9KRH4uGx/Gh+4Wkv0lDYu213E/bdpS0t8C2F6rCi6dAVGu2eaHBBOENLmacPsUEcCcSVjlKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg8883PjAFVGDa5got6FL7MwdJ8h7Q8iusV19jigyL+NLraACM
	OefsdedttdGpwM+Jnr9j1hXXucpKd1g6DAYreMxy7c+aziqp1TP0l3m78UmzZpfFp0C/S/fE1UP
	M3hihWDBPWd0E+NoZFZo5XnuPZFUZm9cgFhVAptVf
X-Gm-Gg: ASbGnctR22+eJfuLQBXP5PXfyMHevyvrrpZVrBERCalXA7ZZM6oKYvDo9rGYklsVxSH
	nUyFgKk+kqzwMiu10Z7y898AMsHs2LhuF4j7no3zy6FopaAK3zWAym1LjzGPNIcsexhSM7Juvmx
	UjuPCTfwpkrLVPhD5PYpg42mNCOffzAkcibvAq4rCJe4zYXjNwsCN8kPYexYkEcbedjk3Y6be1S
	De9hag9kywC/PL8PXIgPgn2u1phSXDE7fjlEXOVhzq8lN/NbFt/xsaaEC4UE/gWxmXRpg+pUE5W
	QZzTiWF/4Yr1kyjnmjyxznn9
X-Google-Smtp-Source: AGHT+IEFKid8zYGDaSNjwIcBXiL85n1AUyopsccaAfYyHZOO2wajKtjWA5rvEPsKxpOCOfZl264dYCly9KdVdf/oZ9Q=
X-Received: by 2002:a50:9f08:0:b0:63e:d72:4cf with SMTP id 4fb4d7f45d1cf-63e7c0dad4dmr27348a12.2.1761340755363;
 Fri, 24 Oct 2025 14:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001111807.18902-1-gnoack@google.com> <20251001111807.18902-2-gnoack@google.com>
 <20251017.ohthoos9Ogha@digikod.net>
In-Reply-To: <20251017.ohthoos9Ogha@digikod.net>
From: Jann Horn <jannh@google.com>
Date: Fri, 24 Oct 2025 23:18:39 +0200
X-Gm-Features: AWmQ_bntNWi01IQLkCw1gO5Qel7NIpgFGlAUcckkgMJExifS1kU8Ql4APtvWR9I
Message-ID: <CAG48ez2KoF6hVSJwdPfUpN3oroMww6Mu1+-bsBSbO8C5f91P6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] landlock: Multithreading support for landlock_restrict_self()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Tingmao Wang <m@maowtm.org>, 
	Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 5:04=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Wed, Oct 01, 2025 at 01:18:06PM +0200, G=C3=BCnther Noack wrote:
> > +     /* If needed, establish enforcement prerequisites. */
> > +     if (!ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
> > +             task_set_no_new_privs(current);
>
> We should always set PR_SET_NO_NEW_PRIVS if it is set on the calling
> thread as done by seccomp.  We should just store the result of
> task_no_new_privs() in tsync_shared_context and use it as condition here.
> This should be explained in the documentation.
>
> This also mean that if the calling thread has CAP_SYS_ADMIN but not
> PR_SET_NO_NEW_PRIVS, then a sibling thread could not have CAP_SYS_ADMIN
> nor PR_SET_NO_NEW_PRIVS.  This would be a risky state but mainly because
> of the CAP_SYS_ADMIN inconsistency, not really the missing
> PR_SET_NO_NEW_PRIVS.

Agreed, it would be nice to have behavior that is consistent with seccomp.

[...]
> > +/*
> > + * tsync_works_provide - provides a preallocated tsync_work for the gi=
ven task
> > + *
> > + * This also stores a task pointer in the context and increments the r=
eference
> > + * count of the task.
> > + *
> > + * Returns:
> > + *   A pointer to the preallocated context struct, with task filled in=
.
> > + *
> > + *   NULL, if we ran out of preallocated context structs.
> > + */
> > +static struct tsync_work *tsync_works_provide(struct tsync_works *s,
> > +                                           struct task_struct *task)
> > +{
> > +     struct tsync_work *ctx;
> > +
> > +     if (s->size >=3D s->capacity)
>
> In which case can this happen?  Should we wrap this in a WARN_ON_ONCE()?

No, this can legitimately happen if new sibling threads are created
between the time we pre-allocate memory and the time we loop over them
to call tsync_works_provide().

[...]
> > +             return 0;
> > +
> > +     works =3D krealloc_array(s->works, new_capacity, sizeof(s->works[=
0]),
> > +                            flags);
> > +     if (IS_ERR(works))
> > +             return PTR_ERR(works);
> > +
> > +     s->works =3D works;
> > +
> > +     for (i =3D s->capacity; i < new_capacity; i++) {
> > +             s->works[i] =3D kzalloc(sizeof(*s->works[i]), flags);
>
> We should use a local variable to avoid storing an error code in
> s->works[i] and potentially dereferencing it later (e.g. in
> tsync_work_free).
>
> Why can't we avoid this loop entirely and allocate a flat array with
> only one call to krealloc_array()?  Why struct tsync_works->works needs
> to be a pointer to a pointer?

Because pointers to some "struct tsync_work" items might already be in
use as task work or such, so we can't move them to a different address
anymore at this point.
