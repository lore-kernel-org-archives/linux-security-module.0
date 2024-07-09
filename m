Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1353156F3C
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jul 2024 23:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720566342; cv=none; b=MpJexydcZRqU17x9kxdR+aJ4AI2Hn4fHYVdWVL1A+9yufHXciu+a92lGnB2IIOJdEJE1ijNRb+HmboRSfMKuwC769f9TRIP2Un7Xzws8BzT+oLDGZwj4XL4aaqmLkTVnHdpYmOpFiZp6502kFUzNQP4CinfjtcizmSP5oPAyMdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720566342; c=relaxed/simple;
	bh=5BQJAlJwZxT/0vbnyPxeX/x2m6jHE8o+01GbWKrxvzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+c/eyXHAabIdWFcZTaOln/vSEJT6LDKB1JRFE+3aXxLYXnfBRvPm2nmghe2JuTqFa41hQgsFqU3MaD9+B57oFHzy1IEYqo8CsBtl9ngMXt3L9MV55PrA5MumJouHZUDf0iqGOvrcX6U/3tjDEv5IfQ5txjxpjY/VUB1LIJOgtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dYDIMy3s; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dYDIMy3s"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-64b9f11b92aso51208557b3.1
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jul 2024 16:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720566340; x=1721171140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tY9c41sNnAt0cMwB8+rfC0lt67qAWf4pCBzn85Yh0Oc=;
        b=dYDIMy3sn0UJl6MkKkn9IZJ8cnBzKr33QcKU5QXHwMYNaGM4ctV7ebQrBXgOP+LiZ4
         /L6i/RW7tDJWqxagCArIk92/A9qxj1lj9UW7SjH3E4wxt6gXYpLaHtz0scv5I1myeFIo
         nvJcGu1t8qUdBJEB6tnbPRvJAf562+SEzjPIUrLRNcwYEMFP4oYqGZCTo7XNnvMm8JA9
         N55fO1eNgXus6Qa4xsBgeJBSx/I1rlTdsdKWvwy1+LJkKlKmFcvwJmdr/E3sFs5QzFMJ
         iqWzzqcTksoFT0q/tH5wqQT9AYM0YHMBDv6no73YJqEJivCOvOiZ6en//olrhvRxqpa4
         0IKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720566340; x=1721171140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tY9c41sNnAt0cMwB8+rfC0lt67qAWf4pCBzn85Yh0Oc=;
        b=uYCL2yXPlUMieFpcnqSddnF6lJFsM1/vqhfc7zljMLLhxf/leV/NGyqOeUDOweRo2I
         7iY+TJxagb507viPv84rPg+AoYY4Ga4gGj1jdHPaXA0gOCgDMQ5G4YaiZMhpSpqDQuFa
         3WNng96FI0rmrb1DSVjPMthoDlTMNjyvhULwrMbKh2EvH2cK0EUYG8y8yWIC1Cc0szpx
         Y1DzT1cBkC7aRcDL2gaCuRx16Cq1lQ8qKdsUvsnXYA6PzCnXW3oNJYI1kcUP9QVUanZX
         LTTAXS9X5L2IKETOC88b7a+llv39rhDPmtA5878DWJDY4klMYnPBb43kr91t+a3lVtG7
         Cmvw==
X-Gm-Message-State: AOJu0YzYNngYjdXN/mKgvfoUEPLwAIw1AFC38jW2jLXafCetc4f+xHs1
	b3nxQd0ON75VHH8RgETITg5M/eFr4rlqL83O4Zj05jfpJv9CsxAiof4hE/RbcqlxPUDQtCmm1QC
	TeI8vFOH3uL5UQwQYnyTTtgAEc1SEs5+sGlAF
X-Google-Smtp-Source: AGHT+IEm6mKadb51cVuBUNkBQbHKBndCAf5YpFQ36aM3MgAtoXhacWN7OQzDM8kO+hPR7RJInPl40ICJgHzS9JYMroo=
X-Received: by 2002:a05:690c:c02:b0:650:8d5b:77c4 with SMTP id
 00721157ae682-658eee5a277mr50150177b3.20.1720566339675; Tue, 09 Jul 2024
 16:05:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708213957.20519-1-casey@schaufler-ca.com>
 <20240708213957.20519-2-casey@schaufler-ca.com> <CAHC9VhR-OOsjS-gB+Y35_bsLxTS__eJEwrYOrzLYou8gU10imw@mail.gmail.com>
 <f815cc68-ca2d-4bd0-b5fe-7093b5bc5e4a@schaufler-ca.com>
In-Reply-To: <f815cc68-ca2d-4bd0-b5fe-7093b5bc5e4a@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 Jul 2024 19:05:29 -0400
Message-ID: <CAHC9VhRrKOcayQzY1GeExqufzs=COGQrkcnKeW-kAxKrrr0BeA@mail.gmail.com>
Subject: Re: [PATCH 1/6] LSM: Infrastructure management of the sock security
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 7:00=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 7/9/2024 12:15 PM, Paul Moore wrote:
> > On Mon, Jul 8, 2024 at 5:40=E2=80=AFPM Casey Schaufler <casey@schaufler=
-ca.com> wrote:
> >> Move management of the sock->sk_security blob out
> >> of the individual security modules and into the security
> >> infrastructure. Instead of allocating the blobs from within
> >> the modules the modules tell the infrastructure how much
> >> space is required, and the space is allocated there.
> >>
> >> Acked-by: Paul Moore <paul@paul-moore.com>
> >> Reviewed-by: Kees Cook <keescook@chromium.org>
> >> Reviewed-by: John Johansen <john.johansen@canonical.com>
> >> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  include/linux/lsm_hooks.h         |  1 +
> >>  security/apparmor/include/net.h   |  3 +-
> >>  security/apparmor/lsm.c           | 17 +------
> >>  security/apparmor/net.c           |  2 +-
> >>  security/security.c               | 36 +++++++++++++-
> >>  security/selinux/hooks.c          | 80 ++++++++++++++----------------=
-
> >>  security/selinux/include/objsec.h |  5 ++
> >>  security/selinux/netlabel.c       | 23 ++++-----
> >>  security/smack/smack.h            |  5 ++
> >>  security/smack/smack_lsm.c        | 70 +++++++++++++--------------
> >>  security/smack/smack_netfilter.c  |  4 +-
> >>  11 files changed, 133 insertions(+), 113 deletions(-)
> > ..
> >
> >> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> >> index 7eed331e90f0..19346e1817ff 100644
> >> --- a/security/selinux/hooks.c
> >> +++ b/security/selinux/hooks.c
> >> @@ -5495,8 +5488,8 @@ static void selinux_sctp_sk_clone(struct sctp_as=
sociation *asoc, struct sock *sk
> >>
> >>  static int selinux_mptcp_add_subflow(struct sock *sk, struct sock *ss=
k)
> >>  {
> >> -       struct sk_security_struct *ssksec =3D ssk->sk_security;
> >> -       struct sk_security_struct *sksec =3D sk->sk_security;
> >> +       struct sk_security_struct *ssksec =3D selinux_sock(ssk);
> >> +       struct sk_security_struct *sksec =3D selinux_sock(sk);
> >>
> >>         ssksec->sclass =3D sksec->sclass;
> >>         ssksec->sid =3D sksec->sid;
> > That's new :)
> >
> > Unfortunately I merged a previous version of this patch into lsm/dev a
> > couple of weeks ago (see below) which appears to have a bug based on
> > the changes in this revision (lore link below).  While I'm generally
> > adverse to popping patches off the lsm/dev branch so as to not upset
> > any ongoing development work, given that we are at -rc7 it's probably
> > okay and much cleaner than doing a full revert; I'll remove that
> > commit now.
>
> Sorry 'bout that. I had troubles with kernels built from lsm/dev crashing=
,
> so I switched to linus' tree.

No worries, that's fine, my policy is that I'll typically resolve
merge conflicts so long as the patches are based on either Linus' or
the subsystem tree.  In this case it turned out to be a good thing as
it highlighted the MPTCP omission in the commit merged into lsm/dev.

However, do you have any more detail on the lsm/dev crashes you are
seeing?  I wonder if it is general v6.10-rc1 instability ...

--=20
paul-moore.com
