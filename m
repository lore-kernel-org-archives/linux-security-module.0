Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A5E3ACA70
	for <linux-security-module@vger.kernel.org>; Fri, 26 Jun 2026 22:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782511315; cv=none; b=HJU5f2TpLs/VqEfg+4zI2m7d7JwBw1v5ZcydkwJqqNRbEkdqZCbr6qrUMJLisG/BwmYqrM1xoO/hJXUCjLgolfdQqPuQLQuaRNcl1yjsHHuXDIzPBjCiughP0Ah36qRaz4THUHCbcI8rfFqEO2Vonmyu6vxObDW2P7jDyAdgpCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782511315; c=relaxed/simple;
	bh=oej/Pnu0/2wxm5A9H6A8eDRKR+CG5i8dBBxrtGUjicg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHmNVcWTHM5foOc2LIXIdCCmKQ4M5+rIIFMjL5wyBBaEtklUi+hgq27sI6f0JDpuTu7N3M5WdbrgEzr9WfjU2ljbVKWcKanNwQReicGMR5pxtvrabqYQfIDSxISJDx3K9BDLH4OsK03CTQIvejNQ8hDVpnNdXAJ6T56N4FfEKAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nq85NxuL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nq85NxuL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09DE1F00AC4
	for <linux-security-module@vger.kernel.org>; Fri, 26 Jun 2026 22:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782511313;
	bh=pa6DivPtjv8ukIBs+sewB41NxeosJsGE3DcS0Nbtie8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Nq85NxuL4nxY5PP6Q+rT2paMCgcJQ1RdSDQieh7ofxvaTHPEeV5/SO/oj18zVUUIj
	 yKSYYCnMo3QMZqKKRt1016rKVEF+O8UA7jA/Gzdm19HZM1laqdKLUrdgPHZeiRfdId
	 52ztmiIHc/ZofDMGU04Bje9VCbC6SyFaVRLJgaFepWKbAkwieBD5Rq1+8GYkN+G8Cs
	 KhvXb1S0NWBdA/puKQ5XeBKDdtJw123su2Xx0sDvVvy+UYp1QYY6gUgJPWFZJNfVZk
	 k9ShTgUZPoqrj/17ZI0vVz/yXZZd49ob2vkXaNCl//ig5g1mOf2XrevOeh+fl93u1/
	 qsUilrmW0qIcA==
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4923fb1f095so13997275e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 26 Jun 2026 15:01:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9hBFnxJowPVBf/XEhIbHiWQdevtpHtRwBLgsg1jks2c42hAVHIoC+ezNGddjGGV0oG9VnL/zn2j3YKD0DuzIhUAc+X0d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzHFQ/X5MpkqTOixFryCzezIt4Qm34YCJlbgdaZMSHQjloaVG5
	GUm4mz5CmJxZ8NhTbCpwVup/xSkZdpH1Csd3/+F0uDAswuoWCmmdg67s7jn1Il6ldCisb5aEWdK
	a9LKiu/18woww20AOkR9ZKSqmvoSF846yG7kJg3LS
X-Received: by 2002:a05:600c:4fc7:b0:492:3fb5:4697 with SMTP id
 5b1f17b1804b1-492668628d6mr121259895e9.5.1782511312224; Fri, 26 Jun 2026
 15:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624140301.93421-1-daniel@iogearbox.net> <20260624140301.93421-2-daniel@iogearbox.net>
 <CAHC9VhRar1x7kyjhgdmJ=Mfz4Msarv=wQ1821v723CaVdk1uTA@mail.gmail.com>
 <603d0f6f-bf02-48ec-af90-f16a239bad85@iogearbox.net> <CAHC9VhTF6_VaSm0uOjW1eV05CvsaaL+2jimVuPTXHeLGEQcMPg@mail.gmail.com>
 <c4dc3117-ad84-4c94-952a-cf0642cb42e7@iogearbox.net> <CAHC9VhRV9jW+dwNf7mW+1zTCsZ1xstBAugWL-TJ-DVNARdzC=Q@mail.gmail.com>
 <DJIL18C2F40B.39U9WHD43SDBR@gmail.com>
In-Reply-To: <DJIL18C2F40B.39U9WHD43SDBR@gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Sat, 27 Jun 2026 00:01:41 +0200
X-Gmail-Original-Message-ID: <CACYkzJ64SxZj1Qvf1JRDfpoOWkg+bk_hpXcfGfPvecSfSu2jdA@mail.gmail.com>
X-Gm-Features: AVVi8Ccv_2wm4PejHNAzKWiQvtyyGwE_Q2VYsfOe9Ea_5yVwT3-3Z_TBltiQkRw
Message-ID: <CACYkzJ64SxZj1Qvf1JRDfpoOWkg+bk_hpXcfGfPvecSfSu2jdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Verify signed loader metadata at
 load time
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org, 
	James.Bottomley@hansenpartnership.com, bboscaccy@linux.microsoft.com, 
	memxor@gmail.com, torvalds@linux-foundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 3:16=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu Jun 25, 2026 at 5:59 PM PDT, Paul Moore wrote:
> >
> > For all the reasons I gave previously, I can't support moving the
> > existing security_bpf_prog_load() hook at this point in time.
>
> Paul,
> it's not up to you to approve or deny where security_bpf_prog_load()
> is called within bpf subsystem as long as it doesn't affect behavior.
> Daniel's patch doesn't change observable state from LSMs pov.
> It merely moves the call from syscall.c to verifier.c.
> So we're going to proceed.
>
> > I'm guessing you still haven't looked at Blaise's patchset from last
> > September.
>
> Blaise approach was Nacked because you guys ignored TOCTOU issue.
> I pointed it a year ago before AI was a thing. Then sashiko
> pointed it again and the bot explained it in detail. It was again
> ignored.
>

Agreed, with Alexei: I like Daniel's solution because it avoids the
complexity of machine independent BTF for loader programs and still
addresses the signing goal, without the TOCTOU. I am okay with the
current implementation as well. I think having kfuncs in loader
programs would be useful, but we don't need to rush it or tie it to
the signing effort.

- KP

> Daniel's v1 sadly had the same issue and sashiko spotted it too.
> Hence v2 is moving the location of security_bpf_prog_load().
>
> > on-list.  As you can see from the lore archives, he has vehemently
> > opposed the approach you are proposing for quite a while.
>
> Exactly, because you kept ignoring TOCTOU issue.
> Claiming support for signed bpf that can be easily defeated
> is a shameless security scam.
>
