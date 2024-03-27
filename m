Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86B612FF60
	for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2024 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552742; cv=none; b=YPMVVJ1GBUfIKev6T8dNRrdvrGtl72O/qnzJctPmoeqBzAq2TKDnq8of4qm0A6Jtxm0AqDnmr1MIiwEd2oDyzVHdxCZaWwWHvj5v+S1ru36aSmnw2McjkCbePj+9Y2K8oAhPV0Rod2ek5HFKkAh6xKzIWjaunteDMdhmrELEL+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552742; c=relaxed/simple;
	bh=cYV47wSqDLz/DZEO4hDxq39ar8uuEH/aAHyDveZz6OM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcBGfiTlA2YRQ4DfGTgpR+XwIZ9arUtcVdL541/feD7fUVkpgaychlTQzmf1B1LdbUwi4jbWOBjuIRUIRsEPfTm0p0imT8iraUKWx/g0dOppehiltLLE3IyJqXTF2uYVqdREZquYHk4UR3JoDN+oUmnA5errg3GKgFFQMiLy1Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZUjmSrHU; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZUjmSrHU"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc74435c428so6751455276.2
        for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2024 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711552739; x=1712157539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yq59GO0FnyPqwHqxe0IeQ1op8rTclciPhd2Wg71JmLk=;
        b=ZUjmSrHULF9DSCJB/rh9PcAuzAu0bLBNQQA/Ok09JJfiXS1GipjKqPAQVTQEj3lk3P
         QOiMOw1N8J9d/slTlGfTups3MkIwoZFGpqlpDVWXqwNVhR+AG80b0xFddgoDUmyXsgPR
         TGcXD5wFjvTB+9FPB4tDptUOLn8vjOOz5Z+SzX9ce1WR8GXMDL5D4y0NFP4HZGvC3c9Q
         SmwLAdhJdTvRo8nj/9mR/Lwv32YaVR8dA6tHuh7ZPTEnLbstHQFVag4vhm6B+mexr4ok
         OM0XzbZtTtKg4mHAVJIM1Xp9sek8mzu/AU4XYTOZ9lnCvCQJDAjelYbINF46+2TDHFpW
         gKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711552739; x=1712157539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yq59GO0FnyPqwHqxe0IeQ1op8rTclciPhd2Wg71JmLk=;
        b=fSOBcL+xXFoWIgifopIgpI48Ao68W6R+fqfXjsfVGEUUeZ8hKPdKu456og62gyN3Gu
         bLtRTkSnNGrkgCJ3Fj8I1tfkFPQv08viTS1MnxD6Wh5iinWiFefz6Me7AJyXeWJSwm8J
         83qah3kKg0mDd1X8NlRaWRrTapjT3RbfUPVaMX7YD9l/Fb8CWT839iZo34erT+IDfEST
         d0Yb0z3hsY+Yc/DHdXxl3SUcNBkrB6sMyUrtRk+ZtCEEo3M7XhbzzBVARyQR62Z2jg5Z
         /kiCHMAEtowib9koombWezAliFevvm7PNxwARkB21FOeyKjwcRMuwWy34pGce6+xvY/t
         xwkQ==
X-Gm-Message-State: AOJu0YySY1w28L48hSWahJkotT2ZEoch0e6WYzBjEco7Sqr0iQzVmelY
	1wXhc/jMeuJYSCwHbB5eMib44WYbPgL9wmzkV02ZpvnruOq4DxeMhcokA4TNiwk23S1sCDVkxmd
	yFjFpVofpFtTHgnboSUPbQcFUXJAruafR7M3oI+UwAImXpgQ=
X-Google-Smtp-Source: AGHT+IHSXeWROPJJ2oeP5xwdcr6BxMf0BxB4uDqqigtM0cMsC1fTkS6aEH/hbvfDj93A8rCd+7Qq8H2441U397mHFiY=
X-Received: by 2002:a25:b28c:0:b0:dcb:fa70:c09 with SMTP id
 k12-20020a25b28c000000b00dcbfa700c09mr94463ybj.28.1711552738637; Wed, 27 Mar
 2024 08:18:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324223231.6249-1-greg@enjellic.com> <CAHC9VhQ22ef_o_OYue93RZfff70LPuOaCuN7Czv7HiEy346Svw@mail.gmail.com>
 <20240326103047.GA19964@wind.enjellic.com> <CAHC9VhQvN43LL-ynV-ZZgR2L8wFfUeq2-SZb5QHh9ZMWtz4C1A@mail.gmail.com>
 <20240327091644.GA32347@wind.enjellic.com>
In-Reply-To: <20240327091644.GA32347@wind.enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 27 Mar 2024 11:18:47 -0400
Message-ID: <CAHC9VhSjjeBH2CE5i+PK9Zyg661k-ryDbYkoPLtEe-g52DW0Fw@mail.gmail.com>
Subject: Re: [PATCH] Do not require attributes for security_inode_init_security.
To: "Dr. Greg" <greg@enjellic.com>
Cc: linux-security-module@vger.kernel.org, roberto.sassu@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 5:17=E2=80=AFAM Dr. Greg <greg@enjellic.com> wrote:
> On Tue, Mar 26, 2024 at 03:12:37PM -0400, Paul Moore wrote:
> > On Tue, Mar 26, 2024 at 6:31???AM Dr. Greg <greg@enjellic.com> wrote:
> > > On Mon, Mar 25, 2024 at 05:08:54PM -0400, Paul Moore wrote:
> > > > On Sun, Mar 24, 2024 at 6:33???PM Greg Wettstein <greg@enjellic.com=
> wrote:
> > > > >
> > > > > The integration of the Integrity Measurement Architecture (IMA)
> > > > > into the LSM infrastructure introduced a conditional check that
> > > > > denies access to the security_inode_init_security() event handler
> > > > > if the LSM extended attribute 'blob' size is 0.
> > > > >
> > > > > This changes the previous behavior of this event handler and
> > > > > results in variable behavior of LSM's depending on the LSM boot
> > > > > configuration.
> > > > >
> > > > > Modify the function so that it removes the need for a non-zero
> > > > > extended attribute blob size and bypasses the memory allocation
> > > > > and freeing that is not needed if the LSM infrastructure is not
> > > > > using extended attributes.
> > > > >
> > > > > Use a break statement to exit the loop that is iterating over the
> > > > > defined handlers for this event if a halting error condition is
> > > > > generated by one of the invoked LSM handlers.  The checks for how
> > > > > to handle cleanup are executed at the end of the loop regardless
> > > > > of how the loop terminates.
> > > > >
> > > > > A two exit label strategy is implemented.  One of the exit
> > > > > labels is a target for the no attribute case while the second is
> > > > > the target for the case where memory allocated for processing of
> > > > > extended attributes needs to be freed.
> > > > >
> > > > > Signed-off-by: Greg Wettstein <greg@enjellic.com>
> > > > > ---
> > > > >  security/security.c | 24 ++++++++++++------------
> > > > >  1 file changed, 12 insertions(+), 12 deletions(-)
> >
> > ...
> >
> > > > Looking at this quickly, why does something like the following not =
work?
> > > >
> > > > [Warning: copy-n-paste patch, likely whitespace damaged]
> > > >
> > > > diff --git a/security/security.c b/security/security.c
> > > > index 7e118858b545..007ce438e636 100644
> > > > --- a/security/security.c
> > > > +++ b/security/security.c
> > > > @@ -1712,10 +1712,7 @@ int security_inode_init_security(struct inod=
e *inode, str
> > > > uct inode *dir,
> > > >        if (unlikely(IS_PRIVATE(inode)))
> > > >                return 0;
> > > >
> > > > -       if (!blob_sizes.lbs_xattr_count)
> > > > -               return 0;
> > > > -
> > > > -       if (initxattrs) {
> > > > +       if (initxattrs && blob_sizes.lbs_xattr_count) {
> > > >                /* Allocate +1 as terminator. */
> > > >                new_xattrs =3D kcalloc(blob_sizes.lbs_xattr_count + =
1,
> > > >                                     sizeof(*new_xattrs), GFP_NOFS);
> > >
> > > We ran with something similar to the above for several days of TSEMv3
> > > testing.
> > >
> > > For the patch that we submitted upstream, we elected to take a 'belt
> > > and suspenders' approach that isolated the 'no attributes' execution
> > > flow from the flow followed if extended attributes are present.
> > >
> > > The approach used doesn't make any difference to us as long as we get
> > > the functionality of the hook restored.
>
> > I'd prefer the simpler approach.  I'd likely also prefer we park
> > this patch until it is needed upstream, or am I misunderstanding
> > things and upstream is currently broken without a fix like this?
>
> As of the 6.8 release, a security handler that previously functioned
> in a consistent manner now functions inconsistently depending on the
> LSM stacking configuration that is in effect.

In Linux v6.8[1] only Smack and SELinux provide implementations for
the security_inode_init_security() hook, and both also increment the
associated lsm_blob_sizes::lbs_xattr_count field.  While the behavior
of the hook may have changed, I see no indications of any harm with
respect to the standard upstream Linux kernel.  We obviously want to
ensure that we work to fix harmful behavior, but I simply don't see
that here; convince me there is a problem, send me a patch as we've
discussed, and I'll merge it.

If we are talking about future code, simply include the change with
the associated patchset.

If we are talking about out-of-tree code, that's something else.

[1] In Linux v6.9-rc1 this grows to include EVM, but EVM also provides
both a hook implementation and a lbs_xattr_count bump.

> Perhaps more problematically, when the handler does not function
> correctly, there is no indication of that fact passed upward to the
> LSM invoking the handler.  This would cause the LSM to conclude that a
> security relevant action was conducted when it did not actually occur.
>
> I believe we would all universally conclude that having security
> critical infrastructure function in a consistent and reliable manner
> is of benefit, so we should return the previous behavior of the
> handler, particularly since it can be done with a one line fix if that
> is your preference.

You need to demonstrate the harm caused to the upstream Linux kernel,
either a proper tagged release in Linus' tree, the current development
code in Linus tree, or a subsystem branch/repository.

> If you would be so kind, please put a 'Reported-by:' tag on whatever
> you commit upstream.

As you initially submitted a patch for this, it would be preferable if
you would send a patch ... if necessary (see above comments).  Of
course if you are unable to do so, and we all agree that a problem in
the upstream kernel exists, I can submit a patch with the appropriate
credit.

I will mention that bug fixes like this are a great way for new
contributors to gain experience working with the upstream Linux
kernel; I would encourage you to see this through.  As frustrating as
this might be, debates like this are part of the process :)

--=20
paul-moore.com
