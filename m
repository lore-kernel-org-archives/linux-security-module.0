Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAF813CF94
	for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2024 19:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480371; cv=none; b=dwQc0D6QcLMwzTAbpLDQoT0JEqGMGnia0XsswsGRAITpTtxrBVqo3pALIESrCRDzgfoN5OQuwbYek5bETvWHsxG94ib7o+LygdhUxHlYvrTkxYfq0znwL4AQxeE00pKcWr0bCYFbTIeMz1S5IdUYjJMJMgK9fsWRpatM3Fq3IDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480371; c=relaxed/simple;
	bh=LZl6vWhe4TuLx6deRbG7NYsGe4+6/8RoVTVdja7RsCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tqx3rMVHAhcGSWM9RSYXe7o2pp7R1YslEAMWOpKiwihXMK+5Mthb1HiIJcfzWz8yX1SD/PYO4L25ju0PltQzCopJx5zTPrCssViLgwSzAHBktJPp3voOoQorDvVb2T8JJ8qklHcfUxATKJdJdqZPf99SdA1boEsy2WJ8EriFo6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aC3gMNt8; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aC3gMNt8"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dd02fb9a31cso5533346276.3
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2024 12:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711480368; x=1712085168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvZCJ/JDReotslzAmgbyUhxkai0RQoKKPHm/JYUfwws=;
        b=aC3gMNt8zDkfGGxX1oXKRWRpRCLwlC0QwUPHFhMkJwzALLFN1kV1QEIntsnupvyUea
         lX5zlG43lleWpL25dEFw6MWMkDTHf2l99Dk1K4o1Q0lRNMF1704bkp5XcZ+WFBBFdVzW
         BHmYHwP3p31yA4+bDzdDypRVrWyj52KzTNe28sVjf69KQxBiCWkRRLVemnRcp7Fc+GfN
         y2uktgZj8oKedXsdpU5QeJOnGD47bMpz7oLpMz0eDOGwIiB5RlwO/IJGBv7rTIjHcjLc
         LAQevnd5LH/t9xiDX28hye5sAfDpjAca1JS5+Hh682318Um70ok6KF9AplATG740Z/Vu
         N6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711480368; x=1712085168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvZCJ/JDReotslzAmgbyUhxkai0RQoKKPHm/JYUfwws=;
        b=F9QheyGkb2tYVuBTzGPA64+zZg4SnQM/aF8lOcoOBKxe6DmnwhE5iEk1P7KM12XSnT
         T+J385eKSK+qoeXHHP3nJkUnvNYupzycPbKIQgCL0DOyn2ONUPfvjX0DqQNnCVX5gXOh
         lAj/H43qJQuBZn9b+A3fC3rYn3zR+T2A9G9RmqYhy2ic75dvp31oSCG2bokHDszQ+t5y
         FKLgI6joWnrvFruDchxma9OM683ks6zjabqHRq4TNmUwXNrdzzttrfwx9hbsIi2Vzx7+
         V8ZdKVC1A9yDFXQ8ayMflJhWgTPQdm28qUMfpbDeoAJ7ZLBzQTFiiucCxGzK2KUdU+EQ
         w9iQ==
X-Gm-Message-State: AOJu0YwwHQuyHK7Oopl47mARgklB4r23QytmfgsFa4XBkJiZCB7LjwzN
	irwnR/Aw/q4a/0SJ2Y8iZCqoqS/r6gpg+4bX7WSOT98FftMwRjocMewkOkdB6FOuE4Ewmrl4iuN
	GOCpmVvYe6FyP/VFXheMoUbH20YtFud9m+2rWzWp8ZCnW4aQ=
X-Google-Smtp-Source: AGHT+IGbOdm4+VvQgLNdvwKqCExkCTRuMMYrw3YeFnDtH5BxhL07uwl3IVZVyezlgH0T/bnyzeTFRZHMj7/vzMLCHqE=
X-Received: by 2002:a25:5846:0:b0:dcd:3a37:bdb1 with SMTP id
 m67-20020a255846000000b00dcd3a37bdb1mr606911ybb.44.1711480368384; Tue, 26 Mar
 2024 12:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324223231.6249-1-greg@enjellic.com> <CAHC9VhQ22ef_o_OYue93RZfff70LPuOaCuN7Czv7HiEy346Svw@mail.gmail.com>
 <20240326103047.GA19964@wind.enjellic.com>
In-Reply-To: <20240326103047.GA19964@wind.enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 Mar 2024 15:12:37 -0400
Message-ID: <CAHC9VhQvN43LL-ynV-ZZgR2L8wFfUeq2-SZb5QHh9ZMWtz4C1A@mail.gmail.com>
Subject: Re: [PATCH] Do not require attributes for security_inode_init_security.
To: "Dr. Greg" <greg@enjellic.com>
Cc: linux-security-module@vger.kernel.org, roberto.sassu@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 6:31=E2=80=AFAM Dr. Greg <greg@enjellic.com> wrote:
> On Mon, Mar 25, 2024 at 05:08:54PM -0400, Paul Moore wrote:
> > On Sun, Mar 24, 2024 at 6:33???PM Greg Wettstein <greg@enjellic.com> wr=
ote:
> > >
> > > The integration of the Integrity Measurement Architecture (IMA)
> > > into the LSM infrastructure introduced a conditional check that
> > > denies access to the security_inode_init_security() event handler
> > > if the LSM extended attribute 'blob' size is 0.
> > >
> > > This changes the previous behavior of this event handler and
> > > results in variable behavior of LSM's depending on the LSM boot
> > > configuration.
> > >
> > > Modify the function so that it removes the need for a non-zero
> > > extended attribute blob size and bypasses the memory allocation
> > > and freeing that is not needed if the LSM infrastructure is not
> > > using extended attributes.
> > >
> > > Use a break statement to exit the loop that is iterating over the
> > > defined handlers for this event if a halting error condition is
> > > generated by one of the invoked LSM handlers.  The checks for how
> > > to handle cleanup are executed at the end of the loop regardless
> > > of how the loop terminates.
> > >
> > > A two exit label strategy is implemented.  One of the exit
> > > labels is a target for the no attribute case while the second is
> > > the target for the case where memory allocated for processing of
> > > extended attributes needs to be freed.
> > >
> > > Signed-off-by: Greg Wettstein <greg@enjellic.com>
> > > ---
> > >  security/security.c | 24 ++++++++++++------------
> > >  1 file changed, 12 insertions(+), 12 deletions(-)

...

> > Looking at this quickly, why does something like the following not work=
?
> >
> > [Warning: copy-n-paste patch, likely whitespace damaged]
> >
> > diff --git a/security/security.c b/security/security.c
> > index 7e118858b545..007ce438e636 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -1712,10 +1712,7 @@ int security_inode_init_security(struct inode *i=
node, str
> > uct inode *dir,
> >        if (unlikely(IS_PRIVATE(inode)))
> >                return 0;
> >
> > -       if (!blob_sizes.lbs_xattr_count)
> > -               return 0;
> > -
> > -       if (initxattrs) {
> > +       if (initxattrs && blob_sizes.lbs_xattr_count) {
> >                /* Allocate +1 as terminator. */
> >                new_xattrs =3D kcalloc(blob_sizes.lbs_xattr_count + 1,
> >                                     sizeof(*new_xattrs), GFP_NOFS);
>
> We ran with something similar to the above for several days of TSEMv3
> testing.
>
> For the patch that we submitted upstream, we elected to take a 'belt
> and suspenders' approach that isolated the 'no attributes' execution
> flow from the flow followed if extended attributes are present.
>
> The approach used doesn't make any difference to us as long as we get
> the functionality of the hook restored.

I'd prefer the simpler approach.  I'd likely also prefer we park this
patch until it is needed upstream, or am I misunderstanding things and
upstream is currently broken without a fix like this?

> If you go with the simpler approach, it may be worthwhile to at least
> simplify the handling of the call to the initxattr() function after
> the evm_inode_init_security() call.

Starting with v6.9-rc1 there is no longer an explicit call to
evm_inode_init_security() as it is incorporated into the normal LSM
hook processing, e.g. `hp->hook.inode_init_security(...)`.  I'm also
not sure we need to worry about the initxattrs() call near the bottom
of security_inode_init_security() since in the no
@blob.lbs_xattr_count case the @xattr_count variable will also be zero
so the initxattrs() call will be skipped.

Or were you talking about something else?

> It seems simpler and with more clear intent, to use a negated
> conditional check of the 'ret' value from evm_inode_init_security() to
> call the initxattr() function, rather than using the return value to
> jump over the call.
>
> Once again, your choice, no preferences on our part.

--=20
paul-moore.com
