Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518F43D75CE
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179857; cv=none; b=lyoD34ZzOoz4Lcf3lCgRsXeCNq2YgBdNvHcFckVNnolHaIonMZaPZ95lqnH0PkO7K/kIMZxIUwKbFvd+fjHFsYY8IoYVbYx8GMA7iRx46tIjaf580lVsvi5gha9NgzoRU5Isszvllen1Wi+LB68HrXdUEQQThh64Y7cGSy7MEyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179857; c=relaxed/simple;
	bh=/CD1S0tF75VV8Pt22jOV3o6nDewczq6yzpsKNLL2F8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaGw6jomr9Lm4EPuOMe3j7+FYkevtKv96sZmyNWXVdyQkDsb6yDsuWiKcLUaWp/ZCGVKhO2f4uMGOSBmRTvqaIyfcLSODTNGFZHgnArbFbIG7IOqoCOa3wcGYylKWGtbSWTaT6q6lFpmAFUYqrEz7WcA2oa6t7EFCOSUTlpPzqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObTTcWzK; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObTTcWzK"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48431648f33so1195171f8f.0
        for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 05:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788179853; x=1788784653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ldCU727hj6i4HvipMvvooQ4fYosNMSgvpRhElZfgoAI=;
        b=ObTTcWzKSGzrNSQmsqdyt4qJE9+FFa5SNljA1lzc6iInBJ89B8355lGqicWZXB/RuY
         XC/DUuZdIxrN0OUS/WxPlASfNzTB8hdorZe3MsG0lPyJyied2swxOr1NCbTbhBz1IuQV
         A9DdQUOM/p2hXrluHcd0RUjSQ+GeZ4dvEXKyBYGohBZc1RZmCkmOfOTjTOZkzujEXaHs
         eCMDVGP5lI9c/XBsvRYHp6EyPLQHfU64yufH3ef6HhxcOi29Y8cbdsGcX+bmHfTO4wfC
         IqN+qWUypkDAn2T41/x2GwNFfbGvLdmdZJ6jP80azpO74pdUYSzL22yLHvvlW55W5IEF
         qsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788179853; x=1788784653;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ldCU727hj6i4HvipMvvooQ4fYosNMSgvpRhElZfgoAI=;
        b=NRQV4wreivoKJT/tNSTkoi0BpvskH/rJnYCb1tIxPfuKooxJShpkGGVM6GnMUf7cUX
         L19uoLFw18VnTYIqSG1fX3Z0vGkJudQhk6jKHUMb+A8bryzCVsKdJsBXc9O1EpXcvHao
         NKTBK0Cq1veFXwHja8Y9KdaKyReIoMJXaI1KD6p+wDhxbQ6T4ISLNBmQEK3nsn9aBgCl
         MkiJUXRU/YkkaAbDgAi/DnJYvBgOhtfHaSrQXWyAYezOJ6dl1bVv7aPxj8ATl7E5ptpd
         eSpKmjyyL88EinsYTMkfOHAgTHFvloFRMnFjDk76L8u0mObaAVZWmOzbKsGtOTLvS38G
         2RCw==
X-Forwarded-Encrypted: i=1; AHgh+RpHRaEIMqIMCGhF8vvrF1qdcTXV3C93qGniW2EcdGuT8bd29FJBwksul88dQ4cM0dQTUE5yP+Iym8G1EhcScKGwA2MHUE4=@vger.kernel.org
X-Gm-Message-State: AFuF++lhLfDEcosbsEPStRkeUEZblBPtzAN6o30+wQM0qw1L4UC8thUy
	xz6Fs0G7Q1SHxHrrgpBK6j/x2j5wVM2DHHg2o0IyP7kS+t315J934v4m
X-Gm-Gg: AR+sD12mmwV+h22417cq4pX0wZC0g65kyimj2/Vudp2PnV7PH0nc1nfUE6YXEh9YxoX
	mXXTfDtz+o4EojeWbIrgSn5B+pyfhgqS3LlGN4Isug6tPgY3YxkAEWFqrH78pdUNQTSHJVqjwv4
	c2m7ciE2uh4y7qsDLBqbMYrKys+KCvpgQYeuF64Iwmmbm9zKxJ2rdpe1RImVIz+f6di3j4AfWRG
	YALKbyCoM2sVclJtfkNYTYKJeaklfZrlhBWrDBPMOpxRn92qIGMpDlhkFvAiir937Vf6pIDRqZz
	B452E+X3aCbW4/912Ar1gNLkvbYgXosHQq/siSBxS5RI+bXezr4fVK81nSXKmHd7JkP4FX5zzJz
	ADuyTbA4tBPzb0UH6JRJQPYg8Dk7rYLKMfXp6uNQDdWkZW+6HQnLE0bA1L9j1kth7UwVS0JYYdU
	QHA2pTyyccneYkO2yqGzQzv9ygiBdQbWlyB0r1RBvP2iVLNe2h+XcJ6BwBxDU2jqBDT/CB
X-Received: by 2002:a05:600c:1d02:b0:49b:e22:4ee4 with SMTP id 5b1f17b1804b1-49cd538b513mr145172565e9.4.1788179853332;
        Mon, 31 Aug 2026 05:37:33 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4942298fsm383050235e9.1.2026.08.31.05.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 05:37:32 -0700 (PDT)
Date: Mon, 31 Aug 2026 12:48:13 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	kpsingh@kernel.org, matt@bobrowski.net, john.fastabend@gmail.com,
	brauner@kernel.org, paul@paul-moore.com,
	torvalds@linux-foundation.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, martin.lau@kernel.org, yonghong.song@linux.dev,
	mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 1/7] bpf: Allow BPF LSM programs to attach to
 more hooks
Message-ID: <apV4DddDiWqLyldA@mail.gmail.com>
References: <20260831110934.241898-2-a.s.protopopov@gmail.com>
 <32309c5bdc0ed0566f6c7f8d133b4cbf781236c0d4fa76bdd43d0805224f89eb@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32309c5bdc0ed0566f6c7f8d133b4cbf781236c0d4fa76bdd43d0805224f89eb@mail.kernel.org>

On 26/08/31 11:50AM, bot+bpf-ci@kernel.org wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 460cb72688450..d01dd1f096fc1 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5035,6 +5035,7 @@ L:	bpf@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/bpf/prog_lsm.rst
> >  F:	include/linux/bpf_lsm.h
> > +F:	include/linux/bpf_lsm_hook_defs.h
> >  F:	kernel/bpf/bpf_lsm.c
> >  F:	kernel/bpf/bpf_lsm_proto.c
> >  F:	kernel/trace/bpf_trace.c
> 
> [ ... ]
> 
> > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > index dda272d78f013..1e54c7cca27ad 100644
> > --- a/include/linux/bpf_lsm.h
> > +++ b/include/linux/bpf_lsm.h
> > @@ -16,9 +16,19 @@
> >
> >  extern bool bpf_lsm_initialized __ro_after_init;
> >
> > +/*
> > + * Technically, checking bpf_lsm_initialized is not necessary.
> > + * But if it is off, then this means that all security_* calls
> > + * do not call BPF, and it doesn't look reasonable to enable
> > + * only "non-LSM" bpf hooks...
> > + */
> > +#define bpf_lsm_hook(NAME, ...) \
> > +	(bpf_lsm_initialized ? bpf_lsm_##NAME(__VA_ARGS__) : 0)
> 
> Does the new bpf_lsm_hook() macro constrain what hook declarations
> can appear in bpf_lsm_hook_defs.h? The macro hardcodes 0 as the return
> value in two places:
> 
> 1. When bpf_lsm_initialized is false, the ternary returns 0, but when
>    it is true with no program attached, the __weak nop returns the hook's
>    declared DEFAULT. This means LSM_HOOK(int, 0, ...) behaves consistently,
>    but LSM_HOOK(int, -EOPNOTSUPP, ...) would return different values
>    depending on whether 'bpf' appears in lsm= - 0 before initialization,
>    -EOPNOTSUPP after.
> 
> 2. Because of the ternary, LSM_HOOK(void, ...) cannot compile at call
>    sites, since the expression `cond ? void_expr : 0` is invalid.
> 
> 3. The CONFIG_BPF_LSM=n stub at line 128:
> 
>    #define bpf_lsm_hook(NAME, ...) 0
> 
>    discards its arguments entirely, so call-site argument checking only
>    happens on =y builds. Does this create a risk that =n configurations
>    would fail to catch type mismatches or side-effect issues?

Yes, it does (intentionally). For new hooks, which aim to be attach
points for BPF programs, there is no real reason to return anything,
but 0 or error. If they are called from a funciton returning a pointer,
the calling funciton should covert the return value appropriately.
(Also, new void hooks do not make sense.)

> >  #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> >  	RET bpf_lsm_##NAME(__VA_ARGS__);
> >  #include <linux/lsm_hook_defs.h>
> > +#include <linux/bpf_lsm_hook_defs.h>
> >  #undef LSM_HOOK
> 
> [ ... ]
> 
> > diff --git a/include/linux/bpf_lsm_hook_defs.h b/include/linux/bpf_lsm_hook_defs.h
> > new file mode 100644
> > index 0000000000000..29bc0b514d168
> > --- /dev/null
> > +++ b/include/linux/bpf_lsm_hook_defs.h
> > @@ -0,0 +1,6 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * This is a set of BPF LSM hooks, which are _not_ fully implemented
> > + * as LSM hooks. Thus, they only can be used by BPF LSM programs.
> > + */
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index 82c5988417a0c..add344ea26914 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -28,11 +28,13 @@ __weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
> >  }
> >
> >  #include <linux/lsm_hook_defs.h>
> > +#include <linux/bpf_lsm_hook_defs.h>
> >  #undef LSM_HOOK
> >
> >  #define LSM_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
> >  BTF_SET_START(bpf_lsm_hooks)
> >  #include <linux/lsm_hook_defs.h>
> > +#include <linux/bpf_lsm_hook_defs.h>
> >  #undef LSM_HOOK
> >  BTF_SET_END(bpf_lsm_hooks)
> 
> The patch adds bpf_lsm_hook_defs.h to three of the four BPF-owned
> LSM_HOOK expansion sites, but not the fourth. Does this need updating?
> 
> Updated:
>   include/linux/bpf_lsm.h (prototypes, lines 30-31)
>   kernel/bpf/bpf_lsm.c (__weak nop definitions, lines 30-31)
>   kernel/bpf/bpf_lsm.c (bpf_lsm_hooks BTF set, lines 36-37)
> 
> Not updated:
>   kernel/bpf/bpf_lsm.c (void_lsm_hooks BTF set, further down in the file)
> 
> The void_lsm_hooks set is consumed by bpf_lsm_hook_returns_errno() in
> bpf_lsm.c, which feeds cgroup_lsm_atype[i].returns_errno. If a hook
> declared as LSM_HOOK(void, ...) appeared in the new header, wouldn't it
> be omitted from void_lsm_hooks and incorrectly reported as errno-returning?
> 
> This is latent today because the four hooks added later in the series all
> return int, but is there a reason the fourth site shouldn't include the
> new header, or should the header document that it only supports int hooks?

Yes, there is no intent to add new void hooks.

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33386073074

