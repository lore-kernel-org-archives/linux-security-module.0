Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9C71A6807
	for <linux-security-module@vger.kernel.org>; Sat, 21 Mar 2026 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774084194; cv=none; b=JgApRshBSwO0OyG8eMOP4gDJZlOIUcBatqblJnJ1/Tx1cXPuQ8wr2cR6NCTEFn2dD8Y2e1V6s5zmbGeXThmkTn5aXh5LRCsrtElFFPVlQT2SSJEwVc0IHEZpaBCzwVFBKL2D2eekfraGweC7o+WcSvnYq69hh9NbT35MQNvpXLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774084194; c=relaxed/simple;
	bh=LUPp8whwSfGTu6LtsmNNwA8zpxZ1/e3qu+SUWPurZF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwQg/qLExGkaK1IkBng+4Z0QVlNMbQGUQHYPuf7Pb2V6MUf28LwJuO7365xBml6HWZsX+28N6Bi8KFOdL/kvOKC3D2CQ+jkcP3p3FfEzwckt4I/KDJ3mqjaM7XZF+Nt96M4MmoDHZ/iT4znqq0sAdD/mNdEr5k9aj0DL7Ckrqus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=UKogouu1; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="UKogouu1"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fdDCT5WKDztGW;
	Sat, 21 Mar 2026 10:09:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1774084181;
	bh=dluNRpCdS0X5VEFdRp5D6xWdIaxz6Nw8rKsdwlTlHwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UKogouu1drPlhL80fBTsLXkuFDkW5eDMhwGZz9VhweqWH/7uKOShTwfFnPbGWw24S
	 6nov3Fu5TvxJ0AYY0FLJd6Z/9dJPbIXEKLT+maWQmXp/cjI8u2tkygznmFeFfbQPwk
	 IU6THLEAy+BjioPaZSWFiT/Zb8kpboA2FeWmFFTo=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fdDCS2ZrNzVXl;
	Sat, 21 Mar 2026 10:09:40 +0100 (CET)
Date: Sat, 21 Mar 2026 10:09:35 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v6 3/9] landlock: Control pathname UNIX domain socket
 resolution by path
Message-ID: <20260321.Aiquah5gaedo@digikod.net>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
 <20260315222150.121952-4-gnoack3000@gmail.com>
 <20260318.peecoo2Ooyep@digikod.net>
 <20260320.f59cddcb6c6b@gnoack.org>
 <20260320.eez3sheeThul@digikod.net>
 <20260320.ee35c8125f6f@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260320.ee35c8125f6f@gnoack.org>
X-Infomaniak-Routing: alpha

On Fri, Mar 20, 2026 at 11:25:04PM +0100, Günther Noack wrote:
> On Fri, Mar 20, 2026 at 06:51:13PM +0100, Mickaël Salaün wrote:
> > On Fri, Mar 20, 2026 at 05:15:40PM +0100, Günther Noack wrote:
> > > On Wed, Mar 18, 2026 at 05:52:48PM +0100, Mickaël Salaün wrote:
> > > > On Sun, Mar 15, 2026 at 11:21:44PM +0100, Günther Noack wrote:
> > > > > + * @client: Client domain
> > > > > + * @server: Server domain
> > > > > + * @masks: Layer access masks to unmask
> > > > > + * @access: Access bit that controls scoping
> > > > > + */
> > > > > +static void unmask_scoped_access(const struct landlock_ruleset *const client,
> > > > > +				 const struct landlock_ruleset *const server,
> > > > > +				 struct layer_access_masks *const masks,
> > > > > +				 const access_mask_t access)
> > > > > +{
> > > > > +	int client_layer, server_layer;
> > > > > +	const struct landlock_hierarchy *client_walker, *server_walker;
> > > > > +
> > > > > +	/* This should not happen. */
> > > > > +	if (WARN_ON_ONCE(!client))
> > > > > +		return;
> > > > > +
> > > > > +	/* Server has no Landlock domain; nothing to clear. */
> > > > > +	if (!server)
> > > > > +		return;
> > > > > +
> > > > 
> > > > Please also copy the BUILD_BUG_ON() from domain_is_scoped().
> > > 
> > > I don't understand what this check is good for.  It says:
> > > 
> > > /*
> > >  * client_layer must be a signed integer with greater capacity
> > >  * than client->num_layers to ensure the following loop stops.
> > >  */
> > > BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));
> > > 
> > > For the loop to terminate, in my understanding, client_layer must be
> > > able to store client->num_layers - 1 down to - 1, but that is anyway a
> > > given since num_layers can't exceed 16 and client_layer is signed.  It
> > > seems that the termination of this would anyway be caught in our tests
> > > as well?
> > > 
> > > Could you please clarify what this BUILD_BUG_ON() is trying to assert?
> > 
> > The intent was to make sure client_layer is indeed an int and not an
> > unsigned int for instance.  Hopefully tests catch that but using a
> > build-time assert catch the potential issue and document it.  Also, it
> > would be weird to not have the same checks in both copies of code.
> 
> It isn't clear to me why the BUILD_BUG_ON is checking based on the
> sizeof() of these variables then.  The number of bytes in an integer
> type is independent of its signedness, after all.  Should we rather do
> this maybe?
> 
>   /*
>    * client_layer must be a signed integer to ensure the following
>    * loop stops.
>    */
>   BUILD_BUG_ON(!is_signed_type(typeof(client_layer)));

I didn't know about this macro, looks good.

> 
> (Although that is also a bit of a triviality given that the same
> variable is being defined as a signed integer just a few lines above,
> but at least it is very explicit about it.)

Yeah, I know, but I added this canary check because I was bitten by a
bug.  Even if it might be trivial now, it might help when working on
other parts, and it's just a build-time check that also serves as doc.
If in doubt, let's keep build-time checks that were most likely added
for a good reason.  I prefer to have build-time errors than run-time
ones.

> 
> I'd drop the remark about the capacity, as even a signed 8-bit integer
> is large enough to hold the layer indices and the -1.

Large enough for now...  All these checks are useful to easily spot
issues if/when the current invariant change (e.g. if one day we extend
the number of max layers).  Integer C types can silently cast to other
integer types (with different capacity or sign/unsigned), which might be
the source of bugs.  So yeah, please keep the current capacity check and
add the sign one, it won't do any harm.

> 
> Does that sound reasonable?  I can do it in the other function as well
> if you want to keep things consistent.

Yes, please update the other function as well.
