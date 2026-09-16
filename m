Received: from wind.enjellic.com (wind.enjellic.com [67.230.224.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012364C9DEC;
	Wed, 16 Sep 2026 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.230.224.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578265; cv=none; b=oF9ac/dgYwvhx3YqQkLLHcUX62nA8KEznt8p8nZS3npniCmlQ1xP3QVKfdWyR/Wi/P37tndQ+pPms+PxXefF6MXA18E5AhcULXSoHEYDUIm7hQ7KeCJEnGVCTsHMI3WRBbp1YojwSTgRPP9TtVn1lFkQTBXZq2oI+IjRDiyLUWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578265; c=relaxed/simple;
	bh=Lqx96ZCiyALkeCFGSyJXviXMdYefOb4bpTZRt+mnaKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqERKwkUxYaOFCWwCJSBT2UxQ47bbPPQ5gDH/lYmVnjQznNbG9fWFtt37NSJc1myKradu1alcTE//WHIve9uYuoPmrs6hhvtSBQj/PuGbOL+u6UjDG1ZYPg1sZWp8008QCWTgznVU0UZ6UjKuBFzdTpq+Y0ADrZ4Yzq13C4gCxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=67.230.224.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 68GH2gE1029431;
	Wed, 16 Sep 2026 12:02:42 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 68GH2fW5029430;
	Wed, 16 Sep 2026 12:02:41 -0500
Date: Wed, 16 Sep 2026 12:02:41 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Micka??l Sala??n <mic@digikod.net>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Justin Suess <utilityemal77@gmail.com>,
        Paul Moore <paul@paul-moore.com>, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, matt@bobrowski.net,
        viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org,
        casey@schaufler-ca.com, gnoack@google.com, jack@suse.cz,
        song@kernel.org, yonghong.song@linux.dev, martin.lau@linux.dev,
        eddyz87@gmail.com, memxor@gmail.com, jolsa@kernel.org, m@maowtm.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 04/15] lsm: Add the bpf_lsm_policy_release
 kfunc and policy object destructor
Message-ID: <aqrLsbnzbbX4HPr-@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915.ok8eig8Eishi@digikod.net>
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 16 Sep 2026 12:02:42 -0500 (CDT)

On Tue, Sep 15, 2026 at 11:25:13AM +0200, Micka??l Sala??n wrote:

> Hi,

Hezzie says hi too.

> On Sat, Sep 12, 2026 at 12:33:13PM -0700, Alexei Starovoitov wrote:
> > On Fri Sep 11, 2026 at 10:26 PM PDT, Justin Suess wrote:
> 
> [...]
> 
> > landlock was designed for unprivileged users. bpf needs CAP_BPF.

> Yep, and this series would kind of bridge these two worlds. ;)

See my comments to Justin about this 'Mixing of the Blood'... ;-)

> > There is a fundamental disconnect. If you can tolerate CAP_BPF then
> > just use bpf-lsm and implement whatever policy you need there.
> > If bpf-lsm is missing a feature we can fix that.

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

This may be the answer to the question that I was asking Justin, lets
see if we can unpack it a bit for those of us that are dense.

Big picture, as Justin so elegantly pointed out, there are a bunch of
things that eBPF cannot do now, and may never be able to do in the
future, particularily when it comes to 'raceless free' path based
security controls, ie. TOCTOU avoidance.

So, the objective is to have a program, systemd for example, compose a
set of different security policies, that it then hands out to various
process heirarchies, which then uses eBPF to call LandLock kernel
internals to do the heavy security lifting with kernel level
privileges and capabilities, particularily when it comes to path based
controls.

Is that close?

If so, the question remains, why take on this amount of drama?

Something like systemd does at least 10,000 other things, composing
and handing out multiple variants of file descriptor based process
hierarchy security policies would seem like chump change to it.

I'm assuming the answer is that the eBPF programs involved are going
to be implementing other, perhaps proprietary, security controls that
extend beyond the path based controls that eBPF can't do.

We will be interested in your reflections.

Greg

My opinions and those of my Golden Retriever Hezzie only.
