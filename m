Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C846830E0C0
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773856194; cv=none; b=X9lrmbmhzaIeuUp4bh88f5wqsk+rL0hDb1zovGYG6wSqXXjvBQ7y2a8A1hSowWCZK1b+auT//3vrCQzHcdM8SiNv2nnTN1ZXKnzstzL5PrVYaGwAdA2mioomipahtOusbdcfdb2ZOiMePBS/MntfQ+hj48SsOyLYM2VyGx9pzd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773856194; c=relaxed/simple;
	bh=HGCegGKd/wL01yykR6BtOd16uHaQDYMxuA7939bT0Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZQBY9XqsfyXZljLOUsZi0iisdsekyUpF2Pqur79lHqAXqjMMdZW6xovmb0RsNBZWKxOS5grK8CIVsSkmLF6iCmxpZsMqXmt1yGzMsKjhqhBxPxpiRXC2tIP+j5YjVNVmUTUsFHzdccBdHUdv6oDA0EmagDe1Y5qyjh61LJeW2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CUvwReGQ; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CUvwReGQ"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d744d9acbeso55564a34.1
        for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1773856192; x=1774460992; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DwZzEUBvZTlA64oHuhM8Cu6PFpv3s+PziJS94hKbClM=;
        b=CUvwReGQONVpYZsnOprkScrRcNCgbCu+nCgzLBt1zlng+nXeh8HWMFnX0FiDkfdFAt
         zMPzDSRqAez68f4L5nKycu9km5fvjHTyzdYEDFKWpTg1KbQ2tsf19LNoiKnfue0l3cZ8
         rdSel2wcFNrvEARgczNTw7Mu6f0gUz7w55BPqz/4TRBDzZSKlGwGEX0wlDQuc/D2TGeU
         1+RqrKZGMyoSweO2/HpG/QDicGASfKopbkS6YkyyjBPAJjhhyWNJ2laSY0jLa/kZdQeb
         Zf28KP6sGPtixBR5yWg2aV0Dp6/06Ap6yUePYsYyb63SwSbkebWRHdAW2mBWrD+fF8MA
         xLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773856192; x=1774460992;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DwZzEUBvZTlA64oHuhM8Cu6PFpv3s+PziJS94hKbClM=;
        b=kPbKXBAJOQfFXPwedLH7eItU9EOZ8lUakJqCh5v/AVBYTaMhigkI8Dz+bN0nYjcKfw
         HFTluRnndyhRrXbxA8ijMDXcLvw3C4fw2UWv86YhFEJ6CH7nqbNnVnvo1n0WJIjnOmN6
         qcV49hPyWvNXu8L+ZJtp5Q56VF2AEB3QJASe10n8aHp2WsAsjyy8K7O7+i8ocU1mddI2
         gkmYQLREm+yhPyMPBTp3V97UCUmx1sdprlWJ1apWVhzdeWsTM/Y6slmCQ2snA8x1La75
         DBX2qSiPboEu+m55vlZ4Y3cnPPoHub/cnRIQszCjRi5myPgxHt4Iqgybgq5CvWvVC6/u
         djWg==
X-Forwarded-Encrypted: i=1; AJvYcCUR4RKQuooj0zERvcVwy/SlygHFLmGl3LXbJhwLN87TP99pb4kpUPAmEcyjJvpSYkZA2+6bnzRmRcJIU3/iRIBS3KxT4MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeQmxLzrDmbu4tL+NZySUs/yoWVDGUCtXrbMLykuDZPkAfV30l
	Cal7+kHRYulrHcdkWzBKczzvHfmXBF5wKSaIQm+N/r7yN2TF9HvqLWpneEDPlwEOMwM=
X-Gm-Gg: ATEYQzzXQBN5jLpHEVGij0SFjnSFNw3jDFghGpaKnrhZjRcRH7/X+KPe8lL//Bs6PIL
	+Ne+AeCSEBBMapi5FQOXEOurUi27IfaBaTV3/Qn/tsQUX8g2CApSjKlzNgRQxoVksm/ts2zvdje
	zl06qxD4g4mbNPRUwPFhHZo//aEL35S/y/IIlJG6v8YcOSXraJIMih+i1/yVOXDTRJeuSe/9qg4
	J4cRPMSaKVwjzk3to1VCmgHL0vmEHm8PBoSWTz9eg0N1uQwMeByDPG3jjvHepcP3dguE9mDjSfO
	jXqofWxyBih3Jg4unFhJ3137eDwSRMyQ6qYn0k/wQTOfzmlbRRegcFXPrg6DstxR3lJtSn8Qynh
	JWXJQKOIOVOvAbg8IdawXcDAFFR3IopLtXycu0T0Fc9nXvmhNhmjVfEF7yQkQYgBwsEC/V1mgR4
	rRSqyQ
X-Received: by 2002:a05:6830:82bd:b0:7d7:d216:2b26 with SMTP id 46e09a7af769-7d7d2163d29mr1417083a34.4.1773856191557;
        Wed, 18 Mar 2026 10:49:51 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac5:947d:1b37::2b6:4e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7c9b3696asm2632316a34.16.2026.03.18.10.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 10:49:51 -0700 (PDT)
Date: Wed, 18 Mar 2026 12:49:48 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Eric Paris <eparis@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	LSM List <linux-security-module@vger.kernel.org>,
	audit@vger.kernel.org, bpf <bpf@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF
 LSM programs via BPF kfuncs
Message-ID: <abrlvEjQKUdAOcw5@CMGLRV3>
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <CAP01T77VyW=5SHDvM3HXPNHaxRdzs8H__MOh2zx1dQ6STeAUtg@mail.gmail.com>
 <CAADnVQJCJaLjGCwjCX9VtT615c4kn7v5bxviUmGFVj=uTtUHMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJCJaLjGCwjCX9VtT615c4kn7v5bxviUmGFVj=uTtUHMg@mail.gmail.com>

Hi Alexei,

On Tue, Mar 17, 2026 at 06:15:59PM -0700, Alexei Starovoitov wrote:
> On Mon, Mar 16, 2026 at 7:44 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Wed, 11 Mar 2026 at 22:31, Frederick Lawler <fred@cloudflare.com> wrote:
> > >
> > > The motivation behind the change is to give BPF LSM developers the
> > > ability to report accesses via the audit subsystem much like how LSMs
> > > operate today.
> 
> Sure, but bpf lsm-s don't need to follow such conventions.
> audit is nothing but a message passing from kernel to user space
> and done in a very inefficient way by wrapping strings into skb/netlink.
> bpf progs can do this message passing already via various ways:
> perfbuf, ringbuf, streams.
> Teach your user space to consume one of them.

Audit provides additional functionality by keeping messages close to the
syscall, and in-line with other messages for that syscall. Aside from
that, BPF is arguably too flexible. I'm sure it's already understood,
but the idea here is to reduce bespoke logging implementations and reduce
attack surface for violation reporting. Audit is already provided by the
kernel and a well leveraged pipeline.

WRT to performance characteristics, would you rather see this
implementation leverage those maps in a way to reduce that, background
workers, or something else? This is something we've considered, but left out
of RFC to collect more opinion on perf considerations.

Thanks for bring this up. I forgot to include that in the RFC cover, sorry.

Best,
Fred
