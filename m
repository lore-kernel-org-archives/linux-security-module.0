Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4293DA7C8
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 22:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788992463; cv=none; b=IRGrq95VuIESj4QbYC/yW1y52O6X7PoTNMAOTKaiYJo0XlIa36Vqvrx8lJQyKBXVXGSDFSroJLbRDmmo+wzLAKsJlkLDSenlp8d5CnUm5YfTdEDzjzUEaT/TYg5foTPhPdwWw3tMpepiDG/LbJzpyf2qD2ABBAJPmDDWALMMJvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788992463; c=relaxed/simple;
	bh=VLRD/HiFi/GxbQj8PeNPU/EKMxkUn5PB7K/ha5tC76E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHkTDvaQnLav4kvij40Wp1GwhI6AcXqD6o2ZHmfpCGPkY35CuvLBxKnznZgfJ50hmdvCt9dx1TngT1AB79y4XRyuo00XYvug84zvYsJz5ET+CeEgJ0c7TxDPTs+wNI8V4lAHLheGrWXt9keOmk+7lMpRpwaNU1oioS5y5BGtHR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qbb1kSK6; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qbb1kSK6"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66fb2fa79f2so4903268d50.0
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 15:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788992460; x=1789597260; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hPyUNlK5ySA3jIC7v7yMIwiALm7eVfCZWgGZ6vs5Uc4=;
        b=Qbb1kSK67A5OtUER2gAI4th1AQlDHTYY9v2zjsIp3lFpQ4VpGzDGy8uXJolxOeO8mk
         zhHTgXUQMsXYVUx5RKXkOE7tMboZTvARsvpqpji3D+c1rgtnEsFvz1ivgjUaTVpN9rLi
         WlHLMQs1CtLG6xAOBFS4K9+ik7fAj1tPWsWn+2ZBYmGP7X+TlToqNeKj+5L6FisSKtyn
         jb8nmvY3tMdYeQFxzyak+yf5/GhSc4FFzf5rh2ky/RpzZHf1uBJnEtmFRX0TmPHb5/PU
         VqwGUbYCUYutBlkWgIWdMniQ5Y9klI8RcyOzzYFBLM1YS1dkXGiso0lOW14YDk/0Dx8P
         JzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992460; x=1789597260;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hPyUNlK5ySA3jIC7v7yMIwiALm7eVfCZWgGZ6vs5Uc4=;
        b=gZKXV31Hjoye9j/Cu2oAeVffuv2uixt7nX3Ueo/5T7HJduTBqlVxq1hC1j3elvLAnb
         QTEia2m9u5OSaFOFK2w4CvTA0Hoh1x1NAbhgDYpNGmIcc7gm3hrxbaqlK2C6EEXA33fk
         L4aril1h/s4QzbrWQeuTjZGM7DXoVjgc+hkoJDKWja5OfufSQOciqriuXFvAwksSeS/N
         NQWRUKnpWdaH2VTcsnaOdxWpf+CYTceyQNfyqQKZ0FNKHDdGZOWHcmVLqvD35SPZw2XM
         nE8BJUbtl79i3A8r3Q+wiYxACFa7QRba6a4xyy8i9yY122IuQA9zyXc/nsO+84QV87lG
         8rrQ==
X-Forwarded-Encrypted: i=1; AKwUvBwN3iGP7o6L2X9LhI7xbqtDP/kz+/7fFCwghTj52Cihws+tITnkBhKvRacKkeVoQn3FYFxqyPWDBzANfA5LQmTHw34H824=@vger.kernel.org
X-Gm-Message-State: AFuF++nCl4Ylr1InWaFaYvSp6JddDEUgYz6us+N74SZUGqkoBjCiOHPT
	hNAN+UMSZKzseKd9KVxJLtfgCXMce9XmNVAtSUZPgnbyt0hWeNSsokzP
X-Gm-Gg: AYBFou0nzGPVrxdo3E8mQT2oo/rEUuOxz0BV3t8MQyPiFQKrXpIqvlh8G9asbwrbRhL
	oyUXPFlweIUoDtzYqdJqGX+ZJXyIf2Gxh/N7LMXM9qXOHTxrldB+C1y4CSXIdU5zTFTYN8gGDsl
	X8OpCiGtKgp6HiWqqp4oclP+wQTSPQaOpD8Jac1HeApJeT1d7iaGpmw/ODYqkkTqhcvmMIo+3yq
	e1SOuJbBjP9AbvV8VfCfS8bhaHWC9Qg/Dt/4iUMdfHieN8nfGTQE7ycPwKgDpyPXd1XtI5cQP6q
	BLuE2e9YZYBRYABPZFRu8QtsImLygDr9gSZMUjUwa9CqnxtGDiYMTTHS+fM+RUKlrVmIUrw8RyI
	D1XQIifcR++R5VK30uZDIJ3Tb/yfF2EQQw7P7e4154UUyfHzR3itn6trte2CWdEAU0WuHPVyMd6
	5LRd/dGOKsDssxLUs8zaF/jDw6y+tVaetK//e5tt2ZmapB9dNYuCCqqTtcpnnCKIJuA5/8Hv+ED
	bhf1Ey6dKdT6hXvJzyY/zfUDX8lJYdE
X-Received: by 2002:a53:cb09:0:b0:66f:c1bc:4075 with SMTP id 956f58d0204a3-66fc1bc4696mr8411416d50.56.1788992459904;
        Wed, 09 Sep 2026 15:20:59 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:bae:bfc2:7e96:e5c8])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb4641680sm12956460d50.0.2026.09.09.15.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:20:59 -0700 (PDT)
Date: Wed, 9 Sep 2026 18:20:58 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, matt@bobrowski.net, mic@digikod.net, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, kees@kernel.org, casey@schaufler-ca.com, gnoack@google.com, 
	jack@suse.cz, song@kernel.org, yonghong.song@linux.dev, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, jolsa@kernel.org, m@maowtm.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 04/15] lsm: Add the bpf_lsm_policy_release
 kfunc and policy object destructor
Message-ID: <aqHUw6k0Mf83CGFT@zenbox>
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-5-utilityemal77@gmail.com>
 <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>

On Wed, Sep 09, 2026 at 05:34:31PM -0400, Paul Moore wrote:
> On Wed, Sep 9, 2026 at 3:37 PM Justin Suess <utilityemal77@gmail.com> wrote:
> >
> > Add security/bpf_lsm_kfuncs.c, the home of the kfuncs exposing LSM
> > policy objects to BPF programs, with the first of them:
> >
> >   bpf_lsm_policy_release(object)                KF_RELEASE
> >
> > The kfuncs are the LSM framework's own BPF interface: there is no
> > per-LSM kfunc and no intermediate security_*() layer.  Each kfunc
> > walks the matching hook's implementation list and calls the one
> > registered by the LSM whose lsmid the policy object carries.  Calling
> > a kfunc for an LSM that is not active or has no policy object support
> > fails at runtime rather than hiding the kfunc at verification time,
> > so BPF program loading is independent of the boot-time LSM
> > configuration.
> >
> > A policy object reference is meant to be handed over through a map
> > kptr field, so also register a destructor for struct
> > lsm_policy_object: map-held references are dropped on map teardown,
> > possibly from a context that cannot sleep, which the
> > policy_object_put() hook contract accounts for.  For the same reason
> > the kfunc is not KF_SLEEPABLE, and the filter adds no per-kfunc rule:
> > releasing a reference must be allowed wherever one can be held.  The
> > filter itself is needed because BPF_PROG_TYPE_LSM and
> > BPF_PROG_TYPE_SYSCALL, the two registered program types, share their
> > kfunc lookup buckets with other program types.
> >
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: KP Singh <kpsingh@kernel.org>
> > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > ---
> >
> > Notes:
> >     v2->v3:
> >         - No change.
> >
> >  MAINTAINERS               |  1 +
> >  security/Makefile         |  2 +-
> >  security/bpf_lsm_kfuncs.c | 98 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 100 insertions(+), 1 deletion(-)
> >  create mode 100644 security/bpf_lsm_kfuncs.c
> 
> While not a new concern, it has been a few months so I want to mention
> it again to see where things stand with the BPF crowd: are the BPF
> folks still opposed to BPF kfuncs in security/bpf_lsm_kfuncs.c,
> similar to fs/bpf_fs_kfuncs.c?
> 
> If the answer remains yes, the BPF devs are not able to tolerate
> kfuncs under security/, then I'm afraid this patchset is stuck.
> However, if the BPF devs are willing to ACK kfuncs in
> security/bpf_lsm_kfuncs.c, I'll add this patchset to the review queue
> for the LSM tree.
>
To avocate for the current placement:

Placing these kfuncs outside where it is in security/ would
be very awkward, the kfuncs use lsm internal APIs
(lsm_for_each_hook, active static keys, lsm dispatch table) that
have no buisness outside the LSM framework.

And logically, the kfuncs operate entirely on in-tree lsm objects.

> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6215fcb07770..ba816d7ee127 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5081,6 +5081,7 @@ F:        kernel/bpf/bpf_lsm.c
> >  F:     kernel/bpf/bpf_lsm_proto.c
> >  F:     kernel/trace/bpf_trace.c
> >  F:     security/bpf/
> > +F:     security/bpf_lsm_kfuncs.c
> 
> We would need the maintenence of security/bpf_lsm_kfuncs.c to fall to
> the LSM framework, just as the maintenence of bpf_fs_funcs.c falls to
> the VFS.
>
Agreed.

I intend that any security/ kfuncs go through both LSM and BPF
review at a minimum. As a bug in any of these kfuncs or their permitted
calling context / signatures could cause regressions in either subsystem.

Justin
>   % ./scripts/get_maintainer.pl -f fs/bpf_fs_kfuncs.c
>   Alexander Viro
>   Christian Brauner
>   Jan Kara
>   linux-fsdevel@vger
>   linux-kernel@vger
> 
> -- 
> paul-moore.com
