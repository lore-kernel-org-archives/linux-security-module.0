Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F80F3B995D;
	Tue, 15 Sep 2026 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477226; cv=none; b=iGbvFz7Bdn+XINlBTTyo7zinDZc0zC0P9q5+kaNoC1x57rQDSz9lc7kBxRrhRAU9oIpNOeJjkOi7l4hJa4RV20+/s2spI4ahc8h7A85wCOAR8DYX0gMLM0FQ2LoxCq9h5ImysELxVurgwzBMaHa/nRLLNuOt8F3S5QRD1i6nx0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477226; c=relaxed/simple;
	bh=g4R2ALPqs93pJYUMnMUcMKXnx1rinkBT01uksRJhbxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYOvfTMt6geVyF4Wa0JLqlWwG3EszhNGff+DURJXcU7hfMAW0oRaP+mE3yM+YO1lC7bLcXo9xx3rAxqlCMaSGVWyE5Rcn9w3rQs2hQUxseLyEv5Ty3pie6iQ1iiif0L0l5a7HIBwwaHSrKYypasdKD0b3fFr4pQzV6Dm63LBO/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQI6HQbH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQI6HQbH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8B61F000FF;
	Tue, 15 Sep 2026 13:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789477224;
	bh=ci5/Kd93r37BXCmVmRpK3hqSufSmU2Eo1oCU8uvYP9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GQI6HQbHRQF95O7yDwqk/IgA7A4Yrq0F6kojLDNGGNW/c9dwiKPMdU+o9CRkWPjnm
	 CtSCkhU7xWrnOzIw+Y3gzFiqbrWe194IKYII+GhRgohPMlAu6RggDdUDxMhpi0oZLJ
	 5cl2pu4gL4CbE+962dsxNF09XVgPjS1g8bwnviYnMhymeZZk2HcAeuvS9y3RV3yR6L
	 zxEoGuREX3LRBPfB8JTvUCXsyFv11J1hhlc0T+GNsDndh1fT3G2tsbCQjsq5tYuIvH
	 1PltsLpqjq5Q4sx7YupATvpeeDdPBCB68sQj2C2wXc8T7+IxPDXxlv9DsH7ynQyNL2
	 gXDMFg5jitwhA==
Date: Tue, 15 Sep 2026 15:00:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, 
	Justin Suess <utilityemal77@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Kees Cook <kees@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Jan Kara <jack@suse.cz>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Tingmao Wang <m@maowtm.org>, 
	bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: LSM boundaries. Was: [PATCH bpf-next v3 04/15] lsm: Add the
 bpf_lsm_policy_release kfunc and policy object destructor
Message-ID: <20260915-laken-ferngeblieben-verflachen-bafe1f296b02@brauner>
References: <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
 <aqHUw6k0Mf83CGFT@zenbox>
 <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>
 <DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gmail.com>
 <aqTZdCz6JaoK16Fp@zenbox>
 <DLDL7KK3FZKU.17ADLLWJVXB5F@gmail.com>
 <CAHC9VhS0JckwfomqLTUJkZZkDSgeRXYOjMmPQYErgYynQYqMKQ@mail.gmail.com>
 <CAADnVQJCJjy9Eiwn6-88c0iOk4LfgPU6KBv+w0JZdBzmXBMUCw@mail.gmail.com>
 <CAHC9VhTh446SkpPF-hUiLYOHipuurzkgju_nH9LsRGdERSAL1w@mail.gmail.com>
 <CAADnVQLZscKkCxvK5puuOE1aN8nW6PnaS+_dx_zBQjjP2T-DFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLZscKkCxvK5puuOE1aN8nW6PnaS+_dx_zBQjjP2T-DFg@mail.gmail.com>

On Sun, Sep 13, 2026 at 07:24:14PM -0700, Alexei Starovoitov wrote:
> On Sun, Sep 13, 2026 at 5:10 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Sun, Sep 13, 2026 at 7:25 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Sun, Sep 13, 2026 at 12:41 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Sat, Sep 12, 2026 at 3:33 PM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > On Fri Sep 11, 2026 at 10:26 PM PDT, Justin Suess wrote:
> > > > > >
> > > > > > If fs/, mm/, drivers/, net/, are permitted to have kfuncs, then why not
> > > > > > security/? kfuncs.rst doesn't seem to forbid this.
> > > > >
> > > > > because fs, mm, net see the value in bpf. bpf helps these subsytems
> > > > > to focus on their core technologies and moves policy decisions out of
> > > > > kernel and into bpf.
> > > > > while lsm people treat bpf as arch-enemy.
> > > >
> > > > It's amusing to read this when just this week we merged a patchset
> > > > into the LSM tree for the benefit of those writing BPF LSMs.  If you
> > > > look at the discussion around patch 2/2 you will even see a reasonable
> > > > exchange between Matt Bobrowski, a BPF LSM maintainer, and me about
> > > > the patch.  Alexei is obviously welcome to his own opinion, but I
> > > > would encourage those reading this thread to look beyond his comments.
> > > >
> > > > https://lore.kernel.org/linux-security-module/20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com/
> > >
> > > And that's an example of unacceptable land grab by LSM folks
> > > that I'm concerned about.
> >
> > I made sure that patchset was ACK'd or Reviewed-by'd a VFS maintainer,
> > a BPF LSM maintainer, and the Smack maintainer before merging (I
> > covered the LSM and SELinux parts).  You might want to double check
> > your definition of "land grab".
> 
> You're still missing the point.
> Christian could have landed it via vfs tree with your ack for security/*.
> You have no power over lsm hook changes within vfs.

Which tbf is generally how I like to handle thing especially since we
usually have a lot of changes. But I'm open to shared branches as well.

So I think we naturally have to modify existing LSM hooks. But it's
shared pain. Since we use BPF LSM heavily in systemd we generally have
to absorb such growing pains as well.
