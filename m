Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCD92CCB9
	for <linux-security-module@vger.kernel.org>; Fri, 22 May 2026 18:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779476210; cv=pass; b=Eyon3ypimymtWSpkbI+7P6TiLdM/vsuRQYXkfUB3Sw/Khh3EheZC+x2Sz4VbjLa7aqs5G09t9wDe9p+xJe5pZ7A+lsDcdLVcinzLwkFT0aw3KmetkUHgqSyC2uLjAtviognLcVLrtsWOZT2hltBogeaF11lNFKGXxIobOUsV7r8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779476210; c=relaxed/simple;
	bh=sAbHrZt/+I2kfBqDqfCMSFy84O+AR3oaCWmc3PkJ19s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOLWsCgGLr1nG3/g4WBRaqzpjW1dKOZ+MXUELOvQ97jyA55Ep+COulVGJP4hPLv5bfBO2JsKqzDYh7btZPlAUA+8gdjFJgPKl0tlgMs9Vz6ejEpZGDvGoqClQ0wWstCMTFnumH1ca28zcOpr03MlxvN5kGIHq15jNlGrr7Fg3Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JjI2/1mg; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JjI2/1mg"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-83975e992e1so3061754b3a.2
        for <linux-security-module@vger.kernel.org>; Fri, 22 May 2026 11:56:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779476208; cv=none;
        d=google.com; s=arc-20240605;
        b=ldZVIFBlKKPmEVhWhxyYSzx/C6Hg1hqe3PUJj3q2BqfIzMecz7BIKC/c+vGWszF4yZ
         pgA7C0e0WAQaL+sS78+RCzQNPBHwW8FWIHUvpk7Qd8nE8ZXxuPjwVplSfhd+/o305J6E
         lEN4qucM4fBuNkWR2hVhXAuS822g/BWewhR6Eu0R8khIW5MhNmBLNxOt1ScbMtilPV50
         j6KufoRYrDsGcsOyNA1vZOdRnICoTKaRfiPJFRRGQFLc+032iBDLX1XufITaIVg5eaWT
         9919ZXtgO1/AgYfIN6D/VtVxalOsHDF+KTW1iy0e3xiMacjsb5KvN+Cvo9QWUnjGP2t3
         tmmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ireA9ycijQ8TEInPWbRj1B/PNFnpQugJ+wY3JTscrbc=;
        fh=S5FTryvHQD8giRZI57jd0FM1Li6tdC7LBpwa1SFcmmw=;
        b=CAiYyU11WHAznWM51geLtNZe7cTDxc4YoxiMiwWSYLMk5lcGf7MbyU0gRJWKCB0gbd
         We/I2Md9ZZIjxfD5/WT19qzZFpUHEfcGODn0VGMgd8UsxT08g3mnAJbA7RZaH+9IojSx
         f+SyUxVXtL+vXag+YIO0LV00jaAToYygtgHB0jWjOaYvuNZyt/JrEeRzU4Z1ZVCN3wDr
         /4kTFrt/BvqFw89y+gA9iLMzZn2fXCj8PZxwkbO0KYWMRziVYhAKItohhTeaRsPqYRWx
         t/1DL0mDAiPRQNFayWjWMp50bNlrM5X1DOPeMSzqtRUZrH9FzKyugAWHQlXHTIzUsjSD
         4FZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779476208; x=1780081008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ireA9ycijQ8TEInPWbRj1B/PNFnpQugJ+wY3JTscrbc=;
        b=JjI2/1mgCM1DyLMm5gMEmDL7upFDKrf+z0lAVIpinv5uHrHc9DKrk4uMI08Vi2Po/q
         KzwGUunEEGxa9CX9+vytxpuVyX7cgkFwjWzr6eYXeQ+MOZCPcIBzAT1gzrNupYFciE36
         gVo+AMMeXHj9VnLCF9A6lNo4FC1uH7SbOyAWIPjCln2pxi85LkID3aMAnJm4o9C+2Ue8
         jn9okaFRCRkqGbQ1iVsKTG/9EGiJK1RX/8k3qNFJzrsyN6xv7OKnYi5XZJwDfnHzT2zO
         3EKwZN1bC7bHPnPKSmSwQ/MsGIV8KA3Xh8i8+OnQ6x5641sd1dp1Z9VWvLokmRn2xC4s
         PW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779476208; x=1780081008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ireA9ycijQ8TEInPWbRj1B/PNFnpQugJ+wY3JTscrbc=;
        b=SniwwFV+vdlENQH8uEK1/CauOQqbb1xE+j693fwu7ZpBcT7g9U3ThdsbeZUyYXIy+a
         kiaJx3QA2UMHSaJZzyRsj+FxlmwSaPkytCofVdrUSzddg+/JElzV4IOE5y2mGG+Gvo53
         tQviT+FDVj9epc3Ll7quuRP4BM2M8ufOUh/fbe30ptjEoASvGJ/GTkGM8r5eE4JR9MSR
         JikPdAwc7NvaiA7o6vk63qoaA4Gx1VUn9UptP8yhqGXSjOebZ0zZbCxjmKplce1iLEet
         dr3AMx5bT2GsuygRuxwYsqz5VGapRzxtDdxkyQIuETCYeHosuVgjBqCxYjflEJ6mfInZ
         th7w==
X-Gm-Message-State: AOJu0YzTex8JHtdFPMP65PbjkfyANueB8Q531p6yofFHdh/KeoVsDS8E
	DERAWBLnoj+9FoIqBStko4l9qedj1N76IDUK9jIC9/0I5jaYrwrCJBf4qwQNJU4QFTpz49FzAH4
	JAJ8Zq9evjW33YB3NH1DPL71rU/+hq/ldrAQPpQWeYmqN1L/SKBCi68XNNIQ=
X-Gm-Gg: Acq92OG2xMXTjSTcPW2tXrKww1MzwFJf4lCBZ/pnZuLpyBDPAVtwcpPJZhupcqNnbxH
	uFCo2Av+MH7hcU6VeGhuBM5x+heSpxULh4rASuPfTCG9hvgUzDE1p1ay/czNOK6q3XS3AYr+8rB
	/2UjFXFvXO5x7QEEWGNMW3rkfXSz5dIl5lxWiVpGl4wqvfTaBQoBgpB9Ka05QiljWBdIEqJ+8Dg
	X5qXmeDYUtXCmeWLYyNOyYRfMC52a64YhnshDlA1J8RhRAubT7VxtjHrE+gXqaeurCTW3ho6gnK
	+bGv
X-Received: by 2002:a05:6a00:3e01:b0:836:bff4:fa5c with SMTP id
 d2e1a72fcca58-8415f5986cdmr4823766b3a.45.1779476207566; Fri, 22 May 2026
 11:56:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522023234.3778588-1-kpsingh@kernel.org>
In-Reply-To: <20260522023234.3778588-1-kpsingh@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 22 May 2026 14:56:36 -0400
X-Gm-Features: AVHnY4JN1R2oKRZCU-hODTQbPaM1O8Fjje6dlinI6B-bq81QMZtv99t3E6fmCI0
Message-ID: <CAHC9VhTk3qovnQQjK0C_FWU605j6Yi+-poMVVMS8WycRFg9xhQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/13] Signed BPF + IPE Policies
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, James.Bottomley@hansenpartnership.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 10:32=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
>
> This series continues the "Signed BPF programs" work and adds
> the missing pieces needed for an LSM to do policy enforcement
> and addresses the concerns raised by the developers of Hornet.
>
> One signing scheme, please.

This is why we tried working with you and Alexei for quite some time,
providing requirements, patches, reviews, and code suggestions.
Unfortunately, our input was not reflected in the signing scheme that
was merged into Linus' tree, so we have had to get creative to meet
our our needs and those of others.

The good news is that the Hornet signatures are compatible with the
existing BPF signing scheme; a Hornet signed BPF program can be
successfully verified by your signing scheme, in current kernels, as
well as the Hornet LSM.  Which, while were on the topic of
compatibility, it looks like your proposed changes in this patchset
would break compatibility with existing signed BPF programs, am I
reading the patchset right in this regard?

> BPF does not need a second signing scheme. It needs a policy
> framework that consumes the verdict the existing signing pipeline
> produces. Two parallel signing stacks is harmful UX for Cilium,
> bpftrace, systemd, distros, and everyone shipping signed lskels.

Once again, if one signs BPF programs using the Hornet signing tools
provided in Blaise's patches, the resulting signed BPF can be loaded
and verified using both the existing BPF signature verification code
and Hornet.  It is also easy to disable Hornet and/or IPE at kernel
boot using the "lsm=3D" command line parameter, and of course one can
always tailor the IPE policy to meet specific needs.  Although you
surely must be aware of that as your own patchset borrows heavily from
Blaise's original code, albeit without any attribution.

> Hornet has been NACK'd repeatedly by the BPF maintainers [1][2]
> on layering and TOCTOU grounds.

Blaise has recorded Alexei's NACK on the Hornet patchset and addressed
the TOCTOU that Alexei identified.  On a related note, Blaise and I
were working with Eric Biggers today - thank you again Eric! - on
identifying some additional issues and I expect Blaise will have
another patch early next week which leverages security_bpf_prog() to
simplify the Hornet code and address some additional issues.

> What this series adds
>
> - prog->aux->sig (verdict + keyring) and prog->aux->is_kernel,
>   populated by the syscall path before security_bpf_prog_load
>   fires.
> - bpf_loader_verify_metadata kfunc -- the metadata check is now
>   kernel C code, not BPF bytecode. The verifier injects the
>   calling prog->aux as an implicit argument via KF_IMPLICIT_ARGS.

I think there may have been a misunderstanding regarding the "kernel
C" comments.  Our desire was to not have to trust the lskel loader to
do any of the BPF signature verification; perfoming the verification
of both the lskel loader and the original BPF program map in the
native kernel's C code flows, without relying on triggering by the
loader.  This greatly simplifies things from a security perspective.

> - Loader-side prog BTF with BPF_PSEUDO_KFUNC_CALL_PROG_BTF so
>   the kfunc CALL is reproducible across build hosts and resolved
>   at load time.
> - security_bpf_prog_load_post_integrity LSM hook, fired by the
>   kfunc on a successful metadata check.

Does a kfunc calling a LSM hook open the door to a potential recursion
issue involving a BPF LSM?

> - IPE properties (bpf_signature, bpf_keyring, bpf_kernel) and
>   two ops (BPF_PROG_LOAD, BPF_PROG_LOAD_POST_INTEGRITY).
>
> This series address concerns raised by the Hornet developers:
>
> * The metadata hash check should be in kernel C, not BPF
>   bytecode -- Blaise Boscaccy [3]:
>
>   The bpf_loader_verify_metadata kfunc moves the hash check from
>   inline BPF instructions into kernel C code.

Please see my comments above.  While the kfunc is written in C, it is
still reliant on the loader calling that kfunc.

Of course there is still also the usbility issue of not being able to
return an error status to userspace at load time regarding the
verification success of both the loader and the original BPF program
map.

> * LSMs cannot observe the verification result at hook time --
>   Paul Moore [4]:
>
>   prog->aux->sig.verdict and sig.keyring are populated before any
>   LSM hook runs. Furthermore, security_bpf_prog_load_post_integrity
>   hook fires after the in-kernel hash check for consumers that want
>   to observe or gate the post-integrity transition.
>
> [1] Alexei Starovoitov, NACK on Hornet (TOCTOU + layering),
>     https://lore.kernel.org/all/CAADnVQJ1CRvTXBU771KaYzrx-vRaWF+k164DcFOq=
OsCxmuL+ig@mail.gmail.com/
> [2] Daniel Borkmann, NACK on Hornet v3,
>     https://lore.kernel.org/all/798dba24-b5a7-4584-a1f6-793883fe9b5e@ioge=
arbox.net/
> [3] Blaise Boscaccy, Hornet v6 (C-side hash verification rationale),
>     https://lore.kernel.org/all/20260429191431.2345448-1-bboscaccy@linux.=
microsoft.com/
> [4] Paul Moore, push for post-verifier observability,
>     https://lore.kernel.org/all/CACYkzJ4+=3D3owK+ELD9Nw7Rrm-UajxXEw8kVtOT=
JJ+SNAXpsOpw@mail.gmail.com/
>
>
> KP Singh (13):
>   bpf: expose signature verdict to LSMs via bpf_prog_aux
>   bpf: include prog BTF in the signed loader signature scope
>   bpf, libbpf: load prog BTF in the skel_internal loader
>   bpf: add bpf_loader_verify_metadata kfunc
>   bpf: compute prog->digest at BPF_PROG_LOAD entry
>   bpf: resolve loader-style kfunc CALLs against prog BTF
>   libbpf: generate prog BTF for loader programs
>   bpftool gen: embed loader prog BTF in the lskel header
>   lsm: add bpf_prog_load_post_integrity hook
>   bpf: invoke security_bpf_prog_load_post_integrity from the metadata
>     kfunc
>   ipe: add BPF program signature properties
>   ipe: gate post-integrity BPF program loads
>   selftests/bpf: add IPE BPF policy integration tests
>
>  include/linux/bpf.h                           |  19 +++
>  include/linux/bpf_verifier.h                  |   6 +
>  include/linux/btf.h                           |   1 +
>  include/linux/lsm_hook_defs.h                 |   1 +
>  include/linux/security.h                      |   6 +
>  include/uapi/linux/bpf.h                      |   5 +
>  kernel/bpf/btf.c                              |   8 +
>  kernel/bpf/check_btf.c                        |  18 +-
>  kernel/bpf/helpers.c                          |  65 ++++++++
>  kernel/bpf/syscall.c                          |  76 ++++++++-
>  kernel/bpf/verifier.c                         |  58 ++++++-
>  security/ipe/Kconfig                          |  14 ++
>  security/ipe/audit.c                          |  13 ++
>  security/ipe/eval.c                           |  57 +++++++
>  security/ipe/eval.h                           |   5 +
>  security/ipe/hooks.c                          |  42 +++++
>  security/ipe/hooks.h                          |   9 +
>  security/ipe/ipe.c                            |   4 +
>  security/ipe/policy.h                         |  11 ++
>  security/ipe/policy_parser.c                  |  20 +++
>  security/security.c                           |  17 ++
>  tools/bpf/bpftool/gen.c                       |  21 +++
>  tools/bpf/bpftool/sign.c                      |  17 +-
>  tools/include/uapi/linux/bpf.h                |   5 +
>  tools/lib/bpf/bpf_gen_internal.h              |   2 +
>  tools/lib/bpf/gen_loader.c                    | 127 +++++++++++---
>  tools/lib/bpf/libbpf.h                        |   4 +-
>  tools/lib/bpf/skel_internal.h                 |  67 +++++---
>  .../selftests/bpf/test_signed_bpf_ipe.sh      | 156 ++++++++++++++++++
>  tools/testing/selftests/bpf/vmtest.sh         |   4 +-
>  30 files changed, 775 insertions(+), 83 deletions(-)
>  create mode 100755 tools/testing/selftests/bpf/test_signed_bpf_ipe.sh
>
> --
> 2.53.0

--
paul-moore.com
