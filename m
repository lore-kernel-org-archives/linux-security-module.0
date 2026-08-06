Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A65529898F
	for <linux-security-module@vger.kernel.org>; Thu,  6 Aug 2026 00:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785976340; cv=none; b=o7vfHpujlqqhzv81QnDOb33PqHcVFGlzRpTwlB7D0/VZ6Nt9KBfVRvF1xR6dkdb3jGUwwi5sC0rX0IzINvz/NS3hYGQlObkLFJE1R3utYBNAlaUWq8FTcvsX6OBT7V0VAjjdYhwX+8TuJ7WAokrqlgt5SLRlLs65dHIgx5nzSqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785976340; c=relaxed/simple;
	bh=t151uzynxLJ/WULoxogSTwfKcoLQQ946O1PY4MkYhvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrbdS8w1joDb7uNqUkVuTjahcEG+GsJtAk6KirguniBc32Z01BDFIh74parPOC+aJahJ6cqdSaPqQjYf0Q8tj2CCbkp8W2R6N1FOrdISSISpzYT2eaLhDF0v3NR0jiEay0AIL2tmOFRtL0ssvePchZ1vkcBclBkNMRWdd0mXido=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEMPPHG0; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEMPPHG0"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81ed2a06b9eso16455667b3.3
        for <linux-security-module@vger.kernel.org>; Wed, 05 Aug 2026 17:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785976338; x=1786581138; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2F8fXV8jMRshW9OPPH/zGJGmCPAHy4asEUrxhxRVPHU=;
        b=BEMPPHG0FUMbv/RRb5aI6DnmumArWixc2Swg9aG/1MUqco5RuEbnu48yYX4pUAmbV2
         nFcr89Tf8y9uUyatESS7SHMOOpcAvp6Lb+beSgTOIAD/a6vI+xEvaKxxq3Cudw2KmQL1
         4BLuALB0KPmad02yoTcW0/yJ0aV2Xq/t7o9J2SJ9ahF0VYBKXX8lV3ge5FzWayHtMa1h
         e+MplLNQU8FaTZY5CnqkO07QW2zdwA3ee4ez/54U9yVDuZ/lx0bIamk/iy1t/P5ytMiQ
         ebWQi1vvbM1p2+iB8tW4iR/+EmfTjlxZZ3wkSP9Ng+nuRUjSDnZMW4vebuQnm8flV8MX
         jdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785976338; x=1786581138;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2F8fXV8jMRshW9OPPH/zGJGmCPAHy4asEUrxhxRVPHU=;
        b=B5RRmCgubLxP/1Wb5/RgUYOLsVLOFn2rdqPEpK0KKB0yONmz864MyTVQ+1zjkR/rgE
         ipJ9jzD2BlEs1r+s1wdV+wamKTKeqCqud8Xfj9LxdT00yla+d7FkrmjAisyZKyEJ6Mih
         wfDLWpqihhUuVa2OXcf8W+SBBhK9KYcqwQRTu++bgaIh2vhcTNt1EiLhFkeKyEpQTCdc
         +wppT+LqoqbmINr9+jQ7fhNX/vQfWrGmXn0fRQF1AY9PlBjIjdbILVyrN1ZVe7GDVX77
         /aTHs7ukpLFUOtQFretrPfefRK5yTmurAnVh7/siWsLIQRP9XNbPKGN4E6AYhB6sg4xF
         pisw==
X-Forwarded-Encrypted: i=1; AHgh+RoLdoxXVNjU8e2dGaf9IBFc2ZglPYNlwvM9ZA2NTR5GuwX8MclHNeEy9FSEYpGrbgauPOGINRZXuygKHsW73LtDJiCZu5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7u/qwiisAy99uC1+gGHvmdmGBqlsxgasT/gXS8VIKCLVrqpVq
	x2h6USHjug8Z7jOYQ4HRbgLDR89ptzTMag/47joaWNi4qKRqM8+YMde/cHrqCKhF
X-Gm-Gg: AR+sD13CmvLRwbljEzm5Pwm1/BStGSSQwbljrlE6VxCO/8nZzrFVMyM9Kl8ziH6v1yk
	UAg5MYfSKTCZf0jsMn4E2A1gp2z9/cjt+h1jISS3zoIWnMp8zD6hgFLZWMmyvuPTBk2w3y9Uimq
	9c3/mqa2W/RZXJhRA0x/KKbIrcgwdylfVmFtOAYycoMeRYOIltQBX9+H7xoKUwB26Gi9C4FI/JO
	V61ByCBw6WEoYccBlHMhMw8mTdLIDzO4UFbW2oIce8BgDFRZmOcYEwrZJTdDROZFsDSjnkDBIhC
	Xej8lk+IsIIUnckOY38DsG9YHxduxZCTkZp3jFh4cHEwSsYfZGjqAE8Nee2Q2vxaFUZW0BA051k
	f8MajiWSxncTCbm6nO1t76qbnol45zdYyjFOEDHOyrz7kiikfxfj+I6mvt6q7p+N5kH9TphGRdm
	yxH+7u/e5aQARhTPmXBoCVktm2DJnMuCspM7BRiaydaKyMLlSTSgTaqbGqh3mMkb/uO0YBeI2Bc
	7DMtrR+YwSTyLqLCO17PZU=
X-Received: by 2002:a05:690c:4b86:b0:81d:e7d2:a46d with SMTP id 00721157ae682-8201bc73840mr64948197b3.5.1785976337931;
        Wed, 05 Aug 2026 17:32:17 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:7d5b:ac23:cde9:3664])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8201341d3d2sm29635727b3.31.2026.08.05.17.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 17:32:17 -0700 (PDT)
Date: Wed, 5 Aug 2026 20:32:16 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, mic@digikod.net, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	kees@kernel.org, gnoack@google.com, jack@suse.cz, song@kernel.org, 
	yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 00/13] BPF interface for applying Landlock
 rulesets
Message-ID: <anPAbFzuLOizAhm-@zenbox>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
 <CAHC9VhSSzNBCSvy4cQHh6OOM4-EvHF+bmrB9=V1y=Lj53RvxQQ@mail.gmail.com>
 <anOnaGmBTlBW9xwj@zenbox>
 <CAHC9VhRBYMaNBPfnV=TK8g-M7H_qsBu=CsVVOwnAzTPAkpAZaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRBYMaNBPfnV=TK8g-M7H_qsBu=CsVVOwnAzTPAkpAZaA@mail.gmail.com>

On Wed, Aug 05, 2026 at 06:51:56PM -0400, Paul Moore wrote:
> On Wed, Aug 5, 2026 at 5:37 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > On Fri, Jul 31, 2026 at 04:30:39PM -0400, Paul Moore wrote:
> > > On Thu, Jul 30, 2026 at 10:21 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > > [...]
> > > As you may, or may not have seen, there is currently an ongoing debate
> > > regarding the location of LSM kfuncs that will impact this patchset.
> > > Sadly, we don't appear to be approaching an agreement on this issue
> > > which introduces some additional risk to this patchset.  We'll have to
> > > see how that ends up, but I just wanted you to be aware of the
> > > situation.
> >
> > Quick aside question: Would security/bpf/ be a better place for these
> > type of kfuncs?
> >
> > security/bpf/bpf_lsm_kfuncs.c could be for LSM framework kfuncs,
> > and each LSM could maintain their own security/bpf/<lsm>_kfuncs.c
> > for kfuncs dealing with lsm-specific types.
> 
> This gets back to the other issue in the patchset that we've
> discussed: general LSM interfaces vs Landlock specific interfaces.
> There are plenty of reasons why we don't support the kernel calling
> directly into individual LSMs, and from my perspective this is another

I'm 100% on board with the no calling directly into individual LSMs part.

> instance of that.  Here it just happens to be that the kernel caller
> was written in BPF and not C (or Rust for that matter).

The intention is the opposite. The point of the separate directory is
that the kfuncs can never call into an individual LSM, they only get
the LSM framework API in <linux/security.h>.

Every kfunc is a thin wrapper over the generic policy kptr hooks:

    bpf_landlock_get_ruleset_from_fd()
      -> security_policy_kptr_from_fd(LSM_ID_LANDLOCK, ...)
        -> Landlock's hook implementation

So kfunc -> generic lsm hook -> individual LSM, same as any other
caller in the kernel. There's no build dependency on Landlock either:
the kfuncs register under CONFIG_BPF_LSM, and if Landlock is compiled
out or not in the lsm order, the hook dispatch by lsm id misses and
the call returns -EOPNOTSUPP.

The only Landlock-specific part is what the BPF program sees: the
kfunc names and the opaque handle (an empty struct
bpf_landlock_ruleset).

Permit me to use SELinux-specific interface through LSM as an example.

The existing userspace API already has this exact pattern (partially
from [1], thanks Casey it was a great talk!):

  ctx->id      = LSM_ID_SELINUX;
  ctx->flags   = 0;
  ctx->len     = sizeof(struct lsm_ctx) + ctx_len;  
  ctx->ctx_len = ctx_len;
  memcpy(ctx->ctx, "unconfined_u:unconfined_r:foo_t:s0", ctx_len);

  lsm_set_self_attr(LSM_ATTR_EXEC, ctx, ctx->len, 0);

If you think about it; that's what this patch is doing!
"unconfined_u:unconfined_r:foo_t:s0" is as LSM specific as
bpf_landlock_ruleset* is.

This is a generic framework syscall, targeted at one LSM by lsm id, carrying
an LSM-specific payload. Our kptr is basically the lsm_ctx; the
difference is that the lsm id and payload type move out of runtime
fields and into the BTF type, so a mismatch fails at program load
instead of at runtime. Much better for security! (fail fast and fail
hard)

The verifier is why the lsm id can't stay runtime data the way
lsm_ctx carries it. Say LSM xyz's policy struct is protected by a
mutex (the caller must be able to sleep) while LSM abc's is accessed
under RCU. Those rules are enforced at program load time through the
KF_* annotations and argument types of the kfunc itself, so a single
generic policy kfunc can't carry both. Per-LSM kfuncs above the
generic hooks are what let the verifier *prove* each LSM's objects are
only accessed in the right context.

Userspace only gets away with the fully generic lsm_ctx because its
calling context is always the same: syscall context. BPF programs are
everywhere from syscalls to LSM hooks, so the context requirements
have to be part of the interface.

So I don't see these kfuncs as a Landlock-specific interface. They're
the same generic interface the framework already gives userspace,
with the lsm id and access rules promoted into *types* the verifier
can check at load time.

Justin

[1] https://static.sched.com/hosted_files/lssna24/1a/2024-04-LSSNA-liblsm.pdf
