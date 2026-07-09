Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEA24964F
	for <linux-security-module@vger.kernel.org>; Thu,  9 Jul 2026 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602254; cv=pass; b=XHXWoq44IkYm6P8H6AT45o8i1uC72A6dDQMrQhxlwUmvbva+22tJPqqzrley631qeyNQRJ0bXbF0OIfek1vIdC/8rftepp4DrlYgq4JtdxOlBNSWaYF3oYFKmsp427fqqMsfJRiGF74W2+FdetwGDe3J+hS4rA1mzqAdl02PUvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602254; c=relaxed/simple;
	bh=k2/f6UIwAG7NHkU2DktDLP+xMov7JPi3pU0ljjUVvtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GeR/abiLkMbDuhanaK/sjFkYzSNDBJRqS8+ufuHmefjG4vmiygkZBtp9K6GAUSJscR+jIczRqLP6OQr3bot7OvshMj0YyvNgubHZMkfOmimyXsLo/+skK7nPzLjjMzsCq1lPJ06y3DgTfo5qhrZ9ZD8U0IM5925CPC5Ak4fcR34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EyVTBtYx; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EyVTBtYx"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2caf228a910so12537025ad.2
        for <linux-security-module@vger.kernel.org>; Thu, 09 Jul 2026 06:04:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783602251; cv=none;
        d=google.com; s=arc-20260327;
        b=nPRGQF/sk1Op0+H1UMAqPtgECTTreXzbe0Q4yUaYpaithN1iiZkssYsYS+VhBYOdtP
         qzx7MT5pmSctg0jzP2EEpUureqUFVRU5ErJSrYgKF9YmyPcM+h1S8Ah5QhUpFwJMcYxm
         /3AIQImsTGqH5oFPW20G6wNNuni1RmMcXmWcV8KYRf+Dbd5g5HfwemddmpDIVku9m+AA
         wKzVn4eIkk9BRbreUOY2jf2EWc/B/s+byhA28vK4s+qTy5GQh/aLn8F0hdZWx8TMQlbZ
         gqvtYj82G8GprIgcaUrCTebvC273tdAVkxOpXzP00JbtNg7VhEUBfR/IWkfi176RF7Wa
         OeZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7zIvFmIDYE6W4LWpeVv0pxPnUShx5Qma8ITAgool7ZA=;
        fh=bhnnhE+GrFAjzqR1YqOJjzd7RZiivTNP36HGgAysAVY=;
        b=hIdsnABRtDn3l88tTEspoJvzgYgB4y+h3vLH2zomV9FC+t+3NQijjNYRew+JmqMXJN
         KPpor4sG3SXsyRZhh8YYu9rcAMynwWmTpiEDqqsFpKp+Tn/hPyfro1mUNMrSScMDf0qN
         xyqX2alrdRRclkvcvbIf4NO3nsjh/nb7GsVYOa1kyVCz4ZDbXbt8cHgPapX2evgldwJj
         Dlrcrzcx675RgaZ2pUaMwEIoMhJUdoOLPttjyguIB9k7xo7ulhaThptUzh1RB1qMmqj1
         bPckMdb83SBHbvbfSLgLBed38isp0qPzfQZTxKTFyxj7Ja2fql7JMDDYIpgAA688YNPo
         81sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783602251; x=1784207051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7zIvFmIDYE6W4LWpeVv0pxPnUShx5Qma8ITAgool7ZA=;
        b=EyVTBtYxHImOEElTiFt3XS8TAGbTJmYKMsvtJqK519eVtxGdGeVFURng18+N0qKmZY
         XI05BTM7NP0skmrQCSfnHrgxobUF57n50tN38/gmXBZMZQPLEINTuu7jyIK2FTtl2t3+
         UipGNqDkoyEV0XPWlX8ak5Mwl/JkSkMsmrWRenQmr4RuIcTUJ9iKOWBTrMXLtREEiq4z
         jeAOaVEGQLQW1uHqyb8ZFI4+Ov3f6JlfOU1hH/tq0OHM5yvO3W36HlZe39mE5pzLIxYn
         qNbkGJa0oCHUdZpmIo6Mk2wDOc32LmUcVtPYzickyjr1rks4dPSgyuOBA9KRH7dnMA4B
         FBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783602251; x=1784207051;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7zIvFmIDYE6W4LWpeVv0pxPnUShx5Qma8ITAgool7ZA=;
        b=ZMIUDvnqL0XqULie1PG9R+ymdtxNvb1jaDLCPVQXqUETTo39IVOqdTLpBcuHuIqqXo
         PpZ/AJMq3YOiUdmxq62581TcTrjk0HETQYfjfyIilOPH6PupkRlT77cMvxWNtr3hV+bs
         xJF//ml2hqfUIAd53CjdEH1GSOUYz4+XWhpVHEo/oAy0myF+EMwzC19/XinvsPThzyb0
         qgsnuS7uYXgBfnkYJTUyACy1v9cWY5woWLzVunl7jEfxK0IkdAASekPA98Feo8y6KzFh
         tyIiu++AbvLtVcjuwSyYAGkON7D4Sz/aQLdKrVcnnv6eUXTsck2qbGGHPINnV9XqvRHd
         g+Cg==
X-Forwarded-Encrypted: i=1; AHgh+RqY/RsNBsh0TJn8qVeFrMg38TuymbmvDjsOoOEjtpXOB0lR7QtENH25pRb6iOZFZfYZQ8dlc4QhtMLw/+OAj4KmhSfhhOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBOgC4ljxAh8KkDaaaVRkyGFw2Nm7aeuldboIud3dICA3kuPvv
	KkfqyIhrXRguKDlM+5v+OXE8OD+Apzcq2h2NZoxgYZpEFIVLxYb5McRGtXXeo2ZlLvbSpK4En8l
	fCYAKQ0i2+CSGUkJTZwT431doci70rwDOwTeXaazZ
X-Gm-Gg: AfdE7cmBnZGfTRtYtQrkvqz3+ijRAFor/dirLPUw8kwfZw9fn9XekfVxoLYZepu6hcD
	ssfjkq9lTcJP4HCP24TZrPeyF0HOujCiVF89v9RCWzIP5kT7mD+MKikG+ebzUYjZsZgmxjM5hqR
	aSrIZCx7YWtX1FOakn2W3mmBgS8rYFIYAHrcHye1U4gKQbSJGFeEdBD3TyBr2Z6vHErDo0PLbxk
	ljBO2tDfA6qy2gj1EUz4GgHPUR9J3No3SfyRsUE+eD+Solep+DIzZkq0/JziNLPmQJD1Lsl
X-Received: by 2002:a17:903:2ac4:b0:2c6:90ec:f601 with SMTP id
 d9443c01a7336-2ccea36a13bmr75441305ad.8.1783602251063; Thu, 09 Jul 2026
 06:04:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3d4fe99cd1665a1be0b36636aeeaf4ab@paul-moore.com> <20260709.kaemaiTia6Li@digikod.net>
In-Reply-To: <20260709.kaemaiTia6Li@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 9 Jul 2026 09:03:58 -0400
X-Gm-Features: AVVi8CdnZei5xXRKKtGuYRW9Q1XI6Otbura1DuRw3rfdDThUQwQ7WOp0MyzhV0s
Message-ID: <CAHC9VhSVQ0MLwU=C90FmohAThwaQj-mfB7L03fvkB5A0-J2jCg@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] security: add LSM blob and hooks for namespaces
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Daniel Durning <danieldurning.work@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Justin Suess <utilityemal77@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 5:12=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Wed, Jul 08, 2026 at 11:22:17PM -0400, Paul Moore wrote:
> > On May 27, 2026 =3D?UTF-8?q?Micka=3DC3=3DABl=3D20Sala=3DC3=3DBCn?=3D <m=
ic@digikod.net> wrote:
> > >
> > > All namespace types now share the same ns_common infrastructure. Exte=
nd
> > > this to include a security blob so LSMs can start managing namespaces
> > > uniformly without having to add one-off hooks or security fields to
> > > every individual namespace type.

...

> > > @@ -91,7 +103,10 @@ int __ns_common_init(struct ns_common *ns, u32 ns=
_type, const struct proc_ns_ope
> > >
> > >  void __ns_common_free(struct ns_common *ns)
> > >  {
> > > -   proc_free_inum(ns->inum);
> > > +   security_namespace_free(ns);
> > > +
> > > +   if (ns->inum > MNT_NS_INO_SPECIAL_MAX)
> > > +           proc_free_inum(ns->inum);
> >
> > The ns->inum check in the if-conditional above isn't quite the same as
> > the is_anon_ns() check it replaces in free_mnt_ns().  You touch on this
> > a bit in the changelog, but that really should be explained in the
> > commit description.
> >
> > ... or honestly, should that change be a separate patch?
>
> I think it's fine, but it's Christian's patch, so I'll let him answer
> and propose a new commit description.

I don't have a strong opinion on either approach, either a separate
patch or doc update, but one of the two needs to happen.

> > > diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> > > index d9d3d5973bf5..0f1b208d8eef 100644
> > > --- a/kernel/nsproxy.c
> > > +++ b/kernel/nsproxy.c
> > > @@ -385,6 +385,12 @@ static int prepare_nsset(unsigned flags, struct =
nsset *nsset)
> > >
> > >  static inline int validate_ns(struct nsset *nsset, struct ns_common =
*ns)
> > >  {
> > > +   int ret;
> > > +
> > > +   ret =3D security_namespace_install(nsset, ns);
> > > +   if (ret)
> > > +           return ret;
> > > +
> > >     return ns->ops->install(nsset, ns);
> > >  }
> >
> > In the previous revision to the patchset I asked about a
> > security_namespace_switch() hook as we don't know if a namespace is
> > actually attached to a process until we get to switch_task_namespaces()=
.
> > Perhaps that was answered, but I don't recall reading any mail about th=
at
> > and I'm not able to uncover any responses on lore.
>
> From the cover letter:
>
>   no security_namespace_switch() post-hook is
>   added in this series: such a hook would only serve LSMs that maintain
>   per-task state derived from the active namespace set (SELinux-style
>   state tracking), and no current LSM (including this series) needs that.
>   Landlock enforces at namespace_install() and namespace_init(), before
>   the task-to-nsproxy switch.  The hook is left for a separate LSM
>   infrastructure proposal once a concrete user emerges.
>
> This follows the guidance of adding new hooks: there must be at least
> one user.

I'm aware of the new hook guidance, I was the one who documented it :)

In the future, it's both helpful and polite to reply to the email
asking the question with your response.  Adding it to the cover letter
is fine, but to be perfectly honest, once we get past v1 of a
patchset, I don't often read the cover letter very closely unless
there is a significant change.  However, I do look back at the
previous posting to ensure all the feedback from everyone has been
either answered or incorporated into the current revision.

--=20
paul-moore.com
