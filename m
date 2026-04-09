Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863D929992A
	for <linux-security-module@vger.kernel.org>; Thu,  9 Apr 2026 21:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775768677; cv=pass; b=EXkzCuB2LPoTc7LiVSVJ2lBdE8rcVVeWuTsxzSKaAkZY7elwXuzdUa8t4+MZLCMrcPUI/jzizL/RIg2apKmLjz4z1gPFfxcb5+VFR7h7u+g4Wglvyj7EKlci5iLc6Yd95iTSWrhU0t2+9+q+M4QOZ+0B6GeAFSvl8Bb+ELGQhlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775768677; c=relaxed/simple;
	bh=LSYLWSUH9Mj6i04sciDGLrl/1HBwlgwaKnT9iX/4E+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSiBHNXCD0RVvj56SkagNVYBuY6/l/coPGDAEmxLtMKLhSsCrgzokT4tTvwP2TnzIlkvXqU9Q1RIzIp4q3qmOk6nT22JtFPN3uezWchRHbWZsUtGlCI9bIPWNzlxDkN4wjxGp+X4CceLNvp3ZgV3x668w0h7oxa5pRfipYT4Dbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=V7X4gGD7; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="V7X4gGD7"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35c124d2613so931349a91.2
        for <linux-security-module@vger.kernel.org>; Thu, 09 Apr 2026 14:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775768676; cv=none;
        d=google.com; s=arc-20240605;
        b=VVzl0bANFcCUirlzJcfLVOrMKu+RFjwFYQcLoqQheIh85brNAtEdXyo1qnLc2gxdjj
         syGuQ50cmm2BXY3enCU6DpZ9zB+zCqOeWIHl6ThjUH6db7wW7PQhznfDRNUt6VOLq2kY
         hoCnK8jNZgk1nPBmjlCyvSAoz4jp7d+vT2LANIVcLh8M9qxH98t01CGYj0HNPOm41Lg0
         2qum5BiY7BL23blEHlv3Vi9oGEO3kExDhUoNaG9E6wyhLToCT8T9tiSsy0n3i1IkvIP3
         J4vY++SyOYIis2Gx3CUHAkZWh3psZCC97rf5ipc8Yfagvy3UxLdkFSQcjfbs+RcmN52H
         IlPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lhvOaKGuS0RvMrnclskhUETxNWQ62+P6zx5TM7DZbx4=;
        fh=RCKHnfeTBuVmsroDP6wJPwTD1NsBsD0Msp9P7pn9mH4=;
        b=EEDPQ+zB43/ehEr5UYROQNIz2cDsPfERr/nuYW8QJ5S9Q0rfrdfP5/s0B6xLCYmLBu
         UXVdz5jrLvMTCQFsiJuYgqzgRt7ayL/DogNSsUddBA4tlcaSQdZZ1gENmB4hx02zaNhx
         7pkvOaDQpsA0NnDJQXBJj8WyaRZ2kRD+xS9Wd4chOSfaaCqNjYXNBIXYvb0ckb0CkS64
         CXbe41aRX+APY/wTHPie2zUvjw7WuoxSiKcr1as8LSk5gXl4EZYUg/uYhzlRpJl9aaLn
         +XjlSftmEmlSZ0kBKRqcPURJiuQd7d9UCHOpKJyYECa3ksggPXO5uPyJZZp9S4T3mV8i
         3dag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775768676; x=1776373476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhvOaKGuS0RvMrnclskhUETxNWQ62+P6zx5TM7DZbx4=;
        b=V7X4gGD7whTgHgmCFzcNTUdyXfi7fLJB1XdLPs/rgZtnG23DKukhxcra1k+9HK+kiH
         ri7KgWMKq39l6VaF2i6tNb100zITQlGLSeYtzjvUcHI5SYn1cK/E8QfmhdQ7EfnFJ+lB
         vX9DC8x2yd8slQJq1bjwpxS4guKDRfIvpKdvqUDqDicmcBnkdRdYrCrwHxJ+cuQpdGxE
         8yzFhMsdhSxDDvrkdFlP3BbKYpnYEYcw7rpw0h+3YH418tjaG+j1zUKXptBR/dhx7WLn
         v+fpfCIndfDqxfRjeXWN5r3I9jqcGRkdZ+AffFaaPc4cuUAUjsvETOf7nueGb1mbaJ00
         YxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775768676; x=1776373476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lhvOaKGuS0RvMrnclskhUETxNWQ62+P6zx5TM7DZbx4=;
        b=Y+soGLxuZGn6EaRxXEt+gYkCJVJsNQtFnDdocAsbaa6cO4ymg6x0LaEOQtbx0NqkoJ
         YkZuzut/BoSiu4E7tu0GfK91Sumtcys/hnyNV7DwJ21AkiWQbZ2gnoalVd2b5suWlizy
         4rat6KqVj21U6MLl6w7quwfqV3dS9HokJfmKgE9wEjb9GqHU1A/FdOdvw8Rbg4+0mpsi
         /hPcT6xuyaMOt0vqjW3fM9XEjmbiQLTWXXA2L2AVhSy5ID9WCxfCBuXXfmtIZ3M99lDL
         uwh99gjyKl3ntUWmga3sCEB72tNF0ruPc702sJ41rUlO/hKVLPhh8GPixPLypHNfJSs1
         ZjdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDonZQhapT1yf14b2psxo2Ni+PVr5z4aEGrSDV7pQP9/M9ITr+4d7w1UlsAxh7TJ+aLgnno+mW5HRJoXzEjfif2cwpniM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMWSzLNOUNuRN0BmHKcOcLcek+F+2bxA7gB2N5NbnPOCBKbevw
	p4cDudHdK2mMULykRpg+DFUwC4NgwFFe94Xccn6p8QVNtiVKdOxn6StTRdoEKK/J+9A2IczMcrr
	YmHWRNoVhF6iJ+zL50oQZO2vXbf4vt8rIGefSDTcf
X-Gm-Gg: AeBDieuKO4PDqCQGCHAc8O/t2tgSLdQvDYn0yUKhbGI7JA2yzcdyY80mBp7KdZ4g+Gp
	H+t0t+umayqBEb/opZriQLN07b5gFZZc/L4MmzLCZGufe5NOy5jIym8Y+0f2Nba+gZnX24UZgqG
	aJFEMZe39jPXj/Os35W/M6dv00wTSTnehM7OUD2dsJHkIHB9gDujbjC7Mk1K55gYBhH5JXCeDgX
	CsuIOv0EQJMzGCmMP8xDUcWg7DhB+V7kot7C+UPQ5RNL6+7A1cwLeCBLxzvFDwqMJo0XihwRWBO
	4VnWqew=
X-Received: by 2002:a17:90b:35d0:b0:35c:cba:344f with SMTP id
 98e67ed59e1d1-35e42814b32mr506029a91.13.1775768675871; Thu, 09 Apr 2026
 14:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
 <20260409121230.GA720371@unreal> <2dd138a2ae87f90c55dbc3178d9c798294fd4450.camel@huaweicloud.com>
 <20260409124553.GB720371@unreal>
In-Reply-To: <20260409124553.GB720371@unreal>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 9 Apr 2026 17:04:24 -0400
X-Gm-Features: AQROBzCv7hqSB6tSKvErzJZhlb90rNuzAgZmLqxEJrioN65F1TGjEcz2AUzp16g
Message-ID: <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
To: Leon Romanovsky <leon@kernel.org>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Saeed Mahameed <saeedm@nvidia.com>, Itay Avraham <itayavr@nvidia.com>, 
	Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>, 
	Maher Sanalla <msanalla@nvidia.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 8:45=E2=80=AFAM Leon Romanovsky <leon@kernel.org> wr=
ote:
> On Thu, Apr 09, 2026 at 02:27:43PM +0200, Roberto Sassu wrote:
> > On Thu, 2026-04-09 at 15:12 +0300, Leon Romanovsky wrote:
> > > On Tue, Mar 31, 2026 at 08:56:32AM +0300, Leon Romanovsky wrote:
> > > > From Chiara:
> > > >
> > > > This patch set introduces a new BPF LSM hook to validate firmware c=
ommands
> > > > triggered by userspace before they are submitted to the device. The=
 hook
> > > > runs after the command buffer is constructed, right before it is se=
nt
> > > > to firmware.
> > >
> > > <...>
> > >
> > > > ---
> > > > Chiara Meiohas (4):
> > > >       bpf: add firmware command validation hook
> > > >       selftests/bpf: add test cases for fw_validate_cmd hook
> > > >       RDMA/mlx5: Externally validate FW commands supplied in DEVX i=
nterface
> > > >       fwctl/mlx5: Externally validate FW commands supplied in fwctl
> > >
> > > Hi,
> > >
> > > Can we get Ack from BPF/LSM side?
> >
> > + Paul, linux-security-module ML
> >
> > Hi
> >
> > probably you also want to get an Ack from the LSM maintainer (added in
> > CC with the list). Most likely, he will also ask you to create the
> > security_*() functions counterparts of the BPF hooks.
>
> We implemented this approach in v1:
> https://patch.msgid.link/20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.co=
m
> and were advised to pursue a different direction.

I'm assuming you are referring to my comments?  If so, that isn't
exactly what I said, I mentioned at least one other option besides
going directly to BPF.  Ultimately, it is your choice to decide how
you want to proceed, but to claim I advised you to avoid a LSM based
solution isn't strictly correct.

Regardless, looking at your v2 patchset, it looks like you've taken an
unusual approach of using some of the LSM mechanisms, e.g. LSM_HOOK(),
but not actually exposing a LSM hook with proper callbacks.
Unfortunately, that's not something we want to support.  If you want
to pursue an LSM based solution, complete with a security_XXX() hook,
use of LSM_HOOK() macros, etc. then that's fine, I'm happy to work
with you on that.  However, if you've decided that your preferred
option is to create a BPF hook you should avoid using things like
LSM_HOOK() and locating your hook/code in bpf_lsm.c.

The good news is that there are plenty of other examples of BPF
plugable code that you could use as an example, one such thing is the
update_socket_protocol() BPF hook that was originally proposed as a
LSM hook, but moved to a dedicated BPF hook as we generally want to
avoid changing non-LSM kernel objects within the scope of the LSMs.
While your proposed case is slightly different, I think the basic idea
and mechanism should still be useful.

https://lore.kernel.org/all/cover.1692147782.git.geliang.tang@suse.com

--=20
paul-moore.com
