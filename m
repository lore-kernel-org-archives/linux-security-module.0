Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B0445D905
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 23:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788995308; cv=pass; b=YQQHikEEiq925cdbkIc9bxiS1vf7zexdmzc3RIkBkliykGmhcfB2tCAmg+/dh2trQ4xtXkugs+brCgsvuHGLsR1wpmDWnwzJ0Dhkz99kSrVVTvclc8RLaY8sHBsXGE8VVphdkHaCL6tRpvTgnA+3ZlFgqcKVmwxFwW9WSsbTMZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788995308; c=relaxed/simple;
	bh=PXCiYUIUDFbcVYjS13LmGtnLqgKi8EElaJmcYhZhgTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+dIvdnGanlkR5TVZOd5eoBMhptE6I3Fh4qvS9sgBeRynXKkwOxw9jSO9Qe0ZGHIMPx2WhCdfWvW0VxEYrDMlv1EnfHnMe/wV3X7piOPpNV6Lt18FV+hBOuO6xZRDiRWam1D2+CgpS/A+ZjBnPWxi9IcDoLZYCXD45CvIK7MfK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=V9+arPla; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="V9+arPla"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-69fab5a852cso9531110a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 16:08:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788995304; cv=none;
        d=google.com; s=arc-20260327;
        b=Emabx4qWGPJwJTSVR+klDMTeWHD0gBOGNcTzd4BKpBPnc7CunzCA3LRoGbY4U3Lq6H
         YL25icRn3O29vp6CS969XbjyGi6jjoEkrpQE1UXSPYxU/VnFK+iEv3mQJlFEm3TprQqq
         gaESTOjQu55kRWsReg6kHLDca2lmzsyKXUxlA7fkkH24CvOVf4SVXnbDCDt98B8fJ5y4
         C1iob4XjCNfb1kHgI4Rc9vdpVtBHafsKoYczMN6xS1WnPrzq/PLAdVr1826l9/0vkiBg
         PR7KEZCx1vMambJc9uXG9/AN3fRAwA/Mf2LTHRD2rkFZtG88JZcza4K57sDnSeEs2ai+
         ORrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3HeYunSbblpdsvV1s5ghuqQTniP2lHfFC4mJtus2dow=;
        fh=kuoEpZyYTY5CJcwLTDJH4TNCKxheAiBDqWc1lDS01ic=;
        b=YcEl8SzByCPQa7vx/id+DYKCh2y4xA1uFLvk2ffialV7zwH67E19+OPqhRow9uRUxI
         Ci7Wd89lTcNgwk5AUQTNhN4Ah0e3TSGRtxAuEvGzPQFFL3sBjtzzfT1x4hN0QwUvDyMF
         /Fqh86PvctJ4JO3MBH+o2YYVJQ4/jLT+KT337YdpWt8VNH7fe+5zB2a/4i/CRRl/2IGB
         BMs63+xcDNg8OucX7lvZS4bUZ3I0c1WHIRWBqZ8jXSvWpxzIoPva0KpIQE4SVxgs/iVk
         vcZFpgxYxGzLnepeV8zYXFlHXM5gZEfKhuMnbJF8PcwpGlLkvOSDTPS3mj6bjTDCDJ7i
         xcRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788995304; x=1789600104; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3HeYunSbblpdsvV1s5ghuqQTniP2lHfFC4mJtus2dow=;
        b=V9+arPla0SL8qTc6bDoEa0KlmBKTUybqYAio8v07RTbEGg4p7JUSbkOyCeQlbQiKdm
         aNUIVrOuFwEvRQHmNAaaPyZQ5ZDpvbVVdAReB7FFGb5oSZGkSuB5h4N8cEhDxeX7Mve6
         MicGEG/4nRHuFOn9V9UOO1dsrAV6lrA38D0HmFtlV/GGyZh56NYoY7uHUogErRIExnvB
         rc/6q/KcbCwefGlgkrn2KoD/b12fmj9w+ia7aeqjRwthBCxmkIJYm5R4dgfpAIis38MK
         7g+8ILGrl9gyjr0XhnF+vN7pjldKPWRTMoh/BxpNZEqe8fs0vmbDxTBowkmMZUt1nmjO
         Av1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788995304; x=1789600104;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3HeYunSbblpdsvV1s5ghuqQTniP2lHfFC4mJtus2dow=;
        b=jyUNOxKnhyCGEbqjmqLeF00bLxY0G2OxgMD59i1OBREXS4S+ZYO76SCSyzZyDgESVQ
         BklvWcWl5ix92hgK6c9DzIm1qHg7tE7TfrvpFdKKJ0YAWx0lwoSHJiqeiBy8z3LdUiYB
         nn9568gMPk9ywEH6h+8lIx5r8UXRjhVa33sQmvWyuf5ww0KaVr641J4hSlOe1UEMaCU+
         h61Gn8+73iMeQ629jT66Z8CpledZVjPTfU5EbMRSXqYvSyV9X1rvRxHIJOYIqg/u51yX
         U59QYgxd4ixPuwq1hgfBrWw/J2p9bmajC9nYbjz/3f0dSzgupb8fNlHcldggEDiAmOVm
         o1HA==
X-Forwarded-Encrypted: i=1; AKwUvBxhzLSsel674MVQWP42qDkGLj7oBJKAEkbqa2Ysq3rU22iBjZfSmBETS+ws3TjPW7rddP0NLFAuh6LXSiuFuaIWClM3G0E=@vger.kernel.org
X-Gm-Message-State: AFuF++lNNAC7FHSakGngJ1aBzMtY3yVHdECu4g9yV4aqUu3odkzNY0HW
	C+DT2Nvwvx0SWtaD83Moi4JJ5YSdgteAbHj1HAyFnJNGAGqr7pX9B/b7lcaWNClrDM3D73Mo2tA
	lB32auy/2cIXwdTd9qiQtwCy9kdYong6I+SEujXSv
X-Gm-Gg: AYBFou2AA8PnpIErX5onB02H/jpx7DICOGjZiHwag+pQw95aDoHwVs6l5IKDOFxgJGe
	lejQxwSHUiYmIh/Jbfa5KA4apkT5eXxhx5FIpOphEJwclQfds1FjcxXQ44pBoY6IAPSHM0fQDM5
	5SzApZ/QL204+NkVulp5Qjwq+WW/oOvV9/928tfMsAp1Oljj9RBO2N9zlBx/N4oMi057Yb0S9k2
	gomGkuqXkbT07otBSKqfA352a8MdDI++Eclmh62sdzqb5fec1rkfJTH4vEwPIseiJIckq0s5D0i
	/T2qJ0ChEXgcCsZjF6/2oPm4lkvB81WW6QASpOtHSpF1iXOAaLOzJ1QtW8kmRmR/k7w7sCV66T7
	EEUGT2KqzI08=
X-Received: by 2002:a05:6402:51d3:b0:6a7:f25e:31c7 with SMTP id
 4fb4d7f45d1cf-6a7f25e3481mr12004386a12.19.1788995303609; Wed, 09 Sep 2026
 16:08:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-5-utilityemal77@gmail.com> <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
 <aqHUw6k0Mf83CGFT@zenbox>
In-Reply-To: <aqHUw6k0Mf83CGFT@zenbox>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Sep 2026 19:08:05 -0400
X-Gm-Features: AcwNN1VWtmI7TVPKE3LPkQppsWuLJXnoUTUb0EBC2ejua9Hn27X6xeBhQULdxgQ
Message-ID: <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 04/15] lsm: Add the bpf_lsm_policy_release
 kfunc and policy object destructor
To: Justin Suess <utilityemal77@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, matt@bobrowski.net, mic@digikod.net, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, 
	casey@schaufler-ca.com, gnoack@google.com, jack@suse.cz, song@kernel.org, 
	yonghong.song@linux.dev, martin.lau@linux.dev, eddyz87@gmail.com, 
	memxor@gmail.com, jolsa@kernel.org, m@maowtm.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 6:21=E2=80=AFPM Justin Suess <utilityemal77@gmail.co=
m> wrote:
> On Wed, Sep 09, 2026 at 05:34:31PM -0400, Paul Moore wrote:
> > On Wed, Sep 9, 2026 at 3:37=E2=80=AFPM Justin Suess <utilityemal77@gmai=
l.com> wrote:
> > >
> > > Add security/bpf_lsm_kfuncs.c, the home of the kfuncs exposing LSM
> > > policy objects to BPF programs, with the first of them:
> > >
> > >   bpf_lsm_policy_release(object)                KF_RELEASE
> > >
> > > The kfuncs are the LSM framework's own BPF interface: there is no
> > > per-LSM kfunc and no intermediate security_*() layer.  Each kfunc
> > > walks the matching hook's implementation list and calls the one
> > > registered by the LSM whose lsmid the policy object carries.  Calling
> > > a kfunc for an LSM that is not active or has no policy object support
> > > fails at runtime rather than hiding the kfunc at verification time,
> > > so BPF program loading is independent of the boot-time LSM
> > > configuration.
> > >
> > > A policy object reference is meant to be handed over through a map
> > > kptr field, so also register a destructor for struct
> > > lsm_policy_object: map-held references are dropped on map teardown,
> > > possibly from a context that cannot sleep, which the
> > > policy_object_put() hook contract accounts for.  For the same reason
> > > the kfunc is not KF_SLEEPABLE, and the filter adds no per-kfunc rule:
> > > releasing a reference must be allowed wherever one can be held.  The
> > > filter itself is needed because BPF_PROG_TYPE_LSM and
> > > BPF_PROG_TYPE_SYSCALL, the two registered program types, share their
> > > kfunc lookup buckets with other program types.
> > >
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Cc: KP Singh <kpsingh@kernel.org>
> > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > > ---
> > >
> > > Notes:
> > >     v2->v3:
> > >         - No change.
> > >
> > >  MAINTAINERS               |  1 +
> > >  security/Makefile         |  2 +-
> > >  security/bpf_lsm_kfuncs.c | 98 +++++++++++++++++++++++++++++++++++++=
++
> > >  3 files changed, 100 insertions(+), 1 deletion(-)
> > >  create mode 100644 security/bpf_lsm_kfuncs.c
> >
> > While not a new concern, it has been a few months so I want to mention
> > it again to see where things stand with the BPF crowd: are the BPF
> > folks still opposed to BPF kfuncs in security/bpf_lsm_kfuncs.c,
> > similar to fs/bpf_fs_kfuncs.c?
> >
> > If the answer remains yes, the BPF devs are not able to tolerate
> > kfuncs under security/, then I'm afraid this patchset is stuck.
> > However, if the BPF devs are willing to ACK kfuncs in
> > security/bpf_lsm_kfuncs.c, I'll add this patchset to the review queue
> > for the LSM tree.
> >
> To avocate for the current placement:
>
> Placing these kfuncs outside where it is in security/ would
> be very awkward, the kfuncs use lsm internal APIs
> (lsm_for_each_hook, active static keys, lsm dispatch table) that
> have no buisness outside the LSM framework.
>
> And logically, the kfuncs operate entirely on in-tree lsm objects.
>
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 6215fcb07770..ba816d7ee127 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -5081,6 +5081,7 @@ F:        kernel/bpf/bpf_lsm.c
> > >  F:     kernel/bpf/bpf_lsm_proto.c
> > >  F:     kernel/trace/bpf_trace.c
> > >  F:     security/bpf/
> > > +F:     security/bpf_lsm_kfuncs.c
> >
> > We would need the maintenence of security/bpf_lsm_kfuncs.c to fall to
> > the LSM framework, just as the maintenence of bpf_fs_funcs.c falls to
> > the VFS.
>
> Agreed.
>
> I intend that any security/ kfuncs go through both LSM and BPF
> review at a minimum. As a bug in any of these kfuncs or their permitted
> calling context / signatures could cause regressions in either subsystem.

While some other subsystems are lax on this, it's general practice in
the LSM space to *really* try to get ACK's from other affected
subsystems before merging.  Sometimes we move forward anyway, e.g.
patches being ignored for almost a year, but those are exceptions
rather than the rule.

I only bring this up because the MAINTAINERS entry was pointed at the
BPF devs, not the LSM devs.  I would expect that patches going into
security/bpf_lsm_kfuncs.c would need to be ACK'd both the LSM
framework and BPF LSM maintainers.

--=20
paul-moore.com
