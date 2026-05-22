Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0262110E
	for <linux-security-module@vger.kernel.org>; Fri, 22 May 2026 20:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779482802; cv=none; b=IAsHVSjcVxrJFMP47CJxdCTsf2nrrX48tG1LLOGMnViYxQbgA0+KIqt4DD+IG3xHbpiXjk3M33KFCAq6UKmSEZBGVy07Yip7zJGxGSC37nyCcp3VZg9dL2TIOYzJtI1BCTCzYkKY7IsZAtpCue/DRlb2Uq/aHIiKbBrnOU52vrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779482802; c=relaxed/simple;
	bh=52xt7vuU2JG0TOmgOrSTavEwSsSlhZuzRqZBSXbS6T0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTEG4eb2JZ5HqNXQgI86QHeHUglwNc+eTF9uaeIP8UeR1N2HWxQratserT9TTNe7aiYx/2/lITInRqIGPfr4hZPqqAx/9RfI4OGgEgpz7gFpCDnMFTPE/1pjnvUO2YINqal9hujxOyMZNlwGdMnOuKgeXLrVrYVKTQJ6el+5wmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YO9XymAL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YO9XymAL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C1F1F00A3E
	for <linux-security-module@vger.kernel.org>; Fri, 22 May 2026 20:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779482800;
	bh=UnmDdNzc53Xwm3qgMWerKXv7o4bwIrYGe6AUevDriuk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YO9XymALv6vAJGRZzp7tp2PPNncbjhV4E76w1Lec+vtf5B+mn/OHuASb1wkxgMm1O
	 65a4gWr8mlSQfkG1Y9/9e4rDqv2rs3KJ2ANT7pqiiCT/C1ZZG7AjI36pLxG83VUAds
	 Csclete5FewFQ0j+dG0VLS1KYIL8Hi0/O0tUpclzgxzeXCTnX++RBGYjpF29rcP8bW
	 Y9XTZIVBboJ7yw9x9lxYMZR+5RZrub7OSUaCcSiaYiNYAYziuo3XLbOkTPdv3GC665
	 oxMWM8sEv2gwcu+BN23Ax9UTgIN7Dardptg//qkC0VkXlwRam66hFsuhZTuC6oe/+/
	 rSIniHJdwiE/w==
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-452169ae568so5082285f8f.3
        for <linux-security-module@vger.kernel.org>; Fri, 22 May 2026 13:46:40 -0700 (PDT)
X-Gm-Message-State: AOJu0YzZkJAzvB8ZKlUD+7Z5pBnk9PjBm0FefeJdVwUKTAFyzIAW5BeE
	FcxQ7X+yZ773hEgSlyJyVMxzW9pZwWTRiktZMSq5kzMehwcp/w3/T0YIKCzFoAGQbao20/9XWFT
	Lvek6RTmi1mArx9QUXV6mfXdhLhqMWVMCNQeYiLfr
X-Received: by 2002:a05:6000:4305:b0:45e:73b9:e996 with SMTP id
 ffacd0b85a97d-45eb38b7e16mr8421074f8f.32.1779482799070; Fri, 22 May 2026
 13:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522023234.3778588-1-kpsingh@kernel.org> <CAHC9VhTk3qovnQQjK0C_FWU605j6Yi+-poMVVMS8WycRFg9xhQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTk3qovnQQjK0C_FWU605j6Yi+-poMVVMS8WycRFg9xhQ@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Fri, 22 May 2026 22:46:28 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6e4LSPr9pbjAMze9-CpXvFMKdm9xXHepvjhMxMAw+=RQ@mail.gmail.com>
X-Gm-Features: AVHnY4Jh9kG_eX5Gxd4g_2JGkJNfRTrov9ULJS8sVZxuRe_XEupQeK9n-Spm5Ms
Message-ID: <CACYkzJ6e4LSPr9pbjAMze9-CpXvFMKdm9xXHepvjhMxMAw+=RQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/13] Signed BPF + IPE Policies
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, James.Bottomley@hansenpartnership.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 8:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, May 21, 2026 at 10:32=E2=80=AFPM KP Singh <kpsingh@kernel.org> wr=
ote:
> >
> > This series continues the "Signed BPF programs" work and adds
> > the missing pieces needed for an LSM to do policy enforcement
> > and addresses the concerns raised by the developers of Hornet.
> >
> > One signing scheme, please.
>
> This is why we tried working with you and Alexei for quite some time,
> providing requirements, patches, reviews, and code suggestions.
> Unfortunately, our input was not reflected in the signing scheme that
> was merged into Linus' tree, so we have had to get creative to meet
> our our needs and those of others.

Is your idea of creativity to circumvent working with the BPF
maintainers and community?

>
> The good news is that the Hornet signatures are compatible with the
> existing BPF signing scheme; a Hornet signed BPF program can be
> successfully verified by your signing scheme, in current kernels, as
> well as the Hornet LSM.  Which, while were on the topic of
> compatibility, it looks like your proposed changes in this patchset
> would break compatibility with existing signed BPF programs, am I
> reading the patchset right in this regard?

No, they won't.

>
> > BPF does not need a second signing scheme. It needs a policy
> > framework that consumes the verdict the existing signing pipeline
> > produces. Two parallel signing stacks is harmful UX for Cilium,
> > bpftrace, systemd, distros, and everyone shipping signed lskels.
>
> Once again, if one signs BPF programs using the Hornet signing tools
> provided in Blaise's patches, the resulting signed BPF can be loaded
> and verified using both the existing BPF signature verification code
> and Hornet.  It is also easy to disable Hornet and/or IPE at kernel
> boot using the "lsm=3D" command line parameter, and of course one can
> always tailor the IPE policy to meet specific needs.  Although you
> surely must be aware of that as your own patchset borrows heavily from
> Blaise's original code, albeit without any attribution.
>
> > Hornet has been NACK'd repeatedly by the BPF maintainers [1][2]
> > on layering and TOCTOU grounds.
>
> Blaise has recorded Alexei's NACK on the Hornet patchset and addressed

Please record the NACK from Daniel and me.

> the TOCTOU that Alexei identified.  On a related note, Blaise and I
> were working with Eric Biggers today - thank you again Eric! - on
> identifying some additional issues and I expect Blaise will have
> another patch early next week which leverages security_bpf_prog() to
> simplify the Hornet code and address some additional issues.
>
> > What this series adds
> >
> > - prog->aux->sig (verdict + keyring) and prog->aux->is_kernel,
> >   populated by the syscall path before security_bpf_prog_load
> >   fires.
> > - bpf_loader_verify_metadata kfunc -- the metadata check is now
> >   kernel C code, not BPF bytecode. The verifier injects the
> >   calling prog->aux as an implicit argument via KF_IMPLICIT_ARGS.
>
> I think there may have been a misunderstanding regarding the "kernel
> C" comments.  Our desire was to not have to trust the lskel loader to
> do any of the BPF signature verification; perfoming the verification
> of both the lskel loader and the original BPF program map in the
> native kernel's C code flows, without relying on triggering by the
> loader.  This greatly simplifies things from a security perspective.
>
> > - Loader-side prog BTF with BPF_PSEUDO_KFUNC_CALL_PROG_BTF so
> >   the kfunc CALL is reproducible across build hosts and resolved
> >   at load time.
> > - security_bpf_prog_load_post_integrity LSM hook, fired by the
> >   kfunc on a successful metadata check.
>
> Does a kfunc calling a LSM hook open the door to a potential recursion
> issue involving a BPF LSM?

What's the concern here? LSM hooks can fire from BPF kfuncs and
helpers for a while now.

>
> > - IPE properties (bpf_signature, bpf_keyring, bpf_kernel) and
> >   two ops (BPF_PROG_LOAD, BPF_PROG_LOAD_POST_INTEGRITY).
> >
> > This series address concerns raised by the Hornet developers:
> >
> > * The metadata hash check should be in kernel C, not BPF
> >   bytecode -- Blaise Boscaccy [3]:
> >
> >   The bpf_loader_verify_metadata kfunc moves the hash check from
> >   inline BPF instructions into kernel C code.
>
> Please see my comments above.  While the kfunc is written in C, it is
> still reliant on the loader calling that kfunc.

Yes, that's the idea of transitive trust here. Ultimately you signed
the loader with your key. The mechanism proposed here allows
verification of any dynamic metadata, it does not need to be hermetic
to the loader, provided the digest of the metadata is incorporated
into the loader's signed payload.

- KP

>
> Of course there is still also the usbility issue of not being able to
> return an error status to userspace at load time regarding the
> verification success of both the loader and the original BPF program
> map.
>
> > * LSMs cannot observe the verification result at hook time --
> >   Paul Moore [4]:
> >
> >   prog->aux->sig.verdict and sig.keyring are populated before any
> >   LSM hook runs. Furthermore, security_bpf_prog_load_post_integrity
> >   hook fires after the in-kernel hash check for consumers that want
> >   to observe or gate the post-integrity transition.
> >
> > [1] Alexei Starovoitov, NACK on Hornet (TOCTOU + layering),
> >     https://lore.kernel.org/all/CAADnVQJ1CRvTXBU771KaYzrx-vRaWF+k164DcF=
OqOsCxmuL+ig@mail.gmail.com/
> > [2] Daniel Borkmann, NACK on Hornet v3,
> >     https://lore.kernel.org/all/798dba24-b5a7-4584-a1f6-793883fe9b5e@io=
gearbox.net/
> > [3] Blaise Boscaccy, Hornet v6 (C-side hash verification rationale),
> >     https://lore.kernel.org/all/20260429191431.2345448-1-bboscaccy@linu=
x.microsoft.com/
> > [4] Paul Moore, push for post-verifier observability,
> >     https://lore.kernel.org/all/CACYkzJ4+=3D3owK+ELD9Nw7Rrm-UajxXEw8kVt=
OTJJ+SNAXpsOpw@mail.gmail.com/
> >
> >
> > KP Singh (13):
> >   bpf: expose signature verdict to LSMs via bpf_prog_aux
> >   bpf: include prog BTF in the signed loader signature scope
> >   bpf, libbpf: load prog BTF in the skel_internal loader
> >   bpf: add bpf_loader_verify_metadata kfunc
> >   bpf: compute prog->digest at BPF_PROG_LOAD entry
> >   bpf: resolve loader-style kfunc CALLs against prog BTF
> >   libbpf: generate prog BTF for loader programs
> >   bpftool gen: embed loader prog BTF in the lskel header
> >   lsm: add bpf_prog_load_post_integrity hook
> >   bpf: invoke security_bpf_prog_load_post_integrity from the metadata
> >     kfunc
> >   ipe: add BPF program signature properties
> >   ipe: gate post-integrity BPF program loads
> >   selftests/bpf: add IPE BPF policy integration tests
> >
> >  include/linux/bpf.h                           |  19 +++
> >  include/linux/bpf_verifier.h                  |   6 +
> >  include/linux/btf.h                           |   1 +
> >  include/linux/lsm_hook_defs.h                 |   1 +
> >  include/linux/security.h                      |   6 +
> >  include/uapi/linux/bpf.h                      |   5 +
> >  kernel/bpf/btf.c                              |   8 +
> >  kernel/bpf/check_btf.c                        |  18 +-
> >  kernel/bpf/helpers.c                          |  65 ++++++++
> >  kernel/bpf/syscall.c                          |  76 ++++++++-
> >  kernel/bpf/verifier.c                         |  58 ++++++-
> >  security/ipe/Kconfig                          |  14 ++
> >  security/ipe/audit.c                          |  13 ++
> >  security/ipe/eval.c                           |  57 +++++++
> >  security/ipe/eval.h                           |   5 +
> >  security/ipe/hooks.c                          |  42 +++++
> >  security/ipe/hooks.h                          |   9 +
> >  security/ipe/ipe.c                            |   4 +
> >  security/ipe/policy.h                         |  11 ++
> >  security/ipe/policy_parser.c                  |  20 +++
> >  security/security.c                           |  17 ++
> >  tools/bpf/bpftool/gen.c                       |  21 +++
> >  tools/bpf/bpftool/sign.c                      |  17 +-
> >  tools/include/uapi/linux/bpf.h                |   5 +
> >  tools/lib/bpf/bpf_gen_internal.h              |   2 +
> >  tools/lib/bpf/gen_loader.c                    | 127 +++++++++++---
> >  tools/lib/bpf/libbpf.h                        |   4 +-
> >  tools/lib/bpf/skel_internal.h                 |  67 +++++---
> >  .../selftests/bpf/test_signed_bpf_ipe.sh      | 156 ++++++++++++++++++
> >  tools/testing/selftests/bpf/vmtest.sh         |   4 +-
> >  30 files changed, 775 insertions(+), 83 deletions(-)
> >  create mode 100755 tools/testing/selftests/bpf/test_signed_bpf_ipe.sh
> >
> > --
> > 2.53.0
>
> --
> paul-moore.com
