Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF882D8DD0
	for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787941719; cv=none; b=QtJv/00oKh8MnJhN+Ix/iTpxNPyNslqfkd+CYd+tSPfiZM5Abs0jjePw1SQl+HzzuucXgO1Iv7AmGGwqOg6h1vcWFmuYwoq4HB8MiVEbCPYLSQsvaMEC9GPFE3piLX1gHcm39wsmsh+8MnMM+QPQ+kYeg4hpgwOodLDJ+FqH4e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787941719; c=relaxed/simple;
	bh=aIJ3XedisAPbkx/BHNvcS+HFrCoktU7SSApXHopa3VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctQRSnLdMh/K7ylTcTCdoePjwKQjGTQS7tB+bMjGfkpQqPv4gbIQEgfMOQvbxYcqBwIRFrh3M5s4f9ax3L2zwAO9/AZLDTTjl0Pxlebup3/fLYgu8ltjNzhnrLr+8yU7PkajYHlDC5Kqgby9mlSYse5xV5aSsNFZ7Hq4t93Q60I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3AF+sDv; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3AF+sDv"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-85a50f6a7f7so14885087b3.2
        for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 11:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787941717; x=1788546517; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=00XcgwP2TaQwLmCHa5/Xf0oEUUJDtZf0rSmRiAN3I7M=;
        b=G3AF+sDvPKLPPpVkB20tD2xb8lHDW26GUhPmxpOW1y3N+zE4qZCBDizoQ3ywuCfbSo
         Tk1NsFTj/RBtb7fuFNciVvckX17teu7a9rlNKaz/sEqZyWQWCNnexCSkVlxfT1RiQwSU
         atsfFkR8gldbxlOKsuhEy58wW8coxErI+y9LRl5WkGiZd7EKYuthDVE6MajqIxsjzgAK
         lfNwAbWWt/QMHU+8LDLneKmGBqZD9KfJdVpO7dXa7hM0/d9otWpO/v6i+LRNhDKJVDSF
         4Q9julHqumQPxn+DpfHWKD2ZyYIbLb+CQBbdsw7TG/BwM23c1cK+Tfqo4pv6OjKfbjM4
         hITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787941717; x=1788546517;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=00XcgwP2TaQwLmCHa5/Xf0oEUUJDtZf0rSmRiAN3I7M=;
        b=CpQbACKozMIRlEQ4cvErjhjEjbXUSPs7yBngj8nY4mNCHnnefbhkep7c+LkC8X5jvI
         2auAT6CEgEgv6H+nvyq2qeagBQmc77qxMIh6c/2h3iV6qtYRWjv+IPpcJiIGWdfnYrGV
         d0W/gE0O/IOHKttLGU/VWWFL+nkQ0syci/vB87YQ+Xv4EEC6rkwmSL9WxHkFUCePKTzr
         yn/kqXU1SHxq/u7gsDxVMuCKkzobf7aQODWZ/FdVrOyOMa96Reg5ehnHe24hBeYL9K6/
         6YxPupaCq+9gCDaZsY1g1V7sniwTrcWFoMYoxneztv1BbJGLvtzGPHsHBkHGfcV312dK
         /lWA==
X-Forwarded-Encrypted: i=1; AKwUvBwVr3vnISezkcTPL0Ok78lX73v/5PKr9Ysbzk3IE1roUtbiNiRI9TD20pSmub35hwTH6WdV4gZEpIRbSn6kYUS499KNI8g=@vger.kernel.org
X-Gm-Message-State: AFuF++nY5k3c/IEzDkQw6tJtmQscUMKcL6ZHMngNE2CgkWwcnrUKwTHI
	stfUPrnwzDPi+RwT95Plr0AeXwqh1U/brof2BrGXQ/2HMX/8diSZHUmR
X-Gm-Gg: AYBFou3W7fmN000KBdY5kkCfW3PNfFEeux6FT72SsfSKfY8t1E33NtHiHEPpH3St4dq
	xhCpg9CKpbi2HlikMYJ01FSvanSNF+wtZ8Ixsj2qAj+3Gjpj6/bbm8UbaX3RMLbxY33AN6zQud4
	4RiWNky27k+CGH1gDR33SC6mnyBCjm+ZZywzhuoAsiJdlqkV/rFRXMiIusjCp1pCZY/dDdG0dRS
	lmV/Tez1HranwMsLUCPTsAw+V/e10aXmUBZJAREgxQ4wpjJubjRiJ/54eMiaBl7dfTzixdzl9nM
	eEDZDhwzsDNEQ9aGjEyp3aGLaKISIfiZh5+JEv5z45+aMRELsDrzakDyp8vOONoyZVRZAvACLlx
	BxWZTqY0Z5kZHktO84Uix127s/Y9KwjR8Db09lTZDUJ2X5IWnbkz6Kd5kyvRACevftBkRPEPFPV
	ONaORwLpTF3AV/NnEJDU8rZSGvQJGexOo3Vwrz27rj4OMdWhhqrDkDCERjZYpqrp5suLce1dJpK
	xIFWux/6+cPgjbWYlBdXyo=
X-Received: by 2002:a05:690c:e313:b0:857:f33:6f1d with SMTP id 00721157ae682-85d660d961fmr32735737b3.6.1787941717079;
        Fri, 28 Aug 2026 11:28:37 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:a21d:f263:629b:a8f0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e668ce7ecsm10420247b3.34.2026.08.28.11.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 11:28:36 -0700 (PDT)
Date: Fri, 28 Aug 2026 14:28:35 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, mic@digikod.net, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	kees@kernel.org, gnoack@google.com, jack@suse.cz, song@kernel.org, 
	yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 00/13] BPF interface for applying Landlock
 rulesets
Message-ID: <apHN2WNQWeM9lzHc@zenbox>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
 <CAHC9VhSSzNBCSvy4cQHh6OOM4-EvHF+bmrB9=V1y=Lj53RvxQQ@mail.gmail.com>
 <anOnaGmBTlBW9xwj@zenbox>
 <CAHC9VhRBYMaNBPfnV=TK8g-M7H_qsBu=CsVVOwnAzTPAkpAZaA@mail.gmail.com>
 <anPAbFzuLOizAhm-@zenbox>
 <CAHC9VhSJ1q59RUtEEMAmiZLLLi92=XO1tkd9z0fr5T7vuhoy8Q@mail.gmail.com>
 <anZIGtlHvTaidOEC@zenbox>
 <CAHC9VhQcysVLosHhuz_FTh+LUH7KSw1hJWmwucmV1G-seSbHHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQcysVLosHhuz_FTh+LUH7KSw1hJWmwucmV1G-seSbHHg@mail.gmail.com>

On Sun, Aug 09, 2026 at 03:18:21PM -0400, Paul Moore wrote:
> On Fri, Aug 7, 2026 at 6:00 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > On Fri, Aug 07, 2026 at 04:36:20PM -0400, Paul Moore wrote:
> > > On Wed, Aug 5, 2026 at 8:32 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > > > On Wed, Aug 05, 2026 at 06:51:56PM -0400, Paul Moore wrote:
> > > > > On Wed, Aug 5, 2026 at 5:37 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > > > > > On Fri, Jul 31, 2026 at 04:30:39PM -0400, Paul Moore wrote:
> > > > > > > On Thu, Jul 30, 2026 at 10:21 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > > > > > > [...]
> > > > > > > As you may, or may not have seen, there is currently an ongoing debate
> > > > > > > regarding the location of LSM kfuncs that will impact this patchset.
> > > > > > > Sadly, we don't appear to be approaching an agreement on this issue
> > > > > > > which introduces some additional risk to this patchset.  We'll have to
> > > > > > > see how that ends up, but I just wanted you to be aware of the
> > > > > > > situation.
> > > > > >
> > > > > > Quick aside question: Would security/bpf/ be a better place for these
> > > > > > type of kfuncs?
> > > > > >
> > > > > > security/bpf/bpf_lsm_kfuncs.c could be for LSM framework kfuncs,
> > > > > > and each LSM could maintain their own security/bpf/<lsm>_kfuncs.c
> > > > > > for kfuncs dealing with lsm-specific types.
> > > > >
> > > > > This gets back to the other issue in the patchset that we've
> > > > > discussed: general LSM interfaces vs Landlock specific interfaces.
> > > > > There are plenty of reasons why we don't support the kernel calling
> > > > > directly into individual LSMs, and from my perspective this is another
> > > >
> > > > I'm 100% on board with the no calling directly into individual LSMs part.
> > > >
> > > > > instance of that.  Here it just happens to be that the kernel caller
> > > > > was written in BPF and not C (or Rust for that matter).
> > > >
> > > > The intention is the opposite. The point of the separate directory is
> > > > that the kfuncs can never call into an individual LSM, they only get
> > > > the LSM framework API in <linux/security.h>.
> > > >
> > > > Every kfunc is a thin wrapper over the generic policy kptr hooks:
> > > >
> > > >     bpf_landlock_get_ruleset_from_fd()
> > > >       -> security_policy_kptr_from_fd(LSM_ID_LANDLOCK, ...)
> > > >         -> Landlock's hook implementation
> > > >
> > > > So kfunc -> generic lsm hook -> individual LSM, same as any other
> > > > caller in the kernel.
> > >
> > > Not exactly.  That "bpf_*landlock*_XXX" kfuncs are a move away from an
> > > LSM agnostic API and not something we currently do in the kernel.
> > > Some will, and have, argued that this is more akin to the Landlock
> > > syscalls, but I see (at least) two problems with that comparison: the
> > > kfuncs being presented aren't syscalls, they are cross-subsystem
> > > kernel function calls; the Landlock syscalls were created in a
> > I see the argument for normal in-tree kernel interfaces.
> >
> > Unlike normal kernel interfaces, kfuncs:
> >
> > 1. Can exist without in-tree callers.
> 
> Yes, although I'm not sure how relevant that is to our discussion.  I
> can say that it isn't relevant to my decisions.
> 
> > 2. Are explicitly allowed to change or be removed at any time [1].
> 
> FWIW, the LSM hooks can be changed or removed at any time as well.
> For obvious reasons we try to avoid churn where possible, but there
> are plenty of cases where hooks have been modified, removed,
> relocated, etc. (some without our explicit permission, but that's
> another issue for another time).
> 
> > 3. Can't break builds or other in-tree subsystems when they do.
> 
> Of course.  Rule #1 of any kernel subsystem is don't break the build :)
> 
> > This isn't hypothetical: the entire KF_KPTR_GET class
> > (bpf_task_kptr_get(), bpf_cgroup_kptr_get(), the flag itself) was
> > removed and replaced with a better abstraction within about a year
> > of introduction.
> >
> > If Landlock (or any LSM) dies, there's zero uapi/in-tree cost to
> > removing the kfuncs, unlike syscalls which are burned into the uapi
> > forever, or ones with in-tree callers where we can break builds.
> >
> > I argue that the transient, low-commitment nature of kfuncs mitigates
> > maintainability issues that arise from lsm-specific interfaces with
> > in-tree callers. (which we are both opposed to).
> 
> Sadly, the current situation between the BPF and LSM devs is not good,
> which means any discussion around LSM kfuncs has a good chance of
> turning ugly and something that should be relatively easy to maintain
> is likely to turn into a significant headache.  To be clear, this
> doesn't mean I'm opposed to LSM kfuncs, I just don't agree that they
> are "low-commitment" at this point in time or in the foreseeable
> future.
> 
> > To avoid strawman style arguments, I ask what you would see as
> > an alternative interface?
> 
> As I've mentioned a couple of times now, you need to grant me the time
> to properly review your existing patches before I can comment in
> detail on the interface.  You've been quick to post with new thoughts,
> ideas, arguments, etc., which is fine, but replying to them steals my
> time away from the very patchset you want me to review ;)
> 
> It's up to you how you want to handle things, but my suggestion would
> be to pause some of these thoughts until I've had a chance to review
> your patchset in detail; then we can have a better discussion.
>
Hi Paul,

Gonna admit I was wrong on this one. It is entirely possible to make
a generic kfunc interface for this, without it turning into an ioctl
style multiplexer either. Honestly I think it's the better design anyway.
Just took a month of staring at the code before the realization
hit me.

Since it's been about a month since the original submission, my plan is
to send a revised version based on generic kfuncs in
security/bpf_lsm_kfuncs.c, which expose no LSM-specific interface:

  bpf_lsm_policy_from_fd(fd, flags)                                   KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE
  bpf_lsm_policy_acquire(struct lsm_policy_object *)                  KF_ACQUIRE | KF_RCU | KF_RET_NULL
  bpf_lsm_policy_release(struct lsm_policy_object *)                  KF_RELEASE
  bpf_lsm_policy_apply_bprm(struct lsm_policy_object *, bprm, flags)  KF_SLEEPABLE

  struct lsm_policy_object {  /* initialized in LSM object structs */
          u64 lsmid;
          u32 type;
  };

I know I said I'd hold off on revisions until your review, so if
you're already reviewing the current set (or still plan to), just
say so and I'll sit on it. Otherwise I'd rather send the new version
than have you waste time on a stale patchset, or on making a point
you've already convinced me of.

This generic design is better, and I've already experimented with
implementing the same hooks/kfuncs for AppArmor / SELinux exec-time
transitions (possible future patchsets?). This would allow writing
LSM-agnostic BPF programs (like liblsm).

Thank you so much for your feedback Paul.

Mickäel,

I think this should address your concerns about the multiplexer
design, this avoids it handily by making the rulesets/"policy object"
self-identifying so there's no need for an opcode/lsmid parameter.
There's a small lsm_policy_struct that gets embedded in the ruleset
with the lsmid already initialized, and then the original ruleset
is retrieved via container_of.

Otherwise, the semantics of the API, the flags, and implementation
are identical to this set, with the exception that ruleset
references can be taken under RCU.

Thank you for both your time and feedback,
Justin
> -- 
> paul-moore.com
