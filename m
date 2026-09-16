Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6777047D925
	for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2026 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789590024; cv=none; b=rMilEBBr1e/EyTBok7PGiYj0o6xDFYLPXSNBW4OnueNwaVoJlaB+Bdpncpd1YvQe4JcbWa39Mu37B3MGAb5B/U/5jUld6KYR0jV6voAdfUBFicDM1pOyzihYc+LmbbduEdLtPwa6n9NjliaowinKhHlR6i3t9oD8wFFBYhw7LtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789590024; c=relaxed/simple;
	bh=Ej22vtckdvfQ+B6irJUNrCPNb/Gby576+ozFZBj1s5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ofddghoeoz1s0dH57FNENTAKFPfDzb1P/uGyDROfBV16FkgekgyhH8d+Mrrdl9BJQWw71MJrtjsq1i5dH8DSdUl+zrs/cHfkPSXHzQL9Z5mQ8hir+jIDny1/iQppseDdm2uE0T9rSOXR69ChjKFL536xgi3R1MOTJoi49wyJFic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmddu+L/; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmddu+L/"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd4ba9f68so1821775e9.1
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2026 13:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789590009; x=1790194809; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p0JU7NG9wWGfnbR02xknk5oExK7M/TW6csExg90umtY=;
        b=lmddu+L/f1iUwEmQVkkOI3ZFWSpv5tSw/48+ly/d8AI8yN0TRkx7HuxOJlcVUp/l78
         3Rjawz3CY+VT2e8rWlA7yxpKNGHBKd0t9kvW28TgXmJs9Dp39TtFr3QUBPjfMw3I3wQZ
         tA44/QW3ixdrLGQ0ky8CJyGXTfpPtvCkSm4Ro9Ufer2UY22fr+eNbkxUc9XOMHoNlXGK
         pI9IdbBF9baui4ThsaCcEqO8EZpiNLXjDklO/qJycN/cBRGPGMQuHxJBww/n109mdpiU
         sBZ0UKRIyYGmsnSOx3PB3ETN8keGYT+r402ahVBYh3DZQ+fWi3t5WS2XmELboZdqX9tO
         O5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789590009; x=1790194809;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=p0JU7NG9wWGfnbR02xknk5oExK7M/TW6csExg90umtY=;
        b=yU8g6TQ1GXws3xuaEr0/FxdOHQx3qT3VzL20wx3776iecGb1Rr2YvQUcu/RxoYfoB+
         Mo8h1CJQNYTJ/4C1r8ff0QxcFR0zC7mZMKJEbBq7tJ2I/9tDg5x5VCuR69+Uq+xLmNGT
         SwypzyECMFQyFN6Bzv0wnuZOzj+HPqFWSYj8H1Xn3FZk9roQNDyMqyRlDiADqTpx24aY
         1gjl1TNJyMuri6eo5Kxn6tZS91wwVrQ2OtT1DfDbjCQg2ADTzgf60fRgillUNI8qDGUm
         HtHcrtOURb1e+nxCvi5sYGLgTtZKboikVpSrbICbu6oqQs59F0fe9LCE+1O+MeCoFPKX
         5/NQ==
X-Forwarded-Encrypted: i=1; AKwUvBxOAszsAySzN0+hinbdgkFAr2QiRknbDBkNk0Uotdu49K7e/twS8EZ8Q7EUrTAZPZUw0ulW/VwW2UYFzZwUzvO3hPtpTmY=@vger.kernel.org
X-Gm-Message-State: AFuF++m580C9s4k9P0FRZ2ubZYreI6uFGSSWTL12skn75R4BdEpVpF5h
	IsrqCY/tzN7ZP0YCy0PCv/uQ80V6dBWg/GSTjPoTiGcGKolE4JnldL7s
X-Gm-Gg: AYBFou0Hw2FqtYr5Qaxnyjj/5ck8hvhdzHitFf5C0s9KdSFc4V+Fa0Zaz2D01M0hxYb
	Zx6AflCpXi4zH2wQ31BlRaCudWaI9dHKRTS84gFlJaIVbgLpbeGsTGQfEMA/N8dr2ppL/Q+4kBl
	7xPqurbJRPRhKFPs7xI0slPCUqif3qYk853n7zUQRfSSxhKuD/pbYb1WKdTKZm44v82MAh+rf41
	gVQ3bayT1p1+FXYrYxRkHCAtTj3nY3enqPsS+oh2BigsiaVdGUFF7dySBYfUPkziPw+HTj64YXq
	PK6/SAeaY8ad8vtIOBCLQ1+yLKbsx4XMQTu+s6o7fA66Oiyuf+bsACaSmqbDyGolxo6lje52kOZ
	LY9k6eJwvetc6FDnTDbb+y4/Ub7pi/arpSlG3REE9t3V3K8zCKI/p6o66qthdsfXz9bWb61Ck/L
	ZCNzEPzgjqWPEG4ydOGXVNQTMjI+weUY7MZ2W3bmnTY/0+ESGZBrTiOj+xy6po+rIIzfe4wcxuV
	jOIINl+ZZuJdLCyZObW6WXU
X-Received: by 2002:a05:600c:1907:b0:49d:10d6:fd55 with SMTP id 5b1f17b1804b1-49eb73143c7mr47167685e9.1.1789590008675;
        Wed, 16 Sep 2026 13:20:08 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd24774esm27685625e9.10.2026.09.16.13.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 13:20:08 -0700 (PDT)
Date: Wed, 16 Sep 2026 22:20:03 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Paul Moore <paul@paul-moore.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
	matt@bobrowski.net, viro@zeniv.linux.org.uk, brauner@kernel.org,
	kees@kernel.org, casey@schaufler-ca.com, gnoack@google.com,
	jack@suse.cz, song@kernel.org, yonghong.song@linux.dev,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	jolsa@kernel.org, m@maowtm.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 04/15] lsm: Add the bpf_lsm_policy_release
 kfunc and policy object destructor
Message-ID: <20260916.e518e5ee513e@gnoack.org>
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-5-utilityemal77@gmail.com>
 <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
 <aqHUw6k0Mf83CGFT@zenbox>
 <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>
 <DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gmail.com>
 <aqTZdCz6JaoK16Fp@zenbox>
 <DLDL7KK3FZKU.17ADLLWJVXB5F@gmail.com>
 <20260915.ok8eig8Eishi@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915.ok8eig8Eishi@digikod.net>

On Tue, Sep 15, 2026 at 11:25:13AM +0200, Mickaël Salaün wrote:
> On Sat, Sep 12, 2026 at 12:33:13PM -0700, Alexei Starovoitov wrote:
> > On Fri Sep 11, 2026 at 10:26 PM PDT, Justin Suess wrote:
> 
> [...]
> 
> > landlock was designed for unprivileged users. bpf needs CAP_BPF.
> 
> Yep, and this series would kind of bridge these two worlds. ;)
> 
> > There is a fundamental disconnect. If you can tolerate CAP_BPF then
> > just use bpf-lsm and implement whatever policy you need there.
> > If bpf-lsm is missing a feature we can fix that.
> 
> The question is not if BPF LSM can or cannot do what Landlock does.
> Landlock provides a way for userspace to sandbox processes, and that
> comes with a well-defined semantic, logs, and an user space ABI, which
> are specific and dedicated to Landlock.  Some user space depend on that.
> 
> The goal of this patch series is to improve BPF LSM to enable it to
> (also) enforce a Landlock security policy defined by user space thanks
> to the Landlock syscalls.  The security policy still has the properties
> that makes it possible to safely compose different ones (e.g.
> monotonicity/stacking enforcement, inheritance, separation of duty, no
> cover channel, safe privilege reduction without confused deputy issues).
> 
> A process can currently define such security policy, get a file
> descriptor referring to it, and pass this FD to another process that
> would enforce it.  This helps design secure architectures by splitting
> ownership, trust, and privileges (e.g. CAP_BPF).  Being able to use BPF
> programs instead of user space programs to enforce (e.g. an already
> defined) security policy would make this enforcement more powerful
> thanks to the context BPF have access to.  Of course, BPF LSM can (and
> should) also enforce other kind of complementary restrictions.

I'd like to voice my support for this here and maybe try to make more
concrete the "bridging of the two worlds".

For normal Landlock use, CAP_BPF can *not* be assumed because Landlock
is designed to be used by unprivileged processes.  (See
https://landlock.io/integrations/ for an incomplete list of programs
already using it.)  It works similar to the unprivileged use of
seccomp-bpf: The unprivileged process both defines and enforces the
Landlock policy, by invoking unprivileged syscalls.

So a full rewrite of Landlock in eBPF seems infeasible (and TBH, it
would be quite a drastic deviation from the original scope of this
patch set).

However: It *is* true that a program that would use Justin's patch set
*would* need CAP_BPF to use it, and therefore that program *could*
also implement custom logic with the BPF-LSM.

But then again, since Landlock anyway already ships with well-reviewed
policy logic for the normal unprivileged use-case, I don't understand
why it should not be allowed for CAP_BPF programs to lean on that?  It
may be technically feasible to reimplement similar policies in eBPF,
but it might also avoid a lot of complication and potential bugs if
people could lean on a maintained solution like Landlock for the
aspects where it fits the purpose?

–Günther
