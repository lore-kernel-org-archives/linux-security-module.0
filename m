Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793897971;
	b=GIBiJLs3uS1SDPWIXMZXw12HjbYa0gL4hKsuciFxSL6YJyhsPcaNyY22KX6R5byQ6P0d
	 7xcMAgLu6Me3/57j1LUvD55DaixVaeo6nbf7HRzVYemHopez0tg3tGIgZpudFRub6/Fpl
	 rvh3vN8gxPkmb+icZk/1NEm1S2xBycP1MesDd8FvYHm6hTi7q5IFZmndLSARIkZcRV2S7
	 jwD2I5EO2yGy4fKitFlXIegOYGlOh+7+MApB2AaNfRxLnpiPx4HAOm+s1QeAGVMR/s2/l
	 M4Oc75f2GsQ9mv0daYQ/98k5WXyXlG81xp93frg36qr62VhKz9MwwjYfFLnMIWUkNjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ENTWrgdqNOnhBXm7Ydoc9z3n/Zlmn8Dt6MNiq3/7nzs=;
	b=4UDGGO9v27GI70Con2qS4aWxbWXc+jVmLQUIeF+Fg4QyMlTUYPX2+kvcQ+4Y6/jgiMEh
	 DjQsnNvDoL+WtbldAbNDR6OPuzucDuwewxOAF/BYPucg4yQyR7o/5UHzeJhezDw1nVjb1
	 R+IVNjxx8os3qG/3Z88e7Q5jMS+EtXDvegd58hGvxx7nJ3tFowKND+L/Kzwx2H2oXhZ9D
	 fDhjVd3+8UTKAWW2lrB5gDd0lzkJpryp871QhiHCY/gQEEhDVJZkmHXxS2j6lRSKDwEJU
	 AOaT0C7K9/dah2udycGlAcnFDyCOOU/IaVt+WZ8KKxpvw4LCov5XBlwhLWIKFm/wTQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=M4rBHBr6;
	arc=fail smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF83606A328
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 16:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BF83606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=M4rBHBr6
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5ba36cc21cdso2074853e87.1
        for <linux-security-module@vger.kernel.org>; Thu, 05 Nov 2026 08:59:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793897969; cv=none;
        d=google.com; s=arc-20260327;
        b=lahgpxsXw17yYRIX5XC277X4NESoh6VqtEOnCyHNjSWoohsscCWWDzgDptUIeSztIn
         Njak1uP9nT8eWrPJPgRh230QOEUYy55q6sq5TY3bd90NzWO3AFOwzvNwyJlgpHDSMX8p
         ushOogR1AdKiiW11hn7ogxapuFbF6Koj1DIECOlyc4K1IAharKa+s7kThsiidhryfySh
         65UgR7a/inPL22yELyS7e/nIccY5HYFwSsroNvDhYBs3v2vo8JFKSjBR6ySAdXVBP6b7
         p64DmiXikhFQ/nwNGmAzvFTfYy+oXfmHKXPivgJMlKudR0Za+UC056XCKTVltRwJyhha
         3ZYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ENTWrgdqNOnhBXm7Ydoc9z3n/Zlmn8Dt6MNiq3/7nzs=;
        fh=fYkfi2ATwu7BCPwkrxXaohe2WYwYMb+NatqfrqQZ4X8=;
        b=kw5HiPPG2LSgxLd4sbeKrSJCH3ettChBsKyLAQh9iAbKlaa7WewYsfhEE4F0JhpCMN
         5YByCIhrDuD8BolLloaf1FVT7vqPBiCdA1ExV1cLWm9i61NL0P1l+T7m8Sg+ki5X43GO
         sDRscMO2EQSpcCl+XZVPJOyzTVqwFZL0gIQnSyuis+uLJ3mGwals+0/azNogi9vXdfZh
         1RMnrqoRX4lWJNKooLnsTN5hb9KKecFBzs6NSpK0scZhMiOJay3LrU/DYvoku9U6DLAO
         1+Zle9DbQOPy5unsTDi2JfaXYdsCJmlrKOR9K4y2kChpmgzCxlM5yg0l6cJIZBffMGOF
         9hcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1793897969; x=1794502769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ENTWrgdqNOnhBXm7Ydoc9z3n/Zlmn8Dt6MNiq3/7nzs=;
        b=M4rBHBr63W/SAVwNNbCQfErkFQNKWB1qkv3HtqteP54rOiV/HHnDMbtUKJCArIzFu4
         mYj0S1RcIb0q9pNYYwzfkrgcW/4hpcfT9cokBuN88bZN0gEMLrtAd9p4+/Q1wKWLERCs
         DrW00xbJ3OukwQpHPe/em0QG+3GlYH+g3IYsga7TvOEBXsyzoIivcIrFXjcPfBtQMsJx
         dhhKFMCZQePt2r/MCoc/hvcGaP1eaY7HE+KfNY0jNPytwrHw0Re5wyWLV4CIYYEeqBaz
         M8PdhqQP2K58xdjOL5tlAIrLEOG/UBLGLNET3to0NrS8A3suRDOPofJdLYHDtzflD6hB
         0Dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793897969; x=1794502769;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ENTWrgdqNOnhBXm7Ydoc9z3n/Zlmn8Dt6MNiq3/7nzs=;
        b=PUumYEiAq8Wn3EL4ie/w2nJ3mNBml/n1rFqNO7f5Qs4Eut1/9t6YvabUszY6Uzs6z+
         9sidyTbHJjnoYMWVVKW9syqYxogsHQp8OX7iTOB6SviwD1hOej6GfMbWYo6jFJljfy9W
         YSb7Pgvmw/nW/dl/ufcXTSJKi4p2O2aDMhOyWBFfWe9rHHpWPb7vdAQiZv7fxhSXNqs7
         bYUBmvy3vQzRJTlLCAk5APV9W6nnE4albFEaXcOwocgfwjkNwCM/pYvWWHuJvHHSIzEG
         qL+89SnEK0VhUMvVmvCLTpvU8RBnywtiMrxxdW2VZRD92J798RWVf1GJ75L2i+QLCaqo
         OV/A==
X-Forwarded-Encrypted: i=1; AKwUvBw1iYgNY/aMNNaMSe+LxLoDQGJzHKBlg2PAlmVjGayuWxjgd2a9hXMPaebU/kTJNNTCwUrOQ5a3Q9NIm8LxQLluKJYX63Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9aLcoPt79h3zDVr6lUWFKQFFjYBaHNN0w9IDtv5x4RbwTwYG3k
	85o5DteEIaf4G0XApHo7A117N4HkrP+/6YbekkZcdCCwSG3zon8NIz98M2VAB0xfqP2xAOz0XjR
	hPFmzSVoIc1R+xOOwILcF/SN3UQ09+P/5jR3Z1GZU
X-Gm-Gg: AYBFou15HnL76tYYTunGS9NKQlCl0nE40zhPFNrqrz92CjD3SxSOdijgYa2AswggpzD
	P6+nSxfuca1Pg/TjS3RQw0jbW5LGdkWdR0ZkR8vDYQrok47ZJ0xmROUXf/nL/lHeTif5NW6vYBx
	3BIq2fYy2lHdZ+y6sF+pH95T/+o1TiTPCOeqOdBFh2QP+2ssl5V1x4Cb97tYlJpNmC+0H8lAU7a
	t/nlv3Mx8nhxDv+sj7CnxLX0nQKMZeedWAhDUclZiOFw9f1Usl7HSHfmEpyjzamFTI1qYAG4ueB
	lpTVNv+EHPATYtf7FbRUPgmdEWtfcRl4lVKpZ3qFg009yHheIiFXaY/ACg3FRSSyx1glg1oE3bB
	HLaqV7fb6jvUN0/0cjzWt3SyNoodCm0NA1g==
X-Received: by 2002:a05:6512:3e1c:b0:5b8:f97f:7a22 with SMTP id
 2adb3069b0e04-5bfd957683fmr6945728e87.54.1793897969539; Thu, 05 Nov 2026
 08:59:29 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028221705.3915340-1-halg@google.com> <aunVmg42/S2uUDWR@hallyn.com>
 <auyink594bxptAPN@google.com>
In-Reply-To: <auyink594bxptAPN@google.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 5 Nov 2026 08:59:17 -0800
X-Gm-Features: AclHuK99RUxjga4Yt7Cih1iKUoXn780fqABuH5tRHwVrGa5--KTUob_Z762ltig
Message-ID: <CALCETrWaFf-X-mD0moxqaqEDWOV+85geK2B2Rs3ArixKd=Ntfw@mail.gmail.com>
Subject: Re: [PATCH 0/8] userns: per-namespace capability bounding set and
 opt-in netns loopback
To: "Hallgrimur H. Gunnarsson" <halg@google.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jann Horn <jannh@google.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	KP Singh <kpsingh@kernel.org>, Jonathan Calmels <jcalmels@3xx0.net>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	containers@lists.linux.dev, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 7:48=E2=80=AFAM Hallgrimur H. Gunnarsson <halg@googl=
e.com> wrote:
>
> On Tue, Nov 03, 2026 at 06:37:46AM -0600, Serge E. Hallyn wrote:
> > Generally, if I, or some users I support, need to use unprivileged cont=
ainers
> > or user namespaces, then when an 0day comes along, I can hopefully trus=
t them
> > not to exploit it.  The biggest danger comes from the fact that, right =
now, if
> > they can use them, anyone can.  So if someone can trigger some other co=
de running
> > as user nginx or something, that can become a root vector.
> >
> > So what if we had a built-in feature or LSM which implemented a credent=
ial based
> > whitelist, entered at firstboot?  Something like
> >
> > ```
> > # Default deny
> > uid =3D=3D 1000  # approved
> > 1005 < uid < 1010  # approved
> > gid =3D=3D 1005
> > security_label =3D lxc_user_t  # Not sure how far we want to go with th=
is
> > tty # must have a session
> > ```
> >
> > Now, if you want to use user namespaces for generic sandboxes for all
> > users, e.g. to confine browser activity or nginx modules, then this mod=
el
> > may not fit.  Or rather, it might need a few tweaks.
>
> Thanks for taking a look and sharing the credential-based allowlist.
>
> The latter scenario (generic sandboxes for all users) is actually the
> primary use case that I'm targeting. I want to allow unprivileged users t=
o
> create user namespaces, e.g. for sandboxing, but without granting them
> security-sensitive network capabilities (CAP_NET_ADMIN/CAP_NET_RAW) when
> they are not strictly needed, given the historically high risk of local
> privilege escalation associated with them.
>
> The two approaches target complementary layers of the problem. A credenti=
al
> allowlist at creation time controls who can create a user namespace, whil=
e
> this patch series controls what capabilities are available inside that
> namespace (and its descendants) once it is created.
>
> Gating creation works well when there is a clear boundary between trusted
> and untrusted users. However, in a multi-tenant environment (like a large
> container fleet), we generally treat workloads as untrusted by default.
> Because we still want to allow these untrusted workloads to use unprivile=
ged
> user namespaces for sandboxing, it is essential to keep the attack surfac=
e
> small and follow the principle of least privilege whenever possible.
>
> More specifically, this patch series enables that model of safe sandboxin=
g
> across three key use cases:
>
> 1. Configurable capability stripping: Administrators can enable unprivile=
ged
>    user namespaces for all users to support sandboxing, but configure the
>    system to strip CAP_NET_ADMIN and CAP_NET_RAW by default in new user
>    namespaces created by unprivileged users. Basic sandboxing rarely need=
s
>    these (except to bring up loopback, which Patch 1 addresses via
>    CLONE_NEWNET_LOOPBACK).
>
>    The per-namespace bounding set can enforce this either globally via th=
e
>    sysctl, or explicitly via clone3() at the container manager level. Thi=
s
>    restriction is monotonic and persists down the namespace hierarchy.
>
> 2. Selectively granting CAP_NET_ADMIN: Some containerized workloads
>    legitimately need CAP_NET_ADMIN to configure advanced networking for
>    sub-containers. Because an unprivileged creator's child namespace is
>    bounded by:
>
>      parent_bset & (sysctl_ceiling | creator_effective)

Right after sending my last email, I had the following thought of a
variant of the model.  Permission to gain CAP_NET_ADMIN via creating a
userns is kind of like a capability itself, right?  We could get
pretty close to nice semantics if we allocated a capability bit for
this (CAP_USERNS_NET_ADMIN perhaps?) and, by default, giving it to all
users.  Unfortunately, the latter part is tricky because even sticking
it in the ambient set won't keep it from being dropped by setuid.

Perhaps we could have an extra capability mask that is for default-on
capabilities.

The intuition for this is that permission to gain capabilities in a
userns is a mess if it's a sysctl (as sysctls are global and there is
no clean way to say that a particular unprivileged task may
nonetheless create namespaces with CAP_NET_ADMIN) and it's a mess if
it's a securebit (still has the latter problem), but it's much tidier
if it's tied to a task.
