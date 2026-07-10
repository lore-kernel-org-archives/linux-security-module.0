Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6EA331ECA;
	Fri, 10 Jul 2026 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783666528; cv=none; b=O/lq4fXH2ACzy0zzv+aQz1UzPALi4QHrWnhByw9Af5WWkXno5iJP6GkHLddEoMubqDjn8UMUuJ0hcAZafcW+wwLMDj+XWMowIZC2fHYQl1d3kos7P0h+/jte+RK3/K/KS2UIrlLAdQ4K0HBUYiuULOpg90q1qyvd8vaejF9Yau0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783666528; c=relaxed/simple;
	bh=TGzD8JAox5ALaaLNKUrnk755zePD2TNWVP4GSkcX3xE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=iMBtiQQUKjSKltuzS6c3Mq6q1be07JJPaZ47CuCU0GlaN+Cj3TKx8IpMctF6tJM+wkn70le5KMJp6Q6sgsWT5wldy8ZhyxMWjrE3AT/Z322EgkQCrZ+Ay67u+H495BBCAGLYC3N+5RkwwY9anqfKw9o+4sLpeUWisEFFGxoMrd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzjT/IaZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzjT/IaZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA42E1F000E9;
	Fri, 10 Jul 2026 06:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783666527;
	bh=YWt8ZJ7BRPWlSw3Gxdok+/xV06Xi+OMC4Vy9OibbcNw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=fzjT/IaZoIAeiTyPEmNqwofnH9a4pGENVOSCChn3dCORPnV0bLeqG4oK3VQWxZQEd
	 GJFqGVRAVk8/JVgZxsF8/u69kKzY43gU92cvGaqFwxXPjazvyVFG3EeEPEwPwqDvuf
	 pXLRlkaGVgP49rjd8dVurTgJBAlKN/2qtMJA9FbYZsFtUG/p8eeFcRckZnwz18FIPQ
	 V3dGN9ul21AoBnp157VD7e9CjhFePDu12OhWjC5+alcal/wWzLeHJSS49hUyyiiWCy
	 4S6gf90gPRSKNK0RFmXBX5/XIWb3UsOgepTnZqRx6IQAyjNqS0YR5Sg8kI0djoRgDK
	 UFolkgvHsf1Kw==
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/9] security: add LSM blob and hooks for namespaces
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 "Serge E . Hallyn" <serge@hallyn.com>, 
 Daniel Durning <danieldurning.work@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Justin Suess <utilityemal77@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, 
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
 Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, 
 kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20260709.paitheut7Ief@digikod.net>
References: <3d4fe99cd1665a1be0b36636aeeaf4ab@paul-moore.com>
 <20260709.kaemaiTia6Li@digikod.net>
 <CAHC9VhSVQ0MLwU=C90FmohAThwaQj-mfB7L03fvkB5A0-J2jCg@mail.gmail.com>
 <20260709.paitheut7Ief@digikod.net>
Date: Fri, 10 Jul 2026 08:55:21 +0200
Message-Id: <20260710-sardinen-zinken-aerodynamik-8b09dafc60a2@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1785; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TGzD8JAox5ALaaLNKUrnk755zePD2TNWVP4GSkcX3xE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQFTI/mv/a7iD9rQdRb9X69T7P0Fcp4fnQ1u+7pnfv43
 L2Ta9qWdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkloXhN8uCSYbbVv39/3lR
 qsDRngvxIbs4Sy5+Kl65J1mqoLZjQggjwx8l1g/TLJy23BbQL47iu+Rb93rqm4bIJMbYOcqbBHQ
 imAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-09 17:58 +0200, Mickaël Salaün wrote:
> On Thu, Jul 09, 2026 at 09:03:58AM -0400, Paul Moore wrote:
> > On Thu, Jul 9, 2026 at 5:12 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > On Wed, Jul 08, 2026 at 11:22:17PM -0400, Paul Moore wrote:
> > > > On May 27, 2026 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> > > > >
> > > > > All namespace types now share the same ns_common infrastructure. Extend
> > > > > this to include a security blob so LSMs can start managing namespaces
> > > > > uniformly without having to add one-off hooks or security fields to
> > > > > every individual namespace type.
> > 
> > ...
> > 
> > > > > @@ -91,7 +103,10 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
> > > > >
> > > > >  void __ns_common_free(struct ns_common *ns)
> > > > >  {
> > > > > -   proc_free_inum(ns->inum);
> > > > > +   security_namespace_free(ns);
> > > > > +
> > > > > +   if (ns->inum > MNT_NS_INO_SPECIAL_MAX)
> > > > > +           proc_free_inum(ns->inum);
> > > >
> > > > The ns->inum check in the if-conditional above isn't quite the same as
> > > > the is_anon_ns() check it replaces in free_mnt_ns().  You touch on this
> > > > a bit in the changelog, but that really should be explained in the
> > > > commit description.
> > > >
> > > > ... or honestly, should that change be a separate patch?
> > >
> > > I think it's fine, but it's Christian's patch, so I'll let him answer
> > > and propose a new commit description.
> > 
> > I don't have a strong opinion on either approach, either a separate
> > patch or doc update, but one of the two needs to happen.
> 
> Noted, I'll follow on this with Christian.

I think we should add this as a separate patch.

