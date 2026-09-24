Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892A04C7557
	for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790278501; cv=pass; b=QqJ29vqJlKq8kwCLGaPGQhg1+I1gCuQEAaOierCrPvFa4dmQT7nn/hSS2bUxHhnrS4k8UwkKN1qxNqH2NeGS0hiNNB57sthgHPyCeoOVtDeLdptaEyNVmrxJ40uh/MK4JnMAFKGexV1zlmWVzA2kDSd/f+ntinN7/1RGkvBIKn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790278501; c=relaxed/simple;
	bh=Xh6cigaJGh2nl2K1gfL4NfpjbUyrPHxMoHdW4U9oa2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOyGCJyu6bVERwW1RuM63wyiRuiCLLHbU1N3K5aFEsfzWit2AEDcnrDt7GGk+FExVCcG5TfyooLtBP+FO/HOXnTNzNvhA8XI7ZF3+7o5LAlZlDQ3osHDA88O7tfIScvPhbfZi87o34SSIyuvtxHEEMSLJDMs2dIL39v/z2d1anE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BrEolTOi; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BrEolTOi"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eb79f7so552175ad.1
        for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 12:34:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790278492; cv=none;
        d=google.com; s=arc-20260327;
        b=m1rs73Fxs5buw4xxSo1KHkXiK/1zKZ/ZRn3gehqVgPGF0povZjEn94fPpAeS5oNGxd
         bKfJyVtWI9gSLLOyesvvweqWckSnmSSjznzNDYvtyKBF9tBUQrJyePXon14yDLSN9wjH
         JGUu65juIeiBw4aZsfRvKdWjMADMUp6toraNv8Q/kkiwy0MYZGSpJ0vJG02GJBMkPIcG
         YtppZiEoHuUulri7uqK9b8D9RL+LfAUo0uICSp1bHsvn3DCxncSV3aUy1/uQ4hs4nqVI
         PBNSiZEDbj3qBKJaaxO+Ja7izIy99F6qSk4wOT2GK0eK9f2MV4vZ9B4Fm0C4/lFPhia8
         KXBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oRSn02XFlHAYU71ZYcqdkqquo3iQQ46lCWrb5uNEf70=;
        fh=Xk2L8MrqytVqmzvJ/DUS/PR2tU3rIyqADEaBadoNaBc=;
        b=r5Lug7JHqHWQaZnaWCAe2IMU0uola5CCvipOEzxNghkQw7oq6NAnocF4cwg/vy1jkU
         xWM8gbhvEkYApCf9ep+sI04PBefNmCmoSC3AO+6O4DZa3S1ArcIEuHK6DlOKR+1Ligby
         LVmraEaTh8CLv1/iPxGWDYepxhYZ/NQsR5eW8AkUxvSmsrJnqPjP/87AEPihmFDdz5eX
         1ZnaOW3XDn/PUg/GT8Sy8cidn+Ai+4Js0DR5mtP1TNqNg2mJDzfJjCEJCdSTG0kJuwG3
         BLsMIxc7PLaT4igpFGd1ts3Ssjf/NyyaBbJUZIsKyvu4CZ4MOsulB7MB8+D08IQ6+tTK
         iotA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790278492; x=1790883292; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oRSn02XFlHAYU71ZYcqdkqquo3iQQ46lCWrb5uNEf70=;
        b=BrEolTOi0ZFLGwdiqIocwy+8Nm8yKuI93x1FcsnJrcqPvyYPcC7gKpLMNfJYGEAdj8
         MrwtTQb92GMtS8P1PeBocbTgEk8V2GRVAghMuNw9sWsXy59mmtAUG0CFnfRnn+gqk84+
         OsLopjSLL5WPwUZi0k+lgf8+SdnW1mFd5NiVdc9YDA9rxAv2AQZSUDuyCgTL3VN/U55d
         5cNyrwzL8WKyZVo+sfBkSUsTxQgNSqcZNVa1Q60A4v/VCal/aiafVFk4jeHEJwaH1bBS
         LrUqREJxTykqnetQvwBpUgOKECBH7cAstw2MymTvAvJqZXs4f9Z/B/AgYmfcs4T19blb
         TgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790278492; x=1790883292;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oRSn02XFlHAYU71ZYcqdkqquo3iQQ46lCWrb5uNEf70=;
        b=AIpbxNvO1vTrvJUvOEJ7FFHQXhPRUSPSmhUlY9eQAUABalm79CNT30aMzi/mtIoR1p
         GbLQJH8F0+Q3syIAnBFqouHAfq65s9tB2LL+tQduc3yjEbpyonz1GiRybhXIBWswV41O
         UOBt/jWh6jgljcfFe4AmVjvEiAI/gqywWghD5TnOJjtNrBGcaaQKb3UBaiQpUgcyFhlB
         Q0tEKFHwEt3p/7KbpkD04gQBULJlzzPnRkkqURz7j2iPd9y5j49lU6dDPG4CuuSi2OOb
         sa6p9XdvfDsXq4B8FZt68nsQTVSmEnoPPdjyllNKg7lDyw/XKFC1uUCErpYTKFqKalF/
         5jzw==
X-Forwarded-Encrypted: i=1; AKwUvBxvV2Gr/3lW9mNW6JneLRaswdDIJkdQoJiFKNHMZAl6COyU9RINbotaQc826XLpZvs1pj24FPDGlnqbJLUh23uaHySXDa0=@vger.kernel.org
X-Gm-Message-State: AFuF++kfrc/vCFck/hkgIELsemlbBq3k2aYvqXMX5EuMHO474QIvooHw
	oiPCEC7Q119T+J7MkV1/i00SEWgyDMDW/jzjHRaEOldlkAVS3Z2FZxmer68Xvb/AuXLFEFZhy8l
	Lhr2doP4PhYYk/FuU9MC8Mi4GSHa1JSkFvl6AHUC6
X-Gm-Gg: AYBFou1J0HpDOErBWODTlG1xoz59M4DepL4Zxg+cEg3/g6CFbeZADc78/ayEP5ZXn/A
	PSd/++ws5/VrdFn6wCtqPfMceAYr1+naYfbTjbPqs8o7hxd5aUE4EvZSfasmNaJLMVHZd76AXtL
	Z6vcqOId3iRBpdAqywkJHBzw0gjDaEYP7jSIH4r/HV8IVQ3TdvPNlEJ5SzUTlXNMg+XaYT+FWXt
	3qGwyENRLF+qLjwzfvz1kMbUSU/9RAUQtFSYCEC17szK2ca6FLFHupDqbV6X5lkw8SuuC5eOUjC
	ZBiahyIuq9tm0Dn7+ohfqQc3mBUEneQuitNIncPGtATRHj+/f3qDWzP77gUGcxk2X3EZ30l5Ziw
	+2rfr+vOfmwM=
X-Received: by 2002:a17:903:19e7:b0:2dd:c053:82fa with SMTP id
 d9443c01a7336-2df7dfd5d68mr33739235ad.49.1790278491614; Thu, 24 Sep 2026
 12:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915150739.284189-1-daniel@iogearbox.net> <20260915150739.284189-5-daniel@iogearbox.net>
 <CAHC9VhR2Zp9LzDRwDOZoesOC7o8hretfgRH-PRqQRXA0EES2vA@mail.gmail.com>
 <CAEXv5_g1XQAwsydnbu9SUvxNBdYQf+xXjPaZMeC8hxgfThP+pw@mail.gmail.com>
 <arVKSpezisxe3pkr@suesslenovo> <CAHC9VhSwbHF8tZkZ00JM40VTBeXVgcVdoBt7NcX0XKaKSARWug@mail.gmail.com>
 <arVkWs7tG3ayGxyX@suesslenovo> <CAHC9VhTzGJz5Lt8tXYzJfMihsMOX3Wa=6b83dV8QihpRBfBbWw@mail.gmail.com>
In-Reply-To: <CAHC9VhTzGJz5Lt8tXYzJfMihsMOX3Wa=6b83dV8QihpRBfBbWw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 24 Sep 2026 15:34:39 -0400
X-Gm-Features: AclHuK_3RmnxFwfWOEc5RzC2ZEn68Zk0RXtvqz1D3LH-whkeqU9xYC9Rbdxv0Yw
Message-ID: <CAHC9VhRuFWZtxqcH3kfRVgM42dR_9P5QH9JN-dkpudgx0LGUXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/8] bpf, lsm: Let BPF LSM provide xattrs at
 inode creation
To: Justin Suess <utilityemal77@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	alexei.starovoitov@gmail.com, brauner@kernel.org, john.fastabend@gmail.com, 
	memxor@gmail.com, kpsingh@kernel.org, matt@bobrowski.net, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 3:33=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Thu, Sep 24, 2026 at 2:38=E2=80=AFPM Justin Suess <utilityemal77@gmail=
.com> wrote:
> > On Thu, Sep 24, 2026 at 12:23:13PM -0400, Paul Moore wrote:
> > > On Thu, Sep 24, 2026 at 12:15=E2=80=AFPM Justin Suess <utilityemal77@=
gmail.com> wrote:
> > > > On Wed, Sep 23, 2026 at 03:14:28PM -0400, David Windsor wrote:
> > > > > On Wed, Sep 23, 2026 at 12:57=E2=80=AFPM Paul Moore <paul@paul-mo=
ore.com> wrote:
> > > > > > @David, simply for my own understanding, did you ask Daniel to =
do
> > > > > > this, or was Daniel operating on his own with this patchset?
> > > > > >
> > > > >
> > > > > Daniel and I work together and both have things written on top of=
 this
> > > > > kfunc. He reached out to collaborate, I agreed. We're also going =
to
> > > > > send bpf_set_file_xattr shortly.
> > > > >
> > > > > This implementation was chosen due to its immediate mergeability =
(it
> > > > > only touches security/bpf), but was actually suggested by Kumar i=
n v1
> > > > > or so of my original series.
> > > > >
> > > > > That said, sorry for any confusion about this appearing as a new
> > > > > series rather than as v7 of my previous one.
> > > >
> > > > Howdy all,
> > > >
> > > > Hope you all are doing well and having a good Thursday.
> > > >
> > > > These patches are excellent and useful, and have been in the pipeli=
ne
> > > > for a while.
> > > >
> > > > In the interest of moving forward:
> > > >
> > > > Would you both be able to live with the following: provide a securi=
ty hook
> > > > for lsm_get_xattr_slot or another proper interface with the necessa=
ry
> > > > abstraction, and keep the kfunc where it is in fs/?
> > >
> > > That still doesn't change the fundamentals around the kfunc: it is
> > > really only a valid to call it from within the LSM inode_init_securit=
y
> > > callback, it populates a LSM framework managed buffer, and that buffe=
r
> > > is then used to by the LSM framework code in
> > > security_inode_init_security() to do the xattr initialization using
> > > the values from the BPF LSM as well as all of the other configured
> > > LSMs.  It's very hard to see this as anything other than an LSM kfunc=
.
> > > I worked with David over several revisions of his patchset to review
> > > the code and get it in a good place, I'm supportive of the basic
> > > ideas, but this really needs to be located in
> > > security/bpf_lsm_kfuncs.c as it is an LSM kfunc.  As we've seen there
> > > is precedence for subsystem specific kfuncs located in the associated
> > > subsystem's directory, things should be no different here.
> > >
> > Hello,
> >
> > I'm less arguing for any particular placement:
> >
> > More so that the concrete security interest of just getting the kfunc
> > *somewhere* is much more important. I have no doubt that the function
> > would be equally well stewarded in either directory.
> >
> > The xattr kfunc in security/ question can be fought best in a different
> > venue where it's not holding back good contributions.
>
> This (the mailing list) is *the* venue, and sorting out
> cross-subsystem issues isn't a foundational thing, not something that

Sorry, typo.

/isn't/is/

Sorting out cross-subsystem issues *is* a foundational thing.

> can be cast aside because it is inconvenient.  In this particular
> case, resolving this before it lands in Linus' tree is that much more
> important since cooperation has been "strained" to put it mildly.

--=20
paul-moore.com
