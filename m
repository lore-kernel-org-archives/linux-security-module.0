Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75BC2D2397
	for <linux-security-module@vger.kernel.org>; Wed,  1 Jul 2026 18:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782930870; cv=none; b=I++jj4e2CK8eslg1F26zqwvHz1vZ1PL6NsaJCCPhbh0FTUKQHcrfhiwpI9nN92DSjF9eRkv/FwOGRp7+M1qyiOQQXvAHMl1dotJ7v/OcPdgoiTMc9JfT9Z0Vn0tTg6EKUsDn1qPQenGmpYJNTlsPatqHt622WCW2G8K8fniiiRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782930870; c=relaxed/simple;
	bh=gPljzWPcgFRN3dCUIqencE0tOGupLA+eutYTLhEDqCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNjvQxiYenrnVplQIhyfeyucZQuBpaiHBAnBO4XoY3CHx2rKnWNV334nYhOYu9zGpnEarK3qBZRHlGUVqDWt3JjRdyvEx54V6L4Ei4gnhvc94+OzwVAmGmXYYi8yNWhSIlLGkQDq2Nt2xWlreM4Spk7/fCtlgZkfeQHuD6rXAxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=r/Mxdlz0; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="r/Mxdlz0"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gr7vw1pkWzNjf;
	Wed,  1 Jul 2026 20:34:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1782930859;
	bh=x9zsCAel8IcUJsxPYBnz+qgLjbdveeYyNWKEwojOYs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r/Mxdlz0a7Us5BIFnbE3s3+XP2T1MgIX3hXvzNWL9HLlNtOPHneRR2LYr/lnQFy/n
	 192lggcAC//GVg6gVwY9lznXkSSIMYpDgFNtRdAF32IxwATyBce9T0Os1vFkqDoSQS
	 jilXyc8fSp2hfYnocXjbTGp5ua/iwfqeIlecLkmI=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gr7vs5SXZzHyS;
	Wed,  1 Jul 2026 20:34:17 +0200 (CEST)
Date: Wed, 1 Jul 2026 20:34:10 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>, ast@kernel.org, daniel@iogearbox.net, 
	kpsingh@kernel.org, john.fastabend@gmail.com
Cc: Justin Suess <utilityemal77@gmail.com>, andrii@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, gnoack@google.com, 
	jack@suse.cz, jmorris@namei.org, serge@hallyn.com, song@kernel.org, 
	yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, eddyz87@gmail.com, 
	sdf@fomichev.me, skhan@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Frederick Lawler <fred@cloudflare.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
Message-ID: <20260701.jei4Paej3zen@digikod.net>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-7-utilityemal77@gmail.com>
 <20260701.ze4eph1eKo7a@digikod.net>
 <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>
 <akUH13qbsEnJLgQu@zenbox>
 <CAHC9VhSjRcMr9+5dMkep_TPKduYdob-bZ73FLfXd_o2xiWwOSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSjRcMr9+5dMkep_TPKduYdob-bZ73FLfXd_o2xiWwOSg@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Jul 01, 2026 at 09:28:22AM -0400, Paul Moore wrote:
> On Wed, Jul 1, 2026 at 8:52 AM Justin Suess <utilityemal77@gmail.com> wrote:
> > On Wed, Jul 01, 2026 at 08:12:34AM -0400, Paul Moore wrote:
> > > On Wed, Jul 1, 2026 at 6:59 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > > On Tue, Apr 07, 2026 at 04:01:28PM -0400, Justin Suess wrote:
> > > > > Create 2 kfuncs exposing control over Landlock functionality to BPF
> > > > > callers. Export an opaque struct bpf_landlock_ruleset preventing callers
> > > > > from accessing unstable internal Landlock fields.
> > >
> > > Generally speaking we don't want to provide APIs, either in-kernel or
> > > at the userspace/kernel boundary, that are specific to a single LSM,
> > > see the LSM syscalls or the security_current_getlsmprop_subj()
> > > function as examples.

This patch series is not about the LSM framework, only about Landlock
and its specific model and use case.  Landlock using some of the LSM API
is not relevant here.

> >
> > I would raise bpf_ima_file_hash, bpf_ima_inode_hash, as examples of
> > clear precedence for this. (BPF calling into specific LSM)
> 
> The BPF IMA helpers were merged back in the v5.18 timeframe when IMA
> was still standalone, it wasn't until v6.9 that IMA and EVM became
> proper LSMs.
> 
> > Kfuncs are explicitly marked as not being an ABI, and are more
> > flexible for later changes / deprecation etc. [1]
> 
> The issue isn't so much the kfunc itself, it is what the kfunc
> *calls*.  From what I saw in the proposed patch, the kfunc calls
> directly into Landlock instead of passing through the LSM framework,
> e.g. a function wrapper in security/security.c.

Yes, and I'm OK for this kfunc to call directly into a new public
Landlock function.  There is no need to create a new class of LSM
wrapper.

LSM hooks make sense because they are designed for a specific subsystem
(the caller) and their goal is to return an access decision or to keep
up-to-date related states, which means that their API is designed for
the caller, with its own types and specificities, not the other way
around.  This case is different, the kfunc is strongly typed and tied to
the Landlock (subsystem) semantic with an API defined by and for
Landlock.  I don't think a multiplexer would be a good idea.

However, I agree with your layering concern, and it would make more
sense to move the Landlock-related kfuncs to security/landlock/bpf.c,
which is also the idiomatic way for subsystems to own their API.

Alexei, KP, what do you think?

> 
> > LSM framework API can mean a lot of things. I assume you are meaning
> > like a pseudo-filesystem mounted interface that controls LSM?
> > Correct me if I'm wrong.
> 
> My apologies, I should have been more clear.  When I speak about the
> "LSM framework", I'm talking about the abstraction layer that provides
> the interface that the kernel and userspace uses to talk to individual
> LSMs.  The LSM framework is analogous to the VFS layer/framework in
> that it provides a single API for a variety of underlying subsystems.
> While not 100% correct, you can think of it the LSM framework as being
> the functions/hooks defined in security/security.c.

This abstraction layer is useful and make sense for access control hooks
but it is not needed in this case, and it would only make the kfunc
interface more complex for no reason.  If any other kernel subsystem
wants to add a kfunc, I think it should be reviewed with its purpose in
mind and a well defined use case.

> 
> Does that help?

I think Justin is right, and with some minor changes this kfunc should
be good.
