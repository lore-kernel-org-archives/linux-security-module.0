Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DF73B47D3
	for <linux-security-module@vger.kernel.org>; Tue, 26 May 2026 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812626; cv=none; b=Xf3R1rQIWJYo6P5kdeOBRgsrGi4HfjbqwoazoH26h0Avm/70vPrRIhcTiRpgSlcdVqUM1mlwdrUo7l2pfyiZF4xzTLa4SGzARh0RA8idzCB5jG4fA9Z34PrlLV+28t8lUFS5poYvrkUS8zG1w6K2EBl655vM+BIomZ5dDSwpqhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812626; c=relaxed/simple;
	bh=vv5B0lNNGYhGFVWPQgSt9e9eD2K6zdVphhDsNEtMxuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jf+/5x3jJN4wO+7PQBWlCObXRm++7bYbp5NAGpzUm0EjKi5h4Djllwj6SRTfJEwyLCfgu0kBLno7e6euShaMWLXkiDIL6Wkp5T1lDcjFyNxJENfGlgJhKYMiNsX+crB4OEoNWI0Wb8DXn57mFOHvYv7lLW9VyYhNQcfJeK2sqRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TStq3JlD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TStq3JlD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7EC1F000E9
	for <linux-security-module@vger.kernel.org>; Tue, 26 May 2026 16:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779812622;
	bh=1LfCRbFeQtW7WSChOCQSjGbiNuhognVwN4bLp5KK0AE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TStq3JlDrpSueRt484vq6aHU7lfzem+1XeGBiGFi4cXDarHA3YnaDLdqjW3+fOU1t
	 tMXMd7w9hlQg2pFxjFShVDPnl3vcTN2oBZxYr1TZgkV9pPWCmg9m9+6hidb3oxeTOc
	 dsKhhFmGMplbazZl9dSCHj9CXlG8dekI8avlqWf4w3oJu0hK3B7u7H85nRGm1zj+Ed
	 JoAYS3EsfzZStRuMK8LMHcFB104XhoayZsWVgcnkE4cl4fLvJnnzCCpi7aVFE6L4Al
	 2SMy1+MECebBqQ+jwVIADWHGwHWBpGMXz7uZfstV6FKtZ8rwOznjPyJVxMfAYK+6Ew
	 n+sA4YOFZB4hA==
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4904fd4f6aeso31643225e9.2
        for <linux-security-module@vger.kernel.org>; Tue, 26 May 2026 09:23:42 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx6O9zLAMu6bY8pkiOs26s/rq2iFq6tcZp08R1Ud2bmYtH3pVJ2
	f8NCimtjk2sfX/7XyZJ5O3Jsf06oJd9tdTQnpJ4vcr+B+q6Gq6ZETx/Kb9Gb/L49eA6O7QGEhrH
	ZOgrc43TCkOsxiNnXz2QUh7LeAy/ajjoa52bmN9VF
X-Received: by 2002:a05:600c:310c:b0:490:53d3:4753 with SMTP id
 5b1f17b1804b1-49053d34968mr242027385e9.31.1779812620803; Tue, 26 May 2026
 09:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522023234.3778588-1-kpsingh@kernel.org> <87zf1qxeyl.fsf@microsoft.com>
In-Reply-To: <87zf1qxeyl.fsf@microsoft.com>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 26 May 2026 18:23:29 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5ndrnDPgdzusksPbbYoHHxdnrXi-t9DHi9Jey2z7uJfQ@mail.gmail.com>
X-Gm-Features: AVHnY4JFyd01k3j4yQlMFQkg5FQkS8Y5_JiLxkJx6BnidkZyOkYvuqmgwiab1WA
Message-ID: <CACYkzJ5ndrnDPgdzusksPbbYoHHxdnrXi-t9DHi9Jey2z7uJfQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/13] Signed BPF + IPE Policies
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Linux Security Module list <linux-security-module@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 May 2026, 18:34 Blaise Boscaccy,
<bboscaccy@linux.microsoft.com> wrote:
>
> KP Singh <kpsingh@kernel.org> writes:
>
> > This series continues the "Signed BPF programs" work and adds
> > the missing pieces needed for an LSM to do policy enforcement
> > and addresses the concerns raised by the developers of Hornet.
> >
> > One signing scheme, please.
> >
> > BPF does not need a second signing scheme. It needs a policy
> > framework that consumes the verdict the existing signing pipeline
> > produces. Two parallel signing stacks is harmful UX for Cilium,
> > bpftrace, systemd, distros, and everyone shipping signed lskels.
> > Hornet has been NACK'd repeatedly by the BPF maintainers [1][2]
> > on layering and TOCTOU grounds.
> >
> > What this series adds
> >
> > - prog->aux->sig (verdict + keyring) and prog->aux->is_kernel,
> >   populated by the syscall path before security_bpf_prog_load
> >   fires.
> > - bpf_loader_verify_metadata kfunc -- the metadata check is now
> >   kernel C code, not BPF bytecode. The verifier injects the
> >   calling prog->aux as an implicit argument via KF_IMPLICIT_ARGS.
> > - Loader-side prog BTF with BPF_PSEUDO_KFUNC_CALL_PROG_BTF so
> >   the kfunc CALL is reproducible across build hosts and resolved
> >   at load time.
> > - security_bpf_prog_load_post_integrity LSM hook, fired by the
> >   kfunc on a successful metadata check.
> > - IPE properties (bpf_signature, bpf_keyring, bpf_kernel) and
> >   two ops (BPF_PROG_LOAD, BPF_PROG_LOAD_POST_INTEGRITY).
> >
> > This series address concerns raised by the Hornet developers:
> >
> > * The metadata hash check should be in kernel C, not BPF
> >   bytecode -- Blaise Boscaccy [3]:
> >
>
> That's a gross misrepresentation of some of my previous statements on
> the subject. We can go back and forth on this until the cows home with
> increasing vitriolic rhetoric, but that's really just a waste of
>
> everyone's time. Your "trusted loader" design flat-out doesn't work for

I totally agree, I have wasted a lot of time arguing with you and it's
up to the maintainers and Linus to decide here.

> our security requirements, and those of others. You keep screaming that
> we need to "write our own trusted loader" and that isn't really solving
> anything.
>
> You just posted a trusted loader bugfix here.
> https://lore.kernel.org/linux-security-module/20260522215337.662271-1-kpsingh@kernel.org/
>
> What's your path for that now and in the future? How are you getting
> people to rebuild their out-of-tree trusted loaders if there is a bug in
> them? Are you expecting sysadmins to subscribe to the bpf mailing list
> and watch for patches to libbpf and then rebuild an entire corpus of
> eBPF lskel programs?

How do you get people to update their software? Don't you folks update
libraries? If users write their own loaders, they are responsible for
vulnerability management, just as they are for any other piece of
software. Not all trusted software lives in the kernel (eg. systemd,
privileged daemons, software with access to sensitive credentials).

Your arguments are illogical and abrasive. Furthermore, your
requirements are a moving target and you haven't explained the threat
model supporting them, despite repeated requests.

>
> What if there is a security vulnerability or a CVE in the generated code
> that gets emitted, how are you handling that? We have processes in place
> to handle updates, bugfixes and vulnerabilities in the kernel. None
> exist for your "trusted loader" paradigm. You can publish a CVE for
> libbpf, but there is no way to publish a CVE for an infinite number of
> random unknown bpf program in the wild or to notify users that their
> programs are effected, or for them to know which programs are actually
> effected and which ones aren't.
>
> Also as an aside, it looks like some of this patchset is copy-pasted
> from https://lore.kernel.org/linux-security-module/20260507191416.2984054-11-bboscaccy@linux.microsoft.com/
> Which is fine of course, since this is open source software and all, but
> attribution would be appreciated if you use my code in the future :)

There are only so many ways to write IPE policies, but I am happy to
add attribution, I will add it in the next rev.

- KP

>
>
> -blaise
>
>
>
> >   The bpf_loader_verify_metadata kfunc moves the hash check from
> >   inline BPF instructions into kernel C code.
> >
> > * LSMs cannot observe the verification result at hook time --
> >   Paul Moore [4]:
> >
> >   prog->aux->sig.verdict and sig.keyring are populated before any
> >   LSM hook runs. Furthermore, security_bpf_prog_load_post_integrity
> >   hook fires after the in-kernel hash check for consumers that want
> >   to observe or gate the post-integrity transition.
> >
> >
> > [1] Alexei Starovoitov, NACK on Hornet (TOCTOU + layering),
> >     https://lore.kernel.org/all/CAADnVQJ1CRvTXBU771KaYzrx-vRaWF+k164DcFOqOsCxmuL+ig@mail.gmail.com/
> > [2] Daniel Borkmann, NACK on Hornet v3,
> >     https://lore.kernel.org/all/798dba24-b5a7-4584-a1f6-793883fe9b5e@iogearbox.net/
> > [3] Blaise Boscaccy, Hornet v6 (C-side hash verification rationale),
> >     https://lore.kernel.org/all/20260429191431.2345448-1-bboscaccy@linux.microsoft.com/
> > [4] Paul Moore, push for post-verifier observability,
> >     https://lore.kernel.org/all/CACYkzJ4+=3owK+ELD9Nw7Rrm-UajxXEw8kVtOTJJ+SNAXpsOpw@mail.gmail.com/
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
