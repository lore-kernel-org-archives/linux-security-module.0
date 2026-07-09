Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553711A6805
	for <linux-security-module@vger.kernel.org>; Thu,  9 Jul 2026 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612735; cv=none; b=h+WnE9PZAPY9FUnAie37gy9evxwRKWDzspXpl20XLnlFa6W34Fntw+2PVi39bXYk6XzKNpLMefyR+FeDMc7Vz0H08+9w5MQjbC8vr3KBPmiabK9w1Zb3UxczBrY4jD1hcjA3apPUe0Jknti9K6zoCcW12iBGr/P8ZsB2yNXLhQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612735; c=relaxed/simple;
	bh=WLMCSNzgVya1yeI6VB6MkC7/cWl4E3NA6H2zOiNlt34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxPgAA2Lvca6zo6FTcbLT6L7s7CLvAQ7ImlqmY21fBxWdvkssB8951KQ+aQBMw61Ybwm21llgm2d9KtgPYBnrKgOjoiQGGmhIZ6viwe3G9SHKOYTYiYVVA3+mFQW/qzX0xXGHiJDXTVXKFLxDvVX1REC5wU/bmJ51LPixG86Phg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=UcKgIg2O; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="UcKgIg2O"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gx04p3WYBzCtM;
	Thu,  9 Jul 2026 17:58:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1783612730;
	bh=D/YfQO1l9+oQRMO6pfoOvhmNceuKQjV5WSxJDG7oUXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UcKgIg2OSQGCZaU15LNI14ytZFUzBtCTaHSLuzhFoVoSLELIpHIKmTWBYZUR3UW2+
	 EaQjuaB1ss7KuBuDX7hMFHhWj+qIsCAdPpf9a3mUYr6XlivQTjd3z5z40oSxf6Llsm
	 X/uumWaE9Yd8irkRkmX2JcbZ078bT/tyYaHmM2kA=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gx04m3St2zBWK;
	Thu,  9 Jul 2026 17:58:48 +0200 (CEST)
Date: Thu, 9 Jul 2026 17:58:44 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Daniel Durning <danieldurning.work@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Justin Suess <utilityemal77@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/9] security: add LSM blob and hooks for namespaces
Message-ID: <20260709.paitheut7Ief@digikod.net>
References: <3d4fe99cd1665a1be0b36636aeeaf4ab@paul-moore.com>
 <20260709.kaemaiTia6Li@digikod.net>
 <CAHC9VhSVQ0MLwU=C90FmohAThwaQj-mfB7L03fvkB5A0-J2jCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSVQ0MLwU=C90FmohAThwaQj-mfB7L03fvkB5A0-J2jCg@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Jul 09, 2026 at 09:03:58AM -0400, Paul Moore wrote:
> On Thu, Jul 9, 2026 at 5:12 AM Mickaël Salaün <mic@digikod.net> wrote:
> > On Wed, Jul 08, 2026 at 11:22:17PM -0400, Paul Moore wrote:
> > > On May 27, 2026 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> > > >
> > > > All namespace types now share the same ns_common infrastructure. Extend
> > > > this to include a security blob so LSMs can start managing namespaces
> > > > uniformly without having to add one-off hooks or security fields to
> > > > every individual namespace type.
> 
> ...
> 
> > > > @@ -91,7 +103,10 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
> > > >
> > > >  void __ns_common_free(struct ns_common *ns)
> > > >  {
> > > > -   proc_free_inum(ns->inum);
> > > > +   security_namespace_free(ns);
> > > > +
> > > > +   if (ns->inum > MNT_NS_INO_SPECIAL_MAX)
> > > > +           proc_free_inum(ns->inum);
> > >
> > > The ns->inum check in the if-conditional above isn't quite the same as
> > > the is_anon_ns() check it replaces in free_mnt_ns().  You touch on this
> > > a bit in the changelog, but that really should be explained in the
> > > commit description.
> > >
> > > ... or honestly, should that change be a separate patch?
> >
> > I think it's fine, but it's Christian's patch, so I'll let him answer
> > and propose a new commit description.
> 
> I don't have a strong opinion on either approach, either a separate
> patch or doc update, but one of the two needs to happen.

Noted, I'll follow on this with Christian.

> 
> > > > diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> > > > index d9d3d5973bf5..0f1b208d8eef 100644
> > > > --- a/kernel/nsproxy.c
> > > > +++ b/kernel/nsproxy.c
> > > > @@ -385,6 +385,12 @@ static int prepare_nsset(unsigned flags, struct nsset *nsset)
> > > >
> > > >  static inline int validate_ns(struct nsset *nsset, struct ns_common *ns)
> > > >  {
> > > > +   int ret;
> > > > +
> > > > +   ret = security_namespace_install(nsset, ns);
> > > > +   if (ret)
> > > > +           return ret;
> > > > +
> > > >     return ns->ops->install(nsset, ns);
> > > >  }
> > >
> > > In the previous revision to the patchset I asked about a
> > > security_namespace_switch() hook as we don't know if a namespace is
> > > actually attached to a process until we get to switch_task_namespaces().
> > > Perhaps that was answered, but I don't recall reading any mail about that
> > > and I'm not able to uncover any responses on lore.
> >
> > From the cover letter:
> >
> >   no security_namespace_switch() post-hook is
> >   added in this series: such a hook would only serve LSMs that maintain
> >   per-task state derived from the active namespace set (SELinux-style
> >   state tracking), and no current LSM (including this series) needs that.
> >   Landlock enforces at namespace_install() and namespace_init(), before
> >   the task-to-nsproxy switch.  The hook is left for a separate LSM
> >   infrastructure proposal once a concrete user emerges.
> >
> > This follows the guidance of adding new hooks: there must be at least
> > one user.
> 
> I'm aware of the new hook guidance, I was the one who documented it :)

I know.  I guess that means you're ok with that?

> 
> In the future, it's both helpful and polite to reply to the email
> asking the question with your response.  Adding it to the cover letter
> is fine, but to be perfectly honest, once we get past v1 of a
> patchset, I don't often read the cover letter very closely unless
> there is a significant change.  However, I do look back at the
> previous posting to ensure all the feedback from everyone has been
> either answered or incorporated into the current revision.

I forgot to reply to your email, I didn't mean to be impolite, sorry for
the inconvenience.  It's useful to know that the cover letter is not
always part of your review process.
