Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547A73148D3
	for <linux-security-module@vger.kernel.org>; Wed,  1 Jul 2026 21:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782941317; cv=none; b=Nn/2/E4clmdNEcpLTbOx9IBdxL8ULwiVarAVQM7u0uDdpsZ9MbFA55LkQtGzrszmoV5c9xU21v9Ik8ezMY84XKCTy04vWZHqvb4Hmc2LWQxmCl6Uv39zaEloP9X5XElzEwOGDbE6SiSuf1Di6yBnHlW6XOW2moym6G9OJVQupVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782941317; c=relaxed/simple;
	bh=dEUQ/Da4pnHSP+0kKQfjko+As5IBIzmfVYTAQX1pVGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLcf0Q0Rlucs7ReQqj935XSriLqQXNaIpa+3OF++2D/3HRnhONTlUOUVGcXiegBFaV4XOMOWsNkeVi9lvx0f9DOHDeFQzksisbkEi3ThCMT2RZSIlspBQGMQBQFj+CMBwIxm78uHI+Jmv40TuAzDyB3OdXp/J/S05/p1M0QjWsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=YaVpezl/; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="YaVpezl/"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4grCmv1mDXzqCB;
	Wed,  1 Jul 2026 23:28:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1782941310;
	bh=uEr+QVQeNz6rhGt+Xh1nDbaglruQNgz7HzPlQsT/wx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YaVpezl/MXVw4rgS5ZDf2j/f+HKwXxX0FIc71LGZtebEnxYZi1n/aa0wgtoSryoXL
	 2BagYaGSuf/1vNOjbVImqwR/Ww4DrGm28mN0H7ZvtfefUS+2j7tXbsqA8NrN6SLErq
	 GtyXKpC0TWSDiICtNMRwZzwtXRH+OVi6tqHPg3LU=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4grCms1yvNzmY7;
	Wed,  1 Jul 2026 23:28:29 +0200 (CEST)
Date: Wed, 1 Jul 2026 23:28:25 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Justin Suess <utilityemal77@gmail.com>, ast@kernel.org, 
	daniel@iogearbox.net, kpsingh@kernel.org, john.fastabend@gmail.com, andrii@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, gnoack@google.com, 
	jack@suse.cz, jmorris@namei.org, serge@hallyn.com, song@kernel.org, 
	yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, eddyz87@gmail.com, 
	sdf@fomichev.me, skhan@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Frederick Lawler <fred@cloudflare.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
Message-ID: <20260701.aeghohNoe3ek@digikod.net>
References: <20260407200157.3874806-7-utilityemal77@gmail.com>
 <20260701.ze4eph1eKo7a@digikod.net>
 <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>
 <akUH13qbsEnJLgQu@zenbox>
 <CAHC9VhSjRcMr9+5dMkep_TPKduYdob-bZ73FLfXd_o2xiWwOSg@mail.gmail.com>
 <20260701.jei4Paej3zen@digikod.net>
 <CAHC9VhRzZVUz8icZ2RD9OVvscJdZW3ivPERJLEkNi5poBeguxw@mail.gmail.com>
 <20260701.oTeikequi3ee@digikod.net>
 <akVvkA3kmlv_POsF@zenbox>
 <CAHC9VhTQtHPFGqu58EaFqMobV3LCcTsdzYfxy568P8mU769TMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTQtHPFGqu58EaFqMobV3LCcTsdzYfxy568P8mU769TMg@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Jul 01, 2026 at 04:02:36PM -0400, Paul Moore wrote:
> On Wed, Jul 1, 2026 at 3:55 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > On Wed, Jul 01, 2026 at 09:49:07PM +0200, Mickaël Salaün wrote:
> > > On Wed, Jul 01, 2026 at 02:38:08PM -0400, Paul Moore wrote:
> > > > On Wed, Jul 1, 2026 at 2:34 PM Mickaël Salaün <mic@digikod.net> wrote:
> > > > > On Wed, Jul 01, 2026 at 09:28:22AM -0400, Paul Moore wrote:
> > > > > > On Wed, Jul 1, 2026 at 8:52 AM Justin Suess <utilityemal77@gmail.com> wrote:
> > > > > > > On Wed, Jul 01, 2026 at 08:12:34AM -0400, Paul Moore wrote:
> > > > > > > > On Wed, Jul 1, 2026 at 6:59 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > > > > > > > On Tue, Apr 07, 2026 at 04:01:28PM -0400, Justin Suess wrote:
> > > > > > > > > > Create 2 kfuncs exposing control over Landlock functionality to BPF
> > > > > > > > > > callers. Export an opaque struct bpf_landlock_ruleset preventing callers
> > > > > > > > > > from accessing unstable internal Landlock fields.
> > > > > > > >
> > > > > > > > Generally speaking we don't want to provide APIs, either in-kernel or
> > > > > > > > at the userspace/kernel boundary, that are specific to a single LSM,
> > > > > > > > see the LSM syscalls or the security_current_getlsmprop_subj()
> > > > > > > > function as examples.
> > > > >
> > > > > This patch series is not about the LSM framework, only about Landlock
> > > > > and its specific model and use case.  Landlock using some of the LSM API
> > > > > is not relevant here.
> > > >
> > > > Based on a quick look the patchset enables BPF programs to call
> > > > directly into Landlock.  For the same reason we discourage other parts
> > > > of the kernel to call directly into individual LSMs, we want to
> > > > discourage BPF programs from calling directly into individual LSMs.
> > >
> > > We're OK for a dedicated kfunc to call directly into Landlock (with a
> > > tailored interface).  Landlock is designed around its syscall interfaces
> > > (well documented, tailored, tested), and this would be a new user of
> > > almost the same UAPI.
> >
> > Paul, Mickaël,
> >
> > I think there's a cleaner way to resolve this.
> >
> > First, walking back my earlier email: I was wrong saying that we need to call
> > into security/security.c to check whether Landlock is enabled. Landlock's
> > init only runs when it's in the active lsm= list, so I can just test
> > landlock_initialized directly. There's no per-invocation reason to route
> > through the LSM framework for that.
> 
> The landlock_initialized flag is not really a LSM framework API, that
> is still Landlock specific which is something we try hard to avoid.
> 
> > Rather than routing each kfunc *invocation* through a security/security.c
> > wrapper, I think the right place for the framework to be involved is
> > *registration*: have the LSM framework own registration of an LSM's
> > kfunc sets, e.g.
> >
> >     int security_register_lsm_kfunc_set(u64 lsm_id, enum bpf_prog_type type,
> >                                         const struct btf_kfunc_id_set *kset);
> 
> That implies a set of LSM kfunc APIs which Alexei has been deadset
> against (see other ongoing threads).
> 
> > Each LSM calls this once to register its sets. Because registration goes
> > through the framework, the framework gets to decide whether to actually
> > register them so you could, for example, run an LSM while explicitly
> > opting its BPF kfuncs out. (something that should be done at the LSM
> > framework level).
> 
> I'm not opposed to the LSM supporting a set of kfuncs, see my comments
> in other threads, but we should treat these kfuncs just as we treat
> other LSM hooks today because that is what they are: LSM hooks that
> happened to be called from within a BPF program.

What an LSM hook is or should be is the crux of the misunderstanding.  I
explained my point of view here:
https://lore.kernel.org/all/20260701.jei4Paej3zen@digikod.net/

  LSM hooks make sense because they are designed for a specific subsystem
  (the caller) and their goal is to return an access decision or to keep
  up-to-date related states, which means that their API is designed for
  the caller, with its own types and specificities, not the other way
  around.  This case is different, the kfunc is strongly typed and tied to
  the Landlock (subsystem) semantic with an API defined by and for
  Landlock.  I don't think a multiplexer would be a good idea.

I'd try to explain better: in a nutshell, an LSM hook exposes a subset
of the context of the caller, for any access control system to be able
to make a decision.  It makes sense to have such dispatcher because the
callees must adapt to the caller's context, and then the API is tailored
to the caller, so even with several consumers, the API would ultimately
be the same.  In the case of this kfunc, the callee is one specific
subsystem that happens to be Landlock.  The caller asks a specific
subsystem to do something specific to this subsystem, not to ask all
potential access control systems to give a generic verdict to grant an
access or not.  For this kfunc, the caller passes arguments which are
specific to the callee subsystem (e.g. a Landlock ruleset), not the
other way around.  Every LSM has its own configuration, and it doesn't
make sense to somehow wrap these configurations with a common layer/API.
That's the same thing here.

Why not start with something simple that fits a use case now?  If and
when another LSM will need a kfunc, then we'll have something concrete
to talk about.
