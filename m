Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795130849;
	b=j11q1wXE+g6iLL8rDw2/46Yz8xEFzjNASYySP2cGko+6zpGGzFpwgk4HpbRwzw4pp2hI
	 LRV/m2hK+QJp6Q/SyjhQ7xxAsMU5Y9yH90WS8dGMxOOUZTSn39J4xn9f4lzZN+3V0+bIg
	 gipoBg+o+zdff2INPxlja3edtVRnConFYVJHhpIY/kH5kI83upG0cQM1puEJvmB4mUqW9
	 7WrOiaCAGOSqDPZKZQGU41M2uTxi8nAf7yniEQiqEm/w3FbvRmwt5ges8awxgrJ65l58N
	 TByFfA754BQwol7axIWxpRM5o6D1cxKXKUsbaIF3DJXqa8ESa6eAYje2yLmVDru0l/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795130849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OQjCXUbscPytTNcthMSXFUhQzfR2m/iC2VTnVjvFUQk=;
	b=t2VM/Sv0eQO/aydj6cHafWbufIH2VdgeHeAt/XhXkf2Z5Qzctuze15ga8olPqO6MaR8K
	 fYo/EwH/rjrB9kANOLDLv5ZnCNdvJcGYUFhkSmVIGxuRTH7cqzlz6W30sRo0kcKCIWGLe
	 07aikQb5gz/6qHtj6xxT4AU7+GvlKTtlcvx7aLISlxYocY6HER9kfnD7tkQVv8MaK+x52
	 D75NSiRO+FgLDammxVasa0kEhGHp9bvb0bkRluztJWETN2gCavy19EJzTfVud+17mCYSz
	 C+wlyCs77wKfLbhzG0mjAKSuapIB6M2QU95jrW9rCjezd8dmFHBCAOyJ59oUaZZ6Baw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hjX4t2Xo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.175
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D8F606A32A
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 23:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57D8F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hjX4t2Xo
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3acc7a0b558so2288991fa.3
        for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 15:27:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795130847; cv=none;
        d=google.com; s=arc-20260327;
        b=RsfnTsMK9d7CS/qFY9KBcfRHafFpX/X6rrhUY4TVQaFqAwgJgifB1chsdX9T1px9Ln
         6a3kaqnpCDfENAVHC2UHMiECASOnPHY5sxRsOhFz3PesAdztO2U3fQle+7eVdQHzQL0F
         Ouk7LHIYDEe3HuCeAK/pUIlJk2TEvV/3grV6tf+SvYfgs1G3LyqcoeX321Qr3a/G1p06
         50arLWxh3v+oA+kf7DDVYkAWQRRclwqFX53UxNkEvWz9Da2G0zfIDwVyRyeLzp89I5sn
         BGy+qA05fcahApQ3kD9TrBR0lttWpAg7aOG79JO8dZ5cEo1lBWwiOi0pueTzgilcF5bK
         JHfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OQjCXUbscPytTNcthMSXFUhQzfR2m/iC2VTnVjvFUQk=;
        fh=sjTNtz9w/qwm1OF/yWxrGfBRPnFgvto999quURKSKQg=;
        b=Lqv0ARoDZMtiTdS52bgB4B3qXrb89Jxps4vxfjmzsd6H0lgxVAKf6Cpc+hETWIxIeS
         Xo9Ch83I1G7VMgH2YicrfwypNnuqPAu1QMQ2MW+WvCiLFJa2JP2ANE5YeDE1WZ5eaPZ+
         /pS7tmFrUZGpS+Df4ovlnzT6ZMkLRPUEU6+CKiWLvgH5VRq7jouLFFBf0RafaD1tbFmt
         k4rASB9gUulq6RHjlSotz0E0UtcPZCKas1M0yvTVS5AvMw8gMAyM5+E1HJqiysYNA9qs
         kJJjv7d9KlOxQXtaPs0x0OHICGFrheNJz2kk9ROHrXXaG1TX63yARjvwQuh3A+lJ57ln
         z1Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1795130847; x=1795735647; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OQjCXUbscPytTNcthMSXFUhQzfR2m/iC2VTnVjvFUQk=;
        b=hjX4t2Xo0e4RQY2C7GXTldeqYZukwPJ0G0t0eeIIqIxOs+nv/R5cEOi7krUGHcZauR
         vqzkL8y++jDu/is0RF8VMVltWdEd0lyrR1cIBs4FTu4VVQYMJFKG/s1sz43eyqiCcrTX
         Mbg5Ry98V2BB5rY4noROHUppSerOzFFtKwmae0y2na6LMWfxzuzS7JHUleTuTmaHRiow
         9su2Gf++IX3BLOp0vRmJ0CYQlTuqXctSVrAeuH0kMwAL7Ra/++9cvRom3L2AnQl9FlUD
         fl60SeNXa2k2FkgU8xK8tCvQtyjYi99pa5QdP3Pc/FV7HKF68S1o+Utpk9RB7yjgN3SL
         Wk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795130847; x=1795735647;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OQjCXUbscPytTNcthMSXFUhQzfR2m/iC2VTnVjvFUQk=;
        b=bM5CDL2fLAL1aealGrEaLbdFxcVpwQv8TtcBGJR8BpymzCqskhRskcIx2BqnRTNQw0
         kyRV18OBDHuRPyBgEDZCsTwZvcOS4WR/X9akj399xwBMb4qZXhFLto0IPL1LHpeSlAqu
         d4SyNY0cYosWRhKx6OpLLL7dArDS4FTsIVzGVh2y/LJqdNlKowCfLYKQcm7gSX6Bk1T8
         ol/WRN/beqCNaj3cyWzXVGk5qDfCMWO7+ZmEAf0cCc1ldkBrn4UaDhuLAV3Y9rKOolWA
         RBLwW1l9o4RsWa3J+BvrjOU1Wovp2+C9+r8mf+O6toVSmupgurHuyseJlsBkgm4cfsY8
         M6Hw==
X-Forwarded-Encrypted: i=1; AL+hErHYrUYeyn2sHLbcS0lKJwU56jxyKXLTOEC0iRFBiBm50ETZ8EXAxVLBHiYZsy+XQ+WlYny/LzuulnW1PjPmwH83IjLyM0k=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rocyL6T/k56ikTAqUzHqPTd4lGQ1ckR10Tbq/Es5MUqtrfLUU
	Xa3AB4Im88QTG3ewPzBQqdqRL1hZf6pclinOwpovzGKGAzyCVuO+HHOh9LSAp0MsaSmdzt09AVG
	rSWKEPZiRK15/iGf96Pt/4PZhtK1kT7RF1qfKQ2IT
X-Gm-Gg: AYBFou3ITrtJg3Xv5dR4z3NEPxcBtbmbAGdLPzrFaU+E/2Qq8PZG6TObdM+ufhDK6/A
	yDp80QXCD9thN7A9TXz6Oq6MeyGgUbZXzVW0UUSdjhaiHj2Rctkytu+qksZKzACqobEVaMsj5t7
	/iDpSXGk99tdD/L+yDALNNkAEcvf0mLFnsF4jvP/5OgBUFPGrqLMDDkBIVzJl24UjtSaqTo4RJl
	RjODJohZVEazcKEOGRUI8MgsVyABOoLqYeywr1YIQ1YkhcskIZtHa8vtgujDKaAndyAlGU8OHzP
	XybAxkL0ybOLuPkhc/gBVhhgduTF+H55zw3hl9db5RaXkIEd0UZtfwCqPsdZUL0BpP2eDkj5IZH
	EZ/BBeqqdnCrWTo5L++7b7KuE3i6HV5TbPg==
X-Received: by 2002:a05:6512:1194:b0:5bf:b365:d82c with SMTP id
 2adb3069b0e04-5c1bc89ca7dmr310274e87.57.1795130847409; Thu, 19 Nov 2026
 15:27:27 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117231352.3816603-1-jarkko@kernel.org> <CALCETrVUkbpoFjwSAejyA4b_9qEauAP_36i=O8Op1ifp8aUkqA@mail.gmail.com>
 <av3akYFOYaeQZauZ@kernel.org> <av3bkDnwmjunTleX@kernel.org>
 <CALCETrXPLeUgxyhjP4XuWS46FKB0TUHF5PcMkdMf+qeEXbyXRA@mail.gmail.com>
 <9463a969d35a7d5ec5a56aeb67644b94.josef@toxicpanda.com> <CALCETrXt-Do28BHDpbrA98kEy-tQuorxD8c2XsW24Tt8Vspdtg@mail.gmail.com>
In-Reply-To: <CALCETrXt-Do28BHDpbrA98kEy-tQuorxD8c2XsW24Tt8Vspdtg@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 19 Nov 2026 15:27:15 -0800
X-Gm-Features: Aa3M54pRPzoZRQLZtE8vOKLAtvSp1jFKDAaRmJQa_mjsSLqBguq4HCe2_2_ku5M
Message-ID: <CALCETrUbe8rBoxrC+Q66AMsrJ8Fow7xt5KJKRAmobtXBvHWdqg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/13] Namespace for namespace roots
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, 
	Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 2:50=E2=80=AFPM Andy Lutomirski <luto@amacapital.ne=
t> wrote:
>
> On Thu, Nov 19, 2026 at 9:30=E2=80=AFAM Josef Bacik <josef@toxicpanda.com=
> wrote:
> >
> > On Wed, Nov 18, 2026 at 9:46 AM Andy Lutomirski <luto@amacapital.net> w=
rote:
> > > cells: The dance where I create an anonymous mountns, mount stuff int=
o
> > > it, and then attach it to the cell is cute.  But I think the userns
> > > interaction is wrong: you are making me assemble all the mounts in
> > > *my* userns and then clone the entire tree into a fresh, non-anonymou=
s
> > > mountns bound to the current userns.  And that clone operation is not
> > > free and serves no actual practical purpose.
> >
> > The copy buys us nothing, agreed.  That's just what the mount API gives
> > me to work with today, it's not something cells wants.  If I could make
> > an empty mount namespace and fill it by fd I'd use that, the "root" slo=
t
> > takes a mount namespace fd already.  Extending the API for that makes
> > sense to me on its own.
> >
> > The mount namespace staying with the builder's userns is on purpose
> > though, that's what keeps the cell from mounting anything no matter wha=
t
> > capabilities it was given.  The builder sets the tree up and hands it
> > over, so the cell only ever has what it was given, and the mount code
> > isn't something it can attack from the inside.
>
> I don't get it.
>
> Using the builder's user namespace means that the contained processes
> can't be ns_capable on mntns->userns.  But this solves very few
> problems unless you also deny the contained processes the ability to
> unshare userns and make a new mountns, and if you can do that, surely
> you can also deny the ability to modify the mount namespace.
>
> As just one example, a mount namespace could have a little flag to say
> that it's *in* one userns but its owner is a different userns.
>
> >
> > > cells: I find it *incredibly annoying* that one generally cannot put
> > > new mounts into an existing container using most existing container
> > > managers.  I hit this on a surprisingly regular basis.  You seem to b=
e
> > > baking this into the whole cells design.  Why?
> >
> > By design.  Allowing changes to a running container is what causes the
> > problems.  If you need another mount, tear it down and build it again.
>
> What problems?

I'll add:

On a non-container Linux system, you can hot-add a removable drive.
On a Linux-hosted VM, you can hot-add all kinds of devices, with or
without the help of the hypervisor.  (The hypervisor can hot-add a
device, and the guest can mount network devices or newly added USB
devices on a port that was already assigned, etc.)

For some reason, on Docker and its sort-of-clones, approximately the
best you can do is rbind in a directory and then mount things into
that directory from outside.  This is sad.

I get that there are plenty of workloads for which this limitation is
reasonable, and there are more workloads for which this limitation is
silly and people have learned to live with it because everyone
imitates Docker and Docker is limited.  But there are also workloads
that I hit on a surprisingly regular basis for which this limitation
is genuinely annoying.

If you want to write a container manager that shares the same
limitation, fine.  But please don't make it into the kernel without a
compelling reason.

(I personally think that Docker has a *lot* of weird properties that
make little sense.  This is just one of them.)
