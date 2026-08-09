Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F8939CD00
	for <linux-security-module@vger.kernel.org>; Sun,  9 Aug 2026 19:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786303116; cv=pass; b=HXw/AcSEHj+MR+4yP9GOkwaIPtS/opNkoJg8WMW7s6sTgzNu6RYmcvnnfknI/etBzipJfQM+BPreD+IymH8M75Hneik8VMSXhiIdA5U21XHRx4bOFJUGLPOlrkKbCKMu1OOnZ5H+59L/Ope504JYyzlGLewTW/8GtZtZABPNJVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786303116; c=relaxed/simple;
	bh=covybVQYRuNMveGTn+DW3JVfPbAlamzc8lvTIRGDf38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Erk0QlwdXRINCxgGMJwf1pphAq5Ogo/4Vmt/OR/X4UeEJPomQCAOjvx3PzGN0pVVjXjWOR9bTfNaz6PPwO7Geobtb/+AAPHUdceginZBtExquy2caw7/zVZn4Ts6sV1Fexg9gDuAWZ+cxfCAdUB/kFW4z7A/TEzBRFNivytAF4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TMBzj/H0; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TMBzj/H0"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84830c774a0so1011833b3a.1
        for <linux-security-module@vger.kernel.org>; Sun, 09 Aug 2026 12:18:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786303114; cv=none;
        d=google.com; s=arc-20260327;
        b=qyOOzM14yEyhdLun2XSoWNu7vSAm3U6e5qA45GWLWBTayYdVQtTkfpuDHhDxYm10QC
         Q+DqY0Biq1NEfvr4cS3HZbTwVjy04lrMboWYNTOD/1il2H8P9kCmAEM+qQwfCKSSh1Wf
         UqzwauZq8JBiFAg/A+cfm1CUBpWXqSJIi8uc81uPhZDHnr+zzIn7wZLoUow+WEY9Py1I
         OugcpRnxAhEfGVFQ3KCIWgC4pBS9K0IC4ahjnfwndVVtpBhUpb5mdH1CkUU1I1HHNlJI
         QB2BhqMwBk+dZE13zozfIZfPpP6n3OX6/8crJOdsIdAWRPc/KbcHy5Ke7ocwnB4Kq5c4
         rvEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q5jB5lp1XIoqYcLMVm6hbSMvOkuvZLhskODPz83eMPU=;
        fh=ygpUoYb+gD5/lsLcVVZkMD/1VLIlRD5ScpJ7kX09egU=;
        b=AxeGGuISYIzE9yaf1XRtyjCtszedhgHbstSL/yjHpi0UGoEQpxFprGuNFqvxSfHKCe
         sqPiWotz+DUyV5xN0PXHQn/IxxpFsJOxMzbHHRPaCnuf+3+qNEf2BCItW3w9YeuzKkCB
         hKJF8MDhgZRbnTHdADxY8fGBsWZuX8BhY7ypSZ4f2lh3W5F3ABh4ZBiR5c/J0LFSttun
         ZTwje1gMI8b7vUM8ooXItNMU/GHvFAC9OvxfDB9E4lDx0J7fJpUXExGmqMF5U8K66NZc
         HJaLADJTg/iopYnTMMsEPlFaPA10ojlJ5hJ6tT9PKXItbsjffqwFPav3+N4pe+o/VrNj
         K8fA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1786303114; x=1786907914; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q5jB5lp1XIoqYcLMVm6hbSMvOkuvZLhskODPz83eMPU=;
        b=TMBzj/H0LEKN8Kuk/68s2IGjTRjKAVsZ49LNxa6diSjAePvc1ks5aAOARcWEdYnrTY
         sDQPHWAp8wYq67kcIC8ikzIfa0vM9GHn8wVsP9zRj7Km9r18Le31BWqSQXGdVvxqQPYJ
         wkkJNaN7c0vFdqriEXSbtnowhNHNPqoXorQXootZqy+7lQyb6atrRZuRY+XI7Q6ahpd7
         +lK6h55t+bsHQ8HuKwgQHB5V+A9Lk+LhoQYeh65dW28duQpyOZPlzwy24FMv+TNB6A4V
         LnQt1V+7NwUzR2ph9ECGCMNllUhLpofZwhm+VRB6sB61gZn0kK0z+5x6y8fVJ4tG4daV
         t36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786303114; x=1786907914;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q5jB5lp1XIoqYcLMVm6hbSMvOkuvZLhskODPz83eMPU=;
        b=R0hK2XCU3rBAXtgdPBqEUG4mvM6Koh9NRvsj82f80ILctQ245w9w1WwvmKkpK8O0kW
         q/6JBwiDlyeHLRYSw0PJ3MBspK3mnixa/1N6Ch6MjbrXR8Kdr6g4vsahN1Of0qw4ApLY
         yv04g9VMR7/LkDtTKN8sNeSAca7rgOWxBYcmLVq53n0gHgfUEBMssszpFXGV0o9uuVFZ
         5XQERZG39fXIV6brVBnwgB/dYM2uyEtO121UW7YMdWM7KJcobEmS8RpxPkAMcCPsz+qp
         jUKz8+OKGaPRKYyNTFuP/7uO1gbos+vFLvSQJGzysxMe0KOldpivq39irxFgdY4X8O93
         8w+g==
X-Forwarded-Encrypted: i=1; AHgh+RqRlHgCVfmPHI4UER8lROe6416JTbzBJgYij+uVugCSaaQFb4oEBQuFvIfhEweZjPUK5thPoiQIOMu2UBKfJ1Rc/WdIta4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9uhulI0Yxdyk9rLlye8N7dud6V+GF6E+//KL4s6zAvlpFWKnh
	rv7av9a+u3SC1dOviFCAR8fYsWhYP5k2YaIJ30sUFck4/7H/HcQ2jDS/dBex6ztG+Rs7sBwj70K
	SLbtADk8XiVMwwDC7lOtWW/OSlt0/YNGIIPNHDy8J
X-Gm-Gg: AR+sD10NCf2VdTWTr2ETEG6MjX31BbctBzIohffh+UH1l9l9etVcArEz4LZZbp19q0D
	mj21phIbKQR/ZS4/vUX4jFhHkH1mcHX2LHB/Xr8lQcmLJeUZUugOVplbJyeleZRVoSMzlPoMJ1w
	Z5rMt6OKjKnmC4G7fVdrpYcEVSNvwqwm2wEe2xnLz2xYNbWi/S7z5Bz2bz0S89DEoH9RF9WJ3gf
	J1T4BRyZSKE/+wo1OF8QB+PiQ+cvZkae3hejLP/EXytMmxGpWLCqLkrwyL79YEeu9eWk2G6QLL0
	kvF50HvnnpBliswvN8v2B7bMZMPSBUgS0JHDlenZTTOM
X-Received: by 2002:a05:6a00:430c:b0:847:9315:fb8b with SMTP id
 d2e1a72fcca58-84f694168bamr16344433b3a.6.1786303114345; Sun, 09 Aug 2026
 12:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731022047.189137-1-utilityemal77@gmail.com>
 <CAHC9VhSSzNBCSvy4cQHh6OOM4-EvHF+bmrB9=V1y=Lj53RvxQQ@mail.gmail.com>
 <anOnaGmBTlBW9xwj@zenbox> <CAHC9VhRBYMaNBPfnV=TK8g-M7H_qsBu=CsVVOwnAzTPAkpAZaA@mail.gmail.com>
 <anPAbFzuLOizAhm-@zenbox> <CAHC9VhSJ1q59RUtEEMAmiZLLLi92=XO1tkd9z0fr5T7vuhoy8Q@mail.gmail.com>
 <anZIGtlHvTaidOEC@zenbox>
In-Reply-To: <anZIGtlHvTaidOEC@zenbox>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 9 Aug 2026 15:18:21 -0400
X-Gm-Features: AUfX_myAHIvTbo5WKn9lKuAQJsXy1A-audBQrgzJe-_mnt5F5bT9SrEV7J54PxU
Message-ID: <CAHC9VhQcysVLosHhuz_FTh+LUH7KSw1hJWmwucmV1G-seSbHHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/13] BPF interface for applying Landlock rulesets
To: Justin Suess <utilityemal77@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, mic@digikod.net, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, kees@kernel.org, gnoack@google.com, jack@suse.cz, 
	song@kernel.org, yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 6:00=E2=80=AFPM Justin Suess <utilityemal77@gmail.co=
m> wrote:
> On Fri, Aug 07, 2026 at 04:36:20PM -0400, Paul Moore wrote:
> > On Wed, Aug 5, 2026 at 8:32=E2=80=AFPM Justin Suess <utilityemal77@gmai=
l.com> wrote:
> > > On Wed, Aug 05, 2026 at 06:51:56PM -0400, Paul Moore wrote:
> > > > On Wed, Aug 5, 2026 at 5:37=E2=80=AFPM Justin Suess <utilityemal77@=
gmail.com> wrote:
> > > > > On Fri, Jul 31, 2026 at 04:30:39PM -0400, Paul Moore wrote:
> > > > > > On Thu, Jul 30, 2026 at 10:21=E2=80=AFPM Justin Suess <utilitye=
mal77@gmail.com> wrote:
> > > > > > [...]
> > > > > > As you may, or may not have seen, there is currently an ongoing=
 debate
> > > > > > regarding the location of LSM kfuncs that will impact this patc=
hset.
> > > > > > Sadly, we don't appear to be approaching an agreement on this i=
ssue
> > > > > > which introduces some additional risk to this patchset.  We'll =
have to
> > > > > > see how that ends up, but I just wanted you to be aware of the
> > > > > > situation.
> > > > >
> > > > > Quick aside question: Would security/bpf/ be a better place for t=
hese
> > > > > type of kfuncs?
> > > > >
> > > > > security/bpf/bpf_lsm_kfuncs.c could be for LSM framework kfuncs,
> > > > > and each LSM could maintain their own security/bpf/<lsm>_kfuncs.c
> > > > > for kfuncs dealing with lsm-specific types.
> > > >
> > > > This gets back to the other issue in the patchset that we've
> > > > discussed: general LSM interfaces vs Landlock specific interfaces.
> > > > There are plenty of reasons why we don't support the kernel calling
> > > > directly into individual LSMs, and from my perspective this is anot=
her
> > >
> > > I'm 100% on board with the no calling directly into individual LSMs p=
art.
> > >
> > > > instance of that.  Here it just happens to be that the kernel calle=
r
> > > > was written in BPF and not C (or Rust for that matter).
> > >
> > > The intention is the opposite. The point of the separate directory is
> > > that the kfuncs can never call into an individual LSM, they only get
> > > the LSM framework API in <linux/security.h>.
> > >
> > > Every kfunc is a thin wrapper over the generic policy kptr hooks:
> > >
> > >     bpf_landlock_get_ruleset_from_fd()
> > >       -> security_policy_kptr_from_fd(LSM_ID_LANDLOCK, ...)
> > >         -> Landlock's hook implementation
> > >
> > > So kfunc -> generic lsm hook -> individual LSM, same as any other
> > > caller in the kernel.
> >
> > Not exactly.  That "bpf_*landlock*_XXX" kfuncs are a move away from an
> > LSM agnostic API and not something we currently do in the kernel.
> > Some will, and have, argued that this is more akin to the Landlock
> > syscalls, but I see (at least) two problems with that comparison: the
> > kfuncs being presented aren't syscalls, they are cross-subsystem
> > kernel function calls; the Landlock syscalls were created in a
> I see the argument for normal in-tree kernel interfaces.
>
> Unlike normal kernel interfaces, kfuncs:
>
> 1. Can exist without in-tree callers.

Yes, although I'm not sure how relevant that is to our discussion.  I
can say that it isn't relevant to my decisions.

> 2. Are explicitly allowed to change or be removed at any time [1].

FWIW, the LSM hooks can be changed or removed at any time as well.
For obvious reasons we try to avoid churn where possible, but there
are plenty of cases where hooks have been modified, removed,
relocated, etc. (some without our explicit permission, but that's
another issue for another time).

> 3. Can't break builds or other in-tree subsystems when they do.

Of course.  Rule #1 of any kernel subsystem is don't break the build :)

> This isn't hypothetical: the entire KF_KPTR_GET class
> (bpf_task_kptr_get(), bpf_cgroup_kptr_get(), the flag itself) was
> removed and replaced with a better abstraction within about a year
> of introduction.
>
> If Landlock (or any LSM) dies, there's zero uapi/in-tree cost to
> removing the kfuncs, unlike syscalls which are burned into the uapi
> forever, or ones with in-tree callers where we can break builds.
>
> I argue that the transient, low-commitment nature of kfuncs mitigates
> maintainability issues that arise from lsm-specific interfaces with
> in-tree callers. (which we are both opposed to).

Sadly, the current situation between the BPF and LSM devs is not good,
which means any discussion around LSM kfuncs has a good chance of
turning ugly and something that should be relatively easy to maintain
is likely to turn into a significant headache.  To be clear, this
doesn't mean I'm opposed to LSM kfuncs, I just don't agree that they
are "low-commitment" at this point in time or in the foreseeable
future.

> To avoid strawman style arguments, I ask what you would see as
> an alternative interface?

As I've mentioned a couple of times now, you need to grant me the time
to properly review your existing patches before I can comment in
detail on the interface.  You've been quick to post with new thoughts,
ideas, arguments, etc., which is fine, but replying to them steals my
time away from the very patchset you want me to review ;)

It's up to you how you want to handle things, but my suggestion would
be to pause some of these thoughts until I've had a chance to review
your patchset in detail; then we can have a better discussion.

--=20
paul-moore.com
