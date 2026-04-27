Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3E437CD50
	for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2026 21:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326402; cv=pass; b=qzGcUjt5B6U3pyKDwij7ZC+R2tVB1J/f36OMYZKv/+DBY9Ar9twtnCPOEQ7MRSNSViMWSY2UXSNobP2USD1fi7ctxYowyEMIABE+TOKHOM9Ld1VhAwjPw6PaBJxAnIaZLKQYTzglWrdTPlZ9+y25QRtbs14YgM96PulGkTAid+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326402; c=relaxed/simple;
	bh=zhqPdLsliCeh4Cq3JMCBkHOX7txM8MBXqZidergodxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTbgbkspTnLfRmQu5/xpVIQMcFvf6NxSDJYdH7W5B4MltdsvOqwnUwUIYIujYvZGtu63ektUeKIRAyPUEMHxatgg8JB0PYKErOsQlb9XBvEZ2ZEHA4Zb4kxoW9DyGgYCSYHM7ljiTFLKygLfKG5hlWNmUA1OauonmLQNvByxGEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N8D/H87m; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N8D/H87m"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-362ddc1de56so3154295a91.1
        for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2026 14:46:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777326399; cv=none;
        d=google.com; s=arc-20240605;
        b=C/3H5YnGhjzZzuOKx8uoXErZ3Hcd+zTN6VNmgG+DyTPFyGBU4lnKAOLr3HOOENm4yH
         rKm+aOzlWbmG9pMbdb2qgXYUjhsmy++is5xaABGvs9xgycXd4MdS10irU6YAq4thfK5R
         /XLldO3Sx/xvbjQxgY4i46hgGiuTcEQ05E9Pc4qmkMu45XrjjUEO7dwH4DlsO2bKF9w4
         yQF6TZ+e4MVjgS7Xj1hpK/Sht6UMNwIh1lXgMWnmVMdXLTvTK7svwZ53zJnDMzXj9zv/
         bNKhJ14mw6HPI8m3Tq3TBs8O+ir3AnrIC26Xa/rvCOocO7aDBoOabn++tBFxIAj4T0ui
         JI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B3Kg5U1Zkn3lza4GlbBGatxlj+BMyoEuS2pqFmvkL9A=;
        fh=vVZUvpO4FpFXrs6aX9058UGGKmmwG5bbKFcjbkOQ9zU=;
        b=YEDU16ecYGMHHpT6fU7FEtfLAXfNqVIPQw9V/n8+zJHbKpr6kLm4Ez+mrHPzzzN/dt
         dnbBHcIQuUw2iivdVvnJ5Kk6PiVA5+Nh7zmFHVLu5aAxwhRx6aqAqGA018dBVYDyeSJx
         d+6GcVeUoFZGNOlEPzx5ZFG3uEj2Sq9lT5v6BFYc07EldAl6Mo1S0lgiQ4sAlZU7c7MO
         MtHuBvtyorl8NdIN7RsTY1flDDhtjznc4Ar7my51N78ALu99iTVTgQwyU2jLt3k69yQp
         B32yXPcOAOfazACPg1pWlTLGZr8I6BmAyRMlS72SaeyN49a+mYRQ6opholjDQg62VMvj
         Eyfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777326399; x=1777931199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3Kg5U1Zkn3lza4GlbBGatxlj+BMyoEuS2pqFmvkL9A=;
        b=N8D/H87mGkun8WKza0FtKRjUUlcMkalb5lk+brGk6cke3VqrOBpaCtXhCLKsbiy+6k
         SCO2zzIkbWoL9iBg+Riqrey6pLie0x7lJnbbmMhSk3J0AtYP+k4E+6x5TXH2OhOeOYB7
         2sWhidaomi9JL0nRNyEc1OxTuUD8VFW78irKFtOK2g1ZodCzJZowvKYzj8yqe8TOI9JZ
         eJodTm5z2Zgok/0pjl50UGTt9LfcAt1tccMCfVFpLJ9ly/nE7ZOj5iwcAeWE6KokMlft
         U40i0vgcqc6ra6gTg1gtkVnkfu/vD9KBNZnT3cOiHXWHcP06WDvwaM2mIEi+ASdCCIPv
         ckyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326399; x=1777931199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B3Kg5U1Zkn3lza4GlbBGatxlj+BMyoEuS2pqFmvkL9A=;
        b=ZDtIyE9HpB1R8+Og3KKGdJ3aZ974QzebumB8xNnZHlp5MXmff7MOuljDKsNsQDGXyq
         FMQVlCNGhKHn/9h/NgrGEvLvOOnpBFaWWMAsTD6jKn2ouJPfSz3oFGtKPrtVFgA0TmUy
         ocRfnS3kY0qW0EfejNBmBN9eUV41k6me6eMzUU7xLPmBFXaxhxEVTTYKXhUzH5Xt/Ec8
         sMiXn5oatzNkY9BPF2AaD+g54D9AoObImEyysKlAojcm6BMA76Lfazge2Oz4+cJpgEL1
         u2b4vireVWqHyImV79r5LBm8W46kllHPw7Q438X0Uo3x/T0sol+qUJlTaaEyQmG9wnL9
         tKBg==
X-Forwarded-Encrypted: i=1; AFNElJ+vz+8T+TGA1NLMEcsvovVwHlmdyCBtUE7yjGTzBUAAboxHbXtYeVC10/lURIjoD6/5NLxJKDGSPZgmSvs6s+yxCm0IDUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCdXXK1tfIvZ4RBxELSXUceK0XjsRvBi15n20cAHWKr0tPxsoK
	G76fdAzGzyCll1MdQBqkOAy8JGywc22EKEusd5bQ89vPBD4apamsVSbweN6sF/ybC8FwooCn+NX
	ePu5A2qm97zOPpQSJZ6sg2PnIKxFa9+upV7cFnh8O
X-Gm-Gg: AeBDiesDb6yAGabIy0BnkM2Y5UhKqHQVKR6yzkARkRTrfBbpi92q1DqJuwN8zTJnSfb
	MxInVj/qMSRufnSk0EvkxF4CwNCsh8QVrmPwrjcDZCh0OQ855oNNDYall/SZl9yZz0TxR66bH6O
	att6K056mjMORbNbFRp/RdUeL8+9Ps02dpLUNwahWMI1lb3096cUdmNUjnn4jWRD/e/ymBN+37v
	m8SPsoGnIhRsn2Tp1TsbiaEbI4s0OTboDH2OMeYUkb6wFwIDAovFO5Obdsa5XU/zlqVufb2wgG8
	9P1Tpbgm3y0p5D9MTVpeGdedY7oc
X-Received: by 2002:a17:90b:3510:b0:35f:b5df:463 with SMTP id
 98e67ed59e1d1-364920a5111mr316885a91.14.1777326399595; Mon, 27 Apr 2026
 14:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312100444.2609563-1-mic@digikod.net> <20260312100444.2609563-2-mic@digikod.net>
 <CAHC9VhT4Cd-FMYhaKgt6Gv-Suu7YJm7YbKZ-vdMwQV7EiWDryA@mail.gmail.com>
 <20260424.ein5Aiwah6Ai@digikod.net> <CAHC9VhRcokUR0ZKzCuZnZAyaFEMd6EH93BE3OTTKHY9Mo9pVkQ@mail.gmail.com>
 <20260427-belegen-euren-997f91347820@brauner>
In-Reply-To: <20260427-belegen-euren-997f91347820@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Apr 2026 17:46:26 -0400
X-Gm-Features: AVHnY4J_aORyQwUH7L8dzaXakX9ALCnxs85Yx7un-cTrHulHFgAyL_bsxR0vkU4
Message-ID: <CAHC9VhSFc217Msagi8wenJBkuqAZ6ftNBdd_HzejkWF60wPG2A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 01/11] security: add LSM blob and hooks for namespaces
To: Christian Brauner <brauner@kernel.org>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Justin Suess <utilityemal77@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 10:57=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> On Fri, Apr 24, 2026 at 03:28:44PM -0400, Paul Moore wrote:
> > On Fri, Apr 24, 2026 at 2:56=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > > On Wed, Apr 22, 2026 at 08:19:59PM -0400, Paul Moore wrote:
> > > > On Thu, Mar 12, 2026 at 6:05=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > > > >
> > > > > From: Christian Brauner <brauner@kernel.org>
> > > > >
> > > > > All namespace types now share the same ns_common infrastructure. =
Extend
> > > > > this to include a security blob so LSMs can start managing namesp=
aces
> > > > > uniformly without having to add one-off hooks or security fields =
to
> > > > > every individual namespace type.
> > > > >
> > > > > Add a ns_security pointer to ns_common and the corresponding lbs_=
ns
> > > > > blob size to lsm_blob_sizes. Allocation and freeing hooks are cal=
led
> > > > > from the common __ns_common_init() and __ns_common_free() paths s=
o
> > > > > every namespace type gets covered in one go. All information abou=
t the
> > > > > namespace type and the appropriate casting helpers to get at the
> > > > > containing namespace are available via ns_common making it
> > > > > straightforward for LSMs to differentiate when they need to.
> > > > >
> > > > > A namespace_install hook is called from validate_ns() during setn=
s(2)
> > > > > giving LSMs a chance to enforce policy on namespace transitions.
> > > > >
> > > > > Individual namespace types can still have their own specialized s=
ecurity
> > > > > hooks when needed. This is just the common baseline that makes it=
 easy
> > > > > to track and manage namespaces from the security side without req=
uiring
> > > > > every namespace type to reinvent the wheel.
> > > > >
> > > > > Cc: G=C3=BCnther Noack <gnoack@google.com>
> > > > > Cc: Paul Moore <paul@paul-moore.com>
> > > > > Cc: Serge E. Hallyn <serge@hallyn.com>
> > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > > Link: https://lore.kernel.org/r/20260216-work-security-namespace-=
v1-1-075c28758e1f@kernel.org
> > > > > ---
> > > > >  include/linux/lsm_hook_defs.h      |  3 ++
> > > > >  include/linux/lsm_hooks.h          |  1 +
> > > > >  include/linux/ns/ns_common_types.h |  3 ++
> > > > >  include/linux/security.h           | 20 ++++++++
> > > > >  kernel/nscommon.c                  | 12 +++++
> > > > >  kernel/nsproxy.c                   |  8 +++-
> > > > >  security/lsm_init.c                |  2 +
> > > > >  security/security.c                | 76 ++++++++++++++++++++++++=
++++++
> > > > >  8 files changed, 124 insertions(+), 1 deletion(-)
> >
> > ...
> >
> > > > > diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> > > > > index 259c4b4f1eeb..f0b30d1907e7 100644
> > > > > --- a/kernel/nsproxy.c
> > > > > +++ b/kernel/nsproxy.c
> > > > > @@ -379,7 +379,13 @@ static int prepare_nsset(unsigned flags, str=
uct nsset *nsset)
> > > > >
> > > > >  static inline int validate_ns(struct nsset *nsset, struct ns_com=
mon *ns)
> > > > >  {
> > > > > -       return ns->ops->install(nsset, ns);
> > > > > +       int ret;
> > > > > +
> > > > > +       ret =3D ns->ops->install(nsset, ns);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +
> > > > > +       return security_namespace_install(nsset, ns);
> > > > >  }
> > > >
> > > > Do we also want a security_namespace_switch() called from within
> > > > switch_task_namespaces()?  Of course LSMs would not be able to fail=
 or
> > > > return an error at that point, but it seems reasonable that LSMs mi=
ght
> > > > want to update LSM state associated with the current task once the
> > > > namespaces have been changed.  This is similar to all the "_post_" =
LSM
> > > > hooks we have for various operations in the VFS and network layers.
> > >
> > > What cannot be infered from security_namespace_install()?
> >
> > We don't actually know if the namespace is attached to a process until
> > we get to switch_task_namespaces().
> >
> > Now that I'm looking at this again, why is the
> > security_namespace_install() call placed after the ns->ops->install()
> > call?  From an access control perspective we want the LSM hook before
>
> See https://lore.kernel.org/20260325-filmverleih-auffressen-e897fcf8d3f2@=
brauner
> where I requested the order to be changed.

So ... does anyone not want this moved?  It's time to speak up :)

--=20
paul-moore.com
