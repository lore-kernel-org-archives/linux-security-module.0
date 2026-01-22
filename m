Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDA63D6480
	for <linux-security-module@vger.kernel.org>; Thu, 22 Jan 2026 23:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769122885; cv=none; b=LhKGz9uEw6OF1pklysaSNSMzqfiSEhuJ39w1RJh1L4rzFWCmtTRkH3gpi7x4ysOB94R7Ul6wYZ2KlvxQhYleV6cGOpII7gFweSHvycsJu66BU5ITlcFaHmDw0xsWsMFBfnXqv/r3mEaCaWtC6MDDGTWz1CLLQJwiabgmCr1kJ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769122885; c=relaxed/simple;
	bh=JlakTW/ze/YnNgpvwbDGQ4KFotr/cPC9MgSPMwySzvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXAlQBOdiGrLk3sbwzUe8Rx6/wYYRyDSo6Uu5EamiUBdRsO0C+9VCdFndffpyGjNJ+e/DI49gce1t8KaDYAxxfO4Jkxco/dHUa0rLKQennrqCh1tJqZkueUYGTUGiH7dWmtr6w7tik43aJcXYNnyZIhUeXTbrPdfzVtaplVeb9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkf1HwUi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkf1HwUi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE872C2BC87
	for <linux-security-module@vger.kernel.org>; Thu, 22 Jan 2026 23:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769122884;
	bh=JlakTW/ze/YnNgpvwbDGQ4KFotr/cPC9MgSPMwySzvw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mkf1HwUiuxyrQhz8NELuScgiYASWk+bnAhjjlgFrucJzpTrDVZmS7YvrAQMnf2Ac4
	 HqZQjEiLk0AxvGIB1hYCXmmWNVdmlllS191xz8rXKU5Is/gHVzQ9cJFqIlm9KUkAdg
	 +Su6w9bruUy+8DqzRUk3PrAhiXFSrg3zLx9cs1dx1HT4WXW/NqpZdLVhetSbdmHGM7
	 NGxQLAdnKXEbkAx6fqGohSU71a4up4jLBohpsZ9jOKPVDL8ayFJ/F5oFgr1WBy6Zb2
	 2LTnzG1s06mz+fbFoOvrN9Xd312yNIPeCta4EMWfJUT7Mlq6DhUbDgzW+AayAT1SAL
	 15L8PD/1h2aPg==
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c53198a65fso162596385a.3
        for <linux-security-module@vger.kernel.org>; Thu, 22 Jan 2026 15:01:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUseor4GDQ5Z3RoCV6suQPMKi+XYc+lIJT0eFo4m+/b0IPCtWhtfhh1cxI0vLoSf6H2IvRUZ9tnqXiW4DFZK7cgIRLXxYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZrV9lqvwggwZ/XnQzVWuSD66PWkbl9K2V1o4msshHNe+aduQ
	9F8eSaH1EG8g5fWOI0PP403vCYC/K259njCF9VwHnyob5P7GnL1KQe6vCVAHw9yjGvkvqd0JcUn
	J/uTUL9JdIliFhEkTBVdjj91mgMnlflA=
X-Received: by 2002:a05:620a:2a0e:b0:8ba:3d82:de2d with SMTP id
 af79cd13be357-8c6e2e46e4dmr139790485a.67.1769122884014; Thu, 22 Jan 2026
 15:01:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW4=heDwYEkmRzSnLHDdW=da71qDd1KqUj9sYUOT5uOx3w@mail.gmail.com>
 <CAHC9VhRU_vtN4oXHVuT4Tt=WFP=4FrKc=i8t=xDz+bamUG7r6g@mail.gmail.com>
 <CAPhsuW6vCrN=k6xEuPf+tJr6ikH_RwfyaU_Q9DvGg2r2U9y+UA@mail.gmail.com> <94bf50cb-cea7-48c1-9f88-073c969eb211@schaufler-ca.com>
In-Reply-To: <94bf50cb-cea7-48c1-9f88-073c969eb211@schaufler-ca.com>
From: Song Liu <song@kernel.org>
Date: Thu, 22 Jan 2026 15:01:12 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7xi+PP9OnkpBoh96aQyf3C82S1cZY4NJro-FKp0i719Q@mail.gmail.com>
X-Gm-Features: AZwV_Qiqf6sZ_iabxA0mOK3Vfx-ioabvz7MRCMIvXr74zxqrJAA79152HUibatg
Message-ID: <CAPhsuW7xi+PP9OnkpBoh96aQyf3C82S1cZY4NJro-FKp0i719Q@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Refactor LSM hooks for VFS mount operations
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, lsf-pc@lists.linux-foundation.org, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Casey,

Thanks for your comments!

On Thu, Jan 22, 2026 at 9:16=E2=80=AFAM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 1/21/2026 7:00 PM, Song Liu wrote:
> > Hi Paul,
> >
> > On Wed, Jan 21, 2026 at 4:14=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >> On Wed, Jan 21, 2026 at 4:18=E2=80=AFPM Song Liu <song@kernel.org> wro=
te:
> >>> Current LSM hooks do not have good coverage for VFS mount operations.
> >>> Specifically, there are the following issues (and maybe more..):
> >> I don't recall LSM folks normally being invited to LSFMMBPF so it
> >> seems like this would be a poor forum to discuss LSM hooks.
> > Agreed this might not be the best forum to discuss LSM hooks.
> > However, I am not aware of a better forum for in person discussions.
> >
> > AFAICT, in-tree LSMs have straightforward logics around mount
> > monitoring. As long as we get these logic translated properly, I
> > don't expect much controversy with in-tree LSMs.
>
> The existing mount hooks can't handle multiple LSMs that provide
> mount options. Fixing this has proven non-trivial.

Could you please share more information about this issue?

> Changes to LSM
> hooks have to be discussed on the LSM email list, regardless of how
> little impact it seems they might have.

I don't think we're gonna ship anything without thorough discussions in
the mailing list.

Thanks,
Song
