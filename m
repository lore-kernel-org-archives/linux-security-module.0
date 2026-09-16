Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460FF4DE70C
	for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2026 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592361; cv=none; b=Jk/yX0+rJoNLWWoWNjG55zWENQDrWrpyFMcacUA/cmIO3A5Hhjt8D6bj0CR3Wm6c+BvgFhyYG5lXzN1LWA0mZ3vHPoxZ67u2+ex5a/IoYEW9pl8tBpy9MOUEjQpvKFHNo6NF4/p4hy68nZf8Y2FTYwK2WVM6FjohQjwgk/hyUTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592361; c=relaxed/simple;
	bh=tpyrtVP1jfuQ8WMgb3T5IO33cz0Jvp88D3McFEAZlzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4SaK+5a7mIIC6xD1KsROvp+VNIVLtdygz23BwMMIsalk6lblj8/YnpCY+rSLEpd4MIurt6aospAVbKrBDkE4SfOhQASzseefgJCxqGiEOsrit0xTs2/AIWjXK2YIPszQ5rF5P4cOOD53SL1dj0PFgRcJAf33EuKV0AgNJKLh/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=DkqQcBAe; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="DkqQcBAe"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hlWT43VkTzFpk;
	Wed, 16 Sep 2026 22:58:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789592328;
	bh=eeNZDeKo3kAwa8gSqWkTV+x3phqJReGg6WugrdjFUoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DkqQcBAeujRMB2NU6LazQ51sJi6DFw7ZlKHeEHY0w5ERT7lFThr5T1KD+widZy1UT
	 21tOpzoGS7VprNtnV7VwBTDc8HJ9ehkMIjQEsWH7QMD27LWVdOeDSBQx1EWLP1nZu2
	 MAATFllRY1pL9c+7WXJzJRRCzlrfjqA3WRYCxJIA=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hlWT23Fytznr;
	Wed, 16 Sep 2026 22:58:46 +0200 (CEST)
Date: Wed, 16 Sep 2026 22:58:40 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: "Dr. Greg" <greg@enjellic.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Justin Suess <utilityemal77@gmail.com>, Paul Moore <paul@paul-moore.com>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org, matt@bobrowski.net, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, casey@schaufler-ca.com, 
	gnoack@google.com, jack@suse.cz, song@kernel.org, yonghong.song@linux.dev, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, jolsa@kernel.org, 
	m@maowtm.org, bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 04/15] lsm: Add the bpf_lsm_policy_release
 kfunc and policy object destructor
Message-ID: <20260916.aiPhaw6einoh@digikod.net>
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-5-utilityemal77@gmail.com>
 <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
 <aqHUw6k0Mf83CGFT@zenbox>
 <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>
 <DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gmail.com>
 <aqTZdCz6JaoK16Fp@zenbox>
 <DLDL7KK3FZKU.17ADLLWJVXB5F@gmail.com>
 <20260915.ok8eig8Eishi@digikod.net>
 <aqrLsbnzbbX4HPr-@wind.enjellic.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aqrLsbnzbbX4HPr-@wind.enjellic.com>
X-Infomaniak-Routing: alpha

On Wed, Sep 16, 2026 at 12:02:41PM -0500, Dr. Greg wrote:
> On Tue, Sep 15, 2026 at 11:25:13AM +0200, Micka??l Sala??n wrote:
> 
> > Hi,
> 
> Hezzie says hi too.
> 
> > On Sat, Sep 12, 2026 at 12:33:13PM -0700, Alexei Starovoitov wrote:
> > > On Fri Sep 11, 2026 at 10:26 PM PDT, Justin Suess wrote:
> > 
> > [...]
> > 
> > > landlock was designed for unprivileged users. bpf needs CAP_BPF.
> 
> > Yep, and this series would kind of bridge these two worlds. ;)
> 
> See my comments to Justin about this 'Mixing of the Blood'... ;-)

I'm pragmatic and there are different use cases, different constraints,
and different trust models...  Landlock has some good properties which
makes it fit for being used by unprivileged/untrusted processes, and who
can do more can do less.

> 
> > > There is a fundamental disconnect. If you can tolerate CAP_BPF then
> > > just use bpf-lsm and implement whatever policy you need there.
> > > If bpf-lsm is missing a feature we can fix that.
> 

Please keep this in mind:
> > The question is not if BPF LSM can or cannot do what Landlock does.

> > Landlock provides a way for userspace to sandbox processes, and that
> > comes with a well-defined semantic, logs, and an user space ABI, which
> > are specific and dedicated to Landlock.  Some user space depend on that.
> > 
> > The goal of this patch series is to improve BPF LSM to enable it to
> > (also) enforce a Landlock security policy defined by user space thanks
> > to the Landlock syscalls.  The security policy still has the properties
> > that makes it possible to safely compose different ones (e.g.
> > monotonicity/stacking enforcement, inheritance, separation of duty, no
> > cover channel, safe privilege reduction without confused deputy issues).
> > 
> > A process can currently define such security policy, get a file
> > descriptor referring to it, and pass this FD to another process that
> > would enforce it.  This helps design secure architectures by splitting
> > ownership, trust, and privileges (e.g. CAP_BPF).  Being able to use BPF
> > programs instead of user space programs to enforce (e.g. an already
> > defined) security policy would make this enforcement more powerful
> > thanks to the context BPF have access to.  Of course, BPF LSM can (and
> > should) also enforce other kind of complementary restrictions.
> 
> This may be the answer to the question that I was asking Justin, lets
> see if we can unpack it a bit for those of us that are dense.
> 
> Big picture, as Justin so elegantly pointed out, there are a bunch of
> things that eBPF cannot do now, and may never be able to do in the
> future, particularily when it comes to 'raceless free' path based
> security controls, ie. TOCTOU avoidance.

That's a different problem/challenge, but BPF is gradually being
improved, and I'm sure your contributions would be welcome.

> 
> So, the objective is to have a program, systemd for example, compose a
> set of different security policies, that it then hands out to various
> process heirarchies, which then uses eBPF to call LandLock kernel
> internals to do the heavy security lifting with kernel level
> privileges and capabilities, particularily when it comes to path based
> controls.
> 
> Is that close?

That's kind of the opposite: systemd, as a privileged process, is in
charge of loading BPF programs, but this is not a good example here.
That would make more sense with e.g., a dedicated process that manages a
set of security policies (which might be owned by different teams), pass
these (Landlock) policies to the a privileged process that enrich them
with context, and load the related BPF programs to the kernel.  That's
only one simple example, but it should give a good idea of what is
possible.

> 
> If so, the question remains, why take on this amount of drama?
> 
> Something like systemd does at least 10,000 other things, composing
> and handing out multiple variants of file descriptor based process
> hierarchy security policies would seem like chump change to it.
> 
> I'm assuming the answer is that the eBPF programs involved are going
> to be implementing other, perhaps proprietary, security controls that
> extend beyond the path based controls that eBPF can't do.

Yes, that's a possibility, but a simpler approach would be to just map a
runtime context to a set of security policies (e.g. sandbox all
instances of /usr/bin/foo with a custom profile).

> 
> We will be interested in your reflections.
