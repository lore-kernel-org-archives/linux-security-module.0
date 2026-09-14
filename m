Received: from wind.enjellic.com (wind.enjellic.com [67.230.224.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8B4377567;
	Mon, 14 Sep 2026 21:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.230.224.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789421090; cv=none; b=YA4aKoypiOmLA6oFkgKy3rTbqkYT0gS/FLJMTUQdv6Hq9hdduxyc84HLVSKHfwvTkhCYG95D9lTJDU4pkZGPMDSJ+5nCHaypR74SfG2pq4vvZ1NDMhGfFWEWpFy8QrMyz/XRwmlG9qBsKv212dveGXWWxCBxMUPWPZzYAjix1pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789421090; c=relaxed/simple;
	bh=NViCHrnd3m24sOLMApGT9OBLH5NNtssA4JEmXRlkfUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfAXUyhwTN5NdE6t/s1y6CJQsaBjiqWpOoPKOhxuCIJ9LuGZmB8kJ7RhPEc7i7mHcfXXv+pyiXqk1Xe7gwSEucnP51o+BewnVb6GSP+z5SqIc8beFwtsjQuyzdNZsAsmt4gtAVG/qaTqSg+kZHzmy+a6cD5bl9VtEXY1zd3onqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=67.230.224.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 68ELIZgV022271;
	Mon, 14 Sep 2026 16:18:35 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 68ELIWZT022270;
	Mon, 14 Sep 2026 16:18:32 -0500
Date: Mon, 14 Sep 2026 16:18:32 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Justin Suess <utilityemal77@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Matt Bobrowski <matt@bobrowski.net>,
        Micka??l Sala??n <mic@digikod.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        G??nther Noack <gnoack@google.com>, Jan Kara <jack@suse.cz>,
        Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
        Eduard <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Tingmao Wang <m@maowtm.org>,
        bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: LSM boundaries. Was: [PATCH bpf-next v3 04/15] lsm: Add the
 bpf_lsm_policy_release kfunc and policy object destructor
Message-ID: <aqhkqDvwM6loGihB@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLZscKkCxvK5puuOE1aN8nW6PnaS+_dx_zBQjjP2T-DFg@mail.gmail.com>
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Mon, 14 Sep 2026 16:18:35 -0500 (CDT)

On Sun, Sep 13, 2026 at 07:24:14PM -0700, Alexei Starovoitov wrote:

> On Sun, Sep 13, 2026 at 5:10???PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Sun, Sep 13, 2026 at 7:25???PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Sun, Sep 13, 2026 at 12:41???PM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Sat, Sep 12, 2026 at 3:33???PM Alexei Starovoitov
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

> You're still missing the point.
> Christian could have landed it via vfs tree with your ack for security/*.
> You have no power over lsm hook changes within vfs.

I've indicated to a number of colleagues that this issue would begin
to generate considerable dialogue, once everyone finished with their
summer holidays, I see that fact is now eventuating.

There is an important discussion to be had that affects the ability of
Linux to serve the security needs of its constituency, which at this
point now, is pretty much the planet and beyond.  Advancing a relevant
discussion requires casting the underlying issue involved in all of
this into perhaps the glow of harsh sunlight.

The issue at hand is not who gets to ACK or NACK various security
relevant infrastructure, based on who manages source code in a
particular directory heirarchy.

The underlying motivation driving all of this is who gets to control
and define what can be advertised as 'mainline' Linux security.  This
has been the bane of Linux security development for a quarter century
now, Linus openly acknowledges this fact, ie. security people can
never agree on how to do things.

Given the power that this control conveys on certain parties, the
objective of maintaining this type of control is certainly
understandable.

I have deep respect for Linus, but he has failed to demonstrate
appropriate leadership on this front.  Indicating that people should
simply figure out how to use what is already in Linux, given the
current technological tsunami of machine modeling/learning overtaking
all of us, is so hopelessly naive that I cannot believe that he
actually believes what he is saying.

The current static security architectures in Linux, supported by the
LSM model and its development processes, while still technically
useful, will not be operationally relevant to the technology industry
by the end of the decade.

We need a technical architecture to fix to what is a political
problem.  That seems consistent with Linux development ostensibly
being about technology rather than politics.

The steps in recovery are admitting, and then identifying, that one
has a problem, before it can be fixed.  Given the agendas involved it
seems like a great role for the Linux Foundation to assist with.

We now return you to your regularily scheduled programming of who gets
to ACK/NACK kfuncs.

Greg

My opinions and those of my Golden Retriever Hezzie only.
