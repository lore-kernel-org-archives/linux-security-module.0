Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF3F44CF5E;
	Wed, 16 Sep 2026 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789548519; cv=none; b=U7xEDpKvEVyKdCEg+LyRkXSwyyhJd0p7a02RHGbcgd2PiOQK+EvKCqU0zbL17h2AdAyz7QmJmBbEHEpcuC7qVYz3Ie5snDF+Vr0qm7amIM8UhrX5T8kndI3zOAOTM4x03k+xzyTesqS9756+wkXzTDNlKV98uUzpLzRbVsgnNk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789548519; c=relaxed/simple;
	bh=7viyZhT1PsGNuLATssRlBR2Wj5D393HVKb1HwpS+D+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8L5TLbIVxxFus426sLt2qG6/czjgzcLzU7T7ZnFlz3YVeCUhXOyf+70LP6sug54sMkP+6xvJrYOv+J2vMO6HKGetZ7Kq+3n2nEhAGvDi+wjyCip/FW3GrgLMbjOB+R3car6x1uA3z2OtxZg7nPkXq4PRtl5iwmmg2KRjuayzi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLkSQ1PS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLkSQ1PS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DA81F0089F;
	Wed, 16 Sep 2026 08:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789548516;
	bh=pJ4OWSMhlh2wgWK/560jVTv+uUvo5j+lZriJy4kTfhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cLkSQ1PSS6+7dfaFC8Ge5U6yFBDN3CZ3aJiyDQhW1Y0WYeZEdzZ/mTXyJznYS/dC1
	 YLb/l1MxblCyeeeOHlzTAHPGl/mMgKhK1MrMF6ORjMTOfIcAidq+GIT6TQs7hQrqwG
	 8w13M7Tx0f3+G+a1M9R3miCEjNmMfSDGfv3Xk0OwyYOIS8mOoGJaTLjearCV+5UIhJ
	 fpflFAF43rJTBecX4Kh/1Z9OIirhVANpR6E2ndm2yxC5Z1odRf2piNG4o5JVqbkU+J
	 3DONzQsFqec1jXf1e8p8aR2Ul2+DTwsILkwm77to6+4fjV3NU+3WMW74iKezl0rCRa
	 GryjcKIlKbNuQ==
Date: Wed, 16 Sep 2026 10:48:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
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
Message-ID: <20260916-vollrausch-tango-bagger-420300d403c7@brauner>
References: <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>
 <DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gmail.com>
 <aqTZdCz6JaoK16Fp@zenbox>
 <DLDL7KK3FZKU.17ADLLWJVXB5F@gmail.com>
 <CAHC9VhS0JckwfomqLTUJkZZkDSgeRXYOjMmPQYErgYynQYqMKQ@mail.gmail.com>
 <CAADnVQJCJjy9Eiwn6-88c0iOk4LfgPU6KBv+w0JZdBzmXBMUCw@mail.gmail.com>
 <CAHC9VhTh446SkpPF-hUiLYOHipuurzkgju_nH9LsRGdERSAL1w@mail.gmail.com>
 <CAADnVQLZscKkCxvK5puuOE1aN8nW6PnaS+_dx_zBQjjP2T-DFg@mail.gmail.com>
 <20260915-laken-ferngeblieben-verflachen-bafe1f296b02@brauner>
 <CAHC9VhTC5YvALs5K76qDBP9bDRpZPc_V-U8DPZ8qhNsCsXyLnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTC5YvALs5K76qDBP9bDRpZPc_V-U8DPZ8qhNsCsXyLnQ@mail.gmail.com>

On Tue, Sep 15, 2026 at 09:48:59AM -0400, Paul Moore wrote:
> On Tue, Sep 15, 2026 at 9:00 AM Christian Brauner <brauner@kernel.org> wrote:
> > On Sun, Sep 13, 2026 at 07:24:14PM -0700, Alexei Starovoitov wrote:
> > > On Sun, Sep 13, 2026 at 5:10 PM Paul Moore <paul@paul-moore.com> wrote:
> > > >
> > > > On Sun, Sep 13, 2026 at 7:25 PM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > On Sun, Sep 13, 2026 at 12:41 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > On Sat, Sep 12, 2026 at 3:33 PM Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > > On Fri Sep 11, 2026 at 10:26 PM PDT, Justin Suess wrote:
> > > > > > > >
> > > > > > > > If fs/, mm/, drivers/, net/, are permitted to have kfuncs, then why not
> > > > > > > > security/? kfuncs.rst doesn't seem to forbid this.
> > > > > > >
> > > > > > > because fs, mm, net see the value in bpf. bpf helps these subsytems
> > > > > > > to focus on their core technologies and moves policy decisions out of
> > > > > > > kernel and into bpf.
> > > > > > > while lsm people treat bpf as arch-enemy.
> > > > > >
> > > > > > It's amusing to read this when just this week we merged a patchset
> > > > > > into the LSM tree for the benefit of those writing BPF LSMs.  If you
> > > > > > look at the discussion around patch 2/2 you will even see a reasonable
> > > > > > exchange between Matt Bobrowski, a BPF LSM maintainer, and me about
> > > > > > the patch.  Alexei is obviously welcome to his own opinion, but I
> > > > > > would encourage those reading this thread to look beyond his comments.
> > > > > >
> > > > > > https://lore.kernel.org/linux-security-module/20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com/
> > > > >
> > > > > And that's an example of unacceptable land grab by LSM folks
> > > > > that I'm concerned about.
> > > >
> > > > I made sure that patchset was ACK'd or Reviewed-by'd a VFS maintainer,
> > > > a BPF LSM maintainer, and the Smack maintainer before merging (I
> > > > covered the LSM and SELinux parts).  You might want to double check
> > > > your definition of "land grab".
> > >
> > > You're still missing the point.
> > > Christian could have landed it via vfs tree with your ack for security/*.
> > > You have no power over lsm hook changes within vfs.
> >
> > Which tbf is generally how I like to handle thing especially since we
> > usually have a lot of changes. But I'm open to shared branches as well.
> >
> > So I think we naturally have to modify existing LSM hooks. But it's
> > shared pain. Since we use BPF LSM heavily in systemd we generally have
> > to absorb such growing pains as well.
> 
> I have no problem with topic branches that various trees can pull, but
> I do have an issue with the VFS tree merging patchsets that haven't
> been properly ACK'd as well as the VFS tree creating topic branches
> for patchsets that aren't primarily VFS changes.  See below:
> 
> https://lore.kernel.org/linux-security-module/CAHC9VhTE82bRRSXSUuMOdrfoMh=xOb5hDvqiKWzBKD1urab3hA@mail.gmail.com/
> 
> Christian, if you want us to move forward with topic branches in the
> LSM tree for LSM changes that touch fs/ code I'm happy to do that, but
> I need an acknowledgement from you that the behaviors mentioned above
> will be cleaned up in the future.

This is another instance where one of your mails around how to organize
process ends up reading like you're lecturing your peers. This is not
just my impression btw. That impression is shared by other subsystem
maintainers - including in your own.

This is a simple case where something got picked up that you didn't want
to have picked up yet. Plus, I haven't gotten around to reading this
yet. VFS isn't exactly a dormant subsystem.

The easy way is to just say "Hey, I don't think this is ready yet. Could
you please drop it. I also would like to quickly sync on how we want to
merge this.".

If another subsystems hooks into the vfs layer or filesystems that the
vfs trees maintain then the default will always be that the vfs layer
provides the shared tree to pull.
