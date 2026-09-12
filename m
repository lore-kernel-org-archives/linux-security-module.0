Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BEC299920
	for <linux-security-module@vger.kernel.org>; Sat, 12 Sep 2026 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789184249; cv=none; b=eJIx1IE9ET9cuNf+Mq9DQOkVQaEv00C6EdYEHWpzZLWX2Umw0O0zicoR510TvibTEy8a7UfkYkVv0gSFLBhUhOw3dHeGP4ur+F7XDvekCmXY2qMy6JAhBOlSKOylkJhqQb4x+PhtoIXRdCGu16U0kKwc1B0/+0ehKA0CvDiUrN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789184249; c=relaxed/simple;
	bh=FAr9tReetHGiitE150pNp7pPIhm3hZefJKyWwDq8/JI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TDoGBHTUAixikpg75UPpjt7/wLJ0ngrY/eELcAkeKLHSEw+7TVxZE/p9AuRd5I4+lHUB63OPolQ0rKlv5fXL6C9XDHm93zBbAWJK1A7gf6iSPyFLBTvob2K7eFf/aHR7lgS/TdLdj2RA47xjbhiEj+JHNSVauHjQsi4AinQwSNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7zubTUV; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7zubTUV"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-46ac530b9ebso1129435fac.0
        for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 20:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789184245; x=1789789045; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WmrWSnWNyTTCpi7ZqrIB5/x7yhuTuUn6rcorAMZT4zU=;
        b=R7zubTUVdyC4D3UkHl5hK/3v8ofG/SuEdRJVCoHWQK9YL7PpNIc6Pn2gXIUX58dOip
         oiBG3AlwYZCSMC6Os1E6PfwR0GqLVhRg6vvqxyk0eTx+TKKacyBP0WjQvht7sXdE74cv
         XbBV1estltTApxw1eU53LoZMGbVztlFv7eS2chE/alDEA4D3ePaNvm5nDzn54mHaGDwt
         v1NSCrI4lZeey83QqwL9HDqcQIwLXkz+aQM2YINixBsYhXmQJgzd58lrkFvPo7AwocBn
         NJI9AfGBA38M30UqolHMmSLQKRPa60138Hp+t4UCq+PZanbdDUDHLPydS/T2AU2f/x8T
         H4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789184245; x=1789789045;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WmrWSnWNyTTCpi7ZqrIB5/x7yhuTuUn6rcorAMZT4zU=;
        b=TX7baW6diHRhDknsv4BFskVzxZrXMdtOBfSQmwuTW47i1F3v3E+8mIT2PrrWeA7Ylw
         tGYkVy3T4bl22H+d0G8XIpeiD10LaBgqQYP2RV8e3QtpLq+BxTxcwy25ArJVkBIhj69C
         cpU6g6Aukzs97peEAeLCReGYbvjRuW6pLMNIYCPY8GXFT8JGiYTWmL15GwOW0GOOLX+E
         NeK4xlwDgqmq/x9XGt5GsMagZY+fbP+I2oum5JStXkrb9Qg/MikRcsRyaSklDNg7LW/R
         sJCWrPpw+JxLQCcmZZB7LBJFcKo/GEIEWNHswx0ecj/RPyANOkimlelXNZH/76X1sYGB
         IyNQ==
X-Forwarded-Encrypted: i=1; AKwUvBzVVPBEVMIVvoK43q665TuffznCWq1Xn+T0pUepDdXuzB54lg+QgYYi21U9LJIMaTfKKwZ0Hl7BfKjwjCctoeNWqxeByVw=@vger.kernel.org
X-Gm-Message-State: AFuF++m74WvWMyr3Vxzz4KA4Pp7pE6RnTtjvnng2zZt+C4Z2vcCRGu1C
	/IpTHET3naHRUtAZzV5gS7Q1G6BzkCGUYDTQwiouuEd/Z66AjLTzs21H
X-Gm-Gg: AYBFou3s/KuwbAK87zZdbQHO+VBI2Z5DbEe414iTxJGPtugz43uaRH7+N4AgPWA8Syv
	/XbTLc1eyK1eY4Q5EZ/W4qAHh5sB3PO5o3rqetjJZUmqpNHLF0Y1ERtPb8P8GC1o8oppyK7CjLa
	BZV276ON1zT0uN4W0uzXqAiFoTL+5zKfLOllp7IberyhYA7M/9IdhJW0GlXoQdv7G8D+jLG7KL0
	NwPERl78Epl/7NJ7ba7PGDO8ZW4qGyECjd4oWwGhsPPpfn3sBoZaMDZ0TqZYVzxHqH6IC0rLbM5
	NR5DRazgbm22lZ6tQImu48txJ6cuaoF5C6LCOAPgQSUvnOyyaObpxKxlj4ZlmBU57/Dbcp6mhPI
	86zmvSqXh7unSHjfNFJojyXt/q5o8KY/ZOc+BEFYqwVVC0nY7/ITSDXMEdbmWhIdobraJ9jot3d
	dtTNnWaSLIRXUxm8vU17k1La8GgslGKTu+bfrXUpCT/4NEu8wPT7Z4jXYVeUCMSN1hafY/Swqpb
	ewLSdnmLDyxxH4pFVQ1AA97c5p7IVfADXVupDfosuL2rqMqhxZQPYJ3BLYn6wUUyg==
X-Received: by 2002:a05:6870:5d95:b0:467:e082:b93c with SMTP id 586e51a60fabf-47c970414cemr6741625fac.2.1789184245328;
        Fri, 11 Sep 2026 20:37:25 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:42::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47df8bd0278sm3471827fac.7.2026.09.11.20.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 20:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Sep 2026 20:37:22 -0700
Message-Id: <DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gmail.com>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <kpsingh@kernel.org>, <matt@bobrowski.net>, <mic@digikod.net>,
 <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <kees@kernel.org>,
 <casey@schaufler-ca.com>, <gnoack@google.com>, <jack@suse.cz>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <martin.lau@linux.dev>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <jolsa@kernel.org>,
 <m@maowtm.org>, <bpf@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 04/15] lsm: Add the bpf_lsm_policy_release
 kfunc and policy object destructor
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Paul Moore" <paul@paul-moore.com>, "Justin Suess"
 <utilityemal77@gmail.com>
X-Mailer: aerc
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-5-utilityemal77@gmail.com>
 <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
 <aqHUw6k0Mf83CGFT@zenbox>
 <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>
In-Reply-To: <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>

On Wed Sep 9, 2026 at 4:08 PM PDT, Paul Moore wrote:
> On Wed, Sep 9, 2026 at 6:21=E2=80=AFPM Justin Suess <utilityemal77@gmail.=
com> wrote:
>> On Wed, Sep 09, 2026 at 05:34:31PM -0400, Paul Moore wrote:
>> > On Wed, Sep 9, 2026 at 3:37=E2=80=AFPM Justin Suess <utilityemal77@gma=
il.com> wrote:
>> > >
>> > > Add security/bpf_lsm_kfuncs.c, the home of the kfuncs exposing LSM
>> > > policy objects to BPF programs, with the first of them:
>> > >
>> > >   bpf_lsm_policy_release(object)                KF_RELEASE
>> > >
>> > > The kfuncs are the LSM framework's own BPF interface: there is no
>> > > per-LSM kfunc and no intermediate security_*() layer.  Each kfunc
>> > > walks the matching hook's implementation list and calls the one
>> > > registered by the LSM whose lsmid the policy object carries.  Callin=
g
>> > > a kfunc for an LSM that is not active or has no policy object suppor=
t
>> > > fails at runtime rather than hiding the kfunc at verification time,
>> > > so BPF program loading is independent of the boot-time LSM
>> > > configuration.
>> > >
>> > > A policy object reference is meant to be handed over through a map
>> > > kptr field, so also register a destructor for struct
>> > > lsm_policy_object: map-held references are dropped on map teardown,
>> > > possibly from a context that cannot sleep, which the
>> > > policy_object_put() hook contract accounts for.  For the same reason
>> > > the kfunc is not KF_SLEEPABLE, and the filter adds no per-kfunc rule=
:
>> > > releasing a reference must be allowed wherever one can be held.  The
>> > > filter itself is needed because BPF_PROG_TYPE_LSM and
>> > > BPF_PROG_TYPE_SYSCALL, the two registered program types, share their
>> > > kfunc lookup buckets with other program types.
>> > >
>> > > Cc: Paul Moore <paul@paul-moore.com>
>> > > Cc: KP Singh <kpsingh@kernel.org>
>> > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
>> > > ---
>> > >
>> > > Notes:
>> > >     v2->v3:
>> > >         - No change.
>> > >
>> > >  MAINTAINERS               |  1 +
>> > >  security/Makefile         |  2 +-
>> > >  security/bpf_lsm_kfuncs.c | 98 ++++++++++++++++++++++++++++++++++++=
+++
>> > >  3 files changed, 100 insertions(+), 1 deletion(-)
>> > >  create mode 100644 security/bpf_lsm_kfuncs.c
>> >
>> > While not a new concern, it has been a few months so I want to mention
>> > it again to see where things stand with the BPF crowd: are the BPF
>> > folks still opposed to BPF kfuncs in security/bpf_lsm_kfuncs.c,
>> > similar to fs/bpf_fs_kfuncs.c?
>> >
>> > If the answer remains yes, the BPF devs are not able to tolerate
>> > kfuncs under security/, then I'm afraid this patchset is stuck.
>> > However, if the BPF devs are willing to ACK kfuncs in
>> > security/bpf_lsm_kfuncs.c, I'll add this patchset to the review queue
>> > for the LSM tree.
>> >
>> To avocate for the current placement:
>>
>> Placing these kfuncs outside where it is in security/ would
>> be very awkward, the kfuncs use lsm internal APIs
>> (lsm_for_each_hook, active static keys, lsm dispatch table) that
>> have no buisness outside the LSM framework.
>>
>> And logically, the kfuncs operate entirely on in-tree lsm objects.
>>
>> > > diff --git a/MAINTAINERS b/MAINTAINERS
>> > > index 6215fcb07770..ba816d7ee127 100644
>> > > --- a/MAINTAINERS
>> > > +++ b/MAINTAINERS
>> > > @@ -5081,6 +5081,7 @@ F:        kernel/bpf/bpf_lsm.c
>> > >  F:     kernel/bpf/bpf_lsm_proto.c
>> > >  F:     kernel/trace/bpf_trace.c
>> > >  F:     security/bpf/
>> > > +F:     security/bpf_lsm_kfuncs.c
>> >
>> > We would need the maintenence of security/bpf_lsm_kfuncs.c to fall to
>> > the LSM framework, just as the maintenence of bpf_fs_funcs.c falls to
>> > the VFS.
>>
>> Agreed.
>>
>> I intend that any security/ kfuncs go through both LSM and BPF
>> review at a minimum. As a bug in any of these kfuncs or their permitted
>> calling context / signatures could cause regressions in either subsystem=
.
>
> While some other subsystems are lax on this, it's general practice in
> the LSM space to *really* try to get ACK's from other affected
> subsystems before merging.  Sometimes we move forward anyway, e.g.
> patches being ignored for almost a year, but those are exceptions
> rather than the rule.
>
> I only bring this up because the MAINTAINERS entry was pointed at the
> BPF devs, not the LSM devs.  I would expect that patches going into
> security/bpf_lsm_kfuncs.c would need to be ACK'd both the LSM
> framework and BPF LSM maintainers.

There is will be no kfuncs under security/.
Period.

