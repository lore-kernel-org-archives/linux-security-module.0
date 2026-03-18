Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A902C11FA
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852235; cv=pass; b=OVV2u32dg6vSSzNAWcxDRlddW8OUQxYiH7vUa1L/0SgPxnaxtCc8VkqCwFqZ9c/lWZlD4rFvnmdM1ZGpoYc8bn+Mdcz2rbINXXTM1qu/SeioXmVzn8Gj1PgMwnU1Wn6sF+KGNU0ZGcA+qjI3PzvDV/EBbmAHOzeM2xeTWU4Vc68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852235; c=relaxed/simple;
	bh=zXZxPJ1K3LCBhZiouT+2oJJTTv9xMqRYKfOSsTOtYD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZtYFoRNRLS4tcDIt9ICoGN2Zx7oQ98guv6IGw1fsNvcrCutZuruDWcH6EcEOgsiBCI/ZNP/AxFOGLeXhVQ9W1xv8CWiy8FgcndMCv61qqkSQUsylanbaMpheIjPjuQsyR1aKBN3V4LsbIwWxps7y5iJIyc/LmN4JzT+rSAcsOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MGKHeso4; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MGKHeso4"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso81825ad.1
        for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 09:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773852233; cv=none;
        d=google.com; s=arc-20240605;
        b=cVIRTUc3VAjSmspHs2G7YjOcJohPk7LFRpIv5BH0XZTEBrzYPknHbKZu80sQWwQ8Sh
         27XGMbQwoKypN73v5V6golk/5AiMDU2td9EbZ3cMNKhPXGY3g5LfP6OqkBh4ZpT7zV8C
         JS9ky1/G717Y9I0hy+pycRSYjXi1bZcOrLqXFEWWuQe9kRgLJFlk1I3oK1029hY5bUaP
         /9Cw2fjMzTSvwTAErqQztCMXsPFp0S6uLhhdHOHDkuZY+tAPaah57gSTAdXY/ls9ZVQY
         2s40NOYodSE1XNAVIh7cpcQfF2aFKNXTfWl1ACyLkvVs3Wm0kL9jOKDxHsvuSskTX7pI
         nLKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PEcuY1KVmJxJTfhrnCiK85Ol/POWaIDlGkzA+uAqUrc=;
        fh=fWRaEdobaU1b9LG9tg5boYjdeDn/L/KuxPDOvWp4MCU=;
        b=OPjgumnH5mBybP1iE9Gpp7bgdAwvk9arT+7SIWqrryk0u/w0TswdWtBTXrX+JTyfQE
         4vyC/dT2hefDlqcPrRaLvs+uhLrAHcmZvTieJj5wYx3RKDJfmmKAbwwEaIyFulR/9pQ6
         BohEN0TUvAD9agiT5TZWcsJ6QFVaA5pM6gvEpum3LRwmxYdj8UKsMcMK7kn7+xMTCEzi
         9nNsHHJfROtfjSmgtgz8us7RrgmbwZ2k7W8FLUJbJVobWQXYArx8dMYAcG1MTumdET8v
         k7dOaNeQsAMzhXNEfBJXgZzvP1R8iE58jtG/iyzYDAfzjjEG6X7WcGw8dUEtWnuVFPb5
         PJFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773852233; x=1774457033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEcuY1KVmJxJTfhrnCiK85Ol/POWaIDlGkzA+uAqUrc=;
        b=MGKHeso4Go86WhfyQXTWVzMbre9lUF5Omn2JSNl2Zc6jckdauZ6Uth9AxGK2jYQuZf
         DiPMHwZOmk+jtgS+c1QbHRov7/nqdkzMuLdLmZNK40//FiHdnOpAnJgfZFSTBo/caq7/
         zgVmEk7aeily+NtFAOx8ypbuQ8/0qZrHE1k+GUILQ+YAsTrNPZT87ci5fAp+gXHTk+94
         QZmHV0BUuuk0Tqumx9bbHhlu8ihYLq92FLCrzQu3jn7C/IBNlOrSl0U1sy9QvZYwnPsM
         P5hgALjH8aEBaAY2KI5+M4dewDvpB8pskMkmwkcqv6NwIHbixLpCVk6GQ+LMSmIRHZdT
         t6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773852233; x=1774457033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PEcuY1KVmJxJTfhrnCiK85Ol/POWaIDlGkzA+uAqUrc=;
        b=oB5/vqm+rRcEfp9TvMt6A2jYvH5LCRg2+EZ0VIiHhAk6hTtugiusHtkl/bTGtcO4/w
         UlImcWWi8XU6sqWwliF2+mEwzajMzycXDek7XaebKNAKrJUs7kxf5ll0fFn3wWzse9Nv
         X4rlDxa8sOANAJhAQXvAoUpuWfkigOdgKcMC67zIjFu/it2VMgwwdyqZkPyny6xZYHR7
         HeC6IAw9gdkQ9GwZEIQYj3myorcBo45vZgGvQ9tEAkjCBUVzn7xhlbnE8rs8dc+aUa37
         0DSg3hR73iWn7Jgb9uF50jQxzXqVRMJ8ifxyS321NcL5Qk7JmzJloKEg60DJIbvubCcQ
         eyIg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ3jYf8H4HR1iE7gF08xm7/uhmYH3+nzO0O3kZ2mj9zet4xxnvIZ8zCX+FGW4lWtKLZL9MC7DEckDjRXaDFcMWs8vFWFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXUfgB7tpG+yQupv8Sqo9DugoBvqVLnqyekE2UzPq3i2zam6nG
	ISMWMVudSqb2FxyFXQnIP5uKWcI5XqDAlmg+rl1l7OGsi0t46OET84M41ufzJumcD9eyomlJ3yh
	tD7BS7CrC8sm94LbeFGAgz9ls1gEecqy7UvdvZreU
X-Gm-Gg: ATEYQzxLKOfocn36+o9BaTrbvC9hZUxXeDD2KcfttQiJ5jjZKjTOYZScAQZktfNwoVy
	bft5QF+7RIJHHWYrjohCOBX3JhdP+lPubjAX7/oru4ESi7zepIrKGXDSG/M08nz5IKEDHO/uaqw
	XQooNcueY2AxEqyXPGhVnDKMNTWHZ8LV1F8JJGP1cgr28TKpR0zHZAZnYiw7Yka2hI04h9fIZIc
	t1zz3iBwFagW3CcG2s89rGzGd08Oq7EgznBffK6V+I+v9oOxH15oAPST+LkNbjSfU1Ey4AiYWlA
	sMm+AiVYpsdpj5d8UA==
X-Received: by 2002:a17:903:8d0:b0:2b0:6cb5:c6c5 with SMTP id
 d9443c01a7336-2b06e40be78mr48856105ad.49.1773852233544; Wed, 18 Mar 2026
 09:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315222150.121952-2-gnoack3000@gmail.com> <2697b9f672967b1318630f2ffa21914f@paul-moore.com>
 <20260318.In1aekohyivu@digikod.net> <CAHC9VhRy2j3nYHHnyjsDf9Rk6=5DAzCSrmXgHCpo4arVnfBjRw@mail.gmail.com>
 <20260318.wa0eef4tei6I@digikod.net>
In-Reply-To: <20260318.wa0eef4tei6I@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Mar 2026 12:43:41 -0400
X-Gm-Features: AaiRm52R-QUl_6FyQWVZwfUo3fZbrNzCqZ0wswhLxEPTednSfNTcmKYhFSB11MY
Message-ID: <CAHC9VhTkJ9s6SE2Hhg+zpg9R1-WF71e5HNJPENAc6krBCCyaRQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] lsm: Add LSM hook security_unix_find
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 12:22=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
> On Wed, Mar 18, 2026 at 10:44:26AM -0400, Paul Moore wrote:
> > On Wed, Mar 18, 2026 at 4:48=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > > On Tue, Mar 17, 2026 at 05:34:57PM -0400, Paul Moore wrote:
> > > > On Mar 15, 2026 =3D?UTF-8?q?G=3DC3=3DBCnther=3D20Noack?=3D <gnoack3=
000@gmail.com> wrote:
> > > > >
> > > > > Add a LSM hook security_unix_find.
> > > > >
> > > > > This hook is called to check the path of a named unix socket befo=
re a
> > > > > connection is initiated. The peer socket may be inspected as well=
.
> > > > >
> > > > > Why existing hooks are unsuitable:
> > > > >
> > > > > Existing socket hooks, security_unix_stream_connect(),
> > > > > security_unix_may_send(), and security_socket_connect() don't pro=
vide
> > > > > TOCTOU-free / namespace independent access to the paths of socket=
s.
> > > > >
> > > > > (1) We cannot resolve the path from the struct sockaddr in existi=
ng hooks.
> > > > > This requires another path lookup. A change in the path between t=
he
> > > > > two lookups will cause a TOCTOU bug.
> > > > >
> > > > > (2) We cannot use the struct path from the listening socket, beca=
use it
> > > > > may be bound to a path in a different namespace than the caller,
> > > > > resulting in a path that cannot be referenced at policy creation =
time.
> > > > >
> > > > > Cc: G=C3=BCnther Noack <gnoack3000@gmail.com>
> > > > > Cc: Tingmao Wang <m@maowtm.org>
> > > > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > > > > ---
> > > > >  include/linux/lsm_hook_defs.h |  5 +++++
> > > > >  include/linux/security.h      | 11 +++++++++++
> > > > >  net/unix/af_unix.c            | 13 ++++++++++---
> > > > >  security/security.c           | 20 ++++++++++++++++++++
> > > > >  4 files changed, 46 insertions(+), 3 deletions(-)
> > > >
> > > > Some really minor nitpicky things (below), but nothing critical.
> > > > However, as we discussed, I would like to see the AppArmor folks co=
mment
> > > > on the new hook before we merge anything as I know they have an int=
erest
> > > > here.
> > >
> > > John, Georgia, we've been discussing this new hook for a few months n=
ow
> > > but didn't hear from you yet.  We plan to merge this patch series wit=
h
> > > the 7.1 merge window (in a few weeks), so before that I'd like to mer=
ge
> > > it in -next in a few days to get a broader coverage.  I'm pretty sure
> > > this hook will work well with AppArmor too, but could you please take
> > > look to confirm?
> >
> > I probably wasn't as clear as I should have been, my apologies.  The
> > major reason I held back my ACK on this patch was that I wanted to
> > hear from the AA folks regarding the hook's suitability for their
> > needs.  While I don't expect they will have an issue with this hook
> > as-is, they have expressed interest in the hook, and I would just
> > assume make sure it is okay for everyone before we send it to Linus.
> >
> > Since this is a feature addition and not a critical bug fix, I will be
> > quite upset if this is sent to Linus without review by the AA
> > developers and my ACK.
>
> I definitely understand and that makes sense, but even if it is not a
> strict fix, please consider that this feature still fixes an important
> gap in practice (e.g. run anything outside a sandbox with the help of
> systemd; see cover letter and reported issues [1]).  I don't want to
> bypass anyone, but given the importance of this change, I don't want to
> postpone it either (except if there is a major issue of course, but I
> think the review was pretty good).

I understand the desire to close the gap, but as this is a known
limitation of the existing Landlock implementation, I don't think this
is a MUST (in the RFC sense) for the next merge window.  It's
definitely a want, and a *very* nice to have, but if they AA folks
need some more time to sort things out after what has happened
recently I think we can afford them that in this case.

> That's why we'd like to get some
> feedback sooner than later.  While waiting for AA folks feedback, would
> you still be OK for me to push it to -next to improve test and review
> coverage?

That's fine, my comment about "sent to Linus" was deliberate.  Feel
free to do what is appropriate to gather additional testing.

--=20
paul-moore.com
