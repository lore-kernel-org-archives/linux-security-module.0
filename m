Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFA941A937
	for <linux-security-module@vger.kernel.org>; Fri, 24 Jul 2026 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885110; cv=none; b=RMO+8528NP/x/SPmKygenJCCivmyItvJG3iT4TcL22SULS2lEeDOBWmHc8MG+c48xtf/4i4dYRuauPPZ/ldauJn2wgBGJ4JYl9ISPU2d1pJ39crMVxdfDwYaAU5Ld3TzSTyX5G/nPZx0ds/qmTRPa4FUfp0fiVHd+igRzO0j8OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885110; c=relaxed/simple;
	bh=33DWjaLmnQ+QtzMXYVrJLqUCgqvXz9AGWm4fZ3r5IKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOg9e3XIr2djPFALQcMgchh4yQTakyyKcAojEEkjFTznnZuXN4vBF+S/AZpQOG+rja07vTPI/kLBAHATLWxdXJ4PWL5lVdsuiNUhdhd7h0guAWhRJ96BV2LVtM4xeAQQ8ImUO26PM+XdeYL0IOGcx9VrXDYP88woBXKuGyCCST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=HsRMnk+z; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="HsRMnk+z"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h62dK1MJtz5TZ;
	Fri, 24 Jul 2026 11:24:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1784885092;
	bh=yuwKNAEajx+q7KnkeSjLMv+Ykc3LFaQt+lXtpMj6hOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HsRMnk+zfkHoA2i9w2vzlYqTJkow/LSsf0uSJDWUUSiPBGY6CoC4sE5PF6esRB1IB
	 7wHQ6LoSir6ZbwggHmMXTUy5t0mXfuB6OIsXcVDd7aZt9lLcjysvJEkv5seYcaRWwq
	 KpMI6sm/t5BN5sKHbHV/JdCNO7FYIJofcXTcGqxM=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h62dH2mVszrSP;
	Fri, 24 Jul 2026 11:24:51 +0200 (CEST)
Date: Fri, 24 Jul 2026 11:24:46 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Daniel Durning <danieldurning.work@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Justin Suess <utilityemal77@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/9] security: add LSM blob and hooks for namespaces
Message-ID: <20260724.che1quaiPhee@digikod.net>
References: <3d4fe99cd1665a1be0b36636aeeaf4ab@paul-moore.com>
 <20260709.kaemaiTia6Li@digikod.net>
 <CAHC9VhSVQ0MLwU=C90FmohAThwaQj-mfB7L03fvkB5A0-J2jCg@mail.gmail.com>
 <20260709.paitheut7Ief@digikod.net>
 <20260710-sardinen-zinken-aerodynamik-8b09dafc60a2@brauner>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710-sardinen-zinken-aerodynamik-8b09dafc60a2@brauner>
X-Infomaniak-Routing: alpha

On Fri, Jul 10, 2026 at 08:55:21AM +0200, Christian Brauner wrote:
> On 2026-07-09 17:58 +0200, Mickaël Salaün wrote:
> > On Thu, Jul 09, 2026 at 09:03:58AM -0400, Paul Moore wrote:
> > > On Thu, Jul 9, 2026 at 5:12 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > > On Wed, Jul 08, 2026 at 11:22:17PM -0400, Paul Moore wrote:
> > > > > On May 27, 2026 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> > > > > >
> > > > > > All namespace types now share the same ns_common infrastructure. Extend
> > > > > > this to include a security blob so LSMs can start managing namespaces
> > > > > > uniformly without having to add one-off hooks or security fields to
> > > > > > every individual namespace type.
> > > 
> > > ...
> > > 
> > > > > > @@ -91,7 +103,10 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
> > > > > >
> > > > > >  void __ns_common_free(struct ns_common *ns)
> > > > > >  {
> > > > > > -   proc_free_inum(ns->inum);
> > > > > > +   security_namespace_free(ns);
> > > > > > +
> > > > > > +   if (ns->inum > MNT_NS_INO_SPECIAL_MAX)
> > > > > > +           proc_free_inum(ns->inum);
> > > > >
> > > > > The ns->inum check in the if-conditional above isn't quite the same as
> > > > > the is_anon_ns() check it replaces in free_mnt_ns().  You touch on this
> > > > > a bit in the changelog, but that really should be explained in the
> > > > > commit description.
> > > > >
> > > > > ... or honestly, should that change be a separate patch?
> > > >
> > > > I think it's fine, but it's Christian's patch, so I'll let him answer
> > > > and propose a new commit description.
> > > 
> > > I don't have a strong opinion on either approach, either a separate
> > > patch or doc update, but one of the two needs to happen.
> > 
> > Noted, I'll follow on this with Christian.
> 
> I think we should add this as a separate patch.

Ok, I wrote this patch and I'll sent it with v3.
