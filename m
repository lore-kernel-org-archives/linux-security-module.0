Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDF96F067
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jul 2024 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720569614; cv=none; b=t0ml+14qv67HvAzORGoN/iX9/FjRBsrU7yd+7iQ0KsTW7Zyi54p9MohLCrv3HxP+oKffZs9v6k4qYDvL578aXwFjf8FWNce+TP8ePHCoiVt9dzH+S1KGQi66zob+Xt0IFO9AsFm2USmTkZWlxjpAQu2+k+/X1GQdUNUgsQueKaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720569614; c=relaxed/simple;
	bh=RKVMOp7g3Kg+EbTUcIlPaOYSHp3Sx/r9EEYcDIIrxUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rbOnUPigjSXBwxsbnwJhA1TX78rOs9xJ7uJU7hpTWd9S2ThAf94fgBHFwU0XaJ98taCn4g7LZxHVqOKj1swQPO37EHxSvi4grsj4Isab49nOv6sofsG+AfXEik8+wo8Xn8Wp3Gi7JqF+G2lKFmayx0zgz5JzvF+P3ZVHUKvkm0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aSFDdZHw; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aSFDdZHw"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-654ce021660so37096607b3.1
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jul 2024 17:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720569612; x=1721174412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvAd2Ql+NYnTcJ2CkrpPMyu4794qcTHil8Kh5tNjRkw=;
        b=aSFDdZHw+o+agppnOMauO1IUdbRy6C53gmxls+nLbBBk/EnCgPU8R3DhU87S/7pGN1
         jnfrSDHxhcb7X5tPM+y6FVnHJaAgAoOdfWpVapc2nONSYoWZM92Uq17KSqoF+xz2m+rX
         kwSt3nMMMg4WRaWiPsNcyCvZ9oM4keCGirDf2dU7birUq8lf/Z3bWkRwvaUU79Y6w9lX
         XM+oJ8LejklTX8dKtHE3DejNhpf3QN9V5+atw0gD37e6i2k3UPVDD0CQ/zNgsDKpZqXH
         YuidVsbEj9ijvC0lhKgqCr81tNyqVo/2dljeNch49DrRxonhFbO41AYiLOaqqNxV6RyZ
         gBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720569612; x=1721174412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvAd2Ql+NYnTcJ2CkrpPMyu4794qcTHil8Kh5tNjRkw=;
        b=mzPRq/c/MioWo8ptoxZnddlaLjuLapWLJi5NWlwhXLYMoBzfiagk8LJmf9CniXdwaQ
         f78e4xRZcCH4XYm3xyErJHo8F57wxXzc/yT5pUTxvx7lyOgdSqmpYoAO/Qh0HOqT4hJj
         apkTjdmqB6ZStRz96A01ws4VLj3ZcCAJGjSHx+LC8yCLwizWvALTn/09FazgqnXibuCt
         yYZRV0HOKq4Ndcj79oDO+kKU6u9gwf5ICEsMf1eAKPuMHEJjLcOGFarH7GnwnPBpVwkg
         thOUxKOiJ7Gzia6hMbteVqJ8TWFHfLJanxeZ3eYdswsQi5SPdeCUZG9Ns4Y9DL167L+w
         NQBg==
X-Gm-Message-State: AOJu0YymWzol1Q7mdQmrloc546zzzAuJWynNzg66NHDBYuPt36PB30mV
	00ZDeDRHt9Nm6CsVNNIBvIWAdP+FMUSmWcgNnYgWxif48qF2zzaKAymnIECKI0pwMLh34xDq3L5
	apu5nPPWwUpB/XgYhYzpykSKnQTuwK9qMrebD
X-Google-Smtp-Source: AGHT+IE3cgtf5tjcWiMmFbgM3tstuSk9rP9kn6yL5xtsh2Jnl6Zunb48cc1DBLaRElrhfCkYUqzRzozpr+XURr+Cl0I=
X-Received: by 2002:a05:690c:708f:b0:64b:5fcb:6847 with SMTP id
 00721157ae682-658eed5fd7fmr54147507b3.16.1720569612244; Tue, 09 Jul 2024
 17:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708213957.20519-1-casey@schaufler-ca.com>
 <20240708213957.20519-2-casey@schaufler-ca.com> <CAHC9VhR-OOsjS-gB+Y35_bsLxTS__eJEwrYOrzLYou8gU10imw@mail.gmail.com>
 <f815cc68-ca2d-4bd0-b5fe-7093b5bc5e4a@schaufler-ca.com> <CAHC9VhRrKOcayQzY1GeExqufzs=COGQrkcnKeW-kAxKrrr0BeA@mail.gmail.com>
 <b8744973-2236-4f1c-86cb-27c92e753bb2@schaufler-ca.com>
In-Reply-To: <b8744973-2236-4f1c-86cb-27c92e753bb2@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 Jul 2024 20:00:01 -0400
Message-ID: <CAHC9VhSxoWaEG2k7z5DV-2B=WPFoQHpK_VrA13XGPYh6o-cQcw@mail.gmail.com>
Subject: Re: [PATCH 1/6] LSM: Infrastructure management of the sock security
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 7:29=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 7/9/2024 4:05 PM, Paul Moore wrote:
> > On Tue, Jul 9, 2024 at 7:00=E2=80=AFPM Casey Schaufler <casey@schaufler=
-ca.com> wrote:
> >> On 7/9/2024 12:15 PM, Paul Moore wrote:
> >>> On Mon, Jul 8, 2024 at 5:40=E2=80=AFPM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> >>>> Move management of the sock->sk_security blob out
> >>>> of the individual security modules and into the security
> >>>> infrastructure. Instead of allocating the blobs from within
> >>>> the modules the modules tell the infrastructure how much
> >>>> space is required, and the space is allocated there.
> >>>>
> >>>> Acked-by: Paul Moore <paul@paul-moore.com>
> >>>> Reviewed-by: Kees Cook <keescook@chromium.org>
> >>>> Reviewed-by: John Johansen <john.johansen@canonical.com>
> >>>> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >>>> ---
> >>>>  include/linux/lsm_hooks.h         |  1 +
> >>>>  security/apparmor/include/net.h   |  3 +-
> >>>>  security/apparmor/lsm.c           | 17 +------
> >>>>  security/apparmor/net.c           |  2 +-
> >>>>  security/security.c               | 36 +++++++++++++-
> >>>>  security/selinux/hooks.c          | 80 ++++++++++++++--------------=
---
> >>>>  security/selinux/include/objsec.h |  5 ++
> >>>>  security/selinux/netlabel.c       | 23 ++++-----
> >>>>  security/smack/smack.h            |  5 ++
> >>>>  security/smack/smack_lsm.c        | 70 +++++++++++++--------------
> >>>>  security/smack/smack_netfilter.c  |  4 +-
> >>>>  11 files changed, 133 insertions(+), 113 deletions(-)
> >>> ..
> >>>
> >>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> >>>> index 7eed331e90f0..19346e1817ff 100644
> >>>> --- a/security/selinux/hooks.c
> >>>> +++ b/security/selinux/hooks.c
> >>>> @@ -5495,8 +5488,8 @@ static void selinux_sctp_sk_clone(struct sctp_=
association *asoc, struct sock *sk
> >>>>
> >>>>  static int selinux_mptcp_add_subflow(struct sock *sk, struct sock *=
ssk)
> >>>>  {
> >>>> -       struct sk_security_struct *ssksec =3D ssk->sk_security;
> >>>> -       struct sk_security_struct *sksec =3D sk->sk_security;
> >>>> +       struct sk_security_struct *ssksec =3D selinux_sock(ssk);
> >>>> +       struct sk_security_struct *sksec =3D selinux_sock(sk);
> >>>>
> >>>>         ssksec->sclass =3D sksec->sclass;
> >>>>         ssksec->sid =3D sksec->sid;
> >>> That's new :)
> >>>
> >>> Unfortunately I merged a previous version of this patch into lsm/dev =
a
> >>> couple of weeks ago (see below) which appears to have a bug based on
> >>> the changes in this revision (lore link below).  While I'm generally
> >>> adverse to popping patches off the lsm/dev branch so as to not upset
> >>> any ongoing development work, given that we are at -rc7 it's probably
> >>> okay and much cleaner than doing a full revert; I'll remove that
> >>> commit now.
> >> Sorry 'bout that. I had troubles with kernels built from lsm/dev crash=
ing,
> >> so I switched to linus' tree.
> > No worries, that's fine, my policy is that I'll typically resolve
> > merge conflicts so long as the patches are based on either Linus' or
> > the subsystem tree.  In this case it turned out to be a good thing as
> > it highlighted the MPTCP omission in the commit merged into lsm/dev.
> >
> > However, do you have any more detail on the lsm/dev crashes you are
> > seeing?  I wonder if it is general v6.10-rc1 instability ...
>
> Alas, no. My VMs just stopped hard, with no panic or traces.
> The problem went away with rc3 (I did almost nothing with rc2)
> so I shrugged it off and moved on.

Okay, fair enough.  I haven't seen anything in my testing (although
that is lsm/dev+others merged on top of a Rawhide kernel) so I guess I
won't lose too much sleep over this right now.

--=20
paul-moore.com
