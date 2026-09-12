Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B19E383326
	for <linux-security-module@vger.kernel.org>; Sat, 12 Sep 2026 05:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789190814; cv=none; b=PwYyDW6I0NMwAX3tIec6wnvlrMw5nqUJeAe38tulqjJGzdg+CMczmGI3zq9Ob9BDlEZLUMv0fw92sLHDG2BT5jpdhZTrPf0Q4IVp/2dtJNJCZf2P3NHgZcyUTn25r1raMUznpZdl/XKlAPlJEBaoWY0+GfJpdkxKecGooeMCFHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789190814; c=relaxed/simple;
	bh=oGrqY7oiATnnJ5ATU1qCem3mCbK4/B1ftouNKkjMoYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjHwly8NNaB1rIZD2ShuRgg9SylFc+xDoL4Mq2xg6njhmj/XPqRgP8RUrZecqO9whi7KS/cPbNDw1Prf9Qbh5DXUL5R6+bFBIJWGrWFFYW9TlEDACE0FDCep1wUrb+kqnyjVas2UK8isUbWoOdf93kPuShPPvjKTp3MqiXyNeH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ+qtsEJ; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ+qtsEJ"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4aae3147so441648d50.1
        for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 22:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789190809; x=1789795609; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KgbaZUuPh6OacHvhQLfbnUE+2CYqd4A1QNPAO9N6LkA=;
        b=fZ+qtsEJ0wnjv9KwJ+uFnwcrHWMzceLrYZyZiltgctQqmsvcstaaKRCxxdTZXgJpQZ
         WWVDLh/i/eaiEebsaPp9i7r8Ohp6wJcFqbhHeKSIZHDpDP3U9uWVddBfYJEV9A0u1vPW
         ImvUwc2V/iuFfJunzuBUbRnorCgdzIgL5l1x75Sxf/MLmkmuH4xJcq56qzz4cjhjHt/V
         mTfzwGKrqZ4vsF4xYzBvQWPitR9Djol3XTzcTdD85MxyMptIXKudxmrPPV23wFDkhq+a
         5rlxwhSr/lTWDn1YGcBGk9Y129+fxYrKTNO5ZN99+CTIp8sj3dDhrKJetmj6VSrCKFAo
         0c+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789190809; x=1789795609;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KgbaZUuPh6OacHvhQLfbnUE+2CYqd4A1QNPAO9N6LkA=;
        b=AXavX1z1qnfKQYzGAEdjxHy/LPkWSYcEfsQ+wz+ycudHgcuwvp/97rfCZhUPrDIPm1
         RcPjfKeOp38ay8IIsdWzJQ3ppYkodyHj6ODSPzxvzGBiCH+4GwxdBPLY8ySUBn4E5OXS
         EpHLuKIHIQWMqPGRmhQBD/Q0wsuT2E+vlliPas7JZQiUEMvj9MvXv3mjhZOHa2hK9QXd
         LuqmRTHov+MqZ6D87O7dAse5tCrxij3FSuGde4GqBsd+WErzEeAzDoyInYCD48bEaKrg
         uod9ZvYBAe/TE8YvbZkM+sSyGFDNlYNhSQFmAQEnQlwc+T8iaHNeuD1OkGSGI9ZgXVR3
         YhBg==
X-Forwarded-Encrypted: i=1; AKwUvBwXQZoEtMO3s7NYXF/qQpnEnx6+MHeH0H1EsOwzMI91mlZoI/9wiQ/JiLvEI54gpS/3njKjDwHrbhHbRXId0LQMS/k3y5Y=@vger.kernel.org
X-Gm-Message-State: AFuF++n6ClZxwTn3NIaoqFJUwUSrnrgesu6wnb7KphBLfbjfIhK5Oxa3
	5AcMkk9J64G+dKjN3nVOgnBTXzdo9xDdMirW2SYbdJ018RMj/LvFvssc
X-Gm-Gg: AYBFou12SF7WAhn/5O+vyOYTdTFGXP/Z+JgpxTIXVmPjZnV+3FFdzJuSD/KzkRCrkGU
	AmOFMyUfQUMFT10vCnLIa3aRjSVe64fZicLF4OGk7OXhtdEnkX7+oOHiJVzvipCOeE6qjl+gofM
	apHW9F7ESlEwVc+N1ElLHG0ZeSYjjtwmRkkS1hZGMKICgdLx8qJj7AKDd7OVpc8XaUGlOhge411
	fZfS8GvJE8EkVHm93EuNE2IvvrUU4SLF8IFCFcPVoYXjnr3WsGpQ4KQ6qUv+AlzWLWvfAZqHPF/
	rLlTpl5OgnTJdIag8NvUxGRwe98VzWNLtufAjkDvOZup5cto2HOWEiRTgrxnfDTSA2ZoutbUrHc
	+oXiCtQmvHOf/fXPg53nvSMHxqFR2fwMXo3QIQfG2C8PMpvUzb2pDSw5NIRS8oTxfm5nJHk2Crt
	s6EnoR0OsJNYJm57MbaaZbZOJEF1TunDxXiiOuULNX96x+x4kIuFshLK79C6w7Al4m2MAAUWo8Z
	e/gftOTi2yHuG7QZfQnsMQHiPh6tq8S2Q==
X-Received: by 2002:a05:690e:144e:b0:671:2832:efe8 with SMTP id 956f58d0204a3-6712832f61dmr2567610d50.47.1789190808818;
        Fri, 11 Sep 2026 22:26:48 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:70da:1bc0:eb81:aa1b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-88489500e19sm18296697b3.47.2026.09.11.22.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 22:26:48 -0700 (PDT)
Date: Sat, 12 Sep 2026 01:26:47 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, kpsingh@kernel.org, matt@bobrowski.net, mic@digikod.net, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, casey@schaufler-ca.com, 
	gnoack@google.com, jack@suse.cz, song@kernel.org, yonghong.song@linux.dev, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, jolsa@kernel.org, 
	m@maowtm.org, bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 04/15] lsm: Add the bpf_lsm_policy_release
 kfunc and policy object destructor
Message-ID: <aqTZdCz6JaoK16Fp@zenbox>
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-5-utilityemal77@gmail.com>
 <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
 <aqHUw6k0Mf83CGFT@zenbox>
 <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>
 <DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gmail.com>

On Fri, Sep 11, 2026 at 08:37:22PM -0700, Alexei Starovoitov wrote:
> On Wed Sep 9, 2026 at 4:08 PM PDT, Paul Moore wrote:
> > On Wed, Sep 9, 2026 at 6:21 PM Justin Suess <utilityemal77@gmail.com> wrote:
> >> On Wed, Sep 09, 2026 at 05:34:31PM -0400, Paul Moore wrote:
> >> > On Wed, Sep 9, 2026 at 3:37 PM Justin Suess <utilityemal77@gmail.com> wrote:
> >> > >
> >> > > Add security/bpf_lsm_kfuncs.c, the home of the kfuncs exposing LSM
> >> > > policy objects to BPF programs, with the first of them:
> >> > >
> >> > >   bpf_lsm_policy_release(object)                KF_RELEASE
> >> > >
> >> > > The kfuncs are the LSM framework's own BPF interface: there is no
> >> > > per-LSM kfunc and no intermediate security_*() layer.  Each kfunc
> >> > > walks the matching hook's implementation list and calls the one
> >> > > registered by the LSM whose lsmid the policy object carries.  Calling
> >> > > a kfunc for an LSM that is not active or has no policy object support
> >> > > fails at runtime rather than hiding the kfunc at verification time,
> >> > > so BPF program loading is independent of the boot-time LSM
> >> > > configuration.
> >> > >
> >> > > A policy object reference is meant to be handed over through a map
> >> > > kptr field, so also register a destructor for struct
> >> > > lsm_policy_object: map-held references are dropped on map teardown,
> >> > > possibly from a context that cannot sleep, which the
> >> > > policy_object_put() hook contract accounts for.  For the same reason
> >> > > the kfunc is not KF_SLEEPABLE, and the filter adds no per-kfunc rule:
> >> > > releasing a reference must be allowed wherever one can be held.  The
> >> > > filter itself is needed because BPF_PROG_TYPE_LSM and
> >> > > BPF_PROG_TYPE_SYSCALL, the two registered program types, share their
> >> > > kfunc lookup buckets with other program types.
> >> > >
> >> > > Cc: Paul Moore <paul@paul-moore.com>
> >> > > Cc: KP Singh <kpsingh@kernel.org>
> >> > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> >> > > ---
> >> > >
> >> > > Notes:
> >> > >     v2->v3:
> >> > >         - No change.
> >> > >
> >> > >  MAINTAINERS               |  1 +
> >> > >  security/Makefile         |  2 +-
> >> > >  security/bpf_lsm_kfuncs.c | 98 +++++++++++++++++++++++++++++++++++++++
> >> > >  3 files changed, 100 insertions(+), 1 deletion(-)
> >> > >  create mode 100644 security/bpf_lsm_kfuncs.c
> >> >
> >> > While not a new concern, it has been a few months so I want to mention
> >> > it again to see where things stand with the BPF crowd: are the BPF
> >> > folks still opposed to BPF kfuncs in security/bpf_lsm_kfuncs.c,
> >> > similar to fs/bpf_fs_kfuncs.c?
> >> >
> >> > If the answer remains yes, the BPF devs are not able to tolerate
> >> > kfuncs under security/, then I'm afraid this patchset is stuck.
> >> > However, if the BPF devs are willing to ACK kfuncs in
> >> > security/bpf_lsm_kfuncs.c, I'll add this patchset to the review queue
> >> > for the LSM tree.
> >> >
> >> To avocate for the current placement:
> >>
> >> Placing these kfuncs outside where it is in security/ would
> >> be very awkward, the kfuncs use lsm internal APIs
> >> (lsm_for_each_hook, active static keys, lsm dispatch table) that
> >> have no buisness outside the LSM framework.
> >>
> >> And logically, the kfuncs operate entirely on in-tree lsm objects.
> >>
> >> > > diff --git a/MAINTAINERS b/MAINTAINERS
> >> > > index 6215fcb07770..ba816d7ee127 100644
> >> > > --- a/MAINTAINERS
> >> > > +++ b/MAINTAINERS
> >> > > @@ -5081,6 +5081,7 @@ F:        kernel/bpf/bpf_lsm.c
> >> > >  F:     kernel/bpf/bpf_lsm_proto.c
> >> > >  F:     kernel/trace/bpf_trace.c
> >> > >  F:     security/bpf/
> >> > > +F:     security/bpf_lsm_kfuncs.c
> >> >
> >> > We would need the maintenence of security/bpf_lsm_kfuncs.c to fall to
> >> > the LSM framework, just as the maintenence of bpf_fs_funcs.c falls to
> >> > the VFS.
> >>
> >> Agreed.
> >>
> >> I intend that any security/ kfuncs go through both LSM and BPF
> >> review at a minimum. As a bug in any of these kfuncs or their permitted
> >> calling context / signatures could cause regressions in either subsystem.
> >
> > While some other subsystems are lax on this, it's general practice in
> > the LSM space to *really* try to get ACK's from other affected
> > subsystems before merging.  Sometimes we move forward anyway, e.g.
> > patches being ignored for almost a year, but those are exceptions
> > rather than the rule.
> >
> > I only bring this up because the MAINTAINERS entry was pointed at the
> > BPF devs, not the LSM devs.  I would expect that patches going into
> > security/bpf_lsm_kfuncs.c would need to be ACK'd both the LSM
> > framework and BPF LSM maintainers.
> 
> There is will be no kfuncs under security/.
> Period.
> 
Howdy Alexei,

If fs/, mm/, drivers/, net/, are permitted to have kfuncs, then why not
security/? kfuncs.rst doesn't seem to forbid this.

Placement in security/, on my initial thought, was the most logically relevant place
for kfuncs that interact with in-tree LSMs, as we place fs kfuncs under fs/,
net kfuncs under net/ etc.

Where would you point me to?

Thanks,
Justin
