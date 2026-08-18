Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA81325495
	for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2026 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051557; cv=none; b=aEo0bRZ1gQG+XTO33nlL5mQCYLozbph4JwhMdJEvaeNj8dDS0JtrL90ZeS3lvQbN9ULRF/A2L+TONq9/lsPxKkrZM/DlDD4eUsQiyjPop0CyZI+PxHBZRXG0ejV7bY38QTMOAMMhZXf4nHVmi6uGHWpiRatr88fXsvFTlEy4NaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051557; c=relaxed/simple;
	bh=B2+CLnZM+Dfih0z+JXU8VyNPvh5GNDa0TTaCL0GCFRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsfSK4A55yW1fCIKzFKcPmoBs82cNDcWeJIGswDfhfxboutQtp6hFI7jieVHedliZSwTxZmR6f+40TRO1Ixdt1P2Ig6Y0H6BvoZRQ7kVP/kt6h/pKVQyaBFIjFfmwW9xuRCEs8S/a/V4HFWgFbAnUxAWYp4Tv2s8uDuBxndGF3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUHXSB1j; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUHXSB1j"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-836ccf53ef9so38850237b3.1
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2026 04:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787051555; x=1787656355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=15RZOvdraJlVKymuEVqpfPTvFuSCosFv3Jnv/6kSfDg=;
        b=QUHXSB1jU1m9Lmz0+qgvcUrk9DAHEHOvmrXEqt/OSOJjIw+h/Up1ZAQaCi/Lj51xSX
         gYGj6PMLvzDxvKFUZlWd3ojiChdbkV34AlFn9S6nusvjqGtzfqWjWE2UIH0WfZv49GUF
         Z6mokxCT1CGGEGauij2b5efeiuqyO+BL4/hOu98qd9ndoQRMpzvp03sMRmsJK8SybSjV
         mSyrjmxSFQaR/6rtmbNEBfXH9bE5qsz8bTEHq9QRmxxc20F5UXM3K4M/akJUo/r8sc12
         uyHxXbKyQOB24N1BYs9Z02CcGjcJGeqDPAP2wSw8PQsDxeubTmMa5fkqn0NWbjJbVoId
         wF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787051555; x=1787656355;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=15RZOvdraJlVKymuEVqpfPTvFuSCosFv3Jnv/6kSfDg=;
        b=eWNErFo3NSbsg+wUyhfM1JSS2skQbGA88+iVp+WdOfBAmc9eNcEAuR0p9tMJnfr0lJ
         5XflnAHBl+3rMglIki1FwZfjqmt1aWY85QFHwY8ji85zAc4UR8glr5N3HpqLajbE6tUy
         HzqZyCcm3I4WEutDlOpq6bf37z1ioC3B/YiEgIlvxrcgytDk6uZw3yHizuu6oM5kpcL/
         pNU2Oi8YCnuEUTklWjuRu83RMqZSNrm07L9CpTw+HH1lTCwtCYOPnKU0hdKgvZM0DtoQ
         h+sXfWpJvmLPAKiRIiFboYO00qOSJDMvoAXC9jUif+Eu+6IiGzBd8HGIj0Dxm+kltOiF
         L04Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq+KnazjXbdwcYSmZXREKXOu+BbDOtPZFslOBpOLYG3trqRQ+jdFQqOXhExje6niqJ3QZ61E3+dBKHo8kfGoTsSo+5Srto=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL9AvxItiw7jaQPn14VpnJUa/dQYyS0ZoLAfuhwuXil65/jaly
	9i26EC16/GO/GvZopnMzR4YLSax7/VJnzzyuMVeg22tnLAK/onSEua7L
X-Gm-Gg: AR+sD10CyjTCQw8uSHeLbQimvQ8ukuH0SVsj/A/eNrQTGgDPx54AIykOswB5O6Rj/d9
	9aePJF0OVhQNfU6xMBzOlKviJafo4btooPo9Xenlzj4mtHErDd29KlGkx6tZ5dcLrT9PbbBHwKS
	MXfvbg9aFG/JuzlTN7eS4qOgKIVbqzNdfPr6Y/MIknHFpD2xi9PstGOB2sDnPqxObf9gMCJ0oxk
	vo59lSRPtngT78ZmSr2a7ibYho+5BYDIoDlgLiytQYLWT/wpgBogqmIunNC7yTwNgsPHNo6+hrF
	0/KiBsndpF0Gye/TQIv6IfTQAQLC8lhauzsnjKZDGfkdYDO33kxmiNAzaadGLEHRqch2Sm98mtZ
	LgbvZSr3HcqdCClUGdrPLDVChMi+vaOBdns4A9dafpl51dlaYE1Me1d59UjlbhA4EWpZXZpnLev
	LXtY14gB324bIX8RELKZiwsp6uLQzHKRrdPIEdry2ksaRrMHF61jus8IzYGyWpCrYCoGnmMpAp4
	xbpmo2DFlgbE6024GE22Tw=
X-Received: by 2002:a05:690c:a647:b0:821:133e:569c with SMTP id 00721157ae682-8370ee56bc8mr74781987b3.15.1787051554998;
        Tue, 18 Aug 2026 04:12:34 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f3e5:832a:1675:b570])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-840f3d18a90sm16737557b3.46.2026.08.18.04.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 04:12:34 -0700 (PDT)
Date: Tue, 18 Aug 2026 07:12:33 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/2] lsm: give BPF programs a way to query
 locked_down state
Message-ID: <aoQ5PqX9psvbeOtr@zenbox>
References: <20260815112041.1248855-1-utilityemal77@gmail.com>
 <DKRYZPV04750.1V3UXL56PKB6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKRYZPV04750.1V3UXL56PKB6@gmail.com>

On Tue, Aug 18, 2026 at 11:42:34AM +0200, Kumar Kartikeya Dwivedi wrote:
> On Sat Aug 15, 2026 at 1:20 PM CEST, Justin Suess wrote:
> > Howdy,
> >
> > BPF programs can attach to the locked_down LSM hook and contribute a
> > verdict, but they have never been able to ask the locked_down question
> > themselves: there is no way for a program to invoke the hook and learn
> > whether a given operation is locked down. (i.e be a caller of
> > security_locked_down rather than a consumer).
> >
> > Today the state has to be fed in out of band, for example userspace
> > reading /sys/kernel/security/lockdown and writing the result into a
> > map. That is a time-of-check/time-of-use race: a security_locked_down
> > verdict can be raised at runtime, so the cached answer can be stale
> > by the time the program acts on it.
> >
> > Add a bpf_security_locked_down() kfunc that calls
> > security_locked_down() and returns its verdict, letting LSM and
> > syscall programs query locked_down state at decision time. Out-of-range
> > reasons are rejected with -EINVAL before dispatching the hook, and the
> > kfunc is refused to programs attached to the locked_down hook itself,
> > which would recurse into the dispatch. (how the obvious recursion issue
> > is addressed).
> >
> > As this is the first pure-lsm-hook kfunc, add a new file security/lsm_kfuncs.c
> > to host it.
> >
> > This kfunc has no reliance on / relation to the Lockdown LSM, despite the
> > similar naming. It is an LSM-agnostic caller of security_locked_down, and
> > Lockdown just happens to be the only in-tree subscriber to this hook at the
> > moment.
> >
> > In fact, the test environment does not rely on CONFIG_SECURITY_LOCKDOWN at
> > all, and uses a BPF implementation of security_locked_down.
> >
> > This kfunc can cause notices to be printed with kmsg if the Lockdown LSM is
> > enabled due to this line in security/lockdown/lockdown.c:
> >
> >   pr_notice_ratelimited("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
> > 				                 current->comm, lockdown_reasons[what]);
> >
> > Patch 1 adds the kfunc, patch 2 the selftests. This is based on bpf-next/master, but
> > applies cleanly to the lsm tree.
> >
> 
> I don't think there is good enough justification to add this in the discussion.
> The reason you gave (dynamically disabling hibernation) also doesn't inspire
> confidence. I think figuring out some other way to achieve that is better.
>

It is really a quite terrible hack isn't it?

I am using it as part of an hid_bpf_ops program to allow disabling
hibernation on my Linux smartTV box via their proprietary remote
contro.

But you are right using it that way smells off.

I was proud of it anyway...
> If you care about knowing the state of lockdown LSM, doing
> bpf_probe_read_kernel() etc. should allow reading that state from the program.
> If you have a BPF LSM supplying a dynamic verdict in your environment, I don't
> see why you cannot use the decision procedure from the same implementation in
> other places of the LSM. I doubt you have the scenario where BPF LSM is shipped
> by someone else and your program needs access to its decisions instead.

This argument persuaded me.

Given this, I don't think the kfunc is the correct way to do what I was
trying to do anyway... so I will drop this for now since it was a trivial
patch.

Justin
> 
> Lastly, given the difficulties we've faced from the LSM maintainers, I'm not
> inclined to waste more time in explaining again why this cannot go under
> security/.
> 
> pw-bot: cr
> 
> > [...]
