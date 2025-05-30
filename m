Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0FB54652
	for <linux-security-module@vger.kernel.org>; Fri, 30 May 2025 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748643598; cv=none; b=ua2ugrd73OiDs3NKpr5yZMQVj7F6NTKTYATgrWD+JZzYyQRYx/9QJFQ4eJ3mbq58fJyF0W+5N1Saqx509LZj+L6iX9wQRvqH2UnqrxBS3aiAkDJtkKMwnVRNyCIoNcPuiI+cczmL2Ev9Tsy+XhR5qp2ez8qxB/wJTiK8ApVqIxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748643598; c=relaxed/simple;
	bh=X9uthOk49pVr6OwMMXKEM9aGlD7N5kUpyVLqdQJSTII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhXCiZkaM324wNYX0yuZlqb52oUH0d07tlpKsmyIZGCJv54Cv3ZrbLN8M9Nr0EHbh50SIMbCqFLO1rBr4Zv5KG+yUsYXAKQO/kpTaAQhLDN0STfulTdAUASn0Kd87rV9dnKcSfThPzCb+iCKMQv2pWUJKUy0u18TEimqA/LVnjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eE6HGUFu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eE6HGUFu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DA1C4CEFC
	for <linux-security-module@vger.kernel.org>; Fri, 30 May 2025 22:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748643598;
	bh=X9uthOk49pVr6OwMMXKEM9aGlD7N5kUpyVLqdQJSTII=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eE6HGUFuiIxdKYroKE6a52KAiL5xVDlR2K+9QCtKsk4XYYJY6t/FTCiBW4acklaO4
	 GQH6nxlcXoPxN/aJRHPpO9pDISNwYDpx8vHgdSQCt92ubEMTRwsTvnGVV2yPsWDo5K
	 MuIhcBUrWtsiHpxQb09p1NMD/layEIB37XKYRkf5bB4iOEF84wKFFgD/efBZ0zf4E8
	 vE0rsbkryslEQxvUAWW9XLSwR1p3x/zjFm4bK4ew07dFH7Qlwx8P5ZLck9G0T5N3YP
	 RRvHOOLhriaK09m0/o8VfPQy2QeTH3ffCYs53NttUVooBm0kcCHVgTHbPmtes7qT+G
	 Jkomm3bXGk+oA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6021b8b2c5fso4629059a12.2
        for <linux-security-module@vger.kernel.org>; Fri, 30 May 2025 15:19:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYU7Eco1sL0cu5mlPp8tdmgEs3xDlUbEcjxSrC8ZkhJpvRk2E1dMYkfeOBijhXaVdb8JxxRq1jRcDu6i/sowF/eEAJki8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLCTxCkhGwCDlLf4mOSn+SVzDjXyW3yzTB3u+UUsjVt4SiACCG
	nSz3EPv/EhYRp4vpc/V3DrxMBENvQcUgy+c4r8bHHYkwtAG10Ak+QFKHTfBd2m/H+yKdfj/ts5q
	/w7bQ2+dRs5j6YL+AIQmk70iG3O1TMIn2kbw3/xV6
X-Google-Smtp-Source: AGHT+IEFVbhr+VLKGTkXxmdHXBrpU1z9fZIUhNvdOJmYXkRT0zqBk/sOnT42WwibV8LQfP4xA0G3Ch+10jSuOcTqbPk=
X-Received: by 2002:a05:6402:518a:b0:5ff:f524:90e0 with SMTP id
 4fb4d7f45d1cf-605b751baf6mr73164a12.11.1748643597014; Fri, 30 May 2025
 15:19:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528215037.2081066-1-bboscaccy@linux.microsoft.com>
 <CACYkzJ5oJASZ43B531gY8mESqAF3WYFKez-H5vKxnk8r48Ouxg@mail.gmail.com>
 <87iklhn6ed.fsf@microsoft.com> <CACYkzJ75JXUM_C2og+JNtBat5psrEzjsgcV+b74FwrNaDF68nA@mail.gmail.com>
 <87ecw5n3tz.fsf@microsoft.com>
In-Reply-To: <87ecw5n3tz.fsf@microsoft.com>
From: KP Singh <kpsingh@kernel.org>
Date: Sat, 31 May 2025 00:19:46 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4ondubPHDF8HL-sseVQo7AtJ2uo=twqhqLWaE3zJ=jEA@mail.gmail.com>
X-Gm-Features: AX0GCFs7idCN9jaYB_SrteqON5qA41YJX-g8zbOqygcHwSu5E09ECJDr8XP25sI
Message-ID: <CACYkzJ4ondubPHDF8HL-sseVQo7AtJ2uo=twqhqLWaE3zJ=jEA@mail.gmail.com>
Subject: Re: [PATCH 0/3] BPF signature verification
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Paul Moore <paul@paul-moore.com>, jarkko@kernel.org, zeffron@riotgames.com, 
	xiyou.wangcong@gmail.com, kysrinivasan@gmail.com, code@tyhicks.com, 
	linux-security-module@vger.kernel.org, roberto.sassu@huawei.com, 
	James.Bottomley@hansenpartnership.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Ignat Korchagin <ignat@cloudflare.com>, Quentin Monnet <qmo@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Anton Protopopov <aspsk@isovalent.com>, Jordan Rome <linux@jordanrome.com>, 
	Martin Kelly <martin.kelly@crowdstrike.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Matteo Croce <teknoraver@meta.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 12:14=E2=80=AFAM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> KP Singh <kpsingh@kernel.org> writes:
>
> > On Fri, May 30, 2025 at 11:19=E2=80=AFPM Blaise Boscaccy
> > <bboscaccy@linux.microsoft.com> wrote:
> >>
> >> KP Singh <kpsingh@kernel.org> writes:
> >>
> >
> > [...]
> >
> >> >
> >>
> >> And that isn't at odds with the kernel being able to do it nor is it
> >> with what I posted.
> >>
> >> > If your build environment that signs the BPF program is compromised
> >> > and can inject arbitrary code, then signing does not help.  Can you
> >> > explain what a supply chain attack would look like here?
> >> >
> >>
> >> Most people here can read C code. The number of people that can read
> >> ebpf assembly metaprogramming code is much smaller. Compromising clang
> >> is one thing, compromising libbpf is another. Your proposal increases
> >> the attack surface with no observable benefit. If I was going to leave=
 a
> >> hard-to-find backdoor into ring0, gen.c would be a fun place to explor=
e
> >> doing it. Module and UEFI signature verification code doesn't live
> >> inside of GCC or Clang as set of meta-instructions that get emitted, a=
nd
> >> there are very good reasons for that.
> >>
> >> Further, since the signature verification code is unique for each and
> >> every program it needs to be verified/proved/tested for each and every
> >> program. Additionally, since all these checks are being forced outside
> >> of the kernel proper, with the insistence of keeping the LSM layer in
> >> the dark of the ultimate result, the only way to test that a program
> >> will fail if the map is corrupted is to physically corrupt each and
> >> every program and test that individually. That isn't "elegant" nor "us=
er
> >> friendly" in any way, shape or form.
> >>
> >> >> subsystem.  Additionally, it is impossible to verify the code
> >> >> performing the signature verification, as it is uniquely regenerate=
d
> >> >
> >> > The LSM needs to ensure that it allows trusted LOADER programs i.e.
> >> > with signatures and potentially trusted signed user-space binaries
> >> > with unsigned or delegated signing (this will be needed for Cilium a=
nd
> >> > bpftrace that dynamically generate BPF programs), that's a more
> >> > important aspect of the LSM policy from a BPF perspective.
> >> >
> >>
> >> I would like to be able to sign my programs please and have the kernel
> >> verify it was done correctly. Why are you insisting that I *don't* do
> >> that?  I'm yet to see any technical objection to doing that. Do you ha=
ve
> >> one that you'd like to share at this point?
> >
> > The kernel allows a trusted loader that's signed with your private
> > key, that runs in the kernel context to delegate the verification.
> > This pattern of a trusted / delegated loader is going to be required
> > for many of the BPF use-cases that are out there (Cilium, bpftrace)
> > that dynamically generate eBPF programs.
> >
> > The technical objection is that:
> >
> > * It does not align with most BPF use-cases out there as most
> > use-cases need a trusted loader.
>
> No, it's definitely a use case. It's trivial to support both a trusted
> loader and a signature over the hash chain of supplied assets.
>
> > * Locks us into a UAPI, whereas a signed LOADER allows us to
> > incrementally build signing for all use-cases without compromising the
> > security properties.
> >
>
> Your proposal locks us into a UAPI as well. There is no way to make to
> do this via UAPI without making a UAPI design choice.
>
> > BPF's philosophy is that of flexibility and not locking the users into
> > a rigid in-kernel implementation and UAPI.
> >
>
> Then why are you locking us into a rigid
> only-signing-the-loader-is-allowed implementation?

I explained this before, the delegated / trusted loader is needed by
many BPF use-cases. A UAPI is forever, thus the lock-in.

- KP

>
> > - KP
> >
> >>
> >> > MAP_EXCLUSIVE is missing and is required which prevents maps from
> >> > being accessed by other programs as explained in the proposal.
> >> >
> >> > Please hold off on further iterations, I am working on a series and
> >> > will share these patches based on the design that was proposed.
> >> >
> >>
> >> So the premise here seems to be that people should only be allowed to
> >> sign trusted loaders, and that trusted loaders must additionally be
> >> authored by you, correct?
> >>
> >> When can we expect to see your patchset posted?
> >>
> >> >>
> >> >> for every program.
> >> >>
> >> >>
> >> >>
> >> >> 2. Timing of Signature Check
> >> >>
> >> >> This patchset moves the signature check to a point before
> >> >> security_bpf_prog_load is invoked, due to an unresolved discussion
> >> >> here:
> >> >
> >> > This is fine and what I had in mind, signature verification does not
> >> > need to happen in the verifier and the existing hooks are good enoug=
h.
> >> > I did not reply to Paul's comment since this is a fairly trivial
> >> > detail and would be obvious in the implementation that the verifier =
is
> >> > not the right place to check the signature anyways as the instructio=
n
> >> > buffer is only stable pre-verification.
> >> >
> >> >> https://lore.kernel.org/linux-security-module/CAHC9VhTj3=3DZXgrYMNA=
+G64zsOyZO+78uDs1g=3Dkh91=3DGR5KypYg@mail.gmail.com/
> >> >> This change allows the LSM subsystem to be informed of the signatur=
e
> >> >> verification result=E2=80=94if it occurred=E2=80=94and the method u=
sed, all without
> >> >> introducing a new hook. It improves visibility and auditability,
> >> >> reducing the =E2=80=9Ctrust me, friend=E2=80=9D aspect of the origi=
nal design.
> >> >
> >> >
> >> > On Wed, May 28, 2025 at 11:50=E2=80=AFPM Blaise Boscaccy
> >> > <bboscaccy@linux.microsoft.com> wrote:
> >> >>
> >> >> As suggested or mandated by KP Singh
> >> >> https://lore.kernel.org/linux-security-module/CACYkzJ6VQUExfyt0=3D-=
FmXz46GHJh3d=3DFXh5j4KfexcEFbHV-vg@mail.gmail.com/,
> >> >> this patchset proposes and implements an alternative hash-chain
> >> >> algorithm for signature verification of BPF programs.
> >> >>
> >> >> This design diverges in two key ways:
> >> >>
> >> >> 1. Signature Strategy
> >> >>
> >> >> Two different signature strategies are
> >> >> implemented. One verifies only the signature of the loader program =
in
> >> >> the kernel, as described in the link above. The other verifies the
> >> >> program=E2=80=99s maps in-kernel via a hash chain.  The original de=
sign
> >> >> required loader programs to be =E2=80=9Cself-aborting=E2=80=9D and =
embedded the
> >> >> terminal hash verification logic as metaprogramming code generation
> >> >> routines inside libbpf. While this patchset supports that scheme, i=
t
> >> >> is considered undesirable in certain environments due to the potent=
ial
> >> >> for supply-chain attack vectors and the lack of visibility for the =
LSM
> >> >> subsystem.  Additionally, it is impossible to verify the code
> >> >> performing the signature verification, as it is uniquely regenerate=
d
> >> >> for every program.
> >> >>
> >> >> 2. Timing of Signature Check
> >> >>
> >> >> This patchset moves the signature check to a point before
> >> >> security_bpf_prog_load is invoked, due to an unresolved discussion
> >> >> here:
> >> >> https://lore.kernel.org/linux-security-module/CAHC9VhTj3=3DZXgrYMNA=
+G64zsOyZO+78uDs1g=3Dkh91=3DGR5KypYg@mail.gmail.com/
> >> >> This change allows the LSM subsystem to be informed of the signatur=
e
> >> >> verification result=E2=80=94if it occurred=E2=80=94and the method u=
sed, all without
> >> >> introducing a new hook. It improves visibility and auditability,
> >> >> reducing the =E2=80=9Ctrust me, friend=E2=80=9D aspect of the origi=
nal design.
> >> >>
> >> >>
> >> >> Blaise Boscaccy (3):
> >> >>   bpf: Add bpf_check_signature
> >> >>   bpf: Support light-skeleton signatures in autogenerated code
> >> >>   bpftool: Allow signing of light-skeleton programs
> >> >>
> >> >>  include/linux/bpf.h            |   2 +
> >> >>  include/linux/verification.h   |   1 +
> >> >>  include/uapi/linux/bpf.h       |   4 +
> >> >>  kernel/bpf/arraymap.c          |  11 +-
> >> >>  kernel/bpf/syscall.c           | 123 +++++++++++++++++++-
> >> >>  tools/bpf/bpftool/Makefile     |   4 +-
> >> >>  tools/bpf/bpftool/common.c     | 204 +++++++++++++++++++++++++++++=
++++
> >> >>  tools/bpf/bpftool/gen.c        |  66 ++++++++++-
> >> >>  tools/bpf/bpftool/main.c       |  24 +++-
> >> >>  tools/bpf/bpftool/main.h       |  23 ++++
> >> >>  tools/include/uapi/linux/bpf.h |   4 +
> >> >>  tools/lib/bpf/libbpf.h         |   4 +
> >> >>  tools/lib/bpf/skel_internal.h  |  28 ++++-
> >> >>  13 files changed, 491 insertions(+), 7 deletions(-)
> >> >>
> >> >> --
> >> >> 2.48.1
> >> >>
