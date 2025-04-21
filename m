Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1411A221FB3
	for <linux-security-module@vger.kernel.org>; Mon, 21 Apr 2025 22:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745273049; cv=none; b=BfgC7p4tWuEdMLpsqFqmnMwiOhGrG9wbqWVe7nDZEmYUx94mPqyWGERK84fugiP66azG5XbdGb6zMK6j3Kvm5OnPID/m4MGqO8VCmZUFp8Y8CaaQ6vHtT/aHO7urZGPFx1ceg8/xfnO9R+rD6rjQp6vYBtgBXRRM2SlSh5o7xqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745273049; c=relaxed/simple;
	bh=+muycKiBaV5UQqyraI1xwjnbIAioVU0Qup0KnvqWYU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VAAxUTad/NaM6hnk5lNi6twMDzbL67/wIcRLrOQMRAsDhiqYfMsACPDSbZ/rMC4w2S2Pbc2obmxz2yMRqnKlWEe4uDlTFwOuBNaWmoTDsmEdRiCuGjyO3nqRRFZPi7EB0jb6KCsJL/ZwtP+M9lj8R7vd0Ns9hh1AIZ5h0ssbLWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TM0jYe6K; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TM0jYe6K"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e60b75f87aaso3011336276.2
        for <linux-security-module@vger.kernel.org>; Mon, 21 Apr 2025 15:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745273046; x=1745877846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJkBF2Iq9gEiEg9l+Unpndzsq5ns/iefqc51nXn2fRQ=;
        b=TM0jYe6KZQyjxuohb24LcAj0BwGkJx71bYweV1zBZAi5uSods9LE7nYSYB1weQAJyA
         Asb3SNeaVe0WNePwYwLlc587gtrepTlWlFyQI7UVxBJV6w4goVbXoPrJ0DFzCTjj3yT9
         gfR7Oo7ioVNRFiJGTyzI0VvU8FKpw//ZJh9tYCUKeTlAvD+xzihdwZSTl7dig7sbgpVp
         ZpM8Sd01p7AgiTdwukFEyS2IwOVYdrtBnZk98SewZ8NkMNAuq4Iio5UMOAA+xWWLJ7Sw
         /r7LHhjsmDL9n9lv1o0MmTvFgCOzTZcDqqKACG77tU57Y3oHtX8pnnQALz81AvoNuz9G
         fsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745273046; x=1745877846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJkBF2Iq9gEiEg9l+Unpndzsq5ns/iefqc51nXn2fRQ=;
        b=k+j2dj9inZSHMXj2wrprcmoVFFcAuGn5pcby58UhZAU7FVwC1GeQFz26qaITwN3HGF
         cItVZjglxX80jBgncqhxR216y5kRrT9CaSSkoQf5RvrONY4UrHgH+Na6FqgpavRKFNGW
         H2A/UuFCU6iU8/KR6wo+fIUwsNPWQk2CHFY+qXhpI5dF85w5pvw0vBdzYqcCQHFLE7ii
         43a6KHgvE9ramxpOh2IQZIrPb3DsMzqQIFaf6JhSM4cygumUm765tDdIjIFJFqc+CMu9
         b6tGRW4yXoO5xrWZ9SD+vzvHICKo1M75cHjFSlA340ogIqvv2GT501bAXPeSL1/975tl
         cS4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXygWc4M3Ng8iXSqVHu8Ybz08a1AFHPgypIpVbEH/njPO74bxGSw4zwY/40Xj82++a2wqwIA7CZScFpdQjj0+2q5mA57xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgpNC8sVB90TTsVnFNPtc1tczm3S9XVtxwNn75LiCclLyEyfx8
	eSstqsYohk+loE7JnyJ6kKiYhDWRFo9Y2aN+3uvDfR+K4mHqjjayYwtop+gTIktZwtMetokyDcA
	XBwWbzpD3gOeDUx2HuIdieJLbHLj3nI2RYjaS
X-Gm-Gg: ASbGncsIjNpWnMUFNAWBB0is58BhiV4OpuKw0WGDF0sSfUrFZQKl94l1HErXfZGVyK4
	y6WpXdNNz8QIyX5KRGt1uFL3yzTpx4e1durK8nnMAmDBhYrVBPNrBTG1rQUEimQUmqpOYUyZ5Uk
	Kd5xTYMJMwUeji8PqGjCGfbA==
X-Google-Smtp-Source: AGHT+IFjErmdtD9yYgSCvg50nxSRhAaGxDl0MNp2zLoVowjSrOfaMAYKD0cmZ307fSWsTGOXpc7lz6KmktYrMh1O/kc=
X-Received: by 2002:a05:690c:380a:b0:706:aedf:4d91 with SMTP id
 00721157ae682-706cccfa7f8mr180651297b3.14.1745273045751; Mon, 21 Apr 2025
 15:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com>
 <20250404215527.1563146-2-bboscaccy@linux.microsoft.com> <CAADnVQJyNRZVLPj_nzegCyo+BzM1-whbnajotCXu+GW+5-=P6w@mail.gmail.com>
 <87semdjxcp.fsf@microsoft.com> <CAADnVQ+JGfwRgsoe2=EHkXdTyQ8ycn0D9nh1k49am++4oXUPHg@mail.gmail.com>
 <87friajmd5.fsf@microsoft.com> <CAADnVQKb3gPBFz+n+GoudxaTrugVegwMb8=kUfxOea5r2NNfUA@mail.gmail.com>
 <87a58hjune.fsf@microsoft.com> <CAADnVQ+LMAnyT4yV5iuJ=vswgtUu97cHKnvysipc6o7HZfEbUA@mail.gmail.com>
 <87y0w0hv2x.fsf@microsoft.com> <CAADnVQKF+B_YYwOCFsPBbrTBGKe4b22WVJFb8C0PHGmRAjbusQ@mail.gmail.com>
In-Reply-To: <CAADnVQKF+B_YYwOCFsPBbrTBGKe4b22WVJFb8C0PHGmRAjbusQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 21 Apr 2025 18:03:54 -0400
X-Gm-Features: ATxdqUFcqFjq20jX5yxtvOH3DHCD3LQ0LRd6y2kU6Qtvx6XNCs0BPjy44J04_l4
Message-ID: <CAHC9VhS0kQf1mdrvdrs4F675ZbGh9Yw8r2noZqDUpOxRYoTL8Q@mail.gmail.com>
Subject: Re: [PATCH v2 security-next 1/4] security: Hornet LSM
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jan Stancek <jstancek@redhat.com>, Neal Gompa <neal@gompa.dev>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	keyrings@vger.kernel.org, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, nkapron@google.com, 
	Matteo Croce <teknoraver@meta.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 4:13=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Wed, Apr 16, 2025 at 10:31=E2=80=AFAM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
> >
> > > Hacking into bpf internal objects like maps is not acceptable.
> >
> > We've heard your concerns about kern_sys_bpf and we agree that the LSM
> > should not be calling it. The proposal in this email should meet both o=
f
> > our needs
> > https://lore.kernel.org/bpf/874iypjl8t.fsf@microsoft.com/

...

> Calling bpf_map_get() and
> map->ops->map_lookup_elem() from a module is not ok either.

A quick look uncovers code living under net/ which calls into these APIs.

> lskel doing skel_map_freeze is not solving the issue.
> It is still broken from TOCTOU pov.
> freeze only makes a map readonly to user space.
> Any program can still read/write it.

When you say "any program" you are referring to any BPF program loaded
into the kernel, correct?  At least that is my understanding of
"freezing" a BPF map, while userspace is may be unable to modify the
map's contents, it is still possible for a BPF program to modify it.
If I'm mistaken, I would appreciate a pointer to a correct description
of map freezing.

Assuming the above is correct, that a malicious bit of code running in
kernel context could cause mischief, isn't a new concern, and in fact
it is one of the reasons why Hornet is valuable.  Hornet allows
admins/users to have some assurance that the BPF programs they load
into their system come from a trusted source (trusted not to
intentionally do Bad Things in the kernel) and haven't been modified
to do Bad Things (like modify lskel maps).

> One needs to think of libbpf equivalent loaders in golang and rust.
...
> systemd is also using an old style bpf progs written in bpf assembly.

I've briefly talked with Blaise about the systemd issue in particular,
and I believe there are some relatively easy ways to work around the
ELF issue in the current version of Hornet.  I know Blaise is tied up
for the next couple of days on another fire, but I'm sure the next
revision will have a solution for this.

> Introduction of lskel back in 2021 was the first step towards signing
> (as the commit log clearly states).
> lskel approach is likely a solution for a large class of bpf users,
> but not for all. It won't work for bpftrace and bcc.

As most everyone on the To/CC line already knows, Linux kernel
development is often iterative.  Not only is it easier for the kernel
devs to develop and review incremental additions to functionality, it
also enables a feedback loop where users can help drive the direction
of the functionality as it is built.  I view Hornet as an iterative
improvement, building on the lskel concept, that helps users towards
their goal of load time verification of code running inside the
kernel.  Hornet, as currently described, may not be the solution for
everything, but it can be the solution for something that users are
desperately struggling with today and as far as I'm concerned, that is
a good thing worth supporting.

--=20
paul-moore.com
