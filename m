Received: from wind.enjellic.com (wind.enjellic.com [67.230.224.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5B44AB3CE;
	Wed, 16 Sep 2026 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.230.224.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574918; cv=none; b=Dt7aTHz4D7b0iuRrGPOqR1E3lBso86tci2HkbUuYabiXoR5ZWy6hQWxFoYhjfWno33TeL/6Oe5vXJbNbsyY2Ynv0Twts55RbIFgXE7kMXDurVzyT+DtI771qUeFfOUBLLdYE7wY2QrRoy+Yhf74RGsfwDfr8UjRRFF0JQoqbrqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574918; c=relaxed/simple;
	bh=J7nl98zB0XxMW58Fn6zBKKhP7hFNM1LF2VsRwJ8uRhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBrbY5mbYAReEdk5/O2aczspohd7cTgKDBWxlcDQ2jbqfLdafdKgA/7E5ZrNAojJpA4lHG2felFgWxTpYnj3rVG/JDfH5i/B4M+u8VQ7wIopP23NjFydBf5Df+Fx0Uwz9OMKlWxYKup0WBnE1nY/J6g8qpmLIQhWCpxq4HL4k8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=67.230.224.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 68GG6fJX028338;
	Wed, 16 Sep 2026 11:06:41 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 68GG6diN028328;
	Wed, 16 Sep 2026 11:06:39 -0500
Date: Wed, 16 Sep 2026 11:06:39 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Paul Moore <paul@paul-moore.com>, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, matt@bobrowski.net,
        mic@digikod.net, viro@zeniv.linux.org.uk, brauner@kernel.org,
        kees@kernel.org, casey@schaufler-ca.com, gnoack@google.com,
        jack@suse.cz, song@kernel.org, yonghong.song@linux.dev,
        martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
        jolsa@kernel.org, m@maowtm.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 04/15] lsm: Add the bpf_lsm_policy_release
 kfunc and policy object destructor
Message-ID: <aqq-j-xv-P5Qa1Ut@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-5-utilityemal77@gmail.com>
 <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
 <aqHUw6k0Mf83CGFT@zenbox>
 <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>
 <DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gmail.com>
 <aqTZdCz6JaoK16Fp@zenbox>
 <DLDL7KK3FZKU.17ADLLWJVXB5F@gmail.com>
 <aqcb2eXw61LaFaqY@zenbox>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqcb2eXw61LaFaqY@zenbox>
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 16 Sep 2026 11:06:41 -0500 (CDT)

On Sun, Sep 13, 2026 at 08:20:41PM -0400, Justin Suess wrote:

> On Sat, Sep 12, 2026 at 12:33:13PM -0700, Alexei Starovoitov wrote:
> > On Fri Sep 11, 2026 at 10:26 PM PDT, Justin Suess wrote:
> > >
> > > If fs/, mm/, drivers/, net/, are permitted to have kfuncs, then why not
> > > security/? kfuncs.rst doesn't seem to forbid this.
> > 
> > because fs, mm, net see the value in bpf. bpf helps these subsytems
> > to focus on their core technologies and moves policy decisions out of
> > kernel and into bpf.
> > while lsm people treat bpf as arch-enemy.
> > kfuncs are not stable. we keep refactoring them.
> > while lsm folks treat anything within *lsm* and *security* as stable apis.
> > So any kfunc where they have a say, will become a huge burden for further
> > bpf development.

> There are patches on the front page of 
> lore.kernel.org/linux-security-module refactoring security
> hooks and changing signatures. Security hooks and the LSM interface
> is not stable, this is explicitly documented. 
> I deliberately chose kfuncs over helpers to avoid having the interface
> be ossified.

> > > Where would you point me to?
> > 
> > landlock was designed for unprivileged users. bpf needs CAP_BPF.
> > There is a fundamental disconnect. If you can tolerate CAP_BPF then

> Landlock is for privileged and unprivileged users alike.
> This patchset is designed to compose with unprivileged use seamlessly,
> which works because of Landlock's monotonicity.

> > just use bpf-lsm and implement whatever policy you need there.
> > If bpf-lsm is missing a feature we can fix that.

> Sure, in some perfect world in the future where every verifier
> challenge is solved and BPF has feature parity with in-tree c on
> a 1:1 basis, you could implement something like SELinux, or Landlock
> in pure eBPF. It would be about as easy and trivial as building a
> skyscraper from lego bricks.
> 
> There is an entire in-tree ecosystem of LSMs that would provide
> BPF users with well-maintained, versioned, and tested access
> control. Why force every eBPF program that needs to make security
> decisions to reeinvent the wheel? 
> 
> There are real eBPF users such as Tetragon, Falco, Tracee, that
> could use an actively maintained implementation of security models that
> exist in-tree in security/. This would make access control in eBPF much
> less painful.
> 
> Instead of implementing every filesystem, network, and 
> socket access control, they can use existing solutions, and with
> the userspace tooling that already exists. And they can
> mix-and-match, doing custom logic/policy in BPF, and use what
> they need in LSM, with BPF making policy decisions.
> 
> It would fix a real challenge that users have with eBPF, and wouldn't
> take away from BPF's ability to do what it already does.

Justin, I find your thoughts and perspective on this interesting.

First a general question:

If we understand correctly, your work is to enhance the capabilities
of LandLock.  You are fortunate to be in the kernel already and you
have at least a system call interface as a control plane and of course
the possibility of implementing a pseudo-filesystem interface if
something beyond the system call interface was needed.

Given that, what is the motivation for bringing eBPF and all the
assorted drama related to that into the picture?

In addition to all the political drama, eBPF signing is still a bit up
in the air as is the ability to completely lock eBPF based policy into
the kernel so an adversary cannot displace it.

The other issue with this work, seems best described as a problem of
'Mixing of the Blood', as it was once referred to in the Iron Triangle
country of south central North Dakota.

This effort seeks to merge two diametrically opposed viewpoints on how
Linux security should be implemented.  The camp that believes that all
security policy should only be implemented, and most importantly,
controlled through requiring inclusion in the kernel and the camp
seeking the ability to implement kernel based security policies
without years of contentious political struggle.

You raise the question above of as to why we should be forcing every
eBPF program developer to dump out a pile of Lego's and start stacking
them.  The reason is simple, it is the only way to move forward,
particularily in a timely manner, given how fast the security
landscape and challenges are advancing.

While work like this could undoubtedly benefit the Tetragon, Falco,
Tracee and others of this world it seems likely to run into issues
over whether policy should be in the hands of what amounts to
userspace.

> Thanks,
> Justin

Thanks for any insight you may have, especially with respect to the
advantages of endowing in tree LSM's with eBPF capabilities.

Have a good remainder of the week.

Greg
